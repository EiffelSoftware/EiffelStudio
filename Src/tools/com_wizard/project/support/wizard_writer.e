note
	description: "Generate code for a code element"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_WRITER

inherit
	WEL_PROCESS_CREATION_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WEL_STARTUP_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

	ANY

feature -- Access

	generated_code: READABLE_STRING_32
			-- Generated code
		require
			ready: can_generate
		deferred
		end

	can_generate: BOOLEAN
			-- Can code be generated?
		deferred
		end

feature -- Basic Operations

	save_file (a_file_name: READABLE_STRING_32)
			-- Save generated code in `a_file_name'.
		require
			can_generate: can_generate
		do
			save_content (a_file_name, generated_code)
		end

feature {NONE} -- Implementation

	save_content (a_file_name, a_content: READABLE_STRING_32)
			-- Save generated code in `a_file_name'.
		require
			can_generate: can_generate
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			l_string: STRING_32
			p: PATH
			b: PATH
			u: UTF_CONVERTER
		do
			create p.make_from_string (a_file_name.as_lower)
			if not l_retried then
				create l_file.make_with_path (p)
				if l_file.exists and environment.backup then
					l_string := "File already exists: "
					l_string.append (p.name)
					l_string.append ("%N")
					l_string.append ("File backed up with extension %".bac%"")
					message_output.add_warning (l_string)
					b := backup_file_name (p)
					file_delete (b)
					file_copy (p, b)
				end
				l_file.make_with_path (p)
				l_file.open_write
				l_file.put_string (u.string_32_to_utf_8_string_8 (a_content))
				l_file.put_string ("%N")
				l_file.close
			else
				environment.set_abort (File_write_error)
				environment.set_error_data (p.name)
			end
		rescue
			if not failed_on_rescue then
				l_retried := True
				retry
			end
		end

	backup_file_name (a_file_name: PATH): PATH
			-- `a_file_name' backup file name
		local
			n: READABLE_STRING_32
		do
			Result := a_file_name
			if attached Result.extension then
				n := Result.name
				Result := (create {PATH}.make_from_string (n.substring (1, n.last_index_of ('.', 1) - 1))).appended_with_extension (backup_file_extension)
			end
		end

	is_overwritable (a_file_name: STRING): BOOLEAN
			-- Should file `a_file_name' be overwritten?
		local
			lower_case_implemented_coclass_extension: STRING
		do
			lower_case_implemented_coclass_extension := implemented_coclass_extension.twin
			lower_case_implemented_coclass_extension.to_lower
			Result := not a_file_name.substring (a_file_name.count -implemented_coclass_extension.count - 1, a_file_name.count -2).is_equal (lower_case_implemented_coclass_extension)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
