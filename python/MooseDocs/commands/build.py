#* This file is part of the MOOSE framework
#* https://www.mooseframework.org
#*
#* All rights reserved, see COPYRIGHT for full restrictions
#* https://github.com/idaholab/moose/blob/master/COPYRIGHT
#*
#* Licensed under LGPL 2.1, please see LICENSE for details
#* https://www.gnu.org/licenses/lgpl-2.1.html

"""Defines the MooseDocs build command."""
import os
import sys
import collections
import multiprocessing
import logging
import subprocess
import shutil
import yaml
import livereload
import mooseutils
from mooseutils.yaml_load import yaml_load

import MooseDocs
from .. import common
from ..tree import pages

def command_line_options(subparser, parent):
    """
    Define the command line options for the build command.
    """
    parser = subparser.add_parser('build', parents=[parent],
                                  help='Convert markdown into HTML or LaTeX.')

    parser.add_argument('--config', default='config.yml',
                        help="The configuration file.")
    parser.add_argument('--args', default=None, type=lambda a: yaml.load(a, yaml.Loader),
                        help="YAML content to override configuration items supplied in file.")
    parser.add_argument('--disable', nargs='*', default=[],
                        help="A list of extensions to disable.")
    parser.add_argument('--fast', action='store_true',
                        help="Build the pages with the slowest extension (appsyntax) disabled.")
    parser.add_argument('--executioner',
                        help="Select the mode of execution " \
                             "(default: MooseDocs.base.ParallelBarrier).")
    parser.add_argument('--profile', action='store_true',
                        help="Build the pages with python profiling.")
    parser.add_argument('--destination',
                        default=None,
                        help="Destination for writing build content.")
    parser.add_argument('--serve', action='store_true',
                        help="Create a local live server.")
    parser.add_argument('--dump', action='store_true',
                        help="Show page tree to the screen.")
    parser.add_argument('--num-threads', '-j', type=int, default=int(multiprocessing.cpu_count()/2),
                        help="Specify the number of threads to build pages with.")
    parser.add_argument('--port', default='8000', type=str,
                        help="The host port for live web server (default: %(default)s).")
    parser.add_argument('--host', default='127.0.0.1', type=str,
                        help="The local host for live web server (default: %(default)s).")
    parser.add_argument('--clean', type=str, choices=['0', 'false', 'no', '1', 'true', 'yes'],
                        help="Clean the destination directory, by default this is False  when " \
                             "the '--files' option is used, otherwise the default is True.")
    parser.add_argument('-f', '--files', default=[], nargs='*',
                        help="A list of file to build, this is useful for testing. The paths " \
                             "should be as complete as necessary to make the name unique, just " \
                             "as done within the markdown itself.")
    parser.add_argument('--home', default=None, help="The 'home' URL for the hosted website. " \
                                                     "This is mainly used by CIVET to allow " \
                                                     "temporary sites to be functional.")

class MooseDocsWatcher(livereload.watcher.Watcher):
    """
    A livereload watcher for MooseDocs that adds nodes to the directory tree when pages are added.

    Inputs:
        translator[Translator]: Instance of the translator object for converting files.
        options[argparse]: Complete argparse options as passed into the main function.
    """

    def __init__(self, translator, options, *args, **kwargs):

        super(MooseDocsWatcher, self).__init__(*args, **kwargs)
        self._options = options
        self._translator = translator

        self._config = yaml_load(options.config, root=MooseDocs.ROOT_DIR)

        # Determine the directories to watch
        roots = set()
        self._items = common.get_items(self._config.get('Content'))
        for root, _, _ in common.get_files(self._items, self._translator.reader.EXTENSIONS):
            roots.add(root)

        for root in roots:
            self.watch(root, self.build, delay=1)

    def build(self):
        """Build the necessary pages based on the current filepath."""

        # Locate the page to be translated
        page = self._getPage(self.filepath)
        if page is None:
            return
        MooseDocs.PROJECT_FILES.add(self.filepath)

        # Build a list of pages to be translated including the dependencies
        nodes = [page]
        for node in self._translator.getPages():
            uids = node['dependencies'] if 'dependencies' in node else set()
            if page.uid in uids:
                nodes.append(node)

        self._translator.execute(nodes, self._options.num_threads)

    def _getPage(self, source):
        """Search the existing content for pages, if it doesn't exist create it."""

        # Search for the page based on the source name, if it is found return the page
        for page in self._translator.getPages():
            if source == page.source:
                return page

        # Build a list of all filenames
        filenames = common.get_files(self._items, self._translator.reader.EXTENSIONS, False)

        # Build a page object if the filename shows up in the list of available files
        for root, filename in filenames:
            if filename == source:
                key = filename.replace(root, '').strip('/')
                page = common.create_file_page(key, filename, self._translator.reader.EXTENSIONS)
                page.base = self._translator.get('destination')
                if isinstance(page, pages.Source):
                    page.output_extension = self._translator.renderer.EXTENSION
                self._translator.addContent(page) # shoudldn't this be addPage()???
                return page

def main(options):
    """
    Main function for the build command.

    Inputs:
        options[argparse options]: Complete options from argparse, see MooseDocs/main.py
    """
    # Infinite nested dict
    tree = lambda: collections.defaultdict(tree)
    kwargs = tree()

    # Setup executioner
    if options.executioner:
        kwargs['Executioner']['type'] = options.executioner

    # Disable extensions
    if options.fast:
        options.disable += ['appsyntax', 'navigation', 'sqa', 'civet']
    for name in options.disable:
        ext = '.'.join(['MooseDocs', 'extensions', name.lower()])
        kwargs['Extensions'][ext] = dict(active=False)

    # Apply '--args' and override anything already set
    if options.args is not None:
        mooseutils.recursive_update(kwargs, options.args)

    # Create translator, provide kwargs to override content of file
    translator, _ = common.load_config(options.config, **kwargs)
    if options.destination:
        translator.update(destination=mooseutils.eval_path(options.destination))
    if options.profile:
        translator.executioner.update(profile=True)

####################################################################################################
### MAYBE ALL OF THIS CAN BE MOVED TO LIKE A base.subsite KIND OF THING...
###
### Subsites definitely need to be in the config, so idk... maybe it should just be a build arg...
### or perhaps we can call yaml_load right from here and that's the only time subsites are parsed...
###
### I bet we can make load_config() accept a list of configs and return a list of translators, in
### this way, we might be able to make 'subsites' a config key create a _yaml_load_subsites()
### function. And perhaps subsubsites are ignored in this routine... or maybe even that could work
###
### All of this only works if the subsite doc directories are on the same ROOT_DIR
###
### If a subdocs content is already in the main config, error, warn, or just don't build subsite
    print('\n*********************************************************************************')
    print('INITIALIZING', translator['destination'], '\n')

    # oldkeys = [dir(page) for page in translator.getPages()]
    translator.init()
    # for p, page in enumerate(translator.getPages()):
    #     print([key for key in dir(page) if key not in oldkeys[p]])


    print('\n*********************************************************************************')
    print("LOADING SUBDOCS CONFIGURATIONS\n")
    subdocs = [os.path.join(MooseDocs.MOOSE_DIR, 'tutorials/darcy_thermo_mech/doc')]
    # subdocs = [os.path.join(MooseDocs.MOOSE_DIR, 'tutorials/darcy_thermo_mech/doc'),
    #            os.path.join(MooseDocs.MOOSE_DIR, 'modules/tensor_mechanics/doc')]

    # kwargs['Extensions']['MooseDocs.extensions.reveal'] = dict(translate=['workshop/index.md'])
    subtrans = [common.load_config(os.path.join(doc, 'config.yml'), **kwargs)[0] for doc in subdocs]



    content = [page for page in translator.getPages()]
    sources = [page.source for page in content]

    subsites = ['workshop']
    # subsites = ['workshop', 'tensor_mechanics']
    subcontent = dict()
    for trans, site in zip(subtrans, subsites):
        print()
        for e, ext in enumerate(trans.extensions):
            if isinstance(ext, MooseDocs.extensions.reveal.RevealExtension):
                print(dir(ext))
                # ext(dict(translate=['workshop/index.md']))
                ext.update(**dict(translate=['workshop/index.md']))
                print(ext.get('translate'))

        #
        trans.update(destination=translator['destination'])
        # trans.update(destination=os.path.join(trans['destination'], site))
        if options.profile:
            trans.executioner.update(profile=True)

        print('\n*********************************************************************************')
        print('INITIALIZING', os.path.join(translator['destination'], site), '\n')

        # oldkeys = [dir(page) for page in trans.getPages()]
        trans.init()
        # for p, page in enumerate(trans.getPages()):
        #     print([key for key in dir(page) if key not in oldkeys[p]])

        print("running removePage() on", site.upper(), ':', len(trans.getPages()), 'pages')

        subcontent[site] = list()
        for page in [page for page in trans.getPages()]:
            if page.source in sources:
                trans.removePage(page)
            else:
                # page.subsite = site
                page._fullname = os.path.join(site, page.local)
                subcontent[site].append(page)

                # oldkeys = [key for key in page.attributes.keys()]
                translator.includePage(page)
                # print([key for key in page.attributes.keys() if key not in oldkeys], "\n")

        #
        for page in content:
            trans.includePage(page)

    print()
    for page in subcontent['workshop']:
        print(page.local, page.translator.uid)
    print(len(subcontent['workshop']))

    print('\n*********************************************************************************\n')

####################################################################################################

    # Replace "home" with local server
    home = options.home
    if options.serve:
        home = 'http://127.0.0.1:{}'.format(options.port)

    if home is not None:
        for ext in translator.extensions:
            if 'home' in ext:
                ext.update(home=home)

    # Dump page tree
    if options.dump:
        for page in translator.getPages():
            print('{}: {}'.format(page.local, page.source))
        for ext in translator.extensions:
            if isinstance(ext, MooseDocs.extensions.appsyntax.AppSyntaxExtension):
                ext.preExecute()
                print(ext.syntax)
        return 0

    # Set default for --clean: clean when --files is NOT used.
    if options.clean is None:
        options.clean = options.files == []
    else:
        options.clean = options.clean.lower() in ['true', 'yes', '1']

    if options.clean and os.path.exists(translator['destination']):
        log = logging.getLogger('MooseDocs.build')
        log.info("Cleaning destination %s", translator['destination'])
        shutil.rmtree(translator['destination'])

    # Perform build
    if options.files:
        nodes = []
        for filename in options.files:
            nodes += translator.findPages(filename)
        translator.execute(nodes, options.num_threads)
    else:
        translator.execute(content, options.num_threads)

####################################################################################################
### Need to not execute redundant content here, i.e., content already built by main translator

    # for trans in subtrans:
    for trans, site in zip(subtrans, subsites):
        print('\n*********************************************************************************')
        print('BUILDING', site.upper(), '\n')

        # clean up redundant subcontent
        # append cleaned up subcontent to main translator
        # execute subcontent on subtranslator

        trans.execute(subcontent[site], options.num_threads)

    print('\n*********************************************************************************\n')

####################################################################################################

    if options.serve:
        watcher = MooseDocsWatcher(translator, options)
        server = livereload.Server(watcher=watcher)
        server.serve(root=translator['destination'], host=options.host, port=options.port)

    return 0
