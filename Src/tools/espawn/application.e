indexing
	description: "[
		Application root class for starting process spawning.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	APPLICATION

inherit
	ENV_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize application
		local
			l_parser: ARGUMENT_PARSER
			l_layout: EIFFEL_LAYOUT
		do
			create l_layout
			if not l_layout.is_eiffel_layout_defined then
				l_layout.set_eiffel_layout (create {FINISH_FREEZING_EIFFEL_LAYOUT})
			end

			create l_parser.make
			l_parser.execute (agent start (l_parser, l_layout.eiffel_layout))
		end

	start (a_options: ARGUMENT_PARSER; a_env: EIFFEL_ENV) is
			-- Starts application
		require
			a_options_attached: a_options /= Void
			a_options_successful: a_options.successful
			a_env_attached: a_env /= Void
		local
			l_success: BOOLEAN
		do
			if a_options.list_available_compilers then
				list_available_compilers (a_options)
			else
				initialize_environment (a_options, a_env)
				l_success := spawn_processes (a_options)

				if not a_options.ignore_failures then
					if not l_success then
						(create {EXCEPTIONS}).die (1)
					end
				end
			end
		end

feature -- Basic operations

	initialize_environment (a_options: ARGUMENT_PARSER; a_env: EIFFEL_ENV) is
			-- Initializes an environment base on `a_options'
		require
			a_options_attached: a_options /= Void
			a_options_successful: a_options.successful
			a_env_attached: a_env /= Void
		local
			l_manager: C_CONFIG_MANAGER
			l_config: C_CONFIG
		do
			if not a_options.manual then
					-- Configure environment
				create l_manager.make (a_options.for_32bit)
				if l_manager.has_applicable_config then
					if a_options.use_specific_compiler then
						l_config := l_manager.config_from_code (a_options.specific_compiler_code, True)
					else
						l_config := l_manager.best_configuration
					end
					if l_config = Void then
						print ("Warning: No environment were set up, no C/C++ compiler found!%N")
					else
						print ("Using C/C++ compiler from " + l_config.description + "%N")
						merge_variable (path_var_name, l_config.path_var, a_env)
						merge_variable (include_var_name, l_config.include_var, a_env)
						merge_variable (lib_var_name, l_config.lib_var, a_env)

							-- Set platform name
						if not {PLATFORM_CONSTANTS}.is_64_bits or else a_options.for_32bit then
							a_env.set_environment ("windows", ise_platform_var_name)
						else
							a_env.set_environment ("win64", ise_platform_var_name)
						end
					end
				end
			end
		end

	spawn_processes (a_options: ARGUMENT_PARSER): BOOLEAN is
			-- Spawns all processes found in `a_options' and returns successful result
		require
			a_options_attached: a_options /= Void
			a_options_successful: a_options.successful
		local
			l_commands: LINEAR [STRING]
			l_factory: PROCESS_FACTORY
			l_process: PROCESS
			l_spawner: SPAWNER
			l_count, l_failures: INTEGER
		do
				-- Launch processes
			create l_factory
			l_commands := a_options.commands
			create l_spawner.make (a_options.max_processors)
			from l_commands.start until l_commands.after loop
				l_process := l_factory.process_launcher_with_command_line (l_commands.item, Void)
				l_spawner.launch_process (l_process, not a_options.ignore_failures)
				l_commands.forth
				l_count := l_count + 1
			end
			l_spawner.wait_for_exit

			l_failures := l_spawner.unsuccessful_processes.count

			print ("%N")
			print (l_count)
			print (" processes launched.%N")
			print (l_count - l_failures)
			print (" processes returned successfully.%N")
			if l_failures > 0 then
				print (l_failures)
				print (" processes failed to execute correctly!%N")
			end

			Result := l_spawner.successful
		end

	list_available_compilers (a_options: ARGUMENT_PARSER) is
			-- Lists the available C/C++ compilers
		require
			a_options_attached: a_options /= Void
			a_options_successful: a_options.successful
		local
			l_manager: C_CONFIG_MANAGER
			l_codes: LIST [STRING]
			l_cursor: CURSOR
			l_config: C_CONFIG
			l_code: STRING
			l_count: INTEGER
		do
			print ("Available C/C++ compilers:%N%N")
			create l_manager.make (a_options.for_32bit)
			l_codes := l_manager.applicable_config_codes

			if l_codes.is_empty then
				print ("   No applicable compilers could be found.%N")
			else
					-- Determine max code name size
				l_cursor := l_codes.cursor
				from l_codes.start until l_codes.after loop
					l_count := l_count.max (l_codes.item.count)
					l_codes.forth
				end

				from l_codes.start until l_codes.after loop
					l_config := l_manager.config_from_code (l_codes.item, False)
					check l_config_attached: l_config /= Void end
					if l_config /= Void then
						check l_config_exists: l_config.exists end
						l_code := l_config.code
						print ("   " + l_code)
						print (create {STRING}.make_filled (' ', l_count - l_code.count))
						print (":  " + l_config.description + "%N")
					end
					l_codes.forth
				end
				l_codes.go_to (l_cursor)
			end
		end

feature {NONE} -- Basic operations

	merge_variable (a_name: STRING; a_values: STRING; a_env: EIFFEL_ENV) is
			-- Merges `a_value' with the environment variable `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_env_attached: a_env /= Void
		local
			l_var: STRING
			l_new_var: STRING
		do
			if a_values /= Void and then not a_values.is_empty then
				l_var := a_env.get_environment (a_name)
				if l_var = Void or else l_var.is_empty then
					l_new_var := a_values

				else
					create l_new_var.make (a_values.count + l_var.count)
					l_new_var.append (a_values)
					l_new_var.append_character (';')
					l_new_var.append (l_var)
				end
				a_env.set_environment (a_values, a_name)
			end
		end

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
