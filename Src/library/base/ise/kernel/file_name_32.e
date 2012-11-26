note
	description: "File name abstraction based on {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_NAME_32

obsolete "Use PATH instead [2012-Nov]"	

inherit
	PATH_NAME_32
		redefine
			path_name
		end

create
	make_from_string,
	make_from_path,
	make_temporary_name

convert
	to_string_32: {STRING_32, READABLE_STRING_GENERAL, READABLE_STRING_32}

feature -- Creation

	make_from_string (s: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			create path_name.make_from_string (u.utf_32_string_to_utf_8_string_8 (s))
		end

	make_temporary_name
			-- Create a temporary filename.
		do
			create path_name.make_temporary_name
		end

feature -- Status report

	is_file_name_valid (f_name: READABLE_STRING_32): BOOLEAN
			-- Is `f_name' a valid file name part for the operating system?
		local
			u: UTF_CONVERTER
		do
			Result := path_name.is_file_name_valid (u.string_32_to_utf_8_string_8 (f_name))
		end

	is_extension_valid (ext: READABLE_STRING_32): BOOLEAN
			-- Is `ext' a valid extension for the operating system?
		local
			u: UTF_CONVERTER
		do
			Result := path_name.is_extension_valid (u.string_32_to_utf_8_string_8 (ext))
		end

feature -- Status setting

	set_file_name (file_name: READABLE_STRING_32)
			-- Set the value of the file name part.
		require
			string_exists: file_name /= Void
			valid_file_name: is_file_name_valid (file_name)
		local
			u: UTF_CONVERTER
		do
			path_name.set_file_name (u.string_32_to_utf_8_string_8 (file_name))
		ensure
			valid_file_name: is_valid
		end

	add_extension (ext: READABLE_STRING_32)
			-- Append the extension `ext' to the file name
		require
			string_exists: ext /= Void
			non_empty_extension: not ext.is_empty
			valid_extension: is_extension_valid (ext)
		local
			u: UTF_CONVERTER
		do
			path_name.add_extension (u.string_32_to_utf_8_string_8 (ext))
		end

feature {FILE_NAME_32} -- Wrapper

	path_name: FILE_NAME
			-- <Precursor>

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
