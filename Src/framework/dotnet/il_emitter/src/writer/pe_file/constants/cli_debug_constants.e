note
	description: "Constants for debug info"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DEBUG_CONSTANTS


feature -- Type

	type_unknown, type_reserved10: INTEGER = 0

	type_coff, type_clsid: INTEGER = 1

	type_codeview: INTEGER = 2

	type_fpo: INTEGER = 3

	type_misc: INTEGER = 4

	type_exception: INTEGER = 5

	type_fixup: INTEGER = 6

	type_omap_to_src: INTEGER = 7

	type_omap_from_src: INTEGER = 8

	type_borland: INTEGER = 9;

end
