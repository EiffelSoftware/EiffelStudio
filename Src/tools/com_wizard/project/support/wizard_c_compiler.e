indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	WIZARD_C_COMPILER

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ROUTINES

	WIZARD_COMPILER_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

feature -- Basic Operations

	compile_folder (a_folder_name: STRING; a_multi_threaded: BOOLEAN) is
			-- Compiler C files in folder `a_folder_name'.
			-- Report progress with `a_progress_report' if not void.
		require
			non_void_folder_name: a_folder_name /= Void
			valid_folder_name: is_valid_folder_name (a_folder_name)
		local
			l_directory: DIRECTORY
			l_string: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
			l_file_name: STRING
		do
			if a_multi_threaded then
				l_file_name := "Makefile-mt"
			else
				l_file_name := "Makefile"
			end
			if eiffel_layout.has_borland then
				l_file_name.append (".bcb")
			else
				l_file_name.append (".msc")
			end

			create l_directory.make_open_read (a_folder_name)
			if l_directory.has_entry (l_file_name) then
				if eiffel_layout.has_borland then
					l_string := "%"" + eiffel_layout.borland_path.string + "\bin\make%" /f " + l_file_name
				else
					l_string := "nmake /f " + l_file_name
				end
			end
			if l_string /= Void then
				create l_process_launcher
				l_process_launcher.run_hidden
				environment.add_abort_request_action (agent l_process_launcher.terminate_process)
				l_process_launcher.launch (l_string, a_folder_name, agent message_output.add_text)
				if not l_process_launcher.last_launch_successful or not l_directory.has_entry (eiffel_layout.get_environment ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_c_compiler_env)) then
					environment.set_abort (C_compilation_failed)
					environment.set_error_data ("in folder " + Env.current_working_directory + "\" + a_folder_name)
				end
				environment.remove_abort_request_action
			end
			l_directory.close
		end

	compile_file (a_file_name: STRING) is
			-- Compile C file `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: is_c_file (a_file_name)
		local
			l_string: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
		do
			generate_command_line_file (C_compiler_command_line (a_file_name), Temporary_input_file_name)
			if not environment.abort then
				l_string := C_compiler.twin
				l_string.append (Space)
				l_string.append (last_make_command)
				create l_process_launcher
				l_process_launcher.run_hidden
				l_process_launcher.launch (l_string, Env.current_working_directory, agent message_output.add_text)
				if not l_process_launcher.last_launch_successful then
					environment.set_abort (C_compilation_failed)
					environment.set_error_data ("file " + a_file_name)
				end
			end
		end

feature {NONE} -- Implementation

	Lib_command: STRING is "Lib"
			-- Link command

	Lib_out_option: STRING is "/OUT:"
			-- Lib out option

	last_make_command: STRING
			-- Input to compiler
			-- Set by `generate_make_file'.

	generate_command_line_file (content, a_file_name: STRING) is
			-- Generate command line with content `content' and file name `a_file_name'.
			-- Set `last_make_command' with argument to pass to compiler.
		local
			retried: BOOLEAN
			a_file: PLAIN_TEXT_FILE
			a_string: STRING
		do
			if not retried then
				a_string := Env.current_working_directory.twin
				a_string.append_character (Directory_separator)
				a_string.append (a_file_name)
				create a_file.make_open_write (a_string)
				a_file.put_string (content)
				last_make_command := At_sign.twin
				last_make_command.append (a_file_name)
				a_file.close
			else
				environment.set_abort (Makefile_write_error)
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

	C_compiler_command_line (a_file_name: STRING): STRING is
			-- Cl command line used to compile Proxy Stub
		do
			Result := Common_c_compiler_options.twin
			Result.append (" /nologo ")
			Result.append (Env.current_working_directory.twin)
			Result.append_character (Directory_separator)
			Result.append (a_file_name)
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
end -- class WIZARD_C_COMPILER


