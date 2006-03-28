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
			--
		local
			l_ev_tool_bar_separator_1: EV_TOOL_BAR_SEPARATOR
			l_ev_tool_bar_1: EV_TOOL_BAR
			l_ev_save_toolbar: EV_TOOL_BAR
			l_ev_h_area_1: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_ev_vertical_box_1
			create c_compilation_output
			create l_ev_tool_bar_1
			create save_output_btn
			create l_ev_tool_bar_separator_1
			create w_code_btn
			create f_code_btn
			create l_ev_h_area_1
			create l_label.default_create
			create clear_output_btn
			create l_ev_save_toolbar
			create open_editor_btn

			l_ev_h_area_1.extend (l_label)
			l_ev_h_area_1.extend (l_ev_save_toolbar)
			l_ev_h_area_1.extend (l_ev_tool_bar_1)
			l_ev_h_area_1.disable_item_expand (l_ev_save_toolbar)
			l_ev_h_area_1.disable_item_expand (l_ev_tool_bar_1)

				-- Build_widget_structure.
			l_ev_vertical_box_1.extend (c_compilation_output)
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

			c_compilation_output.drop_actions.extend (agent drop_class)
			c_compilation_output.drop_actions.extend (agent drop_feature)
			c_compilation_output.drop_actions.extend (agent drop_cluster)
			c_compilation_output.drop_actions.extend (agent drop_breakable)
			c_compilation_output.change_actions.extend (agent on_text_change)
			on_text_change
			c_compilation_output.pointer_button_release_actions.extend (agent on_pointer_release_in_console)
			c_compilation_output.set_foreground_color (preferences.editor_data.normal_text_color)
			c_compilation_output.set_background_color (preferences.editor_data.normal_background_color)
			c_compilation_output.set_font (preferences.editor_data.font)
			c_compilation_output.disable_edit
		end

feature -- Basic operation

	clear is
			-- Clear window
		do
			c_compilation_output.set_text ("")
			on_text_change
		end

	recycle is
			-- To be called before destroying this objects
		do
			c_compilation_output_manager.prune (Current)
		end

	scroll_to_end is
			-- Scroll the console to the bottom.
		do
			c_compilation_output.scroll_to_line (c_compilation_output.line_count)
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
				c_compilation_output.append_text (str)
			end
		end

feature -- Action

	on_c_compilation_output_finished is
			-- Action to be performed when all output from c compilation has been finished
		do
			on_text_change
		end

feature{NONE} -- Actions

	on_save_output_to_file is
			-- Called when user press Save output button.
		local
			save_tool: EB_SAVE_STRING_TOOL
		do
			if process_manager.is_c_compilation_running then
				show_warning_dialog (Warning_messages.w_cannot_save_when_c_compilation_running, owner.window)
			else
				create save_tool.make_and_save (c_compilation_output.text, owner.window)
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
			go_to_dir (Workbench_generation_path)
		end

	on_go_to_f_code is
			-- Go to F_code directory of current Eiffel system.
		do
			go_to_dir (Final_generation_path)
		end

	on_open_selected_text_in_external_editor is
			-- Open selected text from `c_compilation_output' as file name in external editor.
		local
			l_dlg: EV_WARNING_DIALOG
			req: COMMAND_EXECUTOR
			cmd_string: STRING
			l_dialog_needed: BOOLEAN
			l_message: STRING
		do
			if c_compilation_output.has_selection then
				if has_selected_file then
					cmd_string := command_shell_name
					if not cmd_string.is_empty then
						cmd_string.replace_substring_all ("$target", c_compilation_output.selected_text)
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
			-- Action to be performed when pointer release in `c_compilation_output'
		local
			l_need_sensitive: BOOLEAN
		do
			if button = 1 and then has_selected_file then
				l_need_sensitive := True
			end
			if l_need_sensitive then
				if not open_editor_btn.is_sensitive then
					open_editor_btn.enable_sensitive
				end
			else
				if open_editor_btn.is_sensitive then
					open_editor_btn.disable_sensitive
				end
			end
		end

	on_text_change is
			-- Action performed when text changes in `c_compilation_output'
		local
			l_save_and_clear_need_sensitive: BOOLEAN
		do
			if c_compilation_output.text_length > 0 and then not process_manager.is_c_compilation_running then
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

feature -- Status reporting

	owner_development_window: EB_DEVELOPMENT_WINDOW is
			-- Development window which `Current' is belonged to
		do
			Result := owner
		end

	is_general: BOOLEAN is false

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
			-- Does selected text (if any) in `c_compilation_output' represent a correct file name?
		local
			l_file: RAW_FILE
		do
			if c_compilation_output.has_selection then
				create l_file.make (c_compilation_output.selected_text)
				if l_file.exists then
					Result := True
				end
			end
		end

feature{NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX

	c_compilation_output: EV_TEXT
			-- Text pane used to output c compilation result

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
			Result := preferences.misc_data.general_shell_command.twin
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

end -- class EB_C_COMPILATION_OUTPUT_TOOL
