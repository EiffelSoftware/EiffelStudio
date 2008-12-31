note
	description: "[
		Basic, common, implementation for a cleaner use to clean configuration data.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	CLEANER

inherit
	PACKAGE_CREATABLE

	I_CLEANER

feature {NONE} -- Access

	user_options_factory: USER_OPTIONS_FACTORY
			-- Factory functions for retrieving user project information
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	error_handler: MULTI_ERROR_MANAGER
			-- Access to error manager
		do
			Result := package.error_handler
		ensure
			result_attached: Result /= Void
		end

	path_provider: PATH_PROVIDER
			-- Access to Eiffel related paths
		do
			Result := package.path_provider
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operation

	clean_environment (a_config: I_CLEANING_CONFIG)
			-- Cleans environment configuration files base on user settings.
		do
			if a_config.process_environement_debug_layout then
				remove_file (path_provider.docking_debug_layout_file.out)
			end
			if a_config.process_environement_editing_layout then
				remove_file (path_provider.docking_editing_layout_file.out)
			end
			if a_config.process_environement_preferences then
				remove_preferences
			end
		end

	clean_project (a_config: I_CLEANING_CONFIG)
			-- Cleans project configuration files base on user settings.
		local
			l_options: USER_OPTIONS
			l_targets: LIST [STRING]
		do
			if a_config.process_project then
				user_options_factory.load (a_config.project_location)
				if user_options_factory.successful then
					l_options := user_options_factory.last_options
					l_targets := l_options.target_names
					if a_config.process_project_layout then
						l_targets.do_all (agent (a_name: STRING; a_opts: USER_OPTIONS)
							local
								l_target_opts: TARGET_USER_OPTIONS
							do
								l_target_opts := a_opts.target_of_name (a_name)
								remove_file (path_provider.project_layout_path (l_target_opts.last_location))
							end (?, l_options))
					end
					if a_config.process_project_preferences then
						l_targets.do_all (agent (a_name: STRING; a_opts: USER_OPTIONS)
							local
								l_target_opts: TARGET_USER_OPTIONS
							do
								l_target_opts := a_opts.target_of_name (a_name)
								remove_file (path_provider.project_preferences_path (l_target_opts.last_location))
							end (?, l_options))
					end
					if a_config.process_project_session then
						l_targets.do_all (agent (a_name: STRING; a_opts: USER_OPTIONS)
							local
								l_target_opts: TARGET_USER_OPTIONS
							do
								l_target_opts := a_opts.target_of_name (a_name)
								remove_file (path_provider.project_session_path (l_target_opts.last_location))
							end (?, l_options))
					end
				else
					error_handler.add_error (create {ESC_C03}.make_with_context ([a_config.project_location]), False)
				end
			end
		end

feature -- Basic operations

	remove_file (a_file: STRING)
			-- Attempts to remove file `a_file'
		local
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make (a_file)
				if l_file.exists and then l_file.is_access_writable then
					l_file.delete
				end
			else
				error_handler.add_error (create {ESC_C01}.make_with_context ([a_file]), False)
			end
		rescue
			retried := True
			retry
		end

	remove_preferences
			-- Removes preferences from the windows registry
		deferred
		end

;note
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
