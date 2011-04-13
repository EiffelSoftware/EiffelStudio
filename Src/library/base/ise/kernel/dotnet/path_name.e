
note

	description:
		"Path name abstraction"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class PATH_NAME

inherit
	STRING
		rename
			make as string_make,
			make_empty as make,
			extend as string_extend
		export
			{PATH_NAME} all
			{ANY} is_empty, empty, to_c, to_cil, wipe_out, out, string, twin, prunable, as_attached, make_from_string
		undefine
			new_string
		redefine
			is_equal
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is the path name equal to `other'?
		local
			l_other_full_path: detachable SYSTEM_STRING
		do
				--| .Net exceptions may be raised due to invalid characters or io problems.
			l_other_full_path := {PATH}.get_full_path (other.to_cil)
			Result := l_other_full_path /= Void and then l_other_full_path.equals ({PATH}.get_full_path (to_cil))
		end

feature -- Status report

	is_directory_name_valid (dir_name: STRING): BOOLEAN
			-- Is `dir_name' a valid subdirectory part for the operating system?
		require
			exists: dir_name /= Void
		local
			a_sys_str: detachable SYSTEM_STRING
		do
			a_sys_str := {PATH}.get_full_path (dir_name.to_cil)
			Result := a_sys_str /= Void and then not a_sys_str.equals (a_sys_str.empty)
		end

	is_volume_name_valid (vol_name: STRING): BOOLEAN
			-- Is `vol_name' a valid volume name for the operating system?
		require
			exists: vol_name /= Void
		local
			a_sys_str: detachable SYSTEM_STRING
		do
			a_sys_str := {PATH}.get_full_path (vol_name.to_cil)
			Result := a_sys_str /= Void and then a_sys_str.equals ({PATH}.get_path_root (a_sys_str))
		end

	is_valid: BOOLEAN
			-- Is the path name valid for the operating system?
		deferred
		end

feature -- Status setting

	reset (a_name: STRING)
			-- Reset content with a path starting with `a_name'
		require
			a_name_attached: a_name /= Void
		do
			wipe_out
			append (a_name)
		end

	set_volume (volume_name: STRING)
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

	extend, set_subdirectory (directory_name: STRING)
			-- Append the subdirectory `directory_name' to the path name.
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
			if not is_empty then
				append_character ({PATH}.directory_separator_char)
			end
			append (directory_name)
		ensure
			valid_file_name: is_valid
		end

	set_directory (directory_name: STRING)
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
			if not is_empty then
				append_character ({PATH}.directory_separator_char)
			end
			append (directory_name)
		ensure
			valid_file_name: is_valid
		end

	extend_from_array (directories: ARRAY [STRING])
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

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class PATH_NAME


