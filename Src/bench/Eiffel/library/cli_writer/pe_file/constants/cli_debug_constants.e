indexing
	description: "Constants for debug info"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DEBUG_CONSTANTS

feature -- Type
	
	type_unknown, type_reserved10: INTEGER is 0

	type_coff, type_clsid: INTEGER is 1

	type_codeview: INTEGER is 2

	type_fpo: INTEGER is 3

	type_misc: INTEGER is 4

	type_exception: INTEGER is 5

	type_fixup: INTEGER is 6

	type_omap_to_src: INTEGER is 7

	type_omap_from_src: INTEGER is 8

	type_borland: INTEGER is 9

end -- class CLI_DEBUG_CONSTANTS
