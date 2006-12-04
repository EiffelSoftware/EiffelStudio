indexing
	description: "Eiffel lite compiler application root"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_ERROR_BEHAVIOR
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
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

	make is
			-- Application entry point.
		local
			l_env: ECL_EIFFEL_ENV
			l_eifgen_init: INIT_SERVERS
			l_preference_access: PREFERENCES
			l_parser: ARGUMENT_PARSER
		do
				-- Check that environment variables
				-- are properly set.
			if not is_eiffel_layout_defined then
				create l_env
				l_env.check_environment_variable
				set_eiffel_layout (l_env)
			else
					-- Need to initialize with our own environment.
				check False end
			end

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			create l_eifgen_init.make

				-- Initialization of compiler resources.
			create l_preference_access.make_with_defaults_and_location (
				<<eiffel_layout.general_preferences, eiffel_layout.platform_preferences>>, eiffel_layout.eiffel_preferences)
			initialize_preferences (l_preference_access, False)

				-- We are always in batch mode
			set_stop_on_error (True)

			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Starts application after all command-line arguments have been validated.
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.successful
		local
			l_command: like command_for_parser_state
			l_displayer: ECL_ERROR_DISPLAYER
			l_loader: EC_PROJECT_LOADER
			l_resources: TTY_RESOURCES
			l_window: OUTPUT_WINDOW_STREAM
			l_degree_out: ECL_DEGREE_OUTPUT
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			retried: BOOLEAN
		do
			if not retried then
				create l_resources.initialize

				create l_window.make (io.standard_default)

				l_command := command_for_parser_state (a_parser)
				l_command.set_output_window (l_window)

					-- Initialization of the display	
				create l_displayer.make (create {OUTPUT_WINDOW_STREAM}.make (io.error))
				eiffel_project.set_error_displayer (l_displayer)
				eiffel_project.set_batch_mode (True)

				create l_degree_out.make (l_window)
				l_degree_out.set_is_output_quiet (not a_parser.verbose_output)
				eiffel_project.set_degree_output (l_degree_out)

					-- Load project
				create l_loader
				l_loader.set_should_stop_on_prompt (True)
				l_loader.set_has_library_conversion (False)
					-- Should implement use_settings
				l_loader.set_ignore_user_configuration_file (True)
				l_loader.open_project_file (a_parser.configuration_file, a_parser.target, a_parser.project_location, a_parser.clean_project)

				if not l_loader.has_error then
						-- Set configuration settings
					l_system := l_loader.eiffel_project.lace.conf_system
					if l_system /= Void then
						l_target := l_system.application_target
						if l_target /= Void then
							l_target.settings.merge (a_parser.configuration_settings)

								-- Perform exection
							l_command.set_is_finish_freezing_called (a_parser.compile_c_code)
							l_command.execute
						end
					end
				end
			else
				if l_displayer /= Void then
					if not error_handler.warning_list.is_empty then
						l_displayer.trace_warnings (error_handler)
					end
					l_displayer.trace_errors (error_handler)
					l_displayer.force_display
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Query

	command_for_parser_state (a_parser: ARGUMENT_PARSER): EWB_COMP is
			-- Retrieves a command given a parser's `a_parser' state
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.successful
		do
			if a_parser.precompile then
				if a_parser.optimize then
					create {EWB_FINALIZE_PRECOMP}Result.make (False, a_parser.optimized_options.keep_assertions)
				else
					create {EWB_PRECOMP}Result.make (False)
				end
			else
				if a_parser.optimize then
					create {EWB_FINALIZE}Result.make (a_parser.optimized_options.keep_assertions)
				elseif a_parser.freeze_code then
					create {EWB_FREEZE}Result
				elseif a_parser.force_lookup then
					create {EWB_COMP}Result
				else
					create {EWB_QUICK_MELT}Result
				end
			end
		ensure
			result_attached: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {APPLICATION}
