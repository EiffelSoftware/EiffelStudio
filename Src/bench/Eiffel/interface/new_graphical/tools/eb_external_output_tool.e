indexing
	description	: "Tool where output and error of external commands are displayed."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: ""

class
	EB_EXTERNAL_OUTPUT_TOOL

inherit
	EB_OUTPUT_TOOL
		redefine
			make,  drop_breakable, drop_class, drop_feature, drop_cluster,
			process_text, clear, recycle, scroll_to_end,set_focus,
			quick_refresh_editor,quick_refresh_margin
		end
		
	EB_SHARED_PIXMAPS
	
	EB_EXTERNAL_OUTPUT_CONSTANTS
	
	SHARED_PLATFORM_CONSTANTS
	
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end
		
	EB_CONSTANTS
create
	make

feature{NONE} -- Initialization
	
	make (a_tool: EB_DEVELOPMENT_WINDOW; m: EB_CONTEXT_TOOL) is
			-- Create a new external output tool.
		do
			owner := a_tool			
			initialization (a_tool)
			widget := main_frame
			external_output_manager.extend (Current)		
			stone_manager := m
		end	
		
	initialization (a_tool: EB_DEVELOPMENT_WINDOW) is
			-- 
		local
			--lst_item: EV_LIST_ITEM
			l_ev_horizontal_box_1: EV_HORIZONTAL_BOX	
			l_ev_horizontal_box_2: EV_HORIZONTAL_BOX	
			l_ev_horizontal_box_3: EV_HORIZONTAL_BOX		
			l_ev_horizontal_box_4: EV_HORIZONTAL_BOX	
			l_ev_horizontal_box_5: EV_HORIZONTAL_BOX
			l_ev_horizontal_box_6: EV_HORIZONTAL_BOX	
			l_ev_horizontal_box_7: EV_HORIZONTAL_BOX					
			l_ev_vertical_box_1: EV_VERTICAL_BOX	
			l_ev_vertical_box_2: EV_VERTICAL_BOX	
			l_ev_cmd_lbl: EV_LABEL
			l_ev_output_lbl: EV_LABEL
			l_ev_input_lbl: EV_LABEL
			l_ev_empty_lbl: EV_LABEL
			cmd_toolbar: EV_TOOL_BAR
			output_toolbar: EV_TOOL_BAR
			clear_output_toolbar: EV_TOOL_BAR
			input_toolbar: EV_TOOL_BAR
			tbs: EV_TOOL_BAR_SEPARATOR
			--ext_cmd: EB_EXTERNAL_COMMAND
		do
			create del_cmd_btn
			create tbs.default_create
			create cmd_toolbar
			create output_toolbar
			create input_toolbar
			create console
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
			create terminate_btn
			create run_btn
			create cmd_lst
			create edit_cmd_detail_btn
			create hidden_btn		
			create state_label.make_with_text (l_no_command_is_running)
			create send_input_btn
			create input_field
			create save_output_btn
			create clear_output_btn
			create clear_output_toolbar
			
			l_ev_empty_lbl.set_minimum_height (State_bar_height)
			l_ev_empty_lbl.set_minimum_width (State_bar_height * 2)
			l_ev_horizontal_box_7.extend (l_ev_empty_lbl)
			l_ev_horizontal_box_7.disable_item_expand (l_ev_empty_lbl)
			output_toolbar.extend (save_output_btn)
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
			l_ev_horizontal_box_2.set_padding_width (5)	
			l_ev_horizontal_box_5.extend (cmd_toolbar)
			l_ev_horizontal_box_5.disable_item_expand (cmd_toolbar)
			cmd_toolbar.extend (run_btn)
			cmd_toolbar.extend (terminate_btn)
			cmd_toolbar.extend (tbs)
			cmd_toolbar.extend (edit_cmd_detail_btn)
			cmd_toolbar.extend (del_cmd_btn)		
			l_ev_horizontal_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cmd_lbl)						
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_2)
			l_ev_output_lbl.align_text_left
			l_ev_vertical_box_2.extend (l_ev_output_lbl)
			l_ev_vertical_box_2.disable_item_expand (l_ev_output_lbl)
			l_ev_vertical_box_2.extend (console)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_6)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_6)				
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)									
			l_ev_horizontal_box_4.extend (state_label)	
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_1.set_padding (4)
			l_ev_vertical_box_1.set_border_width (4)

			del_cmd_btn.set_pixmap (Icon_delete_small.item (1))
			del_cmd_btn.set_tooltip (f_delete_command)
			del_cmd_btn.select_actions.extend (agent on_delete_command)
			
			clear_output_btn.set_pixmap (Icon_recycle_bin.item (1))
			clear_output_btn.set_tooltip (f_clear_output)
			clear_output_btn.select_actions.extend (agent on_clear_output_window)
			
			console.set_foreground_color (preferences.editor_data.normal_text_color)
			console.set_font (preferences.editor_data.font)
			console.disable_edit
			
			terminate_btn.set_pixmap (Pixmaps.icon_exec_quit.item (1))
			terminate_btn.set_tooltip (f_terminate_command_button)			
			terminate_btn.select_actions.extend (agent on_terminate_process)

			edit_cmd_detail_btn.set_text ("")
			edit_cmd_detail_btn.set_tooltip (f_edit_cmd_detail_button)
			edit_cmd_detail_btn.set_pixmap (icon_save.item (1))
				
			state_label.set_minimum_height (State_bar_height)
			state_label.align_text_right						
			
			run_btn.set_pixmap (Pixmaps.icon_run.item (1))
			run_btn.set_tooltip (f_start_command_button)
			run_btn.select_actions.extend (agent on_run_process)			

			cmd_lst.key_press_actions.extend (agent on_external_cmd_list_key_down (?))		
			cmd_lst.change_actions.extend (agent on_cmd_lst_text_change)
			cmd_lst.set_text ("")
			
			edit_cmd_detail_btn.set_pixmap (Icon_edited)
			edit_cmd_detail_btn.select_actions.extend (agent on_edit_command_detail)

			input_field.key_press_actions.extend (agent on_key_pressed_in_input_field (?))
			
			send_input_btn.set_pixmap (icon_input_to_process)
			send_input_btn.set_tooltip (f_send_input_button)
			send_input_btn.select_actions.extend (agent on_send_input_btn_pressed)
						
			save_output_btn.set_text ("Save")
			output_toolbar.disable_vertical_button_style
			save_output_btn.set_tooltip (f_save_output_button)
			save_output_btn.set_pixmap (icon_save.item (1))
			save_output_btn.select_actions.extend (agent on_save_output_to_file)

			l_ev_cmd_lbl.set_text (l_command)
			l_ev_output_lbl.set_text (l_output)			
			l_ev_input_lbl.set_text (l_input)			

			synchronize_command_list (Void)
			if external_launcher.is_launch_session_over then
				synchronize_on_process_exits
			else			
				synchronize_on_process_starts ("")
			end			
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
			
			if external_output_manager.target_development_window /= Void then
				if owner = external_output_manager.target_development_window then
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
			
			input_field.disable_sensitive
			send_input_btn.disable_sensitive
			terminate_btn.disable_sensitive	
			if cmd_lst.is_displayed then
				cmd_lst.set_focus				
			end	
			del_cmd_btn.enable_sensitive
			synchronize_command_list (corresponding_external_command)
		end		
		
	clear is
			-- Clear window
		do
			console.clear
		end	
						
	print_command_name (name: STRING) is
			-- Print command `name' to text fielad in command list box.
		require
			name_not_null: name /= Void
		do
			cmd_lst.set_text (name)
		end
		
	recycle is
			-- To be called before destroying this objects
		do
			external_output_manager.prune (Current)
			console := Void
		end	
		
	scroll_to_end is
			-- Scroll the console to the bottom.
		do		
			console.scroll_to_line (console.line_count)
		end
		
	set_focus is
			-- Give the focus to the editor.
		do
			if cmd_lst.is_displayed and then cmd_lst.is_sensitive then
				cmd_lst.set_focus	
			end
		end
		
	set_cmd_lst_focus is
			-- 
		do
			if cmd_lst.is_displayed and then cmd_lst.is_sensitive then
				cmd_lst.set_focus	
			end			
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
				ms := owner.Edit_external_commands_cmd.commands
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
			end
		end
		
	process_block_text (text_block: EB_PROCESS_IO_DATA_BLOCK) is
			-- Print `text_block' on `console'.
		local
			str: STRING
		do	
			str ?= text_block.data
			if str /= Void then
				console.append_text (str)	
			end
		end
		
	process_text (st: STRUCTURED_TEXT) is
			-- Display `st' on the console.
		do	
		end	
		
	drop_breakable (st: BREAKABLE_STONE) is
			-- Inform `Current's manager that a stone concerning breakpoints has been dropped.
		do
		end
		
	drop_class (st: CLASSI_STONE) is
			-- Drop `st' in the context tool and pop the `class info' tab.
		do
		end

	drop_feature (st: FEATURE_STONE) is
			-- Drop `st' in the context tool and pop the `feature info' tab.
		do
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Drop `st' in the context tool.
		do
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
					edit_cmd_detail_btn.set_pixmap (icon_edited)
				else						
					edit_cmd_detail_btn.set_tooltip (f_new_cmd_detail_button)
					edit_cmd_detail_btn.set_pixmap (icon_add_new_external_cmd)				
				end
			else
				run_btn.disable_sensitive
				edit_cmd_detail_btn.set_tooltip (f_new_cmd_detail_button)
				edit_cmd_detail_btn.set_pixmap (icon_add_new_external_cmd)								
			end				
		end
		
	on_edit_command_detail is
			-- Called when user selected `edit_cmd_detail_btn' to
			-- modify command external in detail.
		local
			str: STRING
			ec: EB_EXTERNAL_COMMAND
			warn_dlg: EV_WARNING_DIALOG
		do
			ec := corresponding_external_command
			if ec /= Void then
					-- If external command indicated by text in command list box
					-- exists, pop up an edit dialog and let user edit this command.
				ec.edit_properties (owner.window)
			else
					-- If user has just input a new external command,
					-- first check whether we have room for this command.
				if owner.edit_external_commands_cmd.menus.count = 10 then
					create warn_dlg.make_with_text ("Your external command list is full.%NUse Tools->External Command... to delete one.")
					warn_dlg.show_modal_to_window (owner.window)
				else
						-- If we have room for this command, pop up a new command
						-- dialog and let user add this new command.
					create str.make_from_string (cmd_lst.text)
					str.left_adjust
					str.right_adjust
					create ec.make_from_new_command_line (owner.window, str)
				end
			end
			on_cmd_lst_text_change
			owner.edit_external_commands_cmd.refresh_list_from_outside
			owner.edit_external_commands_cmd.update_menus_from_outside
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
			str: STRING
			found: BOOLEAN
			lt: EV_LIST_ITEM
		do
			if input_field.text /= Void then
				create str.make_from_string (input_field.text)
			else
				str :=""
			end		
			str.append_character ('%N')
			input_field.set_text ("")
			on_input_to_process (str)
			str.left_adjust
			str.right_adjust
			if not str.is_empty then
				from
					input_field.start
					found := False
				until
					input_field.after or found
				loop
					if str.is_equal (input_field.item.text) then
						found := False
					end
					input_field.forth
				end
				if not found then
					create lt.make_with_text (str)
					input_field.put_front (lt)
					if input_field.count > 10 then
						input_field.go_i_th (input_field.count)
						input_field.remove
					end
					
				end
			end
		end
		
	on_key_pressed_in_input_field (key: EV_KEY) is
			-- Agent called when user press enter in `input_field'
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_send_input_btn_pressed
			end
		end
		
	on_save_output_to_file is
			-- Called when user press Save output button.
		local

			ew: EV_WARNING_DIALOG
		do
			if console.text.count = 0 then
				create ew.make_with_text ("No output data.")
				ew.show_modal_to_window (owner.window)
			else
				create save_file_dlg.make_with_title ("Save output to file")
				save_file_dlg.save_actions.extend (agent on_save_file_selected)
				save_file_dlg.show_modal_to_window (owner.window)
				save_file_dlg.destroy
			end
		end
		
	on_save_file_selected is
			-- Called when user chosed a file to store process output.
		require
			save_file_dlg_not_null: save_file_dlg /= Void
		local
			f: PLAIN_TEXT_FILE
			wd: EV_CONFIRMATION_DIALOG
			dlg: EV_WARNING_DIALOG
			retried: BOOLEAN
			actions: ARRAY [PROCEDURE [ANY, TUPLE]]
			str: STRING
		do	
			if not retried then
				
				create f.make (save_file_dlg.file_name)
				create str.make_from_string (save_file_dlg.file_name)
				save_file_dlg.destroy				
				if f.exists then
					create actions.make (1,1)
					actions.put (agent on_overwrite_file (str), 1)
					create wd.make_with_text_and_actions (Warning_messages.w_File_exists (str), actions)
					--create wd.make_with_text ("abcd")
					wd.show_modal_to_window (owner.window)
					wd.destroy
				else
					on_overwrite_file (save_file_dlg.file_name)
				end
			end
		rescue
			retried := True
			create dlg.make_with_text ("Save failed.")
			dlg.show_modal_to_window (owner.window)
			dlg.destroy
			retry
		end
		
	on_overwrite_file (file_name: STRING) is
			-- Agent called when save text from `console' to an existing file
		local
			f: PLAIN_TEXT_FILE	
			dlg: EV_WARNING_DIALOG
			retried: BOOLEAN				
		do
			if not retried then
				create f.make_create_read_write (file_name)
				f.put_string (console.text)
				f.close					
			end
		rescue
			retried := True
			create dlg.make_with_text ("Save failed.")
			dlg.show_modal_to_window (owner.window)
			dlg.destroy
			retry						
		end
		
	on_clear_output_window is
			-- Clear `console'.
		do
			console.clear
		end
		
	on_delete_command is
			-- Agent when user want to delete an external command.
		local
			comm: EB_EXTERNAL_COMMAND
		do
			comm := corresponding_external_command
			if comm /= Void then
				owner.edit_external_commands_cmd.commands.put (Void, comm.index)	
				owner.edit_external_commands_cmd.refresh_list_from_outside
				owner.edit_external_commands_cmd.update_menus_from_outside
				cmd_lst.set_text ("")
				external_output_manager.synchronize_command_list (Void)
			else
				cmd_lst.set_text ("")
			end
		end
				
feature -- Status reporting

	owner_development_window: EB_DEVELOPMENT_WINDOW is
			-- Development window which `Current' is belonged to
		do
			Result := owner
		end
		
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
					i >= owner.edit_external_commands_cmd.commands.count or done
				loop
					e_cmd ?= owner.edit_external_commands_cmd.commands.item (i)
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
		
	text_fully_loaded: BOOLEAN is
			-- Has text been fully loaded, only then,
			-- we can print new data into `console'	
		do
			Result := console.text_fully_loaded
		end
		
feature -- State setting

	display_state (s: STRING; warning: BOOLEAN) is
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
			state_label.set_tooltip (s)
		end

feature{NONE} -- Implementation

	terminate_btn: EV_TOOL_BAR_BUTTON
			-- Button to terminate running process
	
	run_btn: EV_TOOL_BAR_BUTTON
			-- Button to launch process
	
	state_label: EV_LABEL
			-- Label to display process launching status.
	
	main_frame: EV_VERTICAL_BOX	
	
	cmd_lst: EV_COMBO_BOX
			-- List of external commands.
	
	edit_cmd_detail_btn: EV_TOOL_BAR_BUTTON
			-- Button to open new/edit external command dialog.
	
	hidden_btn: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to set whether or not external command should be run hidden.
	
	console: EB_EXTERNAL_OUTPUT_PANEL
			-- Panel to display output from process and waits for user input.
	
	input_field: EV_COMBO_BOX
			-- Text field where user can type data.
			
	send_input_btn: EV_TOOL_BAR_BUTTON
			-- Button to send data into launched process.
			
	save_output_btn: EV_TOOL_BAR_BUTTON
			-- Button to save output from process to file.
			
	clear_output_btn: EV_TOOL_BAR_BUTTON
			-- Button to clear output window.
	
	save_file_dlg: EV_FILE_SAVE_DIALOG	
			-- File dialog to let user choose a file.
			
	del_cmd_btn: EV_TOOL_BAR_BUTTON
					
end -- class EB_EXTERNAL_OUTPUT_TOOL
