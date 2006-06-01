indexing
	description	: "Tool where output and error of external commands are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: ""

class
	EB_C_COMPILATION_OUTPUT_TOOL

inherit
	EB_OUTPUT_TOOL
		redefine
			make,
			clear, recycle, scroll_to_end,set_focus,
			quick_refresh_editor,quick_refresh_margin,
			is_general
		end

	EB_SHARED_PIXMAPS

	EB_EXTERNAL_OUTPUT_CONSTANTS

	SHARED_PLATFORM_CONSTANTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_CONSTANTS

	PROJECT_CONTEXT

	SHARED_WORKBENCH

	EB_TEXT_OUTPUT_TOOL

	SHARED_FLAGS

create
	make

feature{NONE} -- Initialization

	make (a_tool: EB_DEVELOPMENT_WINDOW; m: EB_CONTEXT_TOOL) is
			-- Create a new external output tool.
		do
			owner := a_tool
			initialization (a_tool)
			widget := l_ev_vertical_box_1
			c_compilation_output_manager.extend (Current)
			stone_manager := m
		end

	initialization (a_tool: EB_DEVELOPMENT_WINDOW) is
			-- Initialize interface.
		local
			l_ev_tool_bar_separator_1: EV_TOOL_BAR_SEPARATOR
			l_ev_tool_bar_1: EV_TOOL_BAR
			l_ev_save_toolbar: EV_TOOL_BAR
			l_ev_h_area_1: EV_HORIZONTAL_BOX
		do
			create l_ev_vertical_box_1
			create l_ev_tool_bar_1
			create save_output_btn
			create l_ev_tool_bar_separator_1
			create w_code_btn
			create f_code_btn
			create l_ev_h_area_1
			create clear_output_btn
			create l_ev_save_toolbar
			create open_editor_btn
			create message_label

			message_label.align_text_left
			l_ev_h_area_1.extend (message_label)
			l_ev_h_area_1.extend (l_ev_save_toolbar)
			l_ev_h_area_1.extend (l_ev_tool_bar_1)
			l_ev_h_area_1.disable_item_expand (l_ev_save_toolbar)
			l_ev_h_area_1.disable_item_expand (l_ev_tool_bar_1)

				-- Build_widget_structure.
			l_ev_vertical_box_1.extend (output_text)
			l_ev_save_toolbar.extend (open_editor_btn)
			l_ev_save_toolbar.extend (save_output_btn)
			l_ev_save_toolbar.extend (clear_output_btn)
			l_ev_tool_bar_1.extend (l_ev_tool_bar_separator_1)
			l_ev_tool_bar_1.extend (w_code_btn)
			l_ev_tool_bar_1.extend (f_code_btn)
			l_ev_vertical_box_1.extend (l_ev_h_area_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_h_area_1)
			l_ev_tool_bar_1.disable_vertical_button_style

			open_editor_btn.set_tooltip (interface_names.e_open_selection_in_editor)
			open_editor_btn.set_pixmap (icon_open_file)
			open_editor_btn.select_actions.extend (agent on_open_selected_text_in_external_editor)
			open_editor_btn.disable_sensitive
			save_output_btn.set_pixmap (icon_save)
			save_output_btn.set_tooltip (interface_names.e_save_c_compilation_output)
			save_output_btn.select_actions.extend (agent on_save_output_to_file)
			w_code_btn.set_text (interface_names.e_w_code)
			w_code_btn.select_actions.extend (agent on_go_to_w_code)
			w_code_btn.set_tooltip (interface_names.e_go_to_w_code_dir)
			f_code_btn.set_text (interface_names.e_f_code)
			f_code_btn.select_actions.extend (agent on_go_to_f_code)

			f_code_btn.set_tooltip (interface_names.e_go_to_f_code_dir)

			clear_output_btn.set_pixmap (Icon_recycle_bin)
			clear_output_btn.set_tooltip (f_clear_output)
			clear_output_btn.select_actions.extend (agent on_clear_output_window)

			output_text.drop_actions.extend (agent drop_class)
			output_text.drop_actions.extend (agent drop_feature)
			output_text.drop_actions.extend (agent drop_cluster)
			output_text.drop_actions.extend (agent drop_breakable)
			output_text.change_actions.extend (agent on_text_change)
			on_text_change
			output_text.pointer_button_release_actions.extend (agent on_pointer_release_in_console)
			output_text.set_foreground_color (preferences.editor_data.normal_text_color)
			output_text.set_background_color (preferences.editor_data.normal_background_color)
			output_text.set_font (preferences.editor_data.font)
			output_text.disable_edit
			output_text.selection_change_actions.extend (agent on_selection_change)
			message_label.set_foreground_color ((create{EV_STOCK_COLORS}).red)
		end

feature -- Basic operation

	clear is
			-- Clear window
		do
			output_text.set_text ("")
			on_text_change
			message_label.set_text ("")
		end

	recycle is
			-- To be called before destroying this objects
		do
			c_compilation_output_manager.prune (Current)
			owner := Void
			stone_manager := Void
		end

	scroll_to_end is
			-- Scroll the console to the bottom.
		do
			output_text.scroll_to_line (output_text.line_count)
		end

	set_focus is
			-- Give the focus to the editor.
		do
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
		end

	process_block_text (text_block: EB_PROCESS_IO_DATA_BLOCK) is
			-- Print `text_block' on `console'.
		local
			str: STRING
		do
			str ?= text_block.data
			if str /= Void then
				output_text.append_text (str)
			end
		end

feature -- Action

	on_c_compilation_output_finished is
			-- Action to be performed when all output from c compilation has been finished
		do
			on_text_change
		end

	on_save_output_to_file is
			-- Called when user press Save output button.
		local
			save_tool: EB_SAVE_STRING_TOOL
		do
			if process_manager.is_c_compilation_running then
				show_warning_dialog (Warning_messages.w_cannot_save_when_c_compilation_running, owner.window)
			else
				create save_tool.make_and_save (output_text.text, owner.window)
			end
		end

	on_clear_output_window is
			-- Clear output window.
		do
			if process_manager.is_c_compilation_running then
				show_warning_dialog (Warning_messages.w_cannot_clear_when_c_compilation_running, owner.window)
			else
				clear
			end
		end

	on_go_to_w_code is
			-- Go to W_code directory of current Eiffel system.		
		do
			go_to_dir (project_location.workbench_path)
		end

	on_go_to_f_code is
			-- Go to F_code directory of current Eiffel system.
		do
			go_to_dir (project_location.final_path)
		end

	on_open_selected_text_in_external_editor is
			-- Open selected text from `output_text' as file name in external editor.
		local
			l_dlg: EV_WARNING_DIALOG
			req: COMMAND_EXECUTOR
			cmd_string: STRING
			l_dialog_needed: BOOLEAN
			l_message: STRING
		do
			if output_text.has_selection then
				if has_selected_file then
					cmd_string := command_shell_name
					if not cmd_string.is_empty then
						check
							selected_file_exists: selected_file_path /= Void
						end
						cmd_string.replace_substring_all ("$target", selected_file_path)
						cmd_string.replace_substring_all ("$line", "")
						create req
						req.execute (cmd_string)
					else
						l_dialog_needed := True
						l_message := interface_names.e_external_editor_not_defined
					end
				else
					l_dialog_needed := True
					l_message := interface_names.e_selected_text_is_not_file
				end
			else
				l_dialog_needed := True
				l_message := interface_names.e_no_text_is_selected
			end
			if l_dialog_needed then
				create l_dlg.make_with_text (l_message)
				l_dlg.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	on_pointer_release_in_console (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when pointer release in `output_text'
		local
			l_need_sensitive: BOOLEAN
		do
--			if button = 1 and then has_selected_file then
--				l_need_sensitive := True
--			end
--			if l_need_sensitive then
--				if not open_editor_btn.is_sensitive then
--					open_editor_btn.enable_sensitive
--				end
--			else
--				if open_editor_btn.is_sensitive then
--					open_editor_btn.disable_sensitive
--				end
--			end
		end

	on_text_change is
			-- Action performed when text changes in `output_text'
		local
			l_save_and_clear_need_sensitive: BOOLEAN
		do
			if output_text.text_length > 0 and then not process_manager.is_c_compilation_running then
				l_save_and_clear_need_sensitive := True
			end
			if l_save_and_clear_need_sensitive then
				if not save_output_btn.is_sensitive then
					save_output_btn.enable_sensitive
				end
				if not clear_output_btn.is_sensitive then
					clear_output_btn.enable_sensitive
				end
			else
				if save_output_btn.is_sensitive then
					save_output_btn.disable_sensitive
				end
				if clear_output_btn.is_sensitive then
					clear_output_btn.disable_sensitive
				end
			end
			if has_selected_file then
				if not open_editor_btn.is_sensitive then
					open_editor_btn.enable_sensitive
				end
			else
				if open_editor_btn.is_sensitive then
					open_editor_btn.disable_sensitive
				end
			end
		end

	on_selection_change	is
			-- Action to be performed when selection changes in `output_text'.
		local
			l_need_sensitive: BOOLEAN
		do
			if has_selected_file then
				if not open_editor_btn.is_sensitive then
					open_editor_btn.enable_sensitive
				end
			else
				if open_editor_btn.is_sensitive then
					open_editor_btn.disable_sensitive
				end
			end
		end

feature -- Status reporting

	owner_development_window: EB_DEVELOPMENT_WINDOW is
			-- Development window which `Current' is belonged to
		do
			Result := owner
		end

	is_general: BOOLEAN is false
			-- Is general output tool?	

feature{NONE}	-- Implementation

	go_to_dir (a_dir: STRING) is
			-- Open a console and go to directory `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
		local
			prc_launcher: EB_PROCESS_LAUNCHER
		do
			if workbench.system_defined then
				prc_launcher := external_launcher
				prc_launcher.open_console_in_dir (a_dir)
			else
				show_no_system_defined_dlg
			end
		end

	show_no_system_defined_dlg is
			-- Show a dialog warning no eiffel system defined.
		local
			wd: EV_WARNING_DIALOG
		do
			create wd.make_with_text (Warning_messages.w_No_system_defined)
			wd.show_modal_to_window (owner.window)
		end

	show_warning_dialog (msg: STRING; a_window: EV_WINDOW) is
			-- Show a warning dialog containing message `msg' in `a_window'.
		require
			msg_not_void: msg /= Void
			msg_not_empty: not msg.is_empty
			a_window_not_void: a_window /= Void
		local
			wd: EV_WARNING_DIALOG
		do
			create wd.make_with_text (msg)
			wd.show_modal_to_window (a_window)
		end

	has_selected_file: BOOLEAN is
			-- Does selected text (if any) in `output_text' represent a correct file name?
		local
			l_file: RAW_FILE
			l_path: ARRAYED_LIST [STRING]
			l_selected_text: STRING
		do
			if output_text.has_selection then
				display_status_message (interface_names.l_searching_selected_file)
				l_selected_text := output_text.selected_text.twin
				create l_file.make (l_selected_text)
				if l_file.exists then
					Result := True
					selected_file_path := output_text.selected_text.twin
				end
				if not Result then
					create l_path.make (2)
					if is_last_c_compilation_freezing then
						l_path.extend (project_location.workbench_path)
						l_path.extend (project_location.final_path)
					else
						l_path.extend (project_location.final_path)
						l_path.extend (project_location.workbench_path)
					end
					l_selected_text.left_adjust
					l_selected_text.right_adjust
					if not l_selected_text.is_empty then
						selected_file_path := file_in_path (l_path.i_th (1), l_selected_text)
						Result := selected_file_path /= Void
						if not Result then
							selected_file_path := file_in_path (l_path.i_th (2), l_selected_text)
							Result := selected_file_path /= Void
						end
					end
				end
				if selected_file_path /= Void then
					display_status_message ("")
				else
					display_status_message (interface_names.l_selected_file_not_found)
				end
			else
				display_status_message ("")
			end
		end

	file_in_path (start_path: STRING; keyword: STRING): STRING is
			-- Find file whose path contains `keyword' starting from `start_path'.
			-- If found, return final path of the file, otherwise, return Void.
		require
			start_path_attached: start_path /= Void
			keyword_attached: keyword /= Void
			not_keyword_is_empty: not keyword.is_empty
		local
			l_dir: DIRECTORY
			l_file: RAW_FILE
			l_path: STRING
			l_end_with_separator: BOOLEAN
			l_start_with_separator: BOOLEAN
			l_name: STRING
			l_dot: STRING
			l_dotdot: STRING
		do
			create l_dir.make (start_path)
			if l_dir.exists then
				l_start_with_separator := path_start_with_dir_separator (keyword)
				l_end_with_separator := path_end_with_dir_separator (start_path)
				l_name := start_path.twin
				if not l_start_with_separator and not l_end_with_separator then
					l_name.append_character (directory_separator)
				end
				l_name.append (keyword)
				create l_file.make (l_name)
				if l_file.exists and then not l_file.is_directory then
					Result := l_name
				else
					l_dot := once "."
					l_dotdot := once ".."
					create l_dir.make_open_read (start_path)
					create l_path.make (start_path.count + 50)
					l_path.append (start_path)
					if not l_end_with_separator then
						l_path.append (directory_separator.out)
					end
					from
						l_dir.readentry
					until
						l_dir.lastentry = Void or Result /= Void
					loop
						if not
							(l_dir.lastentry.is_equal (l_dot) or
							l_dir.lastentry.is_equal (l_dotdot))
						then
							l_name := l_path.twin
							l_name.append (l_dir.lastentry)
							create l_file.make (l_name)
							if l_file.is_directory then
								Result := file_in_path (l_name, keyword)
							end
						end
						l_dir.readentry
					end
				end
			end
		end

	display_status_message (a_msg: STRING) is
			-- Display message `a_msg' in `message_label'.
		require
			a_msg_attached: a_msg /= Void
		do
			check message_label /= Void end
			message_label.set_text (a_msg)
		ensure
			message_set: message_label.text.is_equal (a_msg)
		end

feature{NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX

	save_output_btn: EV_TOOL_BAR_BUTTON
			-- Button to save c compilation output to a file

	w_code_btn: EV_TOOL_BAR_BUTTON
			-- Button to go to W_code directory

	f_code_btn: EV_TOOL_BAR_BUTTON
			-- Button to go to F_code directory

	save_file_dlg: EV_FILE_SAVE_DIALOG
			-- File dialog to let user choose a file.

	clear_output_btn: EV_TOOL_BAR_BUTTON;
			-- Button to clear output window.

	open_editor_btn: EV_TOOL_BAR_BUTTON
			-- Button to open selected text in `console' in an external editor

	command_shell_name: STRING is
			-- Name of the command to execute in the shell dialog.
		do
			Result := preferences.misc_data.external_editor_command.twin
		end

	directory_separator: CHARACTER is
			-- Directory separator
		local
			l_obj: ANY
		once
			create l_obj
			Result := l_obj.operating_environment.directory_separator
		end

	path_end_with_dir_separator (path: STRING): BOOLEAN is
			-- Does `path' end with dir separator of current running system?
		require
			path_not_void: path /= Void
		do
			if not path.is_empty then
				Result := path.item (path.count) = path.operating_environment.directory_separator
			end
		ensure
			Result_set: Result implies (not path.is_empty and then (path.item (path.count) = path.operating_environment.directory_separator))
		end

	path_start_with_dir_separator (path: STRING): BOOLEAN is
			-- Does `path' start with dir separator of current running system?
		require
			path_not_void: path /= Void
		do
			if not path.is_empty then
				Result := path.item (1) = path.operating_environment.directory_separator
			end
		ensure
			Result_set: Result implies (not path.is_empty and then (path.item (1) = path.operating_environment.directory_separator))
		end

	selected_file_path: STRING
			-- Final path of selected file

	message_label: EV_LABEL;
			-- Status message label

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

end -- class EB_C_COMPILATION_OUTPUT_TOOL
