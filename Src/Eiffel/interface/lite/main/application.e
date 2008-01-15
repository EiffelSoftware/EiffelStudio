indexing
	description: "Eiffel lite compiler application root"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	EC_SHARED_PREFERENCES
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

-- Access convience

	CONF_ACCESS
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
			new_resources: TTY_RESOURCES
			l_ec_preferences: EC_PREFERENCES
			l_compiler_setting: SETTABLE_COMPILER_OBJECTS
		do
				-- Check that environment variables
				-- are properly set.
			if not is_eiffel_layout_defined then
				create l_env
				l_env.check_environment_variable
				set_eiffel_layout (l_env)
			end

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			create l_eifgen_init.make

				-- Initialization of compiler resources
			create new_resources.initialize

				-- Initialization of compiler resources.
			create l_preference_access.make_with_defaults_and_location (
				<<eiffel_layout.general_preferences, eiffel_layout.platform_preferences>>, eiffel_layout.eiffel_preferences)
			create l_ec_preferences.make (l_preference_access)
			create l_compiler_setting
			l_compiler_setting.set_preferences (l_ec_preferences)

				-- We are always in batch mode
			set_stop_on_error (True)

			create l_parser.make
			l_parser.execute (agent start (l_parser))

				-- Dispose
			l_eifgen_init.dispose
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Starts application after all command-line arguments have been validated.
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.successful
		local
			l_command: like command_for_parser_state
			l_displayer: ECL_ERROR_DISPLAYER
			l_loader: PROJECT_LOADER
			l_resources: TTY_RESOURCES
			l_window: OUTPUT_WINDOW_STREAM
			l_err_window: OUTPUT_WINDOW_STREAM
			l_degree_out: ECL_DEGREE_OUTPUT
			l_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				create l_resources.initialize

				create l_window.make (io.standard_default)

				l_command := command_for_parser_state (a_parser)
				l_command.set_output_window (l_window)

					-- Initialization of the display	
				l_name := a_parser.project_alias
				if l_name = Void then
					l_name := a_parser.system_name
				end

				create l_err_window.make (io.error)
				create l_displayer.make (l_name, l_err_window)
				eiffel_project.set_error_displayer (l_displayer)

				create l_degree_out.make (l_window)
				l_degree_out.set_is_output_quiet (not a_parser.verbose_output)
				eiffel_project.set_degree_output (l_degree_out)

					-- Load project
				l_loader := load_project_file (a_parser)
				if not l_loader.has_error then
					-- Perform exection
					l_command.set_is_finish_freezing_called (a_parser.compile_c_code)
					l_command.execute
				end
			else
				l_window.put_new_line
				l_window.display
				l_err_window.display
				if l_displayer /= Void then

					if not error_handler.warning_list.is_empty then
						l_displayer.trace_warnings (error_handler)
						l_window.put_new_line
						l_window.display
						l_err_window.display
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
					create {EWB_FINALIZE_PRECOMP}Result.make (a_parser.optimized_options.keep_assertions)
				else
					create {EWB_PRECOMP}Result
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

	load_project_file (a_parser: ARGUMENT_PARSER): PROJECT_LOADER is
			-- Loads a configuration file from parser `a_parser'
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.successful
		local
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			l_visitor: CONF_PRINT_VISITOR
			l_settings: HASH_TABLE [STRING, STRING]
			l_loader: EC_PROJECT_LOADER
			l_file: PLAIN_TEXT_FILE
			l_file_name: STRING
			l_cursor: CURSOR
		do
			create l_loader
			l_loader.set_should_stop_on_prompt (not a_parser.interactive_mode)
			l_loader.set_has_library_conversion (False)
			l_loader.set_ignore_user_configuration_file (True)

			l_settings := a_parser.configuration_settings
			if not l_settings.is_empty then
					-- Duplicate project file and set settings.
				l_file := modified_configuration_file (a_parser)
				if l_file /= Void then
					if inject_src_configuration_file (a_parser.configuration_file, l_file) then
						l_file.close

						l_file_name := l_file.name
						l_loader.open_project_file (l_file_name, a_parser.target, a_parser.project_location, a_parser.clean_project)
						if not l_loader.has_error then

								-- Retrieve applicable target.
							l_system := l_loader.eiffel_project.lace.conf_system
							check l_system_attached: l_system /= Void end
							if a_parser.target /= Void then
								l_target := l_system.compilable_targets.item (a_parser.target)
							elseif a_parser.precompile then
								l_target := l_system.library_target
							else
								l_target := l_system.application_target
							end

							if l_target /= Void then
									-- Add settings to configuration.
								l_cursor := l_settings.cursor
								from l_settings.start until l_settings.after loop
									l_target.add_setting (l_settings.key_for_iteration, l_settings.item_for_iteration)
									l_settings.forth
								end
								l_settings.go_to (l_cursor)
							end

								-- Write configuration text.
							create l_visitor.make
							l_system.set_file_name (l_file_name)
							l_visitor.process_system (l_system)

								-- Reset file so we can rewrite from the beginning
							l_file.reset (l_file.name)
							l_file.open_write
							l_file.put_string (l_visitor.text)
							l_file.flush
							l_file.close
						else
							l_file.close

								-- Source configuration file was probably not locatable, so let the configuration systen
								-- handle the error.
							l_loader.open_project_file (a_parser.configuration_file, a_parser.target, a_parser.project_location, a_parser.clean_project)
						end
					end
				else
						-- Source configuration file was probably not locatable, so let the configuration systen
						-- handle the error.	
					l_loader.open_project_file (a_parser.configuration_file, a_parser.target, a_parser.project_location, a_parser.clean_project)
				end
			else
					-- No setting set, use regular configuration file.
				l_loader.open_project_file (a_parser.configuration_file, a_parser.target, a_parser.project_location, a_parser.clean_project)
			end

			Result := l_loader
		ensure
			result_attached: Result /= Void
		end

	modified_configuration_file (a_parser: ARGUMENT_PARSER): PLAIN_TEXT_FILE is
			-- Retrieve a modified configuration file stream opened for writing.
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.successful
		local
			l_cfg_file: STRING
			l_file_name: FILE_NAME
			l_project_location: STRING
			l_slash_pos: INTEGER
			l_count: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_project_location := a_parser.project_location
				if l_project_location /= Void then
						-- Store project configuration file in project location
					l_cfg_file := a_parser.configuration_file.twin
					l_cfg_file.prune_all_trailing (operating_environment.directory_separator)
					l_count := l_cfg_file.count

						-- Retrieve file name			
					l_slash_pos := l_cfg_file.last_index_of (operating_environment.directory_separator, l_count)
					if l_slash_pos < l_count then
						l_cfg_file := l_cfg_file.substring (l_slash_pos + 1, l_count)
					end

					create l_file_name.make_from_string (l_project_location)
					l_file_name.set_file_name (l_cfg_file)
				else
						-- Store project configuration file next to ecf
					create l_file_name.make_from_string (a_parser.configuration_file)
				end
				l_file_name.add_extension ("ecl")

				create Result.make_open_write (l_file_name.out)
			else
					-- Use temporary file location
				create l_file_name.make_temporary_name
				create Result.make_open_write (l_file_name.out)
			end
		ensure
			result_opened_for_writing: Result /= Void implies Result.is_open_write
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	inject_src_configuration_file (a_src_file: STRING; a_dest_file: PLAIN_TEXT_FILE): BOOLEAN is
			-- Injects a source file `a_src_file' into open file `a_dest_file'.
		require
			a_src_file_attached: a_src_file /= Void
			not_a_src_file_is_empty: not a_src_file.is_empty
			a_dest_file_attached: a_dest_file /= Void
			a_dest_file_is_open_write: a_dest_file.is_open_write or a_dest_file.is_open_append
		local
			l_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_open_read (a_src_file)
				l_file.copy_to (a_dest_file)
				a_dest_file.flush
				l_file.close
				Result := True
			else
				if l_file /= Void and then not l_file.is_closed then
					l_file.close
				end
				Result := False
			end
		ensure
			not_a_dest_file_is_close: not a_dest_file.is_closed
		rescue
			retried := True
			retry
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
