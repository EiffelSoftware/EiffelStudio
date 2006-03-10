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
			create output_text
			create l_ev_tool_bar_1
			create save_output_btn
			create l_ev_tool_bar_separator_1
			create w_code_btn
			create f_code_btn
			create l_ev_h_area_1
			create l_label.default_create
			create clear_output_btn
			create l_ev_save_toolbar

			l_ev_h_area_1.extend (l_label)
			l_ev_h_area_1.extend (l_ev_save_toolbar)
			l_ev_h_area_1.extend (l_ev_tool_bar_1)
			l_ev_h_area_1.disable_item_expand (l_ev_save_toolbar)
			l_ev_h_area_1.disable_item_expand (l_ev_tool_bar_1)

				-- Build_widget_structure.
			l_ev_vertical_box_1.extend (output_text)
			l_ev_save_toolbar.extend (save_output_btn)
			l_ev_save_toolbar.extend (clear_output_btn)
			l_ev_tool_bar_1.extend (l_ev_tool_bar_separator_1)
			l_ev_tool_bar_1.extend (w_code_btn)
			l_ev_tool_bar_1.extend (f_code_btn)
			l_ev_vertical_box_1.extend (l_ev_h_area_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_h_area_1)
			l_ev_tool_bar_1.disable_vertical_button_style

			save_output_btn.set_pixmap (icon_save)
			save_output_btn.set_tooltip ("Save c compilation output to file")
			save_output_btn.select_actions.extend (agent on_save_output_to_file)
			w_code_btn.set_text ("W_code")
			w_code_btn.select_actions.extend (agent on_go_to_w_code)
			w_code_btn.set_tooltip ("Go to W_code directory of this system")
			f_code_btn.set_text ("F_code")
			f_code_btn.select_actions.extend (agent on_go_to_f_code)

			f_code_btn.set_tooltip ("Go to F_code directory of this system")

			clear_output_btn.set_pixmap (Icon_recycle_bin)
			clear_output_btn.set_tooltip (f_clear_output)
			clear_output_btn.select_actions.extend (agent on_clear_output_window)

			output_text.drop_actions.extend (agent drop_class)
			output_text.drop_actions.extend (agent drop_feature)
			output_text.drop_actions.extend (agent drop_cluster)
			output_text.drop_actions.extend (agent drop_breakable)
			output_text.set_foreground_color (preferences.editor_data.normal_text_color)
			output_text.set_background_color (preferences.editor_data.normal_background_color)
			output_text.set_font (preferences.editor_data.font)
			output_text.disable_edit
		end

feature -- Basic operation

	clear is
			-- Clear window
		do
			output_text.set_text ("")
		end

	recycle is
			-- To be called before destroying this objects
		do
			c_compilation_output_manager.prune (Current)
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

feature{NONE} -- Actions

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
			go_to_dir (Workbench_generation_path)
		end

	on_go_to_f_code is
			-- Go to F_code directory of current Eiffel system.
		do
			go_to_dir (Final_generation_path)
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

feature -- Status reporting

	owner_development_window: EB_DEVELOPMENT_WINDOW is
			-- Development window which `Current' is belonged to
		do
			Result := owner
		end

	is_general: BOOLEAN is false;

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

feature{NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX

	output_text: EV_TEXT
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
