indexing

	description:
		"Encapsulation of a DLL external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_DLL_EXTENSION_AS

inherit
	C_EXTENSION_AS
		redefine
			parse_special_part
		end
 	EXTERNAL_CONSTANTS

feature -- {NONE} Implementation
 
	parse_special_part is
			-- Parse the dll name
		do  
			parse_special_file_name
		end

feature {NONE} -- Implementation

	dll_type: INTEGER
		-- Dll type

feature -- {EXTERNAL_LANG_AS} Implementation

	set_dll_type (i: INTEGER) is
			-- Assign `i' to `dll_type'.
		do
			dll_type := i
		end

end -- class C_DLL_EXTENSION_AS
