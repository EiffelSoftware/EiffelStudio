# WrapC

`WrapC` is an Eiffel wrapper generator for C libraries, originally known as EWG (http://www.sourceforge.net/projects/ewg)
It can be used to create libraries that bridge the gap between Eiffel and C. It aims to work for arbitrary ANSI C and with EiffelSoftware compiler.


## WrapC Status
Wrap C is a new version of an old project named [EWG](http://www.sourceforge.net/projects/ewg). It was updated to use the latest Eiffel version. WrapC generates Eiffel wrappers using inline externals whenever is possible. Updated callback code generation to use an agent to register the Eiffel feature to be called after a callback. Updated framework to automate building libraries and applications that use WrapC.

### Current Features

	 Parses pretty much all ANSI C, but also understands gcc and Visual C extensions
	 Generates wrappers for: 	

*   _Structs_
*   _Unions_
*   _Enums_
*   _Functions_
*   _Callbacks_
*   _Macro_

#### Note 

	*  Macros are supported, but only for macro definitions used to define constants. Everything else will be ignored.

*	Works with ISE Eiffel.
*	Includes a framework to automate building libraries and applications that use `WrapC`. 


The [Getting started](./doc/Readme.md) lets you discover the `WrapC` tool.
The [Developer guide](./doc/developer/Readme.md) lets you know how to build `WrapC` tool.

### WrapC Intellectual Property
Intelectual property [message](./intellectual_property.md) 

### WrapC Libraries
For an up-to-date list of WrapC based wrapper libraries please visit the [WrapC Homepage organization](https://github.com/eiffel-wrap-c).
