note
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

	SHARED_NOTIFICATION_SERVICE
		export
			{NONE} all
		end

	SHARED_ES_CLOUD_SERVICE
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	ES_ARGUMENTS

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

	SHARED_FORMAT_INFO
		export
			{NONE} all
		end

	SHARED_EIFFEL_EDITION

	EIFFEL_EDITION

	PREFERENCES_VERSIONS

feature {NONE} -- Initialization

	make
		do
			set_eiffel_edition (Current)
		end

	initialize_services
			-- Initializes graphical services.
		do
			if attached (create {SERVICE_CONSUMER [SERVICE_CONTAINER_S]}).service as s then
				service_initializer.add_core_services (s)
			end
				-- Initialize prompts.
			set_prompts (create {EB_PROMPT_PROVIDER})
		end

	compiler_initialization
			-- Various initialization of the compiler
		local
			l_compiler_setting: SETTABLE_COMPILER_OBJECTS
			l_layout: ES_EIFFEL_LAYOUT
			pref_strs: PREFERENCE_CONSTANTS
			new_resources: TTY_RESOURCES
			preference_access: PREFERENCES
			l_studio_preferences: EB_PREFERENCES
		do
				-- Check that environment variables
				-- are properly set.
			check not_is_eiffel_layout_defined: is_eiffel_layout_defined implies eiffel_layout.generating_type ~ {ES_EIFFEL_LAYOUT} end
			create l_layout
			set_eiffel_layout (l_layout)
			l_layout.check_environment_variable

			create l_compiler_setting
			l_compiler_setting.set_command_executor (create {EB_COMMAND_EXECUTOR})

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			;(create {INIT_SERVERS}.make).do_nothing

				-- Initialization of compiler resources
			create new_resources.initialize

				--| Initialization of global resources.		
			create pref_strs
				-- Initialize pixmaps
			pref_strs.Pixmaps_extension_cell.put ("png")
			pref_strs.Pixmaps_path_cell.put (eiffel_layout.bitmaps_path.extended ("png"))

			if not new_resources.error_occurred then
				-- One has to quit there.
			end

				-- Initialization of compiler resources.
			create preference_access.make_with_defaults_and_location_and_version (
				<<eiffel_layout.general_preferences.name, eiffel_layout.platform_preferences.name>>, eiffel_layout.eiffel_preferences, version_2_0)
			create l_studio_preferences.make (preference_access, True, True)
			l_compiler_setting.set_preferences (l_studio_preferences)

				-- Create and setup the output manager / Error displayer
			set_external_output_manager (create {EB_EXTERNAL_OUTPUT_MANAGER})

				-- Set the error display for graphical output
			eiffel_project.set_error_displayer (create_error_displayer)

				-- Create and setup the degree output window.
			if not preferences.development_window_data.graphical_output_disabled then
				Eiffel_project.set_degree_output (create {ES_GRAPHICAL_DEGREE_OUTPUT})
			end

				-- Create and setup the recent projects manager
			set_recent_projects_manager (create {EB_RECENT_PROJECTS_MANAGER}.make)

					-- Formatting includes breakpoints
			set_is_with_breakable

				-- Initialize compiler encoding converter.
			;(create {SHARED_ENCODING_CONVERTER}).set_encoding_converter (create {EC_ENCODING_CONVERTER}.make)

				-- Install code analyzer processor for obsolete calls.
			;(create {CA_CODE_ANALYZER}.make).install_obsolete_call_processor
		ensure
			eiffel_layout_not_void: eiffel_layout /= Void
		end

	initialize_cloud
			-- Initialization for the account system.
		local
			ctlr: ES_CLOUD_CONTROLLER
		do
			create ctlr.make
			if attached ctlr.es_cloud_s.service as s then
				s.register_observer (ctlr)
				s.set_eiffel_edition (Current)
			end
		end

	initialize_debugger
			-- Various initialization of the debugger
		do
			(create {EB_DEBUGGER_MANAGER}.make).register
		end

	initialize_notifications
		do
-- Add global notifications if needed here.
--			if attached notification_s.service as l_notif_service then
--
--			end
		end

feature -- Edition access

	edition_name: STRING
		deferred
		end

	is_standard_edition: BOOLEAN
			-- Is Standard edition?
		do
			Result := edition_name.is_whitespace
		end

	is_enterprise_edition: BOOLEAN
			-- Is Enterprise edition?
		do
			Result := edition_name.is_case_insensitive_equal ("enterprise")
		end

	is_branded_edition: BOOLEAN
		do
			Result := not (is_standard_edition or is_enterprise_edition)
		end

feature {NONE} -- Access

	service_initializer: SERVICE_INITIALIZER
			-- Initializer used to register all services.
		local
			t: like {REFLECTOR}.dynamic_type_from_string
		once
			t := {REFLECTOR}.dynamic_type_from_string ("ES_SERVICE_INITIALIZER_EXTENSION")
			if
				t >= 0 and then
				not {REFLECTOR}.type_of_type (t).is_deferred and then
				attached {ES_SERVICE_INITIALIZER} {REFLECTOR}.new_instance_of (t) as e
			then
				Result := e
			else
				create {ES_SERVICE_INITIALIZER} Result
			end
		end

feature {NONE} -- Implementation (preparation of all widgets)

	prepare (an_app: EV_APPLICATION)
			-- Build graphical compiler
		require
			an_app_not_void: an_app /= Void
		do
			initialize_services
			compiler_initialization

			initialize_cloud

			initialize_debugger

			initialize_notifications

				-- Create a development window
			window_manager.create_window

				-- Initialize the configuration pixmaps
			;(create {CONF_GUI_INTERFACE_CONSTANTS}).set_pixmaps (pixmaps.configuration_pixmaps)

				-- Initialize external command manager
			incoming_command_manager_cell.put (create {ES_INCOMING_COMMAND_MANAGER}.make (create {ES_COMMAND_RECEIVER_CALLBACKS}.make))
				-- Retrive EIS storage when project loaded.
				-- Put front in case the background visitor has been started in prior agents.
			eiffel_project.manager.load_agents.put_front (agent eis_manager.retrieve_storage)
				-- Save EIS storage when project is closed.
			eiffel_project.manager.close_agents.extend (agent eis_manager.save_storage)

			launch_interface
		end

	launch_interface
		do
			if preferences.dialog_data.show_first_launching_dialog then
				display_first_launching_dialog (agent display_launching_page)
			else
				display_launching_page
			end
		end

feature {NONE} -- Welcome dialog

	display_launching_page
		do
			if is_standard_edition and preferences.dialog_data.show_update_manager_dialog then
				display_version_updater_check (agent display_startup_page)
			else
				display_startup_page
			end
		end

	display_version_updater_check (cb: PROCEDURE)
		local
			up_checker: ES_RELEASE_UPDATE_CHECKER
		do
			if is_eiffel_layout_defined then
				create up_checker.make (preferences.misc_data.update_channel, eiffel_layout.eiffel_platform, eiffel_layout.version_name)
				up_checker.async_check_for_update (agent (a_rel: detachable ES_UPDATE_RELEASE)
						local
							m: NOTIFICATION_MESSAGE_WITH_ACTIONS
						do
							if a_rel /= Void then
								if attached notification_s.service as s_notif then
									create m.make ({STRING_32} "Update is available: " + a_rel.filename, "version_check")
									m.register_action (agent (i_link: READABLE_STRING_GENERAL)
											local
												b: BOOLEAN
											do
												b := (create {ES_URI_LAUNCHER}).launch (i_link)
											end(a_rel.link)
										, "Try it now!")
									s_notif.notify (m)
								end
								ev_application.add_idle_action_kamikaze (agent display_update_manager_dialog (a_rel, Void))
							end
						end(?)
					)
				cb.call (Void)
			else
				cb.call (Void)
			end
		end

	display_startup_page
		local
			pg: ES_STARTUP_PAGE
			first_window: EB_DEVELOPMENT_WINDOW
			win: EV_WINDOW
		do
			first_window := window_manager.last_created_window
			check
				first_window_not_void: first_window /= Void
			end
			win := first_window.window

			create pg.make (Current)
			pg.set_quit_action (agent do (create {EB_EXIT_APPLICATION_COMMAND}).execute_with_confirmation (False) end)
			pg.set_next_action (agent load_interface)
			pg.dialog.set_size (first_window.scaled_size (300), first_window.scaled_size (100))
			pg.dialog.show_actions.extend_kamikaze (agent (i_dlg: EV_DIALOG; i_win: EV_WINDOW)
					do
						i_dlg.set_position (
								i_win.x_position + (i_win.width - i_dlg.width) // 2,
								i_win.y_position + (i_win.height - i_dlg.height) // 2
							)
					end(pg.dialog, win)
				)
			pg.start (win)
		end

feature {NONE} -- Implementation: interface loading		

	load_interface
			-- Start interface according to arguments.
		local
			project_index: INTEGER
		do
				-- Account manager
				-- FIXME: find better place.
			across
				window_manager.development_windows as ic
			loop
				if attached ic.item.show_cloud_account_cmd as l_cmd then
					l_cmd.refresh
				end
			end

				-- If some more arguments were specified, it means that we either asked to retrieve
				-- an existing project, or to create one.
			project_index := index_of_word_option ("config")
			if
				project_index /= 0 and
				argument_count >= project_index + 1 and then
				attached argument (project_index + 1) as l_config_pathname
			then
				load_project_file (l_config_pathname)
			else
					-- Show starting dialog, if enabled in prefs.
				display_starting_dialog_if_enabled
			end
		end

	load_project_file (a_config_pathname: READABLE_STRING_GENERAL)
			-- Load project file from path `a_config_pathname`.
		require
			non_blank_config_pathname: a_config_pathname /= Void and then not a_config_pathname.is_whitespace
		local
			path_index: INTEGER
			target_index: INTEGER
			l_config: PATH
			l_project_path: detachable PATH
			l_target: detachable STRING_32
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
				-- A project was specified.
			create l_config.make_from_string (a_config_pathname)
			path_index := index_of_word_option ("project_path")
			if path_index /= 0 and argument_count >= path_index + 1 then
				create l_project_path.make_from_string (argument (path_index + 1))
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
			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Handle (multiple) -config_option values and pass them to project loader.")
			end
-- TODO: why not using the absolute pate?
--			l_loader.open_project_file (l_config.absolute_path.canonical_path, l_target, l_project_path, index_of_word_option ("clean") /= 0, Void)
			l_loader.open_project_file (l_config, l_target, l_project_path, index_of_word_option ("clean") /= 0, Void)
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
		end

	display_starting_dialog_if_enabled
			-- Display starting dialog, if pref `show_starting_dialog` is enabled.
		do
			if preferences.dialog_data.show_starting_dialog then
				display_starting_dialog
			end
		end

	display_starting_dialog
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

	display_first_launching_dialog (cb: detachable PROCEDURE [TUPLE])
			-- Show the starting dialog , when EiffelStudio is launched for the first time
			-- And call `cb` when dialog is closed (cancelled or not).
		local
			dlg: ES_FIRST_LAUNCHING_DIALOG
			first_window: EB_DEVELOPMENT_WINDOW
		do
			if
				is_eiffel_layout_defined and then
				eiffel_layout.installed_version_names.count > 1
			then
				first_window := window_manager.last_created_window
				check
					first_window_not_void: first_window /= Void
				end

				create dlg.make (eiffel_layout.version_name)
				if cb /= Void then
					dlg.next_actions.extend (cb)
				end
				dlg.show_on_active_window
			elseif cb /= Void then
				cb.call (Void)
			end
		end

	display_update_manager_dialog (a_release: ES_UPDATE_RELEASE; cb: detachable PROCEDURE [TUPLE])
			-- Show the starting dialog letting the user choose where
			-- his project is (or will be).
			-- And call `cb` when dialog is closed (cancelled or not).
		local
			dlg: ES_UPDATE_MANAGER_DIALOG
			first_window: EB_DEVELOPMENT_WINDOW
		do
			if
				is_eiffel_layout_defined and then
				eiffel_layout.installed_version_names.count > 1
			then
				first_window := window_manager.last_created_window
				check
					first_window_not_void: first_window /= Void
				end

				create dlg.make (a_release)
				if cb /= Void then
					dlg.next_actions.extend (cb)
				end
				dlg.show_on_active_window
			elseif cb /= Void then
				cb.call (Void)
			end
		end

feature {NONE} -- Exception handling

	handle_exception (a_exception: EXCEPTION)
			-- Handle the exception `a_exception'
		do
				-- Attempt to salvage any open files
			try_to_save_files

				-- Attempts to store session data
			try_to_save_session_data

				-- Raise exception dialog
			clean_exit (a_exception.trace)
		end

	parent_for_dialog: EV_WINDOW
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

	try_to_save_files
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

	try_to_save_session_data
			-- In case of a crash, try to store the session data.
		local
			retried: BOOLEAN
		do
			if not retried then
				if attached (create {SERVICE_CONSUMER [SESSION_MANAGER_S]}).service as s and then s.is_interface_usable then
						-- Stores all session data.
					s.store_all
				end
			else
				prompts.show_error_prompt (interface_messages.e_save_session_data_failed, parent_for_dialog, Void)
			end
		rescue
			retried := True
			retry
		end

	clean_exit (trace: READABLE_STRING_GENERAL)
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

invariant

		unique_edition: is_standard_edition xor is_enterprise_edition xor is_branded_edition
		valid_branded_edition: is_branded_edition implies not edition_name.is_whitespace

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
