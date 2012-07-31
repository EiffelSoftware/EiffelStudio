note
	description: "Path name abstraction based on {STRING_32}."
	implementation: "[
			{PATH_NAME} based on {STRING_8} is used
			to store and compute paths by converting them to UTF-8.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class PATH_NAME_32

inherit
	ANY
		redefine
			copy,
			is_equal
		end

feature {NONE} -- Creation

	make_from_string (s: READABLE_STRING_32)
			-- Create a path name from `s'.
		deferred
		end

feature -- Conversion

	to_string_32: STRING_32
			-- String representation of `Current'.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32 (path_name)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is the path name equal to `other'?
		do
			Result := path_name.is_equal (other.path_name)
		end

feature -- Status report

	is_directory_name_valid (dir_name: STRING_32): BOOLEAN
			-- Is `dir_name' a valid subdirectory part for the operating system?
		require
			exists: dir_name /= Void
		local
			u: UTF_CONVERTER
		do
			Result := path_name.is_directory_name_valid (u.string_32_to_utf_8_string_8 (dir_name))
		end

	is_valid: BOOLEAN
			-- Is the path name valid for the operating system?
		do
			Result := path_name.is_valid
		end

	is_empty: BOOLEAN
			-- Is current name empty?
		do
			Result := path_name.is_empty
		end

feature -- Status setting

	reset (a_name: STRING_32)
			-- Reset content with a path starting with `a_name'
		require
			a_name_attached: a_name /= Void
		local
			u: UTF_CONVERTER
		do
			path_name.reset (u.string_32_to_utf_8_string_8 (a_name))
		end

	extend (directory_name: STRING_32)
			-- Append the subdirectory `directory_name' to the path name.
		require
			string_exists: directory_name /= Void
			valid_directory_name: is_directory_name_valid (directory_name)
		local
			u: UTF_CONVERTER
		do
			path_name.extend (u.string_32_to_utf_8_string_8 (directory_name))
		ensure
			valid_file_name: is_valid
		end


feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			Precursor (other)
			path_name := path_name.twin
		end

feature {PATH_NAME_32} -- Wrapper

	path_name: PATH_NAME
			-- Object used to perform path processing.

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
