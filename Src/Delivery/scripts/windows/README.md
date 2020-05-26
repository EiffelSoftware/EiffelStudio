How to build Windows deliveries ?
=================================

1) local subversion repositories
--------------------------------
First, one can build local mirror of eiffelstudio and private ise repositories.
It speeds up the delivery, and this way, you are not subject to network issue.

See repos/ folder.
For eiffelstudio:
```
> cd repos
> init_eiffelstudio_mirror.bat
> svnsync_all_mirrors.bat
```

For ise
First, you need to setup the ISEVPN to access the subversion repository at `svn://svn.ise:3691/ise_svn` , then
```
> init_ise_mirror.bat your_ise_username your_ise_password
> svnsync_all_mirrors.bat
```

Note, the delivery scripts are setup to use those mirrors, at this location, using file:///..../svn/eiffelstudio location for instance.


2) setup the build scripts
--------------------------
in current directory, you will find a new set of scripts.
Please look into `etc\` folder
update `config.btm` to set the expected version, for instance
```
	set STUDIO_VERSION_MAJOR_MINOR=18.11
```
And there are a few variables to set, but it is recommended to add a new file `etc\machines\%COMPUTERNAME%.btm`  , and set the variables specific to your machine.
This way, you can switch easily from a machine to another.
You can also decide in those files, to use the real subversion repositories, instead of the local mirrors.


in `etc\profiles\` you can have various delivery profiles, for win64, using vc100, or vc150, ...
you can decide to use one of them, by setting the environment variable `ISE_BUILD_NAME` to one of them (use the filename without the extension).
Otherwise it will use default values for `ISE_C_COMPILER*` variables.

3) Requirements
---------------
- TCC/LE (https://jpsoft.com/products/tcc-le.html)
  edit menu.bat to set the TCCLECMD variable.
- expected VisualStudio, to compile C Code.
- WiX: in `C:\Program Files (x86)\Windows Installer XML v3\bin\  ` see file `install/package.wixproj`.

4) And finally, open the wanted Visual Studio prompt and run
```
> menu.bat
```
and you can choose 1 for the full delivery, or 7 only for the standard versions.

