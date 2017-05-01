# Introduction

The following scripts are used to build an EiffelStudio delivery for all supported platforms. Because Unix platforms and Windows are different two different sets of scripts are required. You will find them respectively in the unix and windows folder. Although the final result will be the same (i.e. an Eiffel delivery package), the process to obtain this result is different.

## Prerequesites

Before starting a delivery, you need to set the version you want to compile. This is done by 2 means:

- Set the **ORIGO\_SVN\_REVISION** environment variable to the SVN revision number you want to target
- Define in the file **set_alias** (Unix) or **set_alias.btm** (Windows) the URL to the SVN server as well as the version you are targetting. Most of the time the version is correct. They need to be changed whenever a new version is being generated for the first time.

## Unix

On Unix platforms, we first build a PorterPackage. This is a tar file that contains all the files necessary to build an EiffelStudio delivery on any of our supported platforms. Thus the process is split in 3 parts:

1. Building the Porterpackage by executing the `make_all` script. If you add the `all` arguemnt it will also compile the enterprise edition (which is possible from within Eiffel Software).
2. When the file PorterPackage_X.Y_REV.tar is built, you can copy it to your platform of choice and then execute `compile_exes $ISE_PLATFORM`. This will compile all C libraries and binaries for the platform specified by `$ISE_PLATFORM`.
3. Call `make_images $ISE_PLATFORM`, this will build the final delivery packages that users can download and install on their computer.

## Windows

On Windows, it is just a one step process and it is sufficient to call `make_delivery.bat`.
