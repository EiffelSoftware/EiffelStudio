note
	description: "Used to evaluate environment configuration files that set environment variables."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENV_PARSER

inherit
	ENV_CONSTANTS
		export
			{NONE} all
		end

	NATIVE_STRING_HANDLER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (a_batch_file: like batch_file_name; a_args: like batch_arguments; a_options: like batch_options)
			-- Initialize parser from source batch file `a_batch_file'.
		require
			a_batch_file_attached: a_batch_file /= Void
			not_a_batch_file_is_empty: not a_batch_file.is_empty
			a_batch_file_exists: (create {PLAIN_TEXT_FILE}.make_with_path (a_batch_file)).exists
			not_a_args_is_empty: a_args /= Void implies not a_args.is_empty
			a_options_not_void: a_options /= Void
		do
			batch_file_name := a_batch_file
			batch_arguments := a_args
			batch_options := a_options
		ensure
			batch_file_name_set: batch_file_name = a_batch_file
			batch_arguments_set: batch_arguments = a_args
			batch_options_set: batch_options = a_options
		end

feature -- Access

	path: STRING_32
			-- PATH environment variable.
		do
			Result := variable_for_name (path_var_name)
		ensure
			result_attached: Result /= Void
		end

	include: STRING_32
			-- INCLUDE environment variable.
		do
			Result := variable_for_name (include_var_name)
		ensure
			result_attached: Result /= Void
		end

	lib: STRING_32
			-- LIBS environment variable.
		do
			Result := variable_for_name (lib_var_name)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	batch_file_name: PATH
			-- Location of a configuration batch script.

	batch_arguments: detachable STRING_32
			-- Arguments for `batch_file_name' or Void if none.

	batch_options: READABLE_STRING_32
			-- Option to the COMSPEC DOS prompt.

	environment: EXECUTION_ENVIRONMENT
			-- Access to environment information.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Basic operations

	variable_for_name (a_name: STRING_32): STRING_32
			-- Retrieves varaible for name `a_name'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := variables_via_evaluation.item (a_name)
			if not attached Result then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	variables_via_evaluation: HASH_TABLE [STRING_32, STRING_32]
			-- Retrieves a list of name/value environment variable pairs from evaluating the current environment
			-- Using a batch file provided by `vsvars_batch_file'.
		local
			l_result: like internal_variables_via_evaluation
			l_eval_file_name: READABLE_STRING_GENERAL
			l_file: detachable PLAIN_TEXT_FILE
			l_com_spec: detachable STRING_32
			l_cmd: STRING_32
			l_process_factory: BASE_PROCESS_FACTORY
			l_launcher: BASE_PROCESS
			l_exit_code: INTEGER
			l_pair: like parse_variable_name_value_pair
			l_appliable: like applicable_variables
			retry_count: INTEGER
			l_table: HASH_TABLE [STRING_32, STRING_32]
		do
			l_result := internal_variables_via_evaluation
			if l_result /= Void then
				Result := l_result
			else
				create l_result.make (0)
				l_result.compare_objects

				if retry_count < 2 then
					l_eval_file_name := new_temp_filename (env_eval_tmp_file_name)

					l_com_spec := Void
					if retry_count = 0 then
						create l_com_spec.make_from_string (cmd_exe_file_name.name)
					elseif retry_count = 1 then
							-- CMD did not work out, try ComSpec
							-- Retrieve command executable file name
						l_com_spec := environment.item ("ComSpec")
					end

					if l_com_spec /= Void and then not l_com_spec.is_empty then
							-- Execute batch file using command executable
						create l_cmd.make (l_com_spec.count + 80)
						l_cmd.append (l_com_spec)
						l_cmd.append_character (' ')
						l_cmd.append (batch_options)
						l_cmd.append ({STRING_32} " /c ")
						l_cmd.append (save_variables_command (Void))

						create l_process_factory
						l_launcher := l_process_factory.process_launcher_with_command_line (l_cmd, Void)
						l_launcher.redirect_output_to_file (l_eval_file_name)
						l_launcher.redirect_error_to_same_as_output

							-- Some Microsoft scripts reuse the value of VSINSTALLDIR instead of starting fresh.
							-- We make sure to remove this before executing our scripts.
						l_table := (create {EXECUTION_ENVIRONMENT}).starting_environment
						if l_table.has ("VSINSTALLDIR") then
							l_table.remove ("VSINSTALLDIR")
						end
						l_launcher.set_environment_variable_table (l_table)
						l_launcher.set_hidden (True)
						l_launcher.set_separate_console (True)
						l_launcher.launch
						if l_launcher.launched then
							l_launcher.wait_for_exit
							l_exit_code := l_launcher.exit_code
							create l_file.make_with_name (l_eval_file_name)
							if l_file.exists then
								l_file.open_read
								if l_file.count > 0 then
									l_appliable := applicable_variables
									from l_file.start until l_file.end_of_file loop
										debug
											;(create {REFACTORING_HELPER}).fixme ("Support reading unicode strings from the generated file.")
										end
										l_file.read_line
										if
											attached l_file.last_string as l_line_8 and then
											attached l_line_8.as_string_32 as l_line and then
											is_valid_variable_name_value_pair_string (l_line)
										then
											l_pair := parse_variable_name_value_pair (l_line)
											if
												l_pair /= Void and then
												(
													l_pair.value /= Void and
													(l_pair.name /= Void and then l_appliable.has (l_pair.name.as_upper))
												)
											then
												l_result.extend (l_pair.value, l_pair.name.as_upper)
											end
										end
									end
								end
								l_file.close
								try_delete (l_file)
							end
							if l_exit_code /= 0 then
								(create {EXCEPTIONS}).raise ("Process has terminated with an error [code:" + l_exit_code.out + "].")
							end
						else
							(create {EXCEPTIONS}).raise ("Unable to launch process.")
						end
					end
				end

				if l_file /= Void then
						-- Resource clean up.
					if l_file.exists then
						if not l_file.is_closed then
							l_file.close
						end
						try_delete (l_file)
					end
				end

				Result := l_result
				internal_variables_via_evaluation := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: variables_via_evaluation = Result
		rescue
			if retry_count < 2 then
				retry_count := retry_count + 1
				retry
			end
		end

	try_delete (f: FILE)
			-- Try to delete file `f` and rescue any exception.
		local
			retried: BOOLEAN
		do
			if not retried and f.exists then
				f.delete
			end
		rescue
			retried := True
			retry
		end

	parse_variable_name_value_pair (a_string: STRING_32): detachable TUPLE [name: STRING_32; value: STRING_32]
			-- Given 'a_string' parse and extract the environment variable from it.
		require
			a_string_not_void: a_string /= Void
			a_string_not_empty: not a_string.is_empty
			a_string_valid: is_valid_variable_name_value_pair_string (a_string)
		local
			p: INTEGER
		do
			p := a_string.index_of ('=', 1)
			if p > 0 then
				Result := [a_string.substring (1, p - 1), a_string.substring (p + 1, a_string.count)]
			end
		end

	is_valid_variable_name_value_pair_string (a_line: STRING_32): BOOLEAN
			-- Is `a_string' a valid name value/pair string?
		local
			pos: INTEGER
		do
			if a_line.count > 0 and then not a_line.item (1).is_space then
				pos := a_line.index_of ('=', 1)
				if pos > 0 then
					Result := True
				end
			end
		end

	save_variables_command (a_out: detachable READABLE_STRING_GENERAL): STRING_32
			-- Command to write environment variables to the file `a_out'.
		require
			not_a_out_is_empty: a_out /= Void implies not a_out.is_empty
		do
			create Result.make (256)
			Result.append ({STRING_32} "%"CALL %"")
			Result.append (batch_file_name.name)
			Result.append ({STRING_32} "%" ")
			if attached batch_arguments as l_args then
				Result.append (l_args)
			end
			Result.append ({STRING_32} " > :NUL ")
			Result.append ({STRING_32} " && SET ")
			if a_out /= Void then
				Result.append (" > ")
				Result.append (a_out.as_string_32)
			end
			Result.append_character ({CHARACTER_32} '"')
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			one_line_command: not Result.has ({CHARACTER_32} '%N')
		end

	applicable_variables: ARRAYED_LIST [STRING_32]
			-- List of applicable variables.
		once
			create Result.make (3)
			Result.extend (path_var_name)
			Result.extend (include_var_name)
			Result.extend (lib_var_name)
			Result.compare_objects
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_compares_objects: Result.object_comparison
		end

	new_temp_plaintext_file (a_temp_name: READABLE_STRING_GENERAL): PLAIN_TEXT_FILE
			-- Create a temporary file.
		local
			retried: BOOLEAN
		do

			if not retried then
					-- Create file in the current working directory if possible
				create Result.make_open_write (a_temp_name)
			else
					-- We could not create our temporary file,
					-- let's create one in the temporary directory of the OS.
				create Result.make_open_temporary_with_prefix (a_temp_name)
			end
		rescue
				-- We only allow one failure
			if not retried then
				retried := True
				retry
			end
		end

	new_temp_filename (a_temp_name: READABLE_STRING_GENERAL): STRING_32
			-- Create a temporary file.
		local
			retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			p: PATH
			i: INTEGER
		do
			if attached execution_environment.temporary_directory_path as tmp then
				p := tmp
			else
				p := execution_environment.current_working_path
			end
			if retried then
					-- We could not create our temporary file,
					-- let's create one in the temporary directory of the OS.
				from
					p := p.extended (a_temp_name)
					create l_file.make_with_path (p)
				until
					not l_file.exists or i > 1_000 -- try at max 1_000 times.
				loop
					p := p.appended (i.out)
					l_file.make_with_path (p)
				end
				Result := p.name
				create l_file.make_open_write (Result)
				l_file.close
			else
					-- Create file in the current working directory if possible
				create l_file.make_open_temporary_with_prefix (p.extended (a_temp_name).name)
				Result := l_file.path.name
				l_file.close
				create l_file.make_open_write (Result)
				l_file.close
			end
		rescue
				-- We only allow one failure
			if not retried then
				retried := True
				retry
			end
		end

	env_eval_tmp_file_name: STRING = "tmp_espawn.tmp"
			-- File name of evaluated environment variables.

	cmd_exe_file_name: PATH
			-- File name of Command exe.
		once
			if attached system_folder as l_system and then not l_system.is_empty then
				Result := l_system
			else
					-- Failed to retrieve folder, use fall back
				if attached environment.item ("SystemRoot") as l_value then
					create Result.make_from_string (l_value)
				else
						-- No environment variable, we hardcode to `C:\Windows'.
					create Result.make_from_string ("C:\Windows")
				end
				Result := Result.extended ("system32")
			end
			Result := Result.extended ("cmd.exe")

			if not (create {RAW_FILE}.make_with_path (Result)).exists then
					-- Try a command shell locatable in the user PATH variable.
				create Result.make_from_string ("cmd.exe")
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Externals

	system_folder: detachable PATH
			-- Directory name corresponding to Windows system folder.
		local
			l_count, l_nbytes: INTEGER_32
			l_managed: MANAGED_POINTER
		once
			l_count := 50
			create l_managed.make (50)
			l_nbytes := system_folder_ptr (l_managed.item, l_count)
			if l_nbytes > l_count then
				l_count := l_nbytes
				l_managed.resize (l_count)
				l_nbytes := system_folder_ptr (l_managed.item, l_count)
			end
			if l_nbytes > 0 and l_nbytes <= l_count then
				create Result.make_from_pointer (l_managed.item)
			end
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		end

	system_folder_ptr (a_buffer: POINTER; a_count: INTEGER_32): INTEGER_32
			-- Directory name corresponding to the user directory that will be stored in buffer `a_buffer'
			-- of size `a_count' bytes. Returns the number of bytes necessary in `a_buffer' to get the full copy.
			-- Retrieve Windows system folder.
		external
			"C inline use %"shlobj.h%""
		alias
			"[
					/* This is necessary because in VC++6.0 this is not defined. */
				#ifndef CSIDL_SYSTEM
				#define CSIDL_SYSTEM 0x0025
				#endif
				
				if ($a_buffer && ($a_count >= (MAX_PATH * sizeof(wchar_t)))) {
						/* Buffer is large enough for the call to SHGetFolderPathW. */
					if (SHGetSpecialFolderPathW (NULL, $a_buffer, CSIDL_SYSTEM, TRUE)) {
						return (EIF_INTEGER) ((wcslen($a_buffer) + 1) * sizeof (wchar_t));
					} else {
						return 0;
					}
				} else {
						/* Buffer is NULL or not large enough we ask for more. */
					return MAX_PATH * sizeof(wchar_t);
				}
			]"
		end

feature {NONE} -- Implementation: Internal cache

	internal_variables_via_evaluation: detachable like variables_via_evaluation
			-- Cached version of `variables_via_evaluation'.
			-- Note: Do not use directly!

invariant
	batch_file_name_attached: batch_file_name /= Void
	not_batch_file_name_is_empty: not batch_file_name.is_empty
	batch_file_name_exists: (create {RAW_FILE}.make_with_path (batch_file_name)).exists
	not_batch_arguments_is_empty: attached batch_arguments as l_args implies not l_args.is_empty
	batch_options_attached: batch_options /= Void

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
