indexing

	description:
		"Encapsulation of a C extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special
		end

feature -- Properties

	special_file_name: STRING
			-- Special file name (dll or macro)

feature -- Initialization

	set_special_file_name (f: STRING) is
			-- Assign `f' to `special_file_name'.
		do
			special_file_name := f
		end

feature -- Convenience

	is_special: BOOLEAN is
		do
			Result := special_file_name /=  Void
		end

end -- class C_EXT_BYTE_CODE
