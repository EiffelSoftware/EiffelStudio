indexing
	description	: "Tool where output and error of external commands are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: ""

class
	ES_CONSOLE_TOOL_PANEL

inherit
	ES_OUTPUT_TOOL_PANEL
		export
			{EB_EXTERNAL_OUTPUT_MANAGER}
				develop_window
		undefine
			Ev_application
		redefine
			make_with_tool,
			clear,
			internal_recycle,
			internal_detach_entities,
			scroll_to_end,set_focus,
			quick_refresh_editor,quick_refresh_margin, is_general,
			build_docking_content,
			attach_to_docking_manager,
			show
		end

	EB_EXTERNAL_OUTPUT_CONSTANTS

	SHARED_PLATFORM_CONSTANTS

	EB_TEXT_OUTPUT_TOOL

	EB_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make_with_tool is
			-- Create a new external output tool.
		do
			initialization (develop_window)
			widget := main_frame
			external_output_manager.extend (Current)
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build docking content
		local
			l_constants: EB_CONSTANTS
		do
			Precursor {ES_OUTPUT_TOOL_PANEL} (a_docking_manager)
			content.drop_actions.extend (agent drop_class)
			content.drop_actions.extend (agent drop_feature)
			create l_constants
			content.set_long_title (title)
			content.set_short_title (title)
		end

	initialization (a_tool: EB_DEVELOPMENT_WINDOW) is
			-- Initialize interface.
		local
			l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_3: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_5: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_6: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_7: EV_HORIZONTAL_BOX
			l_ev_vertical_box_1: EV_VERTICAL_BOX
			l_ev_vertical_box_2: EV_VERTICAL_BOX
			l_locale_text: EV_LABEL
			l_cell: EV_CELL

			l_ev_cmd_lbl: EV_LABEL
			l_ev_output_lbl: EV_LABEL
			l_ev_input_lbl: EV_LABEL
			l_ev_empty_lbl: EV_LABEL
			cmd_toolbar: SD_TOOL_BAR
			output_toolbar: SD_TOOL_BAR
			clear_output_toolbar: SD_TOOL_BAR
			input_toolbar: SD_TOOL_BAR
			tbs: SD_TOOL_BAR_SEPARATOR
			l_del_tool_bar: SD_TOOL_BAR
			l_provider: EB_EXTERNAL_CMD_COMPLETION_PROVIDER
		do
			create del_cmd_btn.make
			create tbs.make
			create cmd_toolbar.make
			create output_toolbar.make
			create input_toolbar.make
			create main_frame
			create l_ev_empty_lbl
			create l_ev_vertical_box_2
			create l_ev_cmd_lbl
			create l_ev_output_lbl
			create l_ev_input_lbl
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create l_ev_horizontal_box_2
			create l_ev_horizontal_box_3
			create l_ev_horizontal_box_4
			create l_ev_horizontal_box_5
			create l_ev_horizontal_box_6
			create l_ev_horizontal_box_7
			create terminate_btn.make
			create run_btn.make
			create cmd_lst
			create l_provider.make (Void)
			l_provider.set_code_completable (cmd_lst)
			cmd_lst.set_completion_possibilities_provider (l_provider)
			create edit_cmd_detail_btn.make
			create hidden_btn.make
			create state_label.make_with_text (l_no_command_is_running)
			create send_input_btn.make
			create input_field
			create save_output_btn.make
			create clear_output_btn.make
			create clear_output_toolbar.make
			create toolbar.make
			create l_del_tool_bar.make

			create l_locale_text.make_with_text (interface_names.l_locale)

			l_ev_empty_lbl.set_minimum_height (State_bar_height)
			l_ev_empty_lbl.set_minimum_width (State_bar_height * 2)
			l_ev_horizontal_box_7.extend (l_ev_empty_lbl)
			l_ev_horizontal_box_7.disable_item_expand (l_ev_empty_lbl)
			output_toolbar.extend (save_output_btn)

			save_output_btn.set_tooltip (f_save_output_button)
			save_output_btn.set_pixmap (stock_pixmaps.general_save_icon)
			save_output_btn.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			save_output_btn.select_actions.extend (agent on_save_output_to_file)

			clear_output_toolbar.extend (clear_output_btn)
			l_ev_horizontal_box_7.extend (output_toolbar)
			l_ev_horizontal_box_7.disable_item_expand (output_toolbar)
			l_ev_horizontal_box_7.extend (clear_output_toolbar)
			l_ev_horizontal_box_7.disable_item_expand (clear_output_toolbar)
			l_ev_horizontal_box_6.extend (l_ev_input_lbl)
			l_ev_horizontal_box_6.extend (input_field)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_input_lbl)
			input_toolbar.extend (send_input_btn)
			l_ev_horizontal_box_6.extend (input_toolbar)
			l_ev_horizontal_box_6.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_horizontal_box_6.disable_item_expand (input_toolbar)
			l_ev_horizontal_box_6.set_padding (5)
			main_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_cmd_lbl)
			l_ev_horizontal_box_2.extend (cmd_lst)
			create l_cell
			l_cell.set_minimum_width (5)
			l_ev_horizontal_box_2.extend (l_cell)
			l_ev_horizontal_box_2.disable_item_expand (l_cell)
			l_ev_horizontal_box_2.extend (l_locale_text)
			l_ev_horizontal_box_2.disable_item_expand (l_locale_text)
			l_ev_horizontal_box_2.extend (locale_combo)
			locale_combo.set_minimum_width (200)
			l_ev_horizontal_box_2.disable_item_expand (locale_combo)
			l_ev_horizontal_box_2.set_padding_width (5)
			l_ev_horizontal_box_5.extend (cmd_toolbar)
			l_ev_horizontal_box_5.extend (toolbar)
			l_ev_horizontal_box_5.disable_item_expand (toolbar)
			l_ev_horizontal_box_5.extend (l_del_tool_bar)
			l_ev_horizontal_box_5.disable_item_expand (cmd_toolbar)
			cmd_toolbar.extend (run_btn)
			cmd_toolbar.extend (terminate_btn)
			cmd_toolbar.extend (tbs)
			cmd_toolbar.extend (edit_cmd_detail_btn)

			edit_external_commands_cmd_btn := a_tool.commands.edit_external_commands_cmd.new_sd_toolbar_item (False)
			toolbar.extend (edit_external_commands_cmd_btn)

			l_del_tool_bar.extend (del_cmd_btn)
			l_ev_horizontal_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cmd_lbl)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_2)
			l_ev_output_lbl.align_text_left
			l_ev_vertical_box_2.extend (l_ev_output_lbl)
			l_ev_vertical_box_2.disable_item_expand (l_ev_output_lbl)
			l_ev_vertical_box_2.extend (output_text)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_6)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (state_label)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_1.set_padding (4)
			l_ev_vertical_box_1.set_border_width (4)

			del_cmd_btn.set_pixmap (stock_pixmaps.general_delete_icon)
			del_cmd_btn.set_pixel_buffer (stock_pixmaps.general_delete_icon_buffer)
			del_cmd_btn.set_tooltip (f_delete_command)
			del_cmd_btn.select_actions.extend (agent on_delete_command)

			clear_output_btn.set_pixmap (stock_pixmaps.general_reset_icon)
			clear_output_btn.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			clear_output_btn.set_tooltip (f_clear_output)
			clear_output_btn.select_actions.extend (agent on_clear_output_window)

			output_text.set_foreground_color (preferences.editor_data.normal_text_color)
			output_text.set_background_color (preferences.editor_data.normal_background_color)
			output_text.set_font (preferences.editor_data.font)
			output_text.disable_edit

			terminate_btn.set_pixmap (stock_pixmaps.debug_stop_icon)
			terminate_btn.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			output_text.drop_actions.extend (agent drop_class)
			output_text.drop_actions.extend (agent drop_feature)
			output_text.drop_actions.extend (agent drop_cluster)
			output_text.drop_actions.extend (agent drop_breakable)

			terminate_btn.set_tooltip (f_terminate_command_button)
			terminate_btn.select_actions.extend (agent on_terminate_process)

			edit_cmd_detail_btn.set_text ("")
			edit_cmd_detail_btn.set_tooltip (f_edit_cmd_detail_button)
			edit_cmd_detail_btn.set_pixmap (stock_pixmaps.general_save_icon)
			edit_cmd_detail_btn.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)

			state_label.set_minimum_height (State_bar_height)
			state_label.align_text_right
			state_label.drop_actions.extend (agent drop_class)
			state_label.drop_actions.extend (agent drop_feature)
			state_label.drop_actions.extend (agent drop_cluster)
			state_label.drop_actions.extend (agent drop_breakable)

			run_btn.set_pixmap (stock_pixmaps.debug_run_icon)
			run_btn.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			run_btn.set_tooltip (f_start_command_button)
			run_btn.select_actions.extend (agent on_run_process)

			cmd_lst.key_press_actions.extend (agent on_external_cmd_list_key_down (?))
			cmd_lst.change_actions.extend (agent on_cmd_lst_text_change)
			cmd_lst.focus_in_actions.extend (agent on_focus_in_in_cmd_lst)
			cmd_lst.set_text ("")
			check not_void: cmd_lst.choices /= Void end
			register_action (cmd_lst.choices.focus_in_actions, agent on_focus_in_completion_window)

--			cmd_lst.drop_actions.extend (agent drop_class)
--			cmd_lst.drop_actions.extend (agent drop_feature)
			cmd_lst.drop_actions.extend (agent drop_cluster)
			cmd_lst.drop_actions.extend (agent drop_breakable)

			edit_cmd_detail_btn.set_pixmap (stock_pixmaps.general_add_icon)
			edit_cmd_detail_btn.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
			edit_cmd_detail_btn.select_actions.extend (agent on_edit_command_detail)

			input_field.key_press_actions.extend (agent on_key_pressed_in_input_field (?))

			input_field.drop_actions.extend (agent drop_class)
			input_field.drop_actions.extend (agent drop_feature)
			input_field.drop_actions.extend (agent drop_cluster)
			input_field.drop_actions.extend (agent drop_breakable)

			send_input_btn.set_pixmap (stock_pixmaps.general_send_enter_icon)
			send_input_btn.set_pixel_buffer (stock_pixmaps.general_send_enter_icon_buffer)
			send_input_btn.set_tooltip (f_send_input_button)
			send_input_btn.select_actions.extend (agent on_send_input_btn_pressed)

			l_ev_cmd_lbl.set_text (l_command)
			l_ev_output_lbl.set_text (l_output)
			l_ev_input_lbl.set_text (l_input)
			l_ev_cmd_lbl.drop_actions.extend (agent drop_class)
			l_ev_cmd_lbl.drop_actions.extend (agent drop_feature)
			l_ev_cmd_lbl.drop_actions.extend (agent drop_cluster)
			l_ev_cmd_lbl.drop_actions.extend (agent drop_breakable)
			l_ev_output_lbl.drop_actions.extend (agent drop_class)
			l_ev_output_lbl.drop_actions.extend (agent drop_feature)
			l_ev_output_lbl.drop_actions.extend (agent drop_cluster)
			l_ev_output_lbl.drop_actions.extend (agent drop_breakable)
			l_ev_input_lbl.drop_actions.extend (agent drop_class)
			l_ev_input_lbl.drop_actions.extend (agent drop_feature)
			l_ev_input_lbl.drop_actions.extend (agent drop_cluster)
			l_ev_input_lbl.drop_actions.extend (agent drop_breakable)

			synchronize_command_list (Void)
			if external_launcher.is_launch_session_over then
				synchronize_on_process_exits
			else
				synchronize_on_process_starts ("")
			end

			output_toolbar.compute_minimum_size
			clear_output_toolbar.compute_minimum_size
			input_toolbar.compute_minimum_size
			cmd_toolbar.compute_minimum_size
			toolbar.compute_minimum_size
			l_del_tool_bar.compute_minimum_size
			cmd_lst.drop_actions.extend (agent on_stone_dropped_at_cmd_list)
		end

feature -- Docking

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Basic operation

	synchronize_on_process_starts (cmd_line: STRING) is
			-- Synchronize states of relative widgets when process starts.
		do
			force_display
			print_command_name (cmd_line)
			run_btn.disable_sensitive
			edit_cmd_detail_btn.disable_sensitive
			hidden_btn.disable_sensitive
			cmd_lst.disable_sensitive
			del_cmd_btn.disable_sensitive
			develop_window.commands.Edit_external_commands_cmd.disable_sensitive
			save_output_btn.disable_sensitive
			if external_output_manager.target_development_window /= Void then
				if develop_window = external_output_manager.target_development_window then
					send_input_btn.enable_sensitive
					terminate_btn.enable_sensitive
					input_field.enable_sensitive
					if input_field.is_displayed then
						input_field.set_focus
					end
				else
					input_field.disable_sensitive
					send_input_btn.disable_sensitive
					terminate_btn.disable_sensitive
				end
			else
					input_field.enable_sensitive
					if input_field.is_displayed then
						input_field.set_focus
					end
				send_input_btn.enable_sensitive
				terminate_btn.enable_sensitive
			end
		end

	synchronize_on_process_exits is
			-- Synchronize states of relative widgets when process exits.
		do
			run_btn.enable_sensitive
			edit_cmd_detail_btn.enable_sensitive
			hidden_btn.enable_sensitive
			cmd_lst.enable_sensitive
			develop_window.commands.Edit_external_commands_cmd.enable_sensitive
			save_output_btn.enable_sensitive
			input_field.disable_sensitive
			send_input_btn.disable_sensitive
			terminate_btn.disable_sensitive
			if develop_window = external_output_manager.target_development_window then
				if cmd_lst.is_displayed then
					cmd_lst.set_focus
				end
			end
			del_cmd_btn.enable_sensitive
			synchronize_command_list (corresponding_external_command)
		end

	clear is
			-- Clear window
		do
			output_text.set_text ("")
		end

	print_command_name (name: STRING) is
			-- Print command `name' to text fielad in command list box.
		require
			name_not_null: name /= Void
		do
			cmd_lst.set_text (name)
		end

	scroll_to_end is
			-- Scroll the console to the bottom.
		do
			output_text.scroll_to_line (output_text.line_count)
		end

	set_focus is
			-- Give the focus to the editor.		
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.do_once_on_idle (agent set_focus_on_idle)
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
		end

	synchronize_command_list (selected_cmd: EB_EXTERNAL_COMMAND) is
			-- When external command list is modified through Tools->External Commands...,
			-- synchronize change in command list in external output tool.
			-- `selected_cmd', if not Void, indicates the list item which
			-- should be selected as defaulted.
		local
			ms: ARRAY [EB_EXTERNAL_COMMAND]
			ext_cmd: EB_EXTERNAL_COMMAND
			lst_item: EV_LIST_ITEM
			str: STRING
			text_set: BOOLEAN
			i: INTEGER
		do
			if cmd_lst.is_sensitive then
				str := cmd_lst.text
				ms := develop_window.commands.Edit_external_commands_cmd.commands
				cmd_lst.wipe_out
				from
					i := ms.lower
					text_set := False
				until
					i > ms.upper
				loop
					ext_cmd ?= ms.item (i)
					if ext_cmd /= Void then
						create lst_item.make_with_text (ext_cmd.external_command)

						lst_item.set_data (ext_cmd)
						lst_item.set_tooltip (ext_cmd.name)
						cmd_lst.extend (lst_item)
						if  selected_cmd /= Void and then lst_item.data = selected_cmd then
							lst_item.enable_select
							cmd_lst.set_text (selected_cmd.external_command)
							text_set := True
						end
					end
					i := i + 1
				end
				if not text_set then
					cmd_lst.set_text (str)
				end
				if not cmd_lst.text.is_empty then
					cmd_lst.select_all
				end
			end
		end

--	process_block_text (text_block: EB_PROCESS_IO_DATA_BLOCK) is
--			-- Print `text_block' on `output_text'.
--		local
--			str: STRING
--		do
--			str ?= text_block.data
--			if str /= Void then
--				output_text.append_text (source_encoding.convert_to (destination_encoding, str))
--			end
--		end

	show is
			-- Show tool.
		do
			Precursor {ES_OUTPUT_TOOL_PANEL}
			if widget /= Void and then widget.is_displayed and then widget.is_sensitive then
				set_focus
			end
		end

feature{NONE} -- Actions

	on_external_cmd_list_key_down (key: EV_KEY) is
			-- Check if user pressed enter key in command list box.
			-- If so, launch process indicated by text in this command list box.	
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_run_process
			end
		end

	on_cmd_lst_text_change  is
			-- Agent called when text in command list box changed.
		local
			str: STRING
			eb: EB_EXTERNAL_COMMAND
		do
			create str.make_from_string (cmd_lst.text)
			str.left_adjust
			str.right_adjust
			str.replace_substring_all ("%N", "")
			str.replace_substring_all ("%R", "")
				-- If there is a command line in command list box,
				-- enable `run_btn', `del_cmd_btn', otherwise, disable them.
			if str.count > 0 then
				run_btn.enable_sensitive
				del_cmd_btn.enable_sensitive
				eb := corresponding_external_command
				if eb /= Void then
					edit_cmd_detail_btn.set_tooltip (f_edit_cmd_detail_button)
					edit_cmd_detail_btn.set_pixmap (stock_pixmaps.view_editor_icon)
					edit_cmd_detail_btn.set_pixel_buffer (stock_pixmaps.view_editor_icon_buffer)
				else
					edit_cmd_detail_btn.set_tooltip (f_new_cmd_detail_button)
					edit_cmd_detail_btn.set_pixmap (stock_pixmaps.general_add_icon)
					edit_cmd_detail_btn.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
				end
			else
				run_btn.disable_sensitive
				del_cmd_btn.disable_sensitive
				edit_cmd_detail_btn.set_tooltip (f_new_cmd_detail_button)
				edit_cmd_detail_btn.set_pixmap (stock_pixmaps.general_add_icon)
				edit_cmd_detail_btn.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
			end
		end

	on_edit_command_detail is
			-- Called when user selected `edit_cmd_detail_btn' to
			-- modify command external in detail.
		local
			str: STRING
			ec: EB_EXTERNAL_COMMAND
		do
			ec := corresponding_external_command
			if ec /= Void then
					-- If external command indicated by text in command list box
					-- exists, pop up an edit dialog and let user edit this command.
				ec.edit_properties (develop_window.window)
				ec.setup_managed_shortcut (develop_window.commands.edit_external_commands_cmd.accelerators)
				shortcut_manager.update_external_commands
			else
					-- If user has just input a new external command,
					-- first check whether we have room for this command.
				if develop_window.commands.edit_external_commands_cmd.menus.count = 10 then
					prompts.show_error_prompt (interface_names.e_external_command_list_full, develop_window.window, Void)
				else
						-- If we have room for this command, pop up a new command
						-- dialog and let user add this new command.
					create str.make_from_string (cmd_lst.text)
					str.left_adjust
					str.right_adjust
					create ec.make_from_new_command_line (develop_window.window, str)
					ec.setup_managed_shortcut (develop_window.commands.edit_external_commands_cmd.accelerators)
					shortcut_manager.update_external_commands
				end
			end
			on_cmd_lst_text_change
			develop_window.commands.edit_external_commands_cmd.refresh_list_from_outside
			develop_window.commands.edit_external_commands_cmd.update_menus_from_outside
		end

	on_run_process is
			-- Agent called when launching a process
		local
			str ,wd: STRING
			e_cmd: EB_EXTERNAL_COMMAND
			temp_cmd: EB_EXTERNAL_COMMAND
		do
			create str.make_from_string (cmd_lst.text)
			str.left_adjust
			str.right_adjust
			if not str.is_empty then
				e_cmd := corresponding_external_command
				if e_cmd /= Void then
					wd := e_cmd.working_directory
					if wd = Void then
						wd := ""
					end
					create temp_cmd.make_and_run_only (e_cmd.external_command, wd)
					print_command_name (e_cmd.external_command)
				else
					create temp_cmd.make_and_run_only (str, "")
					print_command_name (str)
				end
			end
		end

	on_input_to_process (str: STRING) is
			-- Called when user press enter in simulated console.
		do
			if external_launcher.launched and then not external_launcher.has_exited then
				external_launcher.put_string (str)
			end
		end

	on_terminate_process is
			-- Agent called when terminate a running process
		do
			if external_launcher.launched and then not external_launcher.has_exited then
				external_launcher.terminate
			end
		end

	on_send_input_btn_pressed is
			-- Agent called when user pressed `send_input_btn'
		local
			found: BOOLEAN
			l_text: STRING_32
			l_input_text: STRING
			l_string: STRING_GENERAL
		do
			l_text := input_field.text.twin
			l_text.append ("%N")
			if source_encoding /= Void then
				l_string := utf32_to_console_encoding (source_encoding, l_text)
			end
			if l_string = Void then
					-- Conversion fails.
				l_input_text := l_text.as_string_8
			else
				l_input_text := l_string.as_string_8
			end
			on_input_to_process (l_input_text)

			if not l_text.is_empty then
				from
					input_field.start
					found := False
				until
					input_field.after or found
				loop
					if l_text.is_equal (input_field.item.text) then
						found := True
					end
					input_field.forth
				end
				if not found then
					input_field.put_front (create {EV_LIST_ITEM}.make_with_text (l_text))
					if input_field.count > 10 then
						input_field.go_i_th (input_field.count)
						input_field.remove
					end
				end
			end
			input_field.set_text ("")
		end

	on_key_pressed_in_input_field (key: EV_KEY) is
			-- Agent called when user press enter in `input_field'
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_send_input_btn_pressed
			end
		end

	on_focus_in_in_cmd_lst is
			-- Agent called when focus goes to `input_field'
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.do_once_on_idle (agent on_idle_action_for_cmd_lst)
		end

	on_idle_action_for_cmd_lst is
			-- Handle focus issue of `cmd_lst' in idle action.
		do
			if last_focus_at_completion_window then
				last_focus_at_completion_window := False
				if cmd_lst /= Void and then not cmd_lst.is_destroyed then
					cmd_lst.set_caret_position (cmd_lst.text.count + 1)
				end
			end
		end

	on_focus_in_completion_window is
			-- Agent called when focus goes to completion window.
		do
			last_focus_at_completion_window := True
		end

	on_save_output_to_file is
			-- Called when user press Save output button.
		local
			save_tool: EB_SAVE_STRING_TOOL
		do
			if process_manager.is_external_command_running then
				show_warning_dialog (Warning_messages.w_cannot_save_when_external_running, develop_window.window)
			else
				create save_tool.make_and_save (output_text.text, develop_window.window)
			end
		end

	on_clear_output_window is
			-- Clear `output_text'.
		do
			clear
		end

	on_delete_command is
			-- Agent when user want to delete an external command.
		local
			comm: EB_EXTERNAL_COMMAND
		do
			comm := corresponding_external_command
			if comm /= Void then
				develop_window.commands.edit_external_commands_cmd.commands.put (Void, comm.index)
				develop_window.commands.edit_external_commands_cmd.refresh_list_from_outside
				develop_window.commands.edit_external_commands_cmd.update_menus_from_outside
				cmd_lst.set_text ("")
				external_output_manager.synchronize_command_list (Void)
			else
				cmd_lst.set_text ("")
			end
		end

	on_stone_dropped_at_cmd_list (a_pebble: ANY) is
			-- Action to be performed when `a_pebble' is dropped at `cmd_lst'
		local
			l_classi_stone: CLASSI_STONE
			l_feature_stone: FEATURE_STONE
			l_group_stone: CLUSTER_STONE
			l_done: BOOLEAN
			l_new_text: STRING
		do
			l_feature_stone ?= a_pebble
			if l_feature_stone /= Void then
				l_new_text := "{" + l_feature_stone.class_name + "}." + l_feature_stone.feature_name
				l_done := True
			end
			if not l_done then
				l_classi_stone ?= a_pebble
				if l_classi_stone /= Void then
					l_new_text := "{" + l_classi_stone.class_name + "}"
					l_done := True
				end
			end
			if not l_done then
				l_group_stone ?= a_pebble
				if l_group_stone /= Void then
					l_new_text := l_group_stone.group.location.evaluated_path
				end
			end
			if l_new_text /= Void then
				if cmd_lst.has_selection then
					cmd_lst.delete_selection
					cmd_lst.remove_selection
				end
				cmd_lst.insert_text (l_new_text)
			end
		end

feature -- Status reporting

	corresponding_external_command: EB_EXTERNAL_COMMAND is
			-- If external command indicated by text in command list box
			-- already exists, return corresponding EB_EXTERNAL_COMMAND object,
			-- otherwise return Void.
		local
			str: STRING
			e_cmd: EB_EXTERNAL_COMMAND
			done: BOOLEAN
			i: INTEGER
		do
			create str.make_from_string (cmd_lst.text)
			str.left_adjust
			str.right_adjust
			if not str.is_empty then
				from
					i := 0
					done := False
				until
					i >= develop_window.commands.edit_external_commands_cmd.commands.count or done
				loop
					e_cmd ?= develop_window.commands.edit_external_commands_cmd.commands.item (i)
					if e_cmd /= Void then
						if e_cmd.external_command.is_equal (str) then
							done := True
						end
					end
					i := i + 1
				end
			end
			if done then
				Result := e_cmd
			else
				Result := Void
			end
		end

	is_general: BOOLEAN is false;

feature -- State setting

	display_state (s: STRING_GENERAL; warning: BOOLEAN) is
			-- Display state `s' in state bar of this output tool
			-- If this is a `warning' state, display in red color,
			-- otherwise in black color.
		do
			if warning then
				state_label.set_foreground_color (red_color)
			else
				state_label.set_foreground_color (black_color)
			end
			state_label.set_text (s)
		end

feature{NONE}

	show_warning_dialog (msg: STRING_GENERAL; a_window: EV_WINDOW) is
			-- Show a warning dialog containing message `msg' in `a_window'.
		require
			msg_not_void: msg /= Void
			msg_not_empty: not msg.is_empty
			a_window_not_void: a_window /= Void
		do
			prompts.show_warning_prompt (msg, a_window, Void)
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- To be called before destroying this objects
		do
			cmd_lst.destroy
			state_label.destroy
			main_frame.destroy
			input_field.destroy
			edit_external_commands_cmd_btn.recycle
			external_output_manager.prune (Current)
			toolbar.destroy
			widget.destroy
			Precursor {ES_OUTPUT_TOOL_PANEL}
		end

	internal_detach_entities is
			-- <Precursor>
		do
			widget := Void
			text_area := Void
			develop_window := Void
			toolbar := Void
			terminate_btn := Void
			run_btn := Void
			state_label := Void
			main_frame := Void
			cmd_lst := Void
			edit_cmd_detail_btn := Void
			hidden_btn := Void
			input_field := Void
			send_input_btn := Void
			save_output_btn := Void
			clear_output_btn := Void
			del_cmd_btn := Void
			edit_external_commands_cmd_btn := Void
			Precursor {ES_OUTPUT_TOOL_PANEL}
		end

feature {NONE} -- Implementation

	toolbar: SD_TOOL_BAR
			-- Tool bar.

	terminate_btn: SD_TOOL_BAR_BUTTON
			-- Button to terminate running process

	run_btn: SD_TOOL_BAR_BUTTON
			-- Button to launch process

	state_label: EV_LABEL
			-- Label to display process launching status.

	main_frame: EV_VERTICAL_BOX

	cmd_lst: EB_EXTERNAL_CMD_COMBO_BOX
			-- List of external commands.

	edit_cmd_detail_btn: SD_TOOL_BAR_BUTTON
			-- Button to open new/edit external command dialog.

	hidden_btn: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Button to set whether or not external command should be run hidden.

	input_field: EV_COMBO_BOX
			-- Text field where user can type data.

	send_input_btn: SD_TOOL_BAR_BUTTON
			-- Button to send data into launched process.

	save_output_btn: SD_TOOL_BAR_BUTTON
			-- Button to save output from process to file.

	clear_output_btn: SD_TOOL_BAR_BUTTON
			-- Button to clear output window.

	del_cmd_btn: SD_TOOL_BAR_BUTTON
			-- Button to delete an already stored external command

	edit_external_commands_cmd_btn: EB_SD_COMMAND_TOOL_BAR_BUTTON;
			-- Button to recycle

	last_focus_at_completion_window: BOOLEAN
		-- Did last focus stayed in code completation window?

	set_focus_on_idle is
			-- Set focus on idle actions.
		local
			l_env: EV_ENVIRONMENT
			l_container: EV_CONTAINER
			l_focused_already: BOOLEAN
			l_widget: EV_WIDGET
		do
			create l_env
			l_container ?= widget
			if l_container /= Void then
				if not l_env.application.is_destroyed then
					l_widget := l_env.application.focused_widget
				end
				if not l_container.is_destroyed and then l_container.has_recursive (l_widget) then
					-- If out tool has focus already, then we don't need set focus again later.
					l_focused_already := True
				end
			end

			if not l_focused_already then
				if cmd_lst.is_displayed and then cmd_lst.is_sensitive then
					cmd_lst.set_focus
				else
					if input_field.is_displayed and then input_field.is_sensitive then
						input_field.set_focus
					end
				end
			end
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

end -- class EB_EXTERNAL_OUTPUT_TOOL
