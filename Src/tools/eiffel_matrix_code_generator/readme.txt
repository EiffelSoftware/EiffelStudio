Eiffel Matrix Code Generator - Read Me
--------------------------------------

1.0 About:
----------
The Eiffel Matrix Code Generator (emcgen) is a tool that can be used to generate an Eiffel class
that permits named access, through Eiffel code, to tiles on a pixmap matrix. The pixmap is not require
to generate the code, only the configuration file.

2.0 Configuration Files:
------------------------
Configuration files are INI formatted files, which have very few rules to create.

2.1 Basic Properties
--------------------
All configuration files must contain the following properties, in the default section (top of the document):

	pixel_width
	pixel_height
	width
	height

pixel_width : Matrix tile pixel width. So for 16x16 icons this would be 16.
              Note: Must be greater than 0!
pixel_height: Matrix tile pixel height. So for 16x16 icons this would be 16.
             Note: Must be greater than 0!

width       : Matrix width in the number of tiles, *not* pixel.
              Note: Must be greater than 0!
height      : Matrix width in the number of tiles, *not* pixel.
              Note: Must be greater than 0!

Optional 'name' and 'suffix' properties can be set to indicate the name of the generate class and its contained
features. The 'name' property can be set or overridden via the '-class' command-line switch.

name        : Name of the class to generate
              Note: If an invalid Eiffel class name is specified the name will be formatted.

suffix      : Suffix to give generated feature names
              Note: If an invalid Eiffel feature name suffix is specified the suffix will be formatted.

2.3 Sections
------------
INI sections are used for two purposes. (1) To prefix generate pixmap access feature names and (2) to skip to 
the next line on the matrix.

As an example:

  [section name]
  icon1
  icon2

  [new section]
  icon3

Will generate features:

  section_name_icon1_icon: EV_PIXMAP... -- Icon at line 1 column 1
  section_name_icon2_icon: EV_PIXMAP... -- Icon at line 1 column 2
  new_section_icon3_icon: EV_PIXMAP...  -- Icon at line 2 column 1

Given that a section will skip to the next line, it's foreseeable that you might want to prefix feature names with
a different prefix but continue on the current line. These come in the form of "continuation sections", which are
section's whose labels a prefixed with an '@' symbol.

As an example:

  [section name]
  icon1
  icon2
  
  [@continued]
  icon3
  icon4

Will generate features:

  section_name_icon1_icon: EV_PIXMAP...   -- Icon at line 1 column 1
  section_name_icon2_icon: EV_PIXMAP...   -- Icon at line 1 column 2
  continued_name_icon3_icon: EV_PIXMAP... -- Icon at line 1 column 3
  continued_name_icon4_icon: EV_PIXMAP... -- Icon at line 1 column 5

2.3 Example
-----------

; Pixmap code generation ini file.

class_name=TEST
pixel_width=16
pixel_height=16
width=6
height=6

[icons]
drop feature
hand

[compiler state]
error
success

[@compilation]
melt
compile

3.0 Frame Files
---------------
Next to the emcgen tool there should be a frames folder. This, be default, contains a single frame file. Frame files
are the template files that will be used to generate the Eiffel class.

If you have a custom frame file you want to use the specify it's location using the -frame command-line switch.

3.1 Frame Variables
-------------------
There are a number of frame file variables that are replaced with emcgen generated code. These variables should
be used in your frame files to function correctly. The following list details:

  ${NAME}          : Class name.
  ${ACCESS}        : Generated pixmap access features.
  ${IMPLEMENTATION}: Generated implementation features.
  ${PIXEL_WIDTH}   : Width, in pixels, of a single matrix tile.
  ${PIXEL_HEIGHT}  : Height, in pixels, of a single matrix tile.
  ${WIDTH}         : Width, in tiles, of the matrix.
  ${HEIGHT}        : Height, in tiles, of the matrix.

3.2 Custom Frame Variables
--------------------------
It's possible to define custom frame variable that can change between INI configuration files. To do this, simply add a named property
in the form of:

  name=value

after the require configuration property declaration (such as 'pixel_height', etc.)

Note: name, access, implementation, pixel_width, pixel_height, width and height have special meaning. If you try to set these your
generated Eiffel class may not appear as it should.

To use the custom variables in your frame file use a ${NAME}, where NAME is the upper-cased version of your property name.

4.0 Matrix Pixmaps
------------------
Matrix pixmaps must be created in a desired fashion, in order to be read correctly (unless you have your own frame
file implementation - See Section 5.0).

Using the default frame template file, matrix pixmaps must be bordered by one pixel and each tile padded with a
single pixel. This is to allow the use of a matrix grid that does not interfere with any of the tiles. This is
what tools, such as EiffelStudio, use.

5.0 Command-Line Options
------------------------

There are number of command-line options, please use

  emcgen /?

for more information.