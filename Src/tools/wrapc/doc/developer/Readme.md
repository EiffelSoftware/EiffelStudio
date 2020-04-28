# Developer Guide

##### Table of Contents  
* [Installation](#installation)
	* [Requirements](#req) 
		* [Setting WrapC](#setwrapc)
* [Directory Structure](#layout)		
* [Building the tools](#build)
	* [Using ecf's](#ecf)
	* [Using geant](#geant)
* [Examples](#examples)	
	*  [Building and Running the examples](#build_examples)
	*  [Build Automation Explained](#build_automation)

<a name="installation"></a>

# Installation

## Getting WrapC
Clone or Download from https://github.com/eiffel-wrap-c/WrapC

	git clone https://github.com/eiffel-wrap-c/WrapC

<a name="req"></a>
## Requirements

Compiler

*   [EiffelStudio](https://www.eiffel.org/downloads) 19.05 or newer

Platform

*   Everything supported by above requirements (At the moment only tested on Windows)

<a name="setwrapc"></a>
### Setting WrapC (Optional)

Once you have `WrapC`tool installed , you should define the following environment variable in order to run `WrapC` wrapper generator or
put the binary under the PATH

*   Set WRAP_C to the directory where you unpacked WrapC code.
*   Put ${WRAP_C}/bin into your ${PATH} environment variable

The following example shows a possible setup for windows:

	set WRAP_C=C:\wrap_c
	set PATH=%PATH%;%WRAP_C%\bin

The following example shows a possible setup for linux:

	export WRAP_C=/home/tools/wrap_c
	export PATH=$PATH:$WRAP_C/bin
   
#### Note
	You have to make sure that Eiffel compiler or C compiler gets used can be located via the PATH environment variable.

<a name="layout"></a>
# Layout Structure
The source code of `WrapC` is structured using the following defined structure. 
The basic layout looks like this:

	WrapC
		bin        	-- wrap_c executable 
		doc 	  	-- WrapC documentation
		examples   	-- Set of examples that comes with WrapC 
		config    	-- Set of configuration files used for the geant automation scripts.
		src        	-- WrapC application source code
		|-----	library -- kernel of WrapC (Parse the config file, Parse C header, AST and code Generation)
		|-----	ewg	-- wrap_c tool

The previous layour shows how `WrapC` is structured on the file system.

<a name="build"></a>
# Building the tools
In this section we will describe how to build WrapC tool using ecf's and using geant `a build tool specifically tailored for the Eiffel programming language.`
 
 WrapC (the package) contains the wrap_c tool:

    wrap_c -- The Eiffel Wrapper Generator command line tool.
   
The source to those tools is located in `${WRAP_C}/src`. When using a binary distribution (i.e. not the source distribution) there is no need to compile the tools, as they come already precompiled for your platform. 

<a name="ecf"></a>
## Compiling the Tools using ECF's
The following will use the EiffelStudio gui and command line to compile the tools

### EiffelStudio IDE
	Open EiffelStudio 
	Open the project under 	`${WRAP_C}/src/ewg/system.ecf`
	Click Finalize
	
### Eiffel command line

	cd ${WRAP_C}/src/ewg
	ec -config system.ecf -target wrap_c -finalize -c_compile -project_path .
	
Finally 	
	 Copy `wrap_c` executable under bin or put it under your PATH.	

<a name="geant"></a>
## Compiling the Tools using Geant
The following will use the Gobo geant tool to setup and install the source code.

	cd ${WRAP_C}
	geant install -- Optional only if you need to regenerate the the Lexer and Yacc files.
	geant compile

<a name="examples"></a>
# Examples
 EWG comes with the following examples

	simple   -- A minimal example. This is a very good example to start with
	callback -- Demonstrates the use of C callbacks from within Eiffel
	template -- Template concept wrapper to start wrapping new libraries.


#### Note
In the future we will provide a little tool to create an empty project to help to create new wrappers.

For an up-to-date list of WrapC based wrapper libraries please visit the [WrapC Homepage organization](https://github.com/eiffel-wrap-c). 

<a name="build_examples"></a>
## Building and Running the examples

This step requires that you already have compiled the wrap_c tool. If you have downloaded a release package for you platform, you are lucky, since these packages already come with the wrap_c tool pre-compiled. 

You can find examples on how to use `WrapC` to create wrappers for C libraries in the directory `${WRAP_C}/examples`. These examples are fully functional, in that they include the necessary build automation to build the examples using Eiffel and C compiler combinations.

<a name="build_automation"></a>
### Build Automation Explained

#### Using Geant
`WrapC` uses Geant a build tool specifically tailored for the Eiffel programming language. 
To learn more about Geant check the following links
* 	[Overview of Geant](http://www.gobosoft.com/eiffel/gobo/geant/overview.html)
*  	[Geant Examples](http://www.gobosoft.com/eiffel/gobo/geant/examples.html)

Available targets for `WrapC` libraries.

	geant
	usage:
	   geant wrap_c			-- Generate wrap_c wrappers for the target C library. 
	   geant wrap_c_pre_script      -- Generate wrap_c wrappers for the target C library, executing a pre processing script
	   geant wrap_c_post_script     -- Generate wrap_c wrappers for the target C library, executing a post processing script
	   geant compile  		-- Build C code
	   geant clean			-- remove intermediary generated files
	   geant clobber   		-- remove all generated files

By default in the examples the target `geant wrap_c` will also call the pre and post processing scripts. For development purposes
then other targets like `wrap_c_pre_script`  or `wrap_c_post_script` could be useful to add.

Most examples wrap a 3rd party C library. If you want to build such an example please read the `Readme.md` file in the examples directory. It is usually necessary for you to install certain development versions of the libraries to wrap. The Readme.md file gives details on what is necessary.

To generate the Eiffel wrapper for a given example go into the library subdirectory of the examples directory. The examples usually have two subdirectories. 
	`library` contains the files necessary to build the wrapper and `hello_world` contains the source code for an actual Eiffel application that uses the wrapper. For example to generate the wrappers for the simple-example do:

	cd ${WRAP_C}/examples/simple/library
	geant wrap_c
	
This will use the wrap_c tool to generate Eiffel and C files that make the C library accessible from within Eiffel. It may sound weird that C files are generated too, but it is unfortunately necessary. The generated C files will be compiled and put into a static link library.

#### Using Automated scripts
Automated scripts are just bat scripts or shell scripts, and will run `WrapC` with pre and post processing scripts and compiling the C glue code needed for the library if you don't have Geant tool. 

#### Windows
```
generator.bat
```
#### Linux
```
./generator.sh
```

To compile and run an example application go into the example applications directory. For example to build the hello_world application of the simple example do:
	
	estudio system.ecf
	then Compile
	then Run

<a name="understanding_wrapc"></a>


