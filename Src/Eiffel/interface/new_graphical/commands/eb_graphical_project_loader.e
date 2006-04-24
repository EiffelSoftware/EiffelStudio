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
			post_create_project
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS
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

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_LAYOUT_CONSTANTS
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
				agent (window_manager.last_focused_development_window.quick_melt_project_cmd).execute)
		end

feature {NONE} -- Actions

	post_create_project is
			-- Actions performed after creating a new project.
		do
				-- Destroy and forget `deleting_dialog' if it was used.
			if deleting_dialog /= Void and then not deleting_dialog.is_destroyed then
				deleting_dialog.destroy
				deleting_dialog := Void
			end
		end

feature {NONE} -- Error reporting

	new_error_dialog: EV_ERROR_DIALOG is
			-- New error dialog properly initialized.
		do
			create Result
			Result.set_title ("Configuration Loading Error")
			Result.set_buttons (<< ev_ok >>)
			Result.set_default_push_button (Result.button (ev_ok))
			Result.set_default_cancel_button (Result.button (ev_ok))
		end

	report_non_readable_configuration_file (a_file_name: STRING) is
			-- Report an error when `a_file_name' cannot be read.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (warning_messages.w_cannot_read_file (a_file_name))
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_non_readable_ace_file_in_epr (a_epr_name, a_file_name: STRING) is
			-- Report an error when ace file `a_file_name' cannot be accessed from epr file `a_epr_name'.
			-- Note that `a_file_name' can be Void if `a_epr_name' does not mention it.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (warning_messages.w_cannot_read_ace_file_from_epr (a_epr_name, a_file_name))
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_cannot_read_ace_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when ace  file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		local
			l_ev: EV_ERROR_DIALOG
			l_msg: STRING
		do
			l_ev := new_error_dialog
			create l_msg.make_from_string (warning_messages.w_unable_to_load_ace_file (a_file_name))
			l_msg.append ("%NFor the following reasons:%N")
			l_msg.append_string (a_conf_error.text)
			l_ev.set_text (l_msg)
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_cannot_read_config_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when a config file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		local
			l_ev: EV_ERROR_DIALOG
			l_msg: STRING
		do
			l_ev := new_error_dialog
			create l_msg.make_from_string (warning_messages.w_unable_to_load_config_file (a_file_name))
			l_msg.append ("%NFor the following reasons:%N")
			l_msg.append_string (a_conf_error.text)
			l_ev.set_text (l_msg)
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_cannot_save_converted_file (a_file_name: STRING) is
			-- Report an error when result of a conversion from ace to acex cannot be stored
			-- in file `a_file_name'.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (warning_messages.w_cannot_save_file (a_file_name))
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_cannot_create_project (a_dir_name: STRING) is
			-- Report an error when we cannot create project in `a_dir_name'.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (warning_messages.w_cannot_create_project_directory (a_dir_name))
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_cannot_open_project (a_msg: STRING) is
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (a_msg)
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_incompatible_project (a_msg: STRING) is
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
				-- Ace file included in the header of the .epr file...we can recompile if needed.
			create cd.make_initialized (
				2, preferences.dialog_data.confirm_convert_project_string,
				Warning_messages.w_project_incompatible_version (config_file_name, version_number,
					Eiffel_project.incompatible_version_number),
				Interface_names.l_discard_convert_project_dialog,
				preferences.preferences
			)
			cd.set_ok_action (agent set_should_override_project (True))
			cd.show_modal_to_window (parent_window)
			if should_override_project then
				is_compilation_requested := True
			end
		end

	report_project_corrupted (a_msg: STRING) is
			-- Report an error when retrieving a project which is corrupted and possibly
			-- propose user to recompile from scratch.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (a_msg)
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_project_retrieval_interrupted (a_msg: STRING) is
			-- Report an error when project retrieval was stopped.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (a_msg)
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_project_incomplete (a_msg: STRING) is
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		local
			l_ev: EV_ERROR_DIALOG
		do
			l_ev := new_error_dialog
			l_ev.set_text (a_msg)
			l_ev.show_modal_to_window (parent_window)
			set_has_error
		end

	report_project_loaded_successfully is
			-- Report that project was loaded successfully.
		local
			l_title: STRING
		do
			l_title := Interface_names.l_loaded_project.twin
			l_title.append (target_name)
			if Eiffel_system.is_precompiled then
				l_title.append ("  (precompiled)")
			end
			window_manager.display_message (l_title)
			Recent_projects_manager.save_environment

				--| IEK With project session handling this code is no longer needed, remove when fully integrated.
				-- We print text in the project_tool text concerning the system
				-- because we were successful retrieving the project without
				-- errors or conversion.
			output_manager.display_system_info
		end

feature {NONE} -- User interaction

	ask_for_config_name (a_dir_name, a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new acex format, ask the
			-- user if he wants to create `a_file_name' or a different name. If he said yes, then
			-- execute `a_action' with chosen file_name, otherwise do nothing.
		local
			l_save_as: EV_FILE_SAVE_DIALOG
			l_file_name: FILE_NAME
			l_ev: EV_MESSAGE_DIALOG
			l_save_as_msg: STRING
			l_dir: STRING
		do
			create l_file_name.make_from_string (a_dir_name)
			l_file_name.set_file_name (a_file_name)

			create l_ev
			l_save_as_msg := "Save As..."
			l_ev.set_title ("Configuration Loading Message")
			l_ev.set_buttons (<< ev_ok, l_save_as_msg >>)
			l_ev.set_default_push_button (l_ev.button (ev_ok))
			l_ev.set_text ("Your old configration file needs to be converted to the new format.%N%
				%The default name for the new configuration is '" + a_file_name + "'.%N%
				%Select OK if you want to keep this name, or 'Save As...' to choose a different name.")

			l_dir := execution_environment.current_working_directory
			create l_save_as.make_with_title ("Choose name for new configuration file")
			l_save_as.set_start_directory (a_dir_name)
			l_save_as.set_file_name (a_file_name)
			l_save_as.filters.extend ([config_files_filter, config_files_description])
			l_save_as.save_actions.extend (agent select_config_file (l_save_as, a_action))
			l_save_as.cancel_actions.extend (agent set_has_error)

			l_ev.button (l_save_as_msg).select_actions.extend (agent l_save_as.show_modal_to_window (parent_window))
			l_ev.button (ev_ok).select_actions.extend (agent a_action.call ([l_file_name.string]))
			l_ev.show_modal_to_window (parent_window)

				-- Due to a bug in EV_FILE_DIALOG which changes the current working directory,
				-- we manually set it back to what it was before.
			execution_environment.change_working_directory (l_dir)
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
			wd: EV_WARNING_DIALOG
			file: RAW_FILE
		do
				-- This is a callback from the name chooser when user click OK.
			file_name := a_dlg.file_name
			check file_name_not_empty: not file_name.is_empty end
			create file.make (file_name)
			if file.exists then
				create wd.make_with_text (Warning_messages.w_file_exists (file_name))
				wd.set_buttons (<< ev_ok, ev_cancel >>)
				wd.set_default_push_button (wd.button (ev_ok))
				wd.set_default_cancel_button (wd.button (ev_cancel))
				wd.button (ev_cancel).select_actions.extend (agent a_dlg.show_modal_to_window (parent_window))
				wd.button (ev_ok).select_actions.extend (agent a_action.call ([file_name]))

					-- Display the warning window. If user presses `Cancel' we ask him again
					-- for a file name, otherwise if he presses `OK' we simply override
					-- the selected `file_name'.
				wd.show_modal_to_window (parent_window)
			else
				a_action.call ([file_name])
			end
		end

	ask_for_target_name (a_targets: HASH_TABLE [CONF_TARGET, STRING]) is
			-- Ask user to choose one target among `a_targets'.
		local
			l_dialog: EV_DIALOG
			l_list: EV_LIST
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_button: EV_BUTTON
			l_item: EV_LIST_ITEM
		do
			if a_targets.count = 1 then
				a_targets.start
				target_name := a_targets.key_for_iteration
			else
				create l_dialog.make_with_title ("Select a target")
				create l_list
				from
					a_targets.start
				until
					a_targets.after
				loop
					create l_item.make_with_text (a_targets.key_for_iteration)
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
				l_vbox.extend (l_list)

				create l_hbox
				l_hbox.set_padding (default_padding_size)
				l_vbox.extend (l_hbox)
				l_vbox.disable_item_expand (l_hbox)

				l_hbox.extend (create {EV_CELL})
				create l_button.make_with_text_and_action ("Select target", agent on_select_button_pushed (l_dialog, l_list))
				l_button.set_minimum_height (default_button_height)
				l_hbox.extend (l_button)
				l_hbox.disable_item_expand (l_button)

				create l_button.make_with_text_and_action (ev_cancel, agent on_target_cancelled (l_dialog))
				l_button.set_minimum_height (default_button_height)
				l_button.set_minimum_width (default_button_width)
				l_hbox.extend (l_button)
				l_hbox.disable_item_expand (l_button)
				l_hbox.extend (create {EV_CELL})

				l_dialog.extend (l_vbox)

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

feature {NONE} -- Actions

	deleting_dialog: EV_DIALOG
			-- Dialog displaying that the program is currently deleting
			-- some files.

	deleting_dialog_label: EV_LABEL
			-- Label displaying the file currently being deleted

	choose_again: BOOLEAN
			-- We need to choose again the file

	build_deleting_dialog is
			-- Build the dialog displayed to have the user wait during the
			-- deletion of a directory.
		local
			label_font: EV_FONT
			pixmap: EV_PIXMAP
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			pixmap_box: EV_CELL
			button_box: EV_HORIZONTAL_BOX
			cancel_button: EV_BUTTON
		do
				-- Create and display a dialog to have the user wait.
			pixmap := (create {EV_STOCK_PIXMAPS}).Information_pixmap.twin
			create pixmap_box
			pixmap_box.extend (pixmap)
			pixmap_box.set_minimum_size (pixmap.width, pixmap.height)

			create deleting_dialog_label
			deleting_dialog_label.align_text_left
			deleting_dialog_label.set_text (Interface_names.l_deleting_dialog_default)
			label_font := deleting_dialog_label.font
			deleting_dialog_label.set_minimum_size (
				label_font.width * minimum_width_of_deleting_dialog,
				label_font.height * minimum_height_of_deleting_dialog
				)

			create cancel_button.make_with_text (Interface_names.b_cancel)
			Layout_constants.set_default_size_for_button (cancel_button)
			cancel_button.select_actions.extend (agent on_cancel_button_pushed)

			create hb
			hb.set_border_width (Layout_constants.Default_border_size)
			hb.set_padding (Layout_constants.Default_padding_size)
			hb.extend (pixmap_box)
			hb.disable_item_expand (pixmap_box)
			hb.extend (deleting_dialog_label)

			create button_box
			button_box.set_padding (Layout_constants.Default_padding_size)
			button_box.set_border_width (Layout_constants.Default_border_size)
			button_box.extend (create {EV_CELL})
			button_box.extend (cancel_button)
			button_box.disable_item_expand (cancel_button)
			button_box.extend (create {EV_CELL})

			create vb
			vb.extend (hb)
			vb.extend (button_box)
			vb.disable_item_expand (button_box)

			create deleting_dialog
			deleting_dialog.extend (vb)
			deleting_dialog.set_default_cancel_button (cancel_button)
			deleting_dialog.set_title (Interface_names.t_deleting_files)
			deleting_dialog.set_icon_pixmap (pixmaps.icon_dialog_window)
			deleting_dialog.show_relative_to_window (parent_window)
		end

	on_delete_directory (deleted_files: ARRAYED_LIST [STRING]) is
			-- The files in `deleted_files' have just been deleted.
			-- Display
		local
			ise_directory_utils: ISE_DIRECTORY_UTILITIES
			deleted_file_pathname: STRING
		do
			if deleting_dialog = Void then
				build_deleting_dialog
			end
			create ise_directory_utils
			deleted_file_pathname := ise_directory_utils.path_ellipsis (deleted_files.first, Path_ellipsis_width)
			check
				deleting_dialog_label_exists: deleting_dialog_label /= Void
			end
			deleting_dialog_label.set_text (deleted_file_pathname)
			deleting_dialog_label.refresh_now
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

	on_target_cancelled (a_dlg: EV_DIALOG) is
			-- Action when user select a target with a double click.
		require
			a_dlg_not_void: a_dlg /= Void
			a_dlg_not_destroyed: not a_dlg.is_destroyed
		do
			has_error := True
			a_dlg.destroy
		end


feature {NONE} -- Implementation / Private constants.

	minimum_width_of_deleting_dialog: INTEGER is 70
			-- Minimum width of the deleting dialog in characters.

	minimum_height_of_deleting_dialog: INTEGER is 2
			-- Minimum height of the deleting dialog in characters.

	Path_ellipsis_width: INTEGER is
			-- Maximum number of characters per item.
		once
			Result := minimum_width_of_deleting_dialog - 10
		end

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
