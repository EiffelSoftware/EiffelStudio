indexing
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

feature -- Access

	generated_code: STRING is
			-- Generated code
		require
			ready: can_generate
		deferred
		end
	
	can_generate: BOOLEAN is
			-- Can code be generated?
		deferred
		end

feature -- Basic Operations

	save_file (a_file_name: STRING) is
			-- Save generated code in `a_file_name'.
		require
			can_generate: can_generate
		do
			save_content (a_file_name, generated_code)
		end

feature {NONE} -- Implementation

	save_content (a_file_name, a_content: STRING) is
			-- Save generated code in `a_file_name'.
		require
			can_generate: can_generate
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			l_string: STRING
		do
			a_file_name.to_lower
			a_file_name.to_lower
			if not l_retried then
				create l_file.make (a_file_name)
				if l_file.exists and environment.backup then
					l_string := "File already exists: "
					l_string.append (a_file_name)
					l_string.append ("%N")
					l_string.append ("File backed up with extension %".bac%"")
					message_output.add_warning (l_string)
					file_delete (backup_file_name (a_file_name))
					file_copy (a_file_name, backup_file_name (a_file_name))
				end
				l_file.make_open_write (a_file_name)
				l_file.put_string (a_content)
				l_file.put_string ("%N")
				l_file.close
			else
				environment.set_abort (File_write_error)
				environment.set_error_data (a_file_name)
			end
		rescue
			if not failed_on_rescue then
				l_retried := True
				retry
			end
		end

	backup_file_name (a_file_name: STRING): STRING is
			-- `a_file_name' backup file name
		local
			a_index: INTEGER
		do
			Result := a_file_name.twin
			a_index := Result.last_index_of ('.', 1) - 1
			if a_index > 0 then
				Result.keep_head (a_index)
			end
			Result.append (Backup_file_extension)
		end

	is_overwritable (a_file_name: STRING): BOOLEAN is
			-- Should file `a_file_name' be overwritten?
		local
			lower_case_implemented_coclass_extension: STRING
		do
			lower_case_implemented_coclass_extension := implemented_coclass_extension.twin
			lower_case_implemented_coclass_extension.to_lower
			Result := not a_file_name.substring (a_file_name.count -implemented_coclass_extension.count - 1, a_file_name.count -2).is_equal (lower_case_implemented_coclass_extension)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_WRITER

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
