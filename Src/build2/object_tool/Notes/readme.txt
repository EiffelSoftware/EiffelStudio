The Object editor was a feature of EiffelBuild which allowed you to quickly and easily build
interfaces for editing objects.

This version has been removed from EiffelBuild so it is no longer dependent on it. This is why
you may find references to Build within the code, and some classes still named accordingly. While
extracting the tool, the goal was to change as little as possible in order to preserve the
original mechanism.

EiffelBuild was built using the original Vision library and therefore, a great deal of modifications
were required to build the tool in Vision2, and to make it generate Vision2 code.

In Build, the tool would generate internal structures which were then later generated into code.
In this version, the only form of output is the generated code.

This tool reads in files generated in EiffelStudio. Select "tools", "documentation". Then select
the build filter and hen the files you wish to include on the next option. The format you then need to
select is "flat contracts" and then go ahead and generate the files. You will need to modify the
extensions of the generated files to .BUI if they are not already.

When setting up this application, you will need to set `Common_directory' in EB_ENVIRONMENT to
the location where the .BUI files outputted from EiffelStudio are located. If you do not do this correctly,
you will not be able to select any classes to build an object tool for.

This version of the object tool is by no means complete, but is now Vision2 compatible, stand alone, and
now ready for further development.

The initial conversion to Vision2 compatibility was performed by Julian Rogers around the middle of August 2001,
so if this has not been updated in accordance with Vision2 changes, that date may be very useful. Good luck.



Included in this "notes" directory is a sample output from the object tool.