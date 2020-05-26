# Welcome to MOOSE

This page includes examples and tutorials intended to introduce the basics of [!ac](MOOSE) for creating custom applications to solve unique and challenging multiphysics problems. Each example or tutorial focuses on different aspects MOOSE, primarily the fundamental C++ classes that are available to solve multiphysics problems.

It is assumed that the reader has some background in computer programming, specifically with C++. The links provided in [#programming] provide additional information for those who need to a refresher on C++.

!!!
*need to explain a few more things here* :

The navigation should be natural, the "breadcrumbs" as the top, contents sections, and if
needed we can add some next/back buttons at the bottom of the pages (but lets use what we have
for now)

Please add links to these two things:

- you will need to download and install the MOOSE package (compile, etc.) (see getting started)
- we are always available to contact (google groups)
!!!

## Examples and Tutorials id=TOC

- [Preface](preface.md)
- [Coupled Darcy Flow and Thermomechanics Tutorial](/darcy_thermo_mech/index.md)
- [Example Problems](/examples/index.md)

## Live Workshops id=lws

The [!ac](MOOSE) development team at [!ac](INL) will occasionally host live workshops at [!ac](INL) and around the world. Registration is open for all who wish to attend, although space is typically limited. !! Please subscribe to the...

!!!
*need to explain a few more things here* :

- how do we usually announce this? (email and website)
- how often (more exactly) do we run these? (2 to 3 times per year)
- how can some be sure they find out when one is happening? mailing list? moose-announce google group? (mailing list)
!!!

## Programming Materials id=programming

!!!
Link to our C++ content as well as the basic online c++ training and explain that there are many more

http://www.cplusplus.com/doc/tutorial/
https://en.cppreference.com/
!!!

## Helpful Software id=helpful-software

A text editor is necessary for creating application files. There are many options available, so please feel free to chose an any editor that meets your needs. A popular option for application developers is [Atom](https://atom.io), which has community developed add-ons specifically for MOOSE: [Atom Editor for MOOSE](Atom_Editor.md).

A graphical post-processor, particularly one that can read ExodusII files, is also necessary. [!ac](MOOSE) includes a [!ac](GUI): [PEACOCK](application_usage/peacock.md). Another popular tool is [ParaView](https://www.paraview.org/). Both of these applications are free and will allow you to visualize and process the results of your problems.
