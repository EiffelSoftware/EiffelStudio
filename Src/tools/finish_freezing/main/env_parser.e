indexing
	description: "Used to evaluate environment configuration files that set environment variables."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ENV_PARSER

inherit
	ENV_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_batch_file: like batch_file_name; a_args: like batch_arguments) is
			-- Initialize parser from source batch file `a_batch_file'
		require
			a_batch_file_attached: a_batch_file /= Void
			not_a_batch_file_is_empty: not a_batch_file.is_empty
			a_batch_file_exists: (create {PLAIN_TEXT_FILE}.make (a_batch_file)).exists
			not_a_args_is_empty: a_args /= Void implies not a_args.is_empty
		do
			batch_file_name := a_batch_file
			batch_arguments := a_args
		ensure
			batch_file_name_set: batch_file_name = a_batch_file
			batch_arguments_set: batch_arguments = a_args
		end

feature -- Access

	path: STRING is
			-- PATH environment variable
		do
			Result := variable_for_name (path_var_name)
		ensure
			result_attached: Result /= Void
		end

	include: STRING is
			-- INCLUDE environment variable
		do
			Result := variable_for_name (include_var_name)
		ensure
			result_attached: Result /= Void
		end

	lib: STRING is
			-- LIBS environment variable
		do
			Result := variable_for_name (lib_var_name)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	batch_file_name: STRING
			-- Location of a configuration batch script.

	batch_arguments: STRING
			-- Arguments for `batch_file_name' or Void if none.

feature {NONE} -- Basic operations

	variable_for_name (a_name: STRING): STRING is
			-- Retrieves varaible for name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := variables_via_evaluation.item (a_name)
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	variables_via_evaluation: TABLE [STRING, STRING] is
			-- Retrieves a list of name/value environment variable pairs from evaluating the current environment
			-- Using a batch file provided by `vsvars_batch_file'
		local
			l_file_name: STRING
			l_eval_file_name: STRING
			l_file: PLAIN_TEXT_FILE
			l_com_spec: STRING
			l_cmd: STRING
			l_launcher: WEL_PROCESS_LAUNCHER
			l_pair: TUPLE [name: STRING; value: STRING]
			l_appliable: like applicable_variables
			l_line: STRING
			l_result: HASH_TABLE [STRING, STRING]
			retried: BOOLEAN
		do
			Result := internal_variables_via_evaluation
			if Result = Void then
				create l_result.make (0)
				l_result.compare_objects

				if not retried then
					l_file_name := temp_batch_file_name
					l_eval_file_name := env_eval_tmp_file_name

						-- Create batch file for environment variable evaluation
					create l_file.make_open_write (l_file_name)
					l_file.put_string (batch_file_content (l_eval_file_name))
					l_file.flush
					l_file.close

						-- Retrieve command executable file name
					l_com_spec := eiffel_layout.get_environment ("ComSpec")
					if l_com_spec = Void or else l_com_spec.is_empty then
							-- Fallback
						l_com_spec := cmd_exe_file_name
					end

					check
						l_com_spec_attached: l_com_spec /= Void
						not_l_com_spec_is_empty: not l_com_spec.is_empty
					end

						-- Execute batch file using command executable
					create l_cmd.make (l_com_spec.count + 4 + l_file_name.count)
					l_cmd.append (l_com_spec)
					l_cmd.append (" /V:ON /c ")
					l_cmd.append (l_file_name)

					create l_launcher
					l_launcher.run_hidden
					l_launcher.launch (l_cmd, Void, Void)

					check l_file_is_closed: l_file.is_closed end
					l_file.delete

					create l_file.make (l_eval_file_name)
					if l_file.exists then
						l_file.open_read
						if l_file.count > 0 then
							l_appliable := applicable_variables
							from l_file.start until l_file.end_of_file loop
								l_file.read_line
								l_line := l_file.last_string
								if l_line /= Void and then not l_line.is_empty then
									l_pair := parse_variable_name_value_pair (l_file.last_string)
									if l_pair.name /= Void and then l_appliable.has (l_pair.name) and then l_pair.value /= Void then
										l_result.extend (l_pair.value, l_pair.name)
									end
								end
							end
						end

						l_file.close
						l_file.delete
					end
				end

				if l_file /= Void then
						-- Resource clean up
					if l_file.exists then
						if not l_file.is_closed then
							l_file.close
						end
						l_file.delete
					end
				end

				Result := l_result
				internal_variables_via_evaluation := Result
			end
		ensure
			result_attached: Result /= Void
			internal_variables_via_evaluation_set: internal_variables_via_evaluation = Result
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	parse_variable_name_value_pair (a_string: STRING): TUPLE [name: STRING; value: STRING] is
			-- Given 'a_string' parse and extract the environment variable from it.
		require
			a_string_not_void: a_string /= Void
			a_string_not_empty: not a_string.is_empty
			a_string_valid: a_string.occurrences ('=') >= 1
		local
			l_list: LIST [STRING]
		do
			l_list := a_string.split ('=')
			if l_list.count = 2 then
				Result := [l_list.first, l_list.i_th (2)]
			end
		end

	batch_file_content (a_out: STRING): STRING is
			-- Generates content for a batch file, used to executed and extract env vars from.
		require
			a_out_attached: a_out /= Void
			not_a_out_is_empty: not a_out.is_empty
		local
			l_args: like batch_arguments
		do
			l_args := batch_arguments

			create Result.make (256)
			Result.append ("@ECHO OFF%N")
			Result.append ("SET PATH=%N")
			Result.append ("SET INCLUDE=%N")
			Result.append ("SET LIB=%N")
			Result.append ("CALL %"")
			Result.append (batch_file_name)
			Result.append ("%" ")
			if l_args /= Void then
				Result.append (l_args)
			end
			Result.append (" > ")
			Result.append (a_out)
			Result.append ("%NSET > ")
			Result.append (a_out)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	applicable_variables: ARRAYED_LIST [STRING] is
			-- List of applicable variables
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

	temp_batch_file_name: STRING = "finish_freezing.bat"
			-- File name of evaluated environment variables

	env_eval_tmp_file_name: STRING = "env_eval.tmp"
			-- File name of evaluated environment variables

	cmd_exe_file_name: STRING = "cmd.exe"
			-- File name of Command exe

feature {NONE} -- Internal implementation cache

	internal_variables_via_evaluation: like variables_via_evaluation
			-- Cached version of `variables_via_evaluation'
			-- Note: Do not use directly!

invariant
	batch_file_name_attached: batch_file_name /= Void
	not_batch_file_name_is_empty: not batch_file_name.is_empty
	batch_file_name_exists: (create {RAW_FILE}.make (batch_file_name)).exists
	not_batch_arguments_is_empty: batch_arguments /= Void implies not batch_arguments.is_empty

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
