indexing

	description:
		"Encapsulation of a macro external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_MACRO_EXTENSION_AS

inherit
	C_EXTENSION_AS
		redefine
			parse_special_part, is_macro
		end

feature -- Conveniences

	is_macro: BOOLEAN is True

feature -- {NONE} Implementation

	parse_special_part is
			-- Parse include file containing macro definition
		do
			parse_special_file_name
		end

end -- class C_MACRO_EXTENSION_AS
