indexing

	description:
		"Encapsulation of a DLL external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_DLL_EXTENSION_AS

inherit
	C_EXTENSION_AS
		redefine 
			parse_special_part, is_dll
		end

feature -- Conveniences

	is_dll: BOOLEAN is True

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the dll name
		do
			parse_special_file_name
		end

feature {NONE} -- Implementation

	dll_type: INTEGER
		-- Dll type

	dll_index: INTEGER
		-- Dll index

feature -- {EXTERNAL_LANG_AS} Implementation

	set_dll_type (t: INTEGER) is
			-- Assign `t' to `dll_type'.
		do
			dll_type := t
		end

	set_dll_index (i: INTEGER) is
			-- Assign `i' to `dll_index'.
		do
			dll_index := i
		end

end -- class C_DLL_EXTENSION_AS
