indexing

	description:
		"Encapsulation of a C extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_equal
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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do	
			Result := same_type (other) and then
				equal (return_type, other.return_type) and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				equal (special_file_name, other.special_file_name)
		end

end -- class C_EXTENSION_I
