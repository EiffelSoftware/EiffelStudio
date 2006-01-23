indexing
	description: "File name abstraction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILE_NAME

inherit
	PATH_NAME

create
	make, make_from_string, make_temporary_name

feature {NONE} -- Initialization

	make_temporary_name is
			-- Create a temporary filename.
		do
			make_from_cil ({PATH}.get_temp_file_name)
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the file name valid for the operating system?
		do
			Result := True
		end

	is_file_name_valid (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name part for the operating system?
		do
			Result := True
		end

	is_extension_valid (ext: STRING): BOOLEAN is
			-- Is `ext' a valid extension for the operating system?
		do
			Result := True
		end

feature -- Status setting

	set_file_name (file_name: STRING) is
			-- Set the value of the file name part.
		require
			string_exists: file_name /= Void
			valid_file_name: is_file_name_valid (file_name)
		local
			ch: CHARACTER
		do
			ch := {PATH}.directory_separator_char
			if item (count) /= ch then
				append_character (ch)
			end
			append (file_name)
		ensure
			valid_file_name: is_valid
		end

	add_extension (ext: STRING) is
			-- Append the extension `ext' to the file name
		require
			string_exists: ext /= Void
			non_empty_extension: not ext.is_empty
			valid_extension: is_extension_valid (ext)
		do
			append_character ('.')
			append (ext)
		end

indexing
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



end -- class FILE_NAME


