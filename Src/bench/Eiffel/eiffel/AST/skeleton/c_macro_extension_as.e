indexing
	description: "Encapsulation of a macro external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_MACRO_EXTENSION_AS

inherit
	C_EXTENSION_AS
		redefine
			parse_special_part, is_macro,
			extension_i, byte_node, need_encapsulation
		end

feature -- Properties

	is_macro: BOOLEAN is True

feature -- Get the macro extension

	extension_i (external_as: EXTERNAL_AS): C_MACRO_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_special_file_name (special_file_name)
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is True
			-- A macro needs to be encapsulated for polymorphic purpose.

feature -- Byte code

	byte_node: MACRO_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse include file containing macro definition
		do
			parse_special_file_name
		end

end -- class C_MACRO_EXTENSION_AS
