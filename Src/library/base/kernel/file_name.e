
indexing

	description:
		"File name abstraction";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FILE_NAME

inherit
	PATH_NAME

creation

	make, make_from_string

feature

	set_file_name (file_name: STRING) is
			-- Set the value of the file name part.
		require
			string_exists: file_name /= Void
			valid_file_name: is_file_name_valid (file_name)
		local
			new_size: INTEGER
			str1, str2: ANY
		do
			new_size := count + file_name.count + 5;
			if capacity < new_size then
				resize (new_size)
			end
			str1 := to_c;
			str2 := file_name.to_c;
			c_append_file_name ($Current, $str1, $str2);
		ensure
			valid_file_name: is_valid
		end

	add_extension (ext: STRING) is
			-- Append the extension `ext' to the file name
		require
			string_exists: ext /= Void
			non_empty_extension: not ext.empty
			valid_extension: is_extension_valid (ext)
		do
			append_character ('.');
			append (ext)
		end

feature

	is_valid: BOOLEAN is
			-- Is the file name valid for the operating system?
		local
			any: ANY
		do
			any := to_c
			Result := c_is_file_valid ($any)
		end

	is_file_name_valid (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name part for the operating system?
		local
			any: ANY
		do
			any := f_name.to_c;
			Result := c_is_file_name_valid ($any)
		end

	is_extension_valid (ext: STRING): BOOLEAN is
			-- Is `ext' a valid extension for the operating system?
		local
			any: ANY
		do
			any := ext.to_c;
			Result := c_is_extension_valid ($any)
		end

feature {NONE} -- Externals

	c_append_file_name (s, p, v: POINTER) is
		external
			"C"
		end

	c_is_file_name_valid (p: POINTER): BOOLEAN is
		external
			"C"
		end

	c_is_extension_valid (p: POINTER): BOOLEAN is
		external
			"C"
		end

	c_is_file_valid (p: POINTER): BOOLEAN is
		external
			"C"
		end

end -- class FILE_NAME

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, 1995, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

