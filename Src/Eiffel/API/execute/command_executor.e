note
	description: "Calls commands outside the eiffel environment."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class COMMAND_EXECUTOR

inherit
	SHARED_EXECUTION_ENVIRONMENT

	SHARED_FLAGS

feature -- Command Execution

	execute (command: READABLE_STRING_GENERAL)
			-- Execute external `command'.
		require
			valid_command: command /= Void
		do
			{EXECUTION_ENVIRONMENT}.launch (command)
		ensure
			instance_free: class
		end

	execute_with_args (appl_name: READABLE_STRING_GENERAL; args: READABLE_STRING_GENERAL)
			-- Execute external command `appl_name' with following arguments.
		require
			appl_name_not_void: appl_name /= Void
			args_not_void: args /= Void
		do
			execute_with_args_and_working_directory (appl_name, args, {EXECUTION_ENVIRONMENT}.current_working_path)
		ensure
			instance_free: class
		end

	execute_with_args_and_working_directory (appl_name: READABLE_STRING_GENERAL; args: READABLE_STRING_GENERAL; working_directory: PATH)
			-- Execute external command `appl_name' with following arguments and working_directory.
		require
			appl_name_not_void: appl_name /= Void
			args_not_void: args /= Void
			working_directory_not_void: working_directory /= Void
		do
			execute_with_args_and_working_directory_and_environment (appl_name, args, working_directory, Void)
		ensure
			instance_free: class
		end

	execute_with_args_and_working_directory_and_environment (appl_name: READABLE_STRING_GENERAL; args: READABLE_STRING_GENERAL; working_directory: detachable PATH;
				envir: HASH_TABLE [STRING, STRING])
			-- Execute external command `appl_name' with following arguments and working_directory.
		require
			appl_name_not_void: appl_name /= Void
			args_not_void: args /= Void
			working_directory_not_void: working_directory /= Void
		local
			command: STRING_32
			l_prc_factory: BASE_PROCESS_FACTORY
			l_prc_launcher: BASE_PROCESS
			wd: detachable READABLE_STRING_GENERAL
		do
			create command.make_empty
			command.append_string_general (appl_name)
			command.append_character (' ')
			command.append_string_general (args)
			create l_prc_factory
			if working_directory /= Void then
				wd := working_directory.name
			end
			l_prc_launcher := l_prc_factory.process_launcher_with_command_line (command, wd)
			if envir /= Void then
				l_prc_launcher.set_environment_variable_table (envir)
			end
			l_prc_launcher.set_separate_console (True)
			l_prc_launcher.launch
		ensure
			instance_free: class
		end

feature -- Compiler specific calls

	link_eiffel_driver (c_code_dir: PATH; system_name: READABLE_STRING_GENERAL; prelink_cmd_name, driver_name: PATH)
			-- Link the driver of the precompilation to
			-- the eiffel project.
		local
			u: FILE_UTILITIES
		do
				-- Copy precompiled driver to the target directory.
			if {PLATFORM}.is_windows then
				u.copy_file_path (driver_name, c_code_dir.extended (system_name).appended_with_extension ("exe"))
			elseif {PLATFORM}.is_vms then
				u.copy_file_path (driver_name, c_code_dir.extended (system_name))
			else
				execution_environment.system
					({STRING_32} "%"" + prelink_cmd_name.name + {STRING_32} "%" " +
					driver_name.name + {STRING_32} " " +
					c_code_dir.extended (system_name).name)
			end
		end

	invoke_finish_freezing (c_code_dir: PATH; freeze_command: STRING_32; asynchronous: BOOLEAN; workbench_mode: BOOLEAN)
			-- Invoke the `finish_freezing' script.
		local
			cwd: PATH
		do
				-- Store current working directory
			cwd := Execution_environment.current_working_path

			Execution_environment.change_working_path (c_code_dir)

			if asynchronous then
				Execution_environment.launch (freeze_command)
			else
				Execution_environment.system (freeze_command)
			end

			Execution_environment.change_working_path (cwd)
		end

	terminate_c_compilation
			-- Terminate running c compilation, if any.
		do
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
