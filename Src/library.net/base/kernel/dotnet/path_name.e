
indexing

	description:
		"Path name abstraction"

	status: "See notice at end of class"
	date: "$Date$"
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
			{ANY} is_empty, empty, to_cil, wipe_out
			{PATH_NAME} count, area
		redefine
			is_equal
		end

feature -- Initialization

	make is
			-- Create path name object.
		do
			string_make (0)
		end

	make_from_string (p: STRING) is
			-- Create path name object and initialize it with the
			-- path name `p'
		do
			string_make (0)
			append (p)
		ensure
			valid_file_name: is_valid
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is the path name equal to `other'?
		local
			l_a: PATH
			a_sys_str: SYSTEM_STRING
			a_str: STRING
		do
			--| .Net exceptions may be raised due to invalid characters or io problems.
			Result := l_a.get_full_path (other.to_cil).equals (l_a.get_full_path (to_cil))
		end

feature -- Status report

	is_directory_name_valid (dir_name: STRING): BOOLEAN is
			-- Is `dir_name' a valid subdirectory part for the operating system?
		require
			exists: dir_name /= Void
		local
			l_a: PATH
			a_sys_str: SYSTEM_STRING
		do
			a_sys_str := l_a.get_full_path (dir_name.to_cil)
			Result := a_sys_str /= Void and then not a_sys_str.equals (a_sys_str.empty)
		end

	is_volume_name_valid (vol_name: STRING): BOOLEAN is
			-- Is `vol_name' a valid volume name for the operating system?
		require
			exists: vol_name /= Void
		local
			l_a: PATH
			a_sys_str: SYSTEM_STRING
		do
			a_sys_str := l_a.get_full_path (vol_name.to_cil)
			Result := a_sys_str.equals (l_a.get_path_root (a_sys_str))
		end

	is_valid: BOOLEAN is
			-- Is the path name valid for the operating system?
		deferred
		end

feature -- Status setting

	set_volume (volume_name: STRING) is
			-- Set the volume part of the path name to `volume_name'.
		require
			string_exists: volume_name /= Void
			valid_volume_name: is_volume_name_valid (volume_name)
			empty_path_name: is_empty
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
			a_new_path: STRING
		do
			new_size := count + directory_name.count + 5
			if capacity < new_size then
				resize (new_size)
			end
			append_character (feature {PATH}.directory_separator_char)
			append (directory_name)
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
		do
			new_size := count + directory_name.count + 5
			if capacity < new_size then
				resize (new_size)
			end
			append_character (feature {PATH}.directory_separator_char)
			append (directory_name)
		ensure
			valid_file_name: is_valid
		end

	extend_from_array (directories: ARRAY [STRING]) is
			-- Append the subdirectories from `directories' to the path name.
		require
			array_exists: directories /= Void and then not (directories.is_empty)
		local
			i, nb: INTEGER
		do
			from
				i := directories.lower
				nb := directories.upper
			until
				i > nb
			loop
				extend (directories.item (i))
				i := i + 1
			end
		ensure
			valid_file_name: is_valid
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class PATH_NAME


