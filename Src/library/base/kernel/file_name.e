
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
			eif_append_file_name ($Current, $str1, $str2);
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
			Result := eif_is_file_valid ($any)
		end

	is_file_name_valid (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name part for the operating system?
		local
			any: ANY
		do
			any := f_name.to_c;
			Result := eif_is_file_name_valid ($any)
		end

	is_extension_valid (ext: STRING): BOOLEAN is
			-- Is `ext' a valid extension for the operating system?
		local
			any: ANY
		do
			any := ext.to_c;
			Result := eif_is_extension_valid ($any)
		end

feature {NONE} -- Externals

	eif_append_file_name (s, p, v: POINTER) is
		external
			"C | %"eif_path_name.h%""
		end

	eif_is_file_name_valid (p: POINTER): BOOLEAN is
		external
			"C | %"eif_path_name.h%""
		end

	eif_is_extension_valid (p: POINTER): BOOLEAN is
		external
			"C | %"eif_path_name.h%""
		end

	eif_is_file_valid (p: POINTER): BOOLEAN is
		external
			"C | %"eif_path_name.h%""
		end

end -- class FILE_NAME

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

