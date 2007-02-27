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

	start (a_parser: ARGUMENT_PARSER; a_env: EIFFEL_ENV) is
			-- Starts application
		require
			a_parser_attached: a_parser /= Void
			a_env_attached: a_env /= Void
		local
			l_manager: C_CONFIG_MANAGER
			l_config: C_CONFIG
			l_commands: LINEAR [STRING]
			l_factory: PROCESS_FACTORY
			l_process: PROCESS
			l_spawner: SPAWNER
			l_count, l_failures: INTEGER
		do
			if not a_parser.manual then
					-- Configure environment
				create l_manager.make (a_parser.for_32bit)
				if l_manager.has_applicable_config then
					l_config := l_manager.best_configuration
					if l_config /= Void then
						merge_variable (path_var_name, l_config.path_var, a_env)
						merge_variable (include_var_name, l_config.include_var, a_env)
						merge_variable (lib_var_name, l_config.lib_var, a_env)
					end
				end
			end

				-- Launch processes
			create l_factory
			l_commands := a_parser.commands
			create l_spawner.make (a_parser.max_processors)
			from l_commands.start until l_commands.after loop
				l_process := l_factory.process_launcher_with_command_line (a_parser.commands.item, Void)
				l_spawner.launch_process (l_process, not a_parser.ignore_failures)
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

			if not a_parser.ignore_failures then
				if not l_spawner.successful then
					(create {EXCEPTIONS}).die (1)
				end
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

--feature -- Basic operations

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
