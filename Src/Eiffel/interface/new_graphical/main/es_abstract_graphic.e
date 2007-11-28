indexing
	description: "Main abstract class for Graphic mode in EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_ABSTRACT_GRAPHIC

inherit
	EB_SHARED_INTERFACE_TOOLS

	SHARED_EIFFEL_PROJECT

	ARGUMENTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	SHARED_SERVICE_PROVIDER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize_services
			-- Initializes graphical services
		local
			l_container: SERVICE_CONTAINER
		do
			l_container ?= service_provider.query_service ({SERVICE_CONTAINER})
			add_core_services (l_container)
		end

feature {NONE} -- Implementation (preparation of all widgets)

	prepare (an_app: EV_APPLICATION) is
			-- Build graphical compiler
		require
			an_app_not_void: an_app /= Void
		local
			project_index: INTEGER
			path_index: INTEGER
			target_index: INTEGER
			l_config, l_project_path, l_target: STRING
			an_output_manager: EB_GRAPHICAL_OUTPUT_MANAGER

			an_external_output_manager: EB_EXTERNAL_OUTPUT_MANAGER
			a_c_compilation_output_manager: EB_C_COMPILATION_OUTPUT_MANAGER

			a_recent_projects_manager: EB_RECENT_PROJECTS_MANAGER
			first_window: EB_DEVELOPMENT_WINDOW
			a_graphical_degree_output: ES_GRAPHICAL_DEGREE_OUTPUT
			preference_access: PREFERENCES
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
				--| If we don't put bench mode here,
				--| `error_window' will assume batch
				--| mode and thus it will initialize
				--| `error_window' as a TERM_WINDOW.
				--| Also note that `error_window' is a
				--| once-function!!

			initialize_services

				-- Initialization of compiler resources.
			create preference_access.make_with_defaults_and_location (
				<<eiffel_layout.general_preferences, eiffel_layout.platform_preferences>>, eiffel_layout.eiffel_preferences)
			initialize_preferences (preference_access, True, True)

				-- Create and setup the output manager / Error displayer
			create an_output_manager
			set_output_manager (an_output_manager)
			create an_external_output_manager
			set_external_output_manager (an_external_output_manager)
			create a_c_compilation_output_manager
			set_c_compilation_output_manager (a_c_compilation_output_manager)

				-- Set the error display for graphical output
			eiffel_project.set_error_displayer (create_error_displayer)

				-- Create and setup the degree output window.
			if not preferences.development_window_data.graphical_output_disabled then
				create a_graphical_degree_output.make_with_output_manager (output_manager)
				Eiffel_project.set_degree_output (a_graphical_degree_output)
			end

				-- Create and setup the recent projects manager
			create a_recent_projects_manager.make
			set_recent_projects_manager (a_recent_projects_manager)

				-- Create a development window
			window_manager.create_window
			first_window := window_manager.last_created_window

			mode.set_item (False)
				-- If some more arguments were specified, it means that we either asked to retrieve
				-- an existing project, or to create one.
			project_index := index_of_word_option ("config")
			if project_index /= 0 and argument_count >= project_index + 1 then
					-- A project was specified.
				l_config := argument (project_index + 1)
				path_index := index_of_word_option ("project_path")
				if path_index /= 0 and argument_count >= path_index + 1 then
					l_project_path := argument (path_index + 1)
				end
				target_index := index_of_word_option ("target")
				if target_index /= 0 and argument_count >= target_index + 1 then
					l_target := argument (target_index + 1)
				end

				check window_manager.last_created_window /= Void end
				create l_loader.make (window_manager.last_created_window.window)
				if path_index /= 0 then
					l_loader.set_is_project_location_requested (False)
				end
				l_loader.open_project_file (l_config, l_target, l_project_path, index_of_word_option ("clean") /= 0)
				if
					not l_loader.has_error and then
					not l_loader.is_compilation_requested
				then
					if index_of_word_option ("melt") /= 0 then
						l_loader.set_is_compilation_requested (True)
						l_loader.melt_project (False)
					elseif index_of_word_option ("freeze") /= 0 then
						l_loader.set_is_compilation_requested (True)
						l_loader.freeze_project (False)
					elseif index_of_word_option ("finalize") /= 0 then
						l_loader.set_is_compilation_requested (True)
						l_loader.finalize_project (False)
					elseif index_of_word_option ("precompile") /= 0 then
						l_loader.set_is_compilation_requested (True)
						l_loader.precompile_project (False)
					end
				end
			else
					-- Show starting dialog.
				if preferences.dialog_data.show_starting_dialog then
					display_starting_dialog
				end
			end

				-- Register help engine
			an_app.set_help_engine (create {EB_HELP_ENGINE}.make)
		end

	display_starting_dialog is
			-- Show the starting dialog letting the user choose where
			-- his project is (or will be).
		local
			project_dialog: EB_STARTING_DIALOG
			first_window: EB_DEVELOPMENT_WINDOW
		do
			first_window := window_manager.last_created_window
			check
				first_window_not_void: first_window /= Void
			end

			create project_dialog.make_default
			project_dialog.show_modal_to_window (first_window.window)
		end

feature {NONE} -- Services

	add_core_services (a_container: SERVICE_CONTAINER)
			-- Initialize core services for the graphical IDE.
			--
			-- `a_container': The service container to add services to.
		require
			a_container_attached: a_container /= Void
		do
			a_container.add_service_with_activator ({EVENT_LIST_SERVICE_S}, agent create_event_list_service, False)
			a_container.add_service_with_activator ({SESSION_MANAGER_S}, agent create_session_manager_service, False)
		end

feature {NONE} -- Service factories

	create_event_list_service: EVENT_LIST_SERVICE_S
			-- Creates the event list service
		do
			create {EVENT_LIST_SERVICE} Result.make
		end

	create_session_manager_service: SESSION_MANAGER_S
			-- Creates the session manager service
		do
			create {SESSION_MANAGER} Result
		end

feature {NONE} -- Exception handling

	handle_exception (a_exception: EXCEPTION) is
			-- Handle the exception `a_exception'
		do
				-- Attempt to salvage any open files
			try_to_save_files
				-- Raise exception dialog
			clean_exit (a_exception.trace_as_string)
		end

	parent_for_dialog: EV_WINDOW is
			-- Retrieve or create a parent for `show_modal_to_window'	
		local
			dev_window: EB_DEVELOPMENT_WINDOW
		do
			dev_window := Window_manager.last_focused_development_window
			if dev_window /= Void then
				Result := dev_window.window
			else
				create Result
			end
		end

	try_to_save_files is
			-- In case of a crash, try to make a backup of all edited files.
		local
			retried: BOOLEAN
		do
			if not retried then
				if window_manager.has_modified_windows then
					prompts.show_error_prompt (warning_messages.w_crashed, parent_for_dialog, Void)
					window_manager.backup_all
					if window_manager.not_backuped = 0 then
						prompts.show_info_prompt (warning_messages.w_backup_succeeded, parent_for_dialog, Void)
					else
						prompts.show_warning_prompt (warning_messages.w_backup_partial (window_manager.not_backuped), parent_for_dialog, Void)
					end
				end
			else
				prompts.show_error_prompt (warning_messages.w_backup_failed, parent_for_dialog, Void)
			end
		rescue
			retried := True
			retry
		end

	clean_exit (trace: STRING) is
			-- Perform clean quit of $EiffelGraphicalCompiler$
		local
			l_dialog: ES_EXCEPTION_DIALOG
		do
			create l_dialog.make
			l_dialog.set_trace (trace)
			l_dialog.show (parent_for_dialog)
			l_dialog.recycle
		end

feature {NONE} -- Factory

	create_error_displayer: ERROR_DISPLAYER
			-- Create a new error displayer, used to display error information in the graphical environment
		require
			window_manager_attached: window_manager /= Void
		do
			create {ES_ERROR_DISPLAYER} Result.make (window_manager)
		ensure
			result_attached: Result /= Void
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

end -- class ES_GRAPHIC
