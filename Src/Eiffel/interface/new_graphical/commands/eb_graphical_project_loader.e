indexing
	description: "Graphical version for project loading."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_PROJECT_LOADER

inherit
	PROJECT_LOADER
		undefine
			warning_messages
		redefine
			is_project_location_requested,
			post_create_project,
			retrieve_or_create_project
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS
		rename
			project_location as compiler_project_location
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		end

	EB_COMMAND_EXECUTOR
		rename
			project_location as compiler_project_location
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent_window) is
			-- New instance of EB_GRAPHICAL_PROJECT_LOADER where dialogs are shown
			-- either relative or modal to `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_not_destroyed: not a_parent.is_destroyed
		do
			parent_window := a_parent
			deletion_agent := agent on_delete_directory
			cancel_agent := agent on_cancel_operation
			is_project_location_requested := True
			has_library_conversion := True
		ensure
			parent_window_set: parent_window = a_parent
			is_project_location_requested_set: is_project_location_requested
		end

feature -- Access

	parent_window: EV_WINDOW
			-- Parent for all dialogs shown.

feature -- Status report

	is_project_location_requested: BOOLEAN
			-- If `True', ask user for a project location, otherwise simply create
			-- project where configuration file is located.

feature -- Settings

	set_is_project_location_requested (v: like is_project_location_requested) is
			-- Set `is_project_location_requested' with `v'.
		do
			is_project_location_requested := v
		ensure
			is_project_location_requested_set: is_project_location_requested = v
		end

	compile_project is
			-- Compile newly created project.
		do
			ev_application.do_once_on_idle (
				agent (window_manager.last_focused_development_window.melt_project_cmd).execute)
		end

	launch_precompile_process (a_arguments: LIST [STRING]) is
			-- Launch precompile process `a_command'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_dialog: EB_EXTERNAL_OUTPUT_DIALOG
		do
			create l_prc_factory
			l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.ec_command_name, a_arguments, Void)
			l_prc_launcher.set_separate_console (False)
			l_prc_launcher.set_hidden (True)
			create l_dialog
			l_dialog.set_process (l_prc_launcher)
			l_dialog.set_title (interface_names.t_precompile_progress)
			l_prc_launcher.redirect_input_to_stream
			l_prc_launcher.redirect_output_to_agent (agent l_dialog.append_in_gui_thread)
			l_prc_launcher.redirect_error_to_same_as_output
			l_prc_launcher.set_on_exit_handler (agent l_dialog.hide_in_gui_thread)
			l_prc_launcher.set_on_terminate_handler (agent l_dialog.hide_in_gui_thread)
			l_prc_launcher.launch
			if l_prc_launcher.launched then
				l_dialog.show_modal_to_window (parent_window)
				is_precompilation_error := l_prc_launcher.exit_code /= 0
			end
		end

	open_project (in_new_studio: BOOLEAN) is
			-- Open project.
		require
			not_has_error: not has_error
			is_project_ready_for_compilation: not is_project_creation_or_opening_not_requested or is_project_ok
		do
			if in_new_studio then
				execute (estudio_cmd_line)
			end
		end

	melt_project (in_new_studio: BOOLEAN) is
			-- Open project.
		require
			not_has_error: not has_error
			is_compilation_requested: is_compilation_requested
			is_project_ready_for_compilation: not is_project_creation_or_opening_not_requested or is_project_ok
		do
			if not in_new_studio then
				ev_application.do_once_on_idle (
					agent (window_manager.last_focused_development_window.melt_project_cmd).execute)
			else
				execute (estudio_cmd_line + " -melt")
			end
		end

	precompile_project (in_new_studio: BOOLEAN) is
			-- Compile newly created project.
		require
			not_has_error: not has_error
			is_compilation_requested: is_compilation_requested
			is_project_ready_for_compilation: not is_project_creation_or_opening_not_requested or is_project_ok
		do
			if not in_new_studio then
				ev_application.do_once_on_idle (
					agent (window_manager.last_focused_development_window.precompilation_cmd).execute)
			else
				execute (estudio_cmd_line + " -precompile")
			end
		end

	freeze_project (in_new_studio: BOOLEAN) is
			-- Compile newly created project.
		require
			not_has_error: not has_error
			is_compilation_requested: is_compilation_requested
			is_project_ready_for_compilation: not is_project_creation_or_opening_not_requested or is_project_ok
		do
			if not in_new_studio then
				ev_application.do_once_on_idle (
					agent (window_manager.last_focused_development_window.freeze_project_cmd).execute)
			else
				execute (estudio_cmd_line + " -freeze")
			end
		end

	finalize_project (in_new_studio: BOOLEAN) is
			-- Compile newly created project.
		require
			not_has_error: not has_error
			is_compilation_requested: is_compilation_requested
			is_project_ready_for_compilation: not is_project_creation_or_opening_not_requested or is_project_ok
		do
			if not in_new_studio then
				ev_application.do_once_on_idle (
					agent (window_manager.last_focused_development_window.finalize_project_cmd).execute)
			else
				execute (estudio_cmd_line + " -finalize")
			end
		end

feature {NONE} -- Actions

	post_create_project is
			-- Actions performed after creating a new project.
		do
				-- Destroy and forget `deleting_dialog' if it was used.
			if delete_status_prompt /= Void and then delete_status_prompt.is_interface_usable then
				delete_status_prompt.recycle
				delete_status_prompt := Void
			end
		end

	retrieve_or_create_project (a_project_path: STRING_8) is
			-- Retrieve or create project.
		local
			l_win: EB_DEVELOPMENT_WINDOW
		do
			l_win := window_manager.last_created_window
			if l_win /= Void then
				-- We call it here to prevent Windows Desktop flickers.	
				l_win.lock_update
			end
			Precursor {PROJECT_LOADER} (a_project_path)
			if l_win /= Void then
				l_win.unlock_update
			end
		end

	estudio_cmd_line: STRING is
			-- Command line to open/compile currently selected project.
		require
			not_has_error: not has_error
		do
			create Result.make (1024)
			Result.append ("%"" + eiffel_layout.estudio_command_name + "%"")
			Result.append (" -config %"")
			Result.append (config_file_name)
			Result.append ("%" -project_path %"")
			Result.append (project_location)
			Result.append ("%" -target %"")
			Result.append (target_name)
			Result.append ("%"")
			if is_recompile_from_scrach then
				Result.append (" -clean ")
			end
		end

feature {NONE} -- Error reporting

	report_non_readable_configuration_file (a_file_name: STRING) is
			-- Report an error when `a_file_name' cannot be read.
		do
			report_loading_error (warning_messages.w_cannot_read_file (a_file_name))
		end

	report_non_readable_ace_file_in_epr (a_epr_name, a_file_name: STRING) is
			-- Report an error when ace file `a_file_name' cannot be accessed from epr file `a_epr_name'.
			-- Note that `a_file_name' can be Void if `a_epr_name' does not mention it.
		do
			report_loading_error (warning_messages.w_cannot_read_ace_file_from_epr (a_epr_name, a_file_name))
		end

	report_cannot_read_ace_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when ace  file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		do
			report_loading_error (warning_messages.w_unable_to_load_ace_file (a_file_name, a_conf_error.text))
		end

	report_cannot_read_config_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when a config file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		do
			report_loading_error (warning_messages.w_unable_to_load_config_file (a_file_name, a_conf_error.text))
		end

	report_cannot_save_converted_file (a_file_name: STRING) is
			-- Report an error when result of a conversion from ace to new format cannot be stored
			-- in file `a_file_name'.
		do
			report_loading_error (warning_messages.w_cannot_save_file (a_file_name))
		end

	report_cannot_convert_project (a_file_name: STRING) is
			-- Report an error when result of a conversion from ace `a_file_name' to new format failed.
		do
			report_loading_error (warning_messages.w_cannot_convert_file (a_file_name))
		end

	report_cannot_create_project (a_dir_name: STRING) is
			-- Report an error when we cannot create project in `a_dir_name'.
		do
			report_loading_error (warning_messages.w_cannot_create_project_directory (a_dir_name))
		end


	report_cannot_open_project (a_msg: STRING_GENERAL) is
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		do
			report_loading_error (a_msg)
		end

	report_incompatible_project (a_msg: STRING_GENERAL) is
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		local
			l_question: ES_DISCARDABLE_QUESTION_PROMPT
		do
			create l_question.make_standard (warning_messages.w_project_incompatible_version (config_file_name, version_number, eiffel_project.incompatible_version_number),
				interface_names.l_discard_convert_project_dialog, preferences.dialog_data.confirm_convert_project_string)
			l_question.set_button_action (l_question.dialog_buttons.yes_button, agent set_should_override_project (True))
			l_question.set_button_action (l_question.dialog_buttons.no_button, agent set_has_error)
			l_question.show (parent_window)
			if should_override_project then
				is_compilation_requested := True
			end
		end

	report_project_corrupted (a_msg: STRING_GENERAL) is
			-- Report an error when retrieving a project which is corrupted and possibly
			-- propose user to recompile from scratch.
		do
			report_loading_error (a_msg)
		end

	report_project_retrieval_interrupted (a_msg: STRING_GENERAL) is
			-- Report an error when project retrieval was stopped.
		do
			report_loading_error (a_msg)
		end

	report_project_incomplete (a_msg: STRING_GENERAL) is
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		do
			report_loading_error (a_msg)
		end

	report_project_loaded_successfully is
			-- Report that project was loaded successfully.
		local
			l_title: STRING_GENERAL
		do
			l_title := Interface_names.l_loaded_project.twin
			l_title.append (target_name)
			if Eiffel_system.is_precompiled then
				l_title.append (interface_names.l_precompiled)
			end
			window_manager.display_message (l_title)
			recent_projects_manager.add_recent_project (config_file_name)
			Recent_projects_manager.save_recent_projects

				--| IEK With project session handling this code is no longer needed, remove when fully integrated.
				-- We print text in the project_tool text concerning the system
				-- because we were successful retrieving the project without
				-- errors or conversion.
			output_manager.display_system_info

			if window_manager.development_windows_count = 1 then
				-- We only do this for frist window (not `last_focused_development_window') since
				-- if we have multi window, `synchronize' will put the stone which belong to the frist window to the last window.
				window_manager.development_windows.first.synchronize
			end

		end

	report_precompilation_error is
			-- Report that the precompilation of a precompile did not work.
		do
			report_loading_error (warning_messages.w_project_build_precompile_error)
		end

	report_loading_error (a_msg: STRING_GENERAL) is
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		local
			l_error: ES_ERROR_PROMPT
		do
			create l_error.make_standard (a_msg)
			l_error.set_sub_title (interface_names.t_configuration_loading_error)
			l_error.show (parent_window)
			set_has_error
		end

feature {NONE} -- User interaction

	ask_for_config_name (a_dir_name, a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new format, ask the
			-- user if he wants to create `a_file_name' or a different name. If he said yes, then
			-- execute `a_action' with chosen file_name, otherwise do nothing.
		local
			l_save_as: EV_FILE_SAVE_DIALOG
			l_file_name: FILE_NAME
			l_ev: EV_MESSAGE_DIALOG
			l_save_as_msg: STRING_32
		do
			create l_file_name.make_from_string (a_dir_name)
			l_file_name.set_file_name (a_file_name)

			create l_ev
			l_save_as_msg := interface_names.b_Save_as
			l_ev.set_title (interface_names.t_configuration_loading_message)
			l_ev.set_buttons (<<interface_names.b_ok, l_save_as_msg, interface_names.b_cancel>>)
			l_ev.set_default_push_button (l_ev.button (interface_names.b_ok))
			l_ev.set_default_cancel_button (l_ev.button (interface_names.b_ok))
			l_ev.set_text (warning_messages.w_configuration_files_needs_to_be_converted (a_file_name))

			create l_save_as.make_with_title (interface_names.t_choose_name_for_new_configuration_file)
			l_save_as.set_start_directory (a_dir_name)
			l_save_as.set_file_name (a_file_name)
			l_save_as.filters.extend ([config_files_filter, config_files_description])
			l_save_as.save_actions.extend (agent select_config_file (l_save_as, a_action))
			l_save_as.cancel_actions.extend (agent set_has_error)

			l_ev.button (l_save_as_msg).select_actions.extend (agent l_save_as.show_modal_to_window (parent_window))
			l_ev.button (interface_names.b_cancel).select_actions.extend (agent on_cancelled (l_ev))
			l_ev.button (interface_names.b_ok).select_actions.extend (agent a_action.call ([l_file_name.string]))
			l_ev.show_modal_to_window (parent_window)
		end

	select_config_file (a_dlg: EV_FILE_SAVE_DIALOG; a_action: PROCEDURE [ANY, TUPLE]) is
			-- Given a save dialog `a_dlg', check if the selected file does not exist, and then
			-- execute `a_action'. If file exists, display a warning and ask if user wants to
			-- override that file or not. If overriden, then execute `a_action', otherwise
			-- bring save dialog one more time.
		require
			a_dlg_not_void: a_dlg /= Void
			a_action_not_void: a_action /= Void
		local
			file_name: STRING
			file: RAW_FILE
		do
				-- This is a callback from the name chooser when user click OK.
			file_name := a_dlg.file_name
			check file_name_not_empty: not file_name.is_empty end
			create file.make (file_name)
			if file.exists then
				prompts.show_warning_prompt_with_cancel (Warning_messages.w_file_exists (file_name), parent_window, agent a_action.call ([file_name]), agent a_dlg.show_modal_to_window (parent_window))
			else
				a_action.call ([file_name])
			end
		end

	ask_for_target_name (a_target: STRING; a_targets: DS_ARRAYED_LIST [STRING]) is
			-- Ask user to choose one target among `a_targets'.
			-- If not Void, `a_target' is the one selected by user.
		local
			l_dialog: EV_DIALOG
			l_list: EV_LIST
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_select_button, l_button: EV_BUTTON
			l_item: EV_LIST_ITEM
			l_label: EV_LABEL
			l_need_choice: BOOLEAN
		do
			l_need_choice := True
			if a_targets.count = 1 then
				a_targets.start
				if a_target = Void or else a_target.is_equal (a_targets.item_for_iteration) then
					target_name := a_targets.item_for_iteration.twin
					l_need_choice := False
				end
			end
			if l_need_choice then
				if a_targets.is_empty then
					prompts.show_error_prompt (warning_messages.w_project_constains_no_compilable_target, parent_window, Void)
					has_error := True
					l_need_choice := False
				end
			end
			if l_need_choice then
				create l_dialog.make_with_title (interface_names.t_target_selection)

				if a_target = Void then
					create l_label.make_with_text (interface_names.l_one_target_among)
				else
					create l_label.make_with_text (interface_names.l_target_does_not_exist (a_target))
				end
				l_label.align_text_left
				create l_list
				from
					a_targets.start
				until
					a_targets.after
				loop
					create l_item.make_with_text (a_targets.item_for_iteration)
					l_item.pointer_double_press_actions.force_extend (agent on_target_selected (l_dialog, l_item))
					l_list.extend (l_item)
					a_targets.forth
				end
					-- Select first item by default.
				l_list.first.enable_select
				l_list.set_minimum_size (100, 150)

				create l_vbox
				l_vbox.set_border_width (default_border_size)
				l_vbox.set_padding (small_padding_size)

				l_vbox.extend (l_label)
				l_vbox.extend (l_list)

				create l_hbox
				l_hbox.set_padding (default_padding_size)
				l_vbox.extend (l_hbox)
				l_vbox.disable_item_expand (l_hbox)

				l_hbox.extend (create {EV_CELL})
				create l_select_button.make_with_text_and_action (interface_names.b_select_target, agent on_select_button_pushed (l_dialog, l_list))
				set_default_width_for_button (l_select_button)
				l_hbox.extend (l_select_button)
				l_hbox.disable_item_expand (l_select_button)

				create l_button.make_with_text_and_action (interface_names.b_cancel, agent on_cancelled (l_dialog))
				set_default_width_for_button (l_button)
				l_hbox.extend (l_button)
				l_hbox.disable_item_expand (l_button)
				l_hbox.extend (create {EV_CELL})

				l_dialog.extend (l_vbox)

				l_dialog.set_default_cancel_button (l_button)
				l_dialog.set_default_push_button (l_select_button)

				l_dialog.show_actions.extend (agent (a_list: EV_LIST)
					require
						a_list_not_void: a_list /= Void
					do
						a_list.set_focus
					end (l_list))
				l_dialog.show_modal_to_window (parent_window)
			end
		end

	ask_for_new_project_location (a_project_path: STRING) is
			-- Given a proposed location `a_project_path', ask user if he wants
			-- this location or another one.
		local
			l_create: EB_CREATE_PROJECT_DIALOG
		do
			create l_create.make_with_ace (parent_window, config_file_name, a_project_path)
			l_create.show_modal_to_parent
			has_error := not l_create.success
			if not has_error then
					-- Process if we should start compilation right away or wait.
				project_location := l_create.project_location
				is_compilation_requested := l_create.compile_project
			end
		end

	ask_compile_precompile is
			-- Should a needed precompile be automatically built?
		local
			l_question: ES_DISCARDABLE_QUESTION_PROMPT
		do
			create l_question.make_standard (warning_messages.w_project_build_precompile, interface_names.l_discard_build_precompile_dialog, preferences.dialog_data.confirm_build_precompile_string)
			l_question.set_button_action (l_question.dialog_buttons.yes_button, agent do is_user_wants_precompile := True end)
			l_question.show (parent_window)
		end

	ask_environment_update (a_key, a_old_val, a_new_val: STRING) is
			-- Should new environment values be accepted?
		local
			l_question: ES_QUESTION_PROMPT
		do
			create l_question.make_standard (warning_messages.w_environment_changed (a_key, a_old_val, a_new_val))
			l_question.set_button_action (l_question.dialog_buttons.yes_button, agent do is_update_environment := True end)
			l_question.set_button_action (l_question.dialog_buttons.no_button, agent do is_update_environment := False end)
			l_question.show (parent_window)
		end

feature {NONE} -- Actions

	choose_again: BOOLEAN
			-- We need to choose again the file

	on_delete_directory (deleted_files: ARRAYED_LIST [STRING]) is
			-- The files in `deleted_files' have just been deleted.
			-- Display
		local
			l_show: BOOLEAN
		do
			if not is_deletion_cancelled then
					-- Check a cancellation request hasn't been made, because if so then
					-- there is no need to report status any longer.
				l_show := delete_status_prompt = Void
				if l_show then
					delete_status_prompt := create_delete_status_prompt
					delete_status_prompt.dialog.set_minimum_width (600)
				end
				delete_status_prompt.set_text ((create {ISE_DIRECTORY_UTILITIES}).path_ellipsis (deleted_files.first, path_ellipsis_width))
				if l_show then
					delete_status_prompt.show (parent_window)
				end
			end
			ev_application.process_events
		end

	on_cancel_button_pushed is
			-- The user has just pushed the "Cancel" in the deleting dialog.
		do
			is_deletion_cancelled := True
		end

	on_cancel_operation: BOOLEAN is
			-- Has the user pushed the "Cancel" in the deleting dialog?
		do
			Result := is_deletion_cancelled
		end

	on_select_button_pushed (a_dlg: EV_DIALOG; a_list: EV_LIST) is
			-- Action when user click Select button for a target.
		require
			a_dlg_not_void: a_dlg /= Void
			a_dlg_not_destroyed: not a_dlg.is_destroyed
			a_list_not_void: a_list /= Void
			a_list_not_destroyed: not a_list.is_destroyed
		do
			if a_list.selected_item /= Void then
				target_name := a_list.selected_item.text
				a_dlg.destroy
			end
		ensure
			target_name_set: old a_list.selected_item /= Void implies (target_name /= Void)
		end

	on_target_selected (a_dlg: EV_DIALOG; a_item: EV_LIST_ITEM) is
			-- Action when user select a target with a double click.
		require
			a_dlg_not_void: a_dlg /= Void
			a_dlg_not_destroyed: not a_dlg.is_destroyed
			a_item_not_void: a_item /= Void
			a_item_not_destroyed: not a_item.is_destroyed
		do
			target_name := a_item.text
			a_dlg.destroy
		end

	on_cancelled (a_dlg: EV_DIALOG) is
			-- Action when user select a target with a double click.
		require
			a_dlg_not_void: a_dlg /= Void
		do
			has_error := True
			if not a_dlg.is_destroyed then
				a_dlg.destroy
			end
		end

feature {NONE} -- Factory

	delete_status_prompt: ES_PROMPT
			-- Delete directory status prompt

	create_delete_status_prompt: ES_PROMPT
			-- Create a delete status prompt
		local
			l_prompt: ES_INFORMATION_PROMPT
			l_dialog: ES_DIALOG
		do
			create l_prompt.make_standard ("")
			l_prompt.set_sub_title (interface_names.st_cleaning_project)
			l_prompt.set_button_text (l_prompt.dialog_buttons.ok_button, interface_names.b_cancel)
			l_prompt.set_button_action (l_prompt.dialog_buttons.ok_button, agent
				do
					on_cancel_button_pushed
				end)
				-- Remove default modal state of prompt
			l_dialog := l_prompt
			l_dialog.set_is_modal (False)

			Result := l_prompt
		end

feature {NONE} -- Implementation / Private constants.

	path_ellipsis_width: INTEGER = 70
			-- Maximum number of characters per item.

invariant
	parent_window_not_void: parent_window /= Void
	parent_window_not_destroyed: not parent_window.is_destroyed

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
end
