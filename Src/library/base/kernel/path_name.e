
indexing

	description:
		"Path name abstraction";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class PATH_NAME

inherit
	STRING
		rename
			make as string_make,
			make_from_string as string_make_from_string,
			extend as string_extend
		export
			{NONE} all
			{ANY} empty, to_c
		end

feature -- Initialization

	make is
			-- Create path name object.
		do
			string_make (0);
		end;

	make_from_string (p: STRING) is
			-- Create path name object and initialize it with the
			-- path name `p'
		do
			string_make (0);
			append (p);
		ensure
			valid_file_name: is_valid
		end

feature

	set_volume (volume_name: STRING) is
			-- Set the volume part of the path name to `volume_name'.
		require
			string_exists: volume_name /= Void
			valid_volume_name: is_volume_name_valid (volume_name)
			empty_path_name: empty
		do
			append (volume_name)
		ensure
			valid_file_name: is_valid
		end

	extend, set_subdirectory (directory_name: STRING) is
			-- Append the subdirectory `directory_name' to the path name.
		require
			string_exists: directory_name /= Void
			valid_directory_name: is_directory_name_valid (directory_name)
		local
			new_size: INTEGER
			str1, str2: ANY
		do
			new_size := count + directory_name.count + 5;
			if capacity < new_size then
				resize (new_size)
			end
			str1 := to_c;
			str2 := directory_name.to_c;
			c_append_directory ($Current, $str1, $str2);
		ensure
			valid_file_name: is_valid
		end

	set_directory (directory_name: STRING) is
			-- Set the absolute directory part of the path name to `directory_name'.
		require
			string_exists: directory_name /= Void
			valid_directory_name: is_directory_name_valid (directory_name)
		local
			new_size: INTEGER
			str1, str2: ANY
		do
			new_size := count + directory_name.count + 5;
			if capacity < new_size then
				resize (new_size)
			end
			str1 := to_c;
			str2 := directory_name.to_c;
			c_set_directory ($Current, $str1, $str2);
		ensure
			valid_file_name: is_valid
		end

	extend_from_array (directories: ARRAY [STRING]) is
			-- Append the subdirectories from `directories' to the path name.
		require
			array_exists: directories /= Void and then not (directories.empty)
		local
			i, nb: INTEGER
		do
			from
				i := directories.lower
				nb := directories.upper
			until
				i > nb
			loop
				extend (directories.item (i));
				i := i + 1
			end
		ensure
			valid_file_name: is_valid
		end

feature

	is_directory_name_valid (dir_name: STRING): BOOLEAN is
			-- Is `dir_name' a valid subdirectory part for the operating system?
		require
			exists: dir_name /= Void
		local
			any: ANY
		do
			any := dir_name.to_c;
			Result := c_is_directory_name_valid ($any);
		end

	is_volume_name_valid (vol_name: STRING): BOOLEAN is
			-- Is `vol_name' a valid volume name for the operating system?
		require
			exists: vol_name /= Void
		local
			any: ANY
		do
			any := vol_name.to_c;
			Result := c_is_volume_name_valid ($any);
		end

	is_valid: BOOLEAN is
			-- Is the path name valid for the operating system?
		deferred
		end

feature {NONE} -- Externals

	c_is_volume_name_valid (p: POINTER): BOOLEAN is
		external
			"C"
		end

	c_is_directory_name_valid (p: POINTER): BOOLEAN is
		external
			"C"
		end

	c_append_directory (s, p, v: POINTER) is
		external
			"C"
		end

	c_set_directory (s, p, v: POINTER) is
		external
			"C"
		end

end -- class PATH_NAME

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

