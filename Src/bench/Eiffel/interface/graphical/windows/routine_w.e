indexing
	description: "Window describing an Eiffel routine."
	date: "$Date$"
	revision: "$Revision$"

class ROUTINE_W 

inherit
	BAR_AND_TEXT
		rename
			Feature_resources as resources,
			edit_bar as routine_toolbar,
			Routine_type as stone_type
		redefine
			make, hole, tool_name, close_windows,
			build_widgets, attach_all, reset, resize_action,
			stone, set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible,
			close, editable_text_window, set_editable_text_window, 
			read_only_text_window, set_read_only_text_window,
			update_boolean_resource, create_toolbar, build_toolbar_menu,
			set_title, set_mode_for_editing, parse_file, display,
			history_window_title, has_editable_text, help_index, icon_id
		end

creation
	make, form_create

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a feature tool.
		do
			is_in_project_tool := False
			{BAR_AND_TEXT} Precursor (a_screen)
		end

	form_create (a_form: FORM file_m, edit_m, format_m, special_m: MENU_PULL) is
			-- Create a feature tool from a form.
		require
			valid_args: a_form /= Void and then edit_m /= Void and then	
				format_m /= Void and then special_m /= Void
		do
			is_in_project_tool := True
			file_menu := file_m
			edit_menu := edit_m
			format_menu := format_m
			special_menu := special_m
			make_form (a_form)
			init_text_window
			set_composite_attributes (a_form)
			set_composite_attributes (file_m)
			set_composite_attributes (edit_m)
			set_composite_attributes (format_m)
			set_composite_attributes (special_m)
		end

feature -- Update Resources

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS
			stop_cmd: SHOW_BREAKPOINTS
		do
			if old_res = resources.show_all_callers then
				rout_cli_cmd ?= showroutclients_frmt_holder.associated_command
				rout_cli_cmd.set_show_all_callers (new_res.actual_value)
			elseif old_res = resources.do_flat_in_breakpoints then
				stop_cmd ?= showstop_frmt_holder.associated_command
				stop_cmd.set_format_mode (new_res.actual_value)
			end
			{BAR_AND_TEXT} Precursor (old_res, new_res)
		end

feature -- Window Properties

	stone: FEATURE_STONE
			-- Stone in tool

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

	history_window_title: STRING is
			-- Title of the history window
		do
			Result := Interface_names.t_Select_feature
		end

	has_editable_text: BOOLEAN is True

	help_index: INTEGER is 3

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Feature_id
		end
 
feature -- Resetting

	reset is
			-- Reset the window contents
		do
			{BAR_AND_TEXT} Precursor
			-- class_hole.set_empty_symbol
			class_text_field.clear
			routine_text_field.clear
		end

	close is
			-- Close Current.
		do
			if is_a_shell then
				Project_tool.remove_routine_entry (Current)
				hide
				reset
			else
				Project_tool.display_feature_cmd_holder.associated_command.work (Void)
			end
		end

feature -- Access

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result := a_stone.stone_type = stone_type or else
				a_stone.stone_type = Breakable_type or else
				a_stone.stone_type = Class_type
		end

	in_debug_format: BOOLEAN is
			-- Does window show breakable points of routine?
		do
			Result := last_format = showstop_frmt_holder
		end

feature -- Update

	parse_file: BOOLEAN is
			-- Parse the file if possible.
			-- (By default, do nothing).
		local
			syn_error: SYNTAX_ERROR
			e_class: E_CLASS
			txt, msg: STRING
		do
			e_class := stone.e_class
			e_class.parse_ast
			syn_error := e_class.last_syntax_error
			if syn_error /= Void then
				txt := "Class has syntax error "
				msg := syn_error.syntax_message
				if not msg.empty then
					txt.extend ('(')
					txt.append (msg)
					txt.extend (')')
				end
					-- syntax error occurred
				text_window.highlight_selected (syn_error.start_position,
									syn_error.end_position)
				text_window.set_cursor_position (syn_error.start_position)
				e_class.clear_syntax_error
				warner (popup_parent).gotcha_call (txt)
			else
				text_window.update_clickable_from_stone (stone)
				Result := true
			end
		end

	set_mode_for_editing is
			-- Set the text mode to be editable.
		do
			text_window.set_read_only
		end
 
	close_windows is
			-- Pop down the associated windows.
		local
			ss: SEARCH_STRING
		do
			{BAR_AND_TEXT} Precursor
			routine_text_field.close_choice_window
			class_text_field.close_choice_window
		end

	highlight_breakable (index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		require
			positive_index: index >= 1
		do
			if in_debug_format then
				text_window.highlight_breakable (stone.e_feature, index)
			end
		end

	resynchronize_debugger (feat: E_FEATURE) is
			-- Resynchronize debugged routine window with feature `feat'.
			-- If `feat' resynchronize routine window.
		local
			cur: CURSOR
			old_do_format: BOOLEAN
			f: FORMATTER
		do
			if (in_debug_format and then stone /= Void and then
				stone.e_feature /= Void) and then
			 	(feat = Void or else 
				feat.body_id.is_equal (stone.e_feature.body_id))
			then
				cur := text_window.cursor
				f := showstop_frmt_holder.associated_command
				old_do_format := f.do_format
				f.set_do_format (true)
				f.execute (stone)
				f.set_do_format (old_do_format)
				text_window.go_to (cur)
			end
		end

	set_debug_format is 
			-- Set the current format to be in `debug_format'.		
		do
			set_read_only_text
			set_last_format (showstop_frmt_holder)
			synchronize
		ensure
			set: showstop_frmt_holder = last_format
		end

	show_stoppoint (f: E_FEATURE index: INTEGER) is
			-- If stone feature is equal to feature `f' and if in debug
			-- mode then redisplay the sign of the `index'-th breakable point.
			-- Otherwize, update the title of feature tool (to print `stop').
		require
			valid_feature: f /= Void and then f.body_id /= Void
			positive_index: index >= 1
		do
			if stone /= Void and then
				stone.e_feature /= Void and then
				f.body_id.is_equal (stone.e_feature.body_id)
			then
				if in_debug_format then
					text_window.redisplay_breakable_mark (stone.e_feature, index)
				elseif last_format = showtext_frmt_holder then
					-- Update the title bar of the feature tool.
					-- "(stop)" if the routine has a stop point set.
					showtext_frmt_holder.associated_command.display_header (stone)
				end
			end
		end

feature -- Status setting

	display is
		do
			{BAR_AND_TEXT} Precursor
			routine_text_field.set_focus
		end

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s)
				Project_tool.change_routine_entry (Current)
			end
		end

	set_editable_text_window (ed: like editable_text_window) is
			-- Set `editable_text_window' to `ed'.
		do
			editable_text_window := ed
		end

	set_read_only_text_window (ed: like read_only_text_window) is
			-- Set `read_only_text_window' to `ed'.
		do
			read_only_text_window := ed
		end

	set_stone (s: like stone) is
			-- Update stone from `s'.
		do
			stone := s
			if s = Void then
				set_icon_name (tool_name)
			else
				update_routine_toolbar
				set_icon_name (s.icon_name)
				hole_button.set_full_symbol
				class_hole_button.set_full_symbol
			end
		end

feature -- Stone updating

	process_feature (a_stone: FEATURE_STONE) is
			-- Process the feature stone `a_stone'. 
		do
			last_format.execute (a_stone)
			add_to_history (a_stone)
			update_routine_toolbar
		end

	process_breakable (a_stone: BREAKABLE_STONE) is
		do
			Project_tool.process_breakable (a_stone)
		end

	process_class (a_stone: CLASSC_STONE) is
		local
			c: E_CLASS
			ris: ROUT_ID_SET
			i: INTEGER
			rout_id: ROUTINE_ID
			fi: E_FEATURE
			fs: FEATURE_STONE
			text: STRUCTURED_TEXT
			s: STRING
		do
			if stone /= Void then
				ris := stone.e_feature.rout_id_set
				c := a_stone.e_class
				from
					i := 1
				until
					i > ris.count
				loop
					rout_id := ris.item (i)
					fi := c.feature_with_rout_id (rout_id)
					if (fi /= Void) then
						i := ris.count
					end
					i := i + 1
				end
				if (fi /= Void) then
					!! fs.make (fi)
					process_feature (fs)
				else
					error_window.clear_window
					!! text.make
					text.add_string ("No version of feature ")
					text.add_feature (stone.e_feature, stone.e_feature.name)
					text.add_new_line
					text.add_string ("   for class ")
					s := c.name_in_upper
					text.add_classi (c.lace_class, s)
					error_window.process_text (text)
					error_window.display
					project_tool.raise
				end
			end
		end
	
feature -- Graphical Interface

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
			if stone = Void then
				-- class_hole.set_empty_symbol
				class_text_field.clear
				routine_text_field.clear
			else
				update_routine_toolbar
			end
		end

	update_routine_toolbar is
			-- Updates the edit bar.
		local
			f_name: STRING
		do
			if stone /= Void then
				class_text_field.update_class_name (stone.e_class.name)
				routine_text_field.set_text (stone.e_feature.name)
			end
		end 
	
	build_widgets is
			-- Build the widgets for this window.
		do
			create_toolbar (global_form)

			build_text_windows (global_form)
			if not is_in_project_tool then
				build_menus
			end

			build_routine_toolbar

			if not is_in_project_tool then
				fill_menus
			end
			build_toolbar_menu
			set_last_format (default_format)

			if resources.command_bar.actual_value = False then
				routine_toolbar.remove
			end

			attach_all	
		end

	attach_all is
			-- Attach all widgets.
		do
			if not is_in_project_tool then
				global_form.attach_left (menu_bar, 0)
				global_form.attach_right (menu_bar, 0)
				global_form.attach_top (menu_bar, 0)
			end

			global_form.attach_left (toolbar_parent, 0)
			global_form.attach_right (toolbar_parent, 0)
			if is_in_project_tool then
				global_form.attach_top (toolbar_parent, 2)
			else
				global_form.attach_top_widget (menu_bar, toolbar_parent, 0)
			end

			global_form.attach_left (editable_text_window.widget, 0)
			global_form.attach_top_widget (toolbar_parent, editable_text_window.widget, 0)
			global_form.attach_right (editable_text_window.widget, 0)
			global_form.attach_bottom (editable_text_window.widget, 0)

			if editable_text_window /= read_only_text_window then
				global_form.attach_left (read_only_text_window.widget, 0)
				global_form.attach_top_widget (toolbar_parent, read_only_text_window.widget, 0)
				global_form.attach_right (read_only_text_window.widget, 0)
				global_form.attach_bottom (read_only_text_window.widget, 0)
			end
		end

feature {TEXT_WINDOW} -- Forms And Holes

	hole: ROUTINE_HOLE
			-- Hole charaterizing Current.

	class_hole: ROUT_CLASS_HOLE
			-- Hole for version of routine for a particular class.

	class_hole_button: EB_BUTTON_HOLE
			-- Button for the class hole

	stop_hole: DEBUG_STOPIN_HOLE
			-- To set breakpoints

	stop_hole_button: EB_BUTTON_HOLE
			-- Button for the stop points hole

feature {TEXT_WINDOW, PROJECT_W} -- Formats

	showroutclients_frmt_holder: FORMAT_HOLDER

	showhomonyms_frmt_holder: FORMAT_HOLDER

	showpast_frmt_holder: FORMAT_HOLDER

	showhistory_frmt_holder: FORMAT_HOLDER

	showfuture_frmt_holder: FORMAT_HOLDER

	showflat_frmt_holder: FORMAT_HOLDER

feature -- Commands

	showstop_frmt_holder: FORMAT_HOLDER

	shell: COMMAND_HOLDER

	current_target_cmd_holder: COMMAND_HOLDER

	previous_target_cmd_holder: COMMAND_HOLDER

	next_target_cmd_holder: COMMAND_HOLDER

	routine_text_field: ROUTINE_TEXT_FIELD

	class_text_field: ROUTINE_CLASS_TEXT_FIELD

	super_melt_menu_entry: EB_MENU_ENTRY

feature {NONE} -- Implementation Window Settings

	resize_action is
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup
			class_text_field.update_text
			routine_text_field.update_text
			--class_text_field.update_choice_position
			--routine_text_field.update_choice_position
		end

feature {NONE} -- Implementation Graphical Interface

	create_toolbar (a_parent: COMPOSITE) is
		local
			sep: THREE_D_SEPARATOR
		do
			!! toolbar_parent.make (new_name, a_parent)
			if not is_in_project_tool then
				!! sep.make (Interface_names.t_Empty, toolbar_parent)
			end
			toolbar_parent.set_column_layout
			toolbar_parent.set_free_size	
			toolbar_parent.set_margin_height (0)
			toolbar_parent.set_spacing (1)
			!! routine_toolbar.make (Interface_names.n_Command_bar_name, toolbar_parent)
			routine_toolbar.set_height (22)
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, special_menu)
			!! toolbar_t.make (routine_toolbar.identifier, special_menu)
			routine_toolbar.init_toggle (toolbar_t)
		end

	build_routine_toolbar is
			-- Build routine toolbar
		local
			shell_cmd: SHELL_COMMAND
			shell_button: EB_BUTTON_HOLE
			shell_menu_entry: EB_MENU_ENTRY
			super_melt_cmd: SUPER_MELT
			previous_target_cmd: PREVIOUS_TARGET
			previous_target_button: EB_BUTTON
			previous_target_menu_entry: EB_MENU_ENTRY
			next_target_cmd: NEXT_TARGET
			next_target_button: EB_BUTTON
			next_target_menu_entry: EB_MENU_ENTRY
			current_target_cmd: CURRENT_ROUTINE
			current_target_button: EB_BUTTON
			current_target_menu_entry: EB_MENU_ENTRY
			sep: SEPARATOR
			sep1, sep2, sep3, sep4: THREE_D_SEPARATOR
			new_class_button: EB_BUTTON_HOLE
			rout_cli_cmd: SHOW_ROUTCLIENTS
			rout_cli_button: FORMAT_BUTTON
			rout_cli_menu_entry: EB_TICKABLE_MENU_ENTRY
			rout_hist_cmd: SHOW_ROUT_HIST
			rout_hist_button: FORMAT_BUTTON
			rout_hist_menu_entry: EB_TICKABLE_MENU_ENTRY
			past_cmd: SHOW_PAST
			past_button: FORMAT_BUTTON
			past_menu_entry: EB_TICKABLE_MENU_ENTRY
			rout_flat_cmd: SHOW_ROUT_FLAT
			rout_flat_button: FORMAT_BUTTON
			rout_flat_menu_entry: EB_TICKABLE_MENU_ENTRY
			future_cmd: SHOW_FUTURE
			future_button: FORMAT_BUTTON
			future_menu_entry: EB_TICKABLE_MENU_ENTRY
			stop_cmd: SHOW_BREAKPOINTS
			stop_button: FORMAT_BUTTON
			stop_menu_entry: EB_TICKABLE_MENU_ENTRY
			text_cmd: SHOW_TEXT
			text_button: FORMAT_BUTTON
			text_menu_entry: EB_TICKABLE_MENU_ENTRY
			homonym_cmd: SHOW_HOMONYMS
			homonym_button: FORMAT_BUTTON
			homonym_menu_entry: EB_TICKABLE_MENU_ENTRY
			label: LABEL
			quit_cmd: QUIT_FILE
			quit_button: EB_BUTTON
			quit_menu_entry: EB_MENU_ENTRY
			exit_menu_entry: EB_MENU_ENTRY
			class_hole_holder: HOLE_HOLDER
			stop_hole_holder: HOLE_HOLDER
			rc: ROW_COLUMN
			search_button: EB_BUTTON
			history_list_cmd: LIST_HISTORY
		do
				-- First we create the needed objects.
			!! hole.make (Current)
			!! hole_button.make (hole, routine_toolbar)
			!! hole_holder.make_plain (hole)
			hole_holder.set_button (hole_button)

			!! class_hole.make (Current)
			!! class_hole_button.make (class_hole, routine_toolbar)
			!! class_hole_holder.make_plain (class_hole)
			class_hole_holder.set_button (class_hole_button)

			if not is_in_project_tool then
				!! stop_hole.make (Current)
				!! stop_hole_button.make (stop_hole, routine_toolbar)
				!! stop_hole_holder.make_plain (stop_hole)
				stop_hole_holder.set_button (stop_hole_button)
			end
			!! routine_text_field.make (routine_toolbar, Current)
			!! class_text_field.make (routine_toolbar, Current)
			!! label.make (Interface_names.t_Empty, routine_toolbar)
			label.set_text ("from: ")
			label.set_right_alignment

			build_edit_menu (routine_toolbar)
			build_save_as_menu_entry
			build_print_menu_entry

				--| We can now compute the search button
			search_button := search_cmd_holder.associated_button

			!! quit_cmd.make (Current)

			if not is_in_project_tool then
				!! quit_menu_entry.make (quit_cmd, file_menu)
				!! quit_cmd_holder.make (quit_cmd, Void, quit_menu_entry)

				!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
				!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
				exit_cmd_holder.set_menu_entry (exit_menu_entry)
			end


			if not is_in_project_tool then
				!! shell_cmd.make (Current)
				!! shell_button.make (shell_cmd, routine_toolbar)
				shell_button.add_third_button_action

				!! shell_menu_entry.make (shell_cmd, special_menu)
				!! shell.make (shell_cmd, shell_button, shell_menu_entry)
				!! new_class_button.make (Project_tool.class_hole_holder.associated_command, 
							routine_toolbar)
			end

			!! super_melt_cmd.make (Current)
			!! super_melt_menu_entry.make (super_melt_cmd, special_menu)

			build_filter_menu_entry

			!! current_target_cmd.make (Current)
			!! sep.make (new_name, special_menu)
			!! current_target_menu_entry.make (current_target_cmd, special_menu)
			!! current_target_cmd_holder.make_plain (current_target_cmd)
			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)

			!! history_list_cmd.make (Current)

			!! next_target_cmd.make (Current)
			!! next_target_button.make (next_target_cmd, routine_toolbar)
			!! next_target_menu_entry.make (next_target_cmd, special_menu)
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry)
			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)

			!! previous_target_cmd.make (Current)
			!! previous_target_button.make (previous_target_cmd, routine_toolbar)
			!! previous_target_menu_entry.make (previous_target_cmd, special_menu)
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry)
			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)

			!! text_cmd.make (Current)
			!! text_button.make (text_cmd, routine_toolbar)
			!! text_menu_entry.make (text_cmd, format_menu)
			!! showtext_frmt_holder.make (text_cmd, text_button, text_menu_entry)

			!! rout_flat_cmd.make (Current)
			!! rout_flat_button.make (rout_flat_cmd, routine_toolbar)
			!! rout_flat_menu_entry.make (rout_flat_cmd, format_menu)
			!! showflat_frmt_holder.make (rout_flat_cmd, rout_flat_button, rout_flat_menu_entry)

			!! rout_cli_cmd.make (Current)
			!! rout_cli_button.make (rout_cli_cmd, routine_toolbar)
			!! rout_cli_menu_entry.make (rout_cli_cmd, format_menu)
			!! showroutclients_frmt_holder.make (rout_cli_cmd, rout_cli_button, rout_cli_menu_entry)
			rout_cli_button.add_third_button_action

			!! sep.make (new_name, format_menu)

			!! rout_hist_cmd.make (Current)
			!! rout_hist_button.make (rout_hist_cmd, routine_toolbar)
			!! rout_hist_menu_entry.make (rout_hist_cmd, format_menu)
			!! showhistory_frmt_holder.make (rout_hist_cmd, rout_hist_button, rout_hist_menu_entry)

			!! past_cmd.make (Current)
			!! past_button.make (past_cmd, routine_toolbar)
			!! past_menu_entry.make (past_cmd, format_menu)
			!! showpast_frmt_holder.make (past_cmd, past_button, past_menu_entry)

			!! future_cmd.make (Current)
			!! future_button.make (future_cmd, routine_toolbar)
			!! future_menu_entry.make (future_cmd, format_menu)
			!! showfuture_frmt_holder.make (future_cmd, future_button, future_menu_entry)

			!! homonym_cmd.make (Current)
			!! homonym_button.make (homonym_cmd, routine_toolbar)
			!! homonym_menu_entry.make (homonym_cmd, format_menu)
			!! showhomonyms_frmt_holder.make (homonym_cmd, homonym_button, homonym_menu_entry)

			!! stop_cmd.make (Current)
			!! stop_button.make (stop_cmd, routine_toolbar)
			!! stop_menu_entry.make (stop_cmd, format_menu)
			!! showstop_frmt_holder.make (stop_cmd, stop_button, stop_menu_entry)
			stop_button.add_third_button_action

			!! sep1.make (Interface_names.t_empty, routine_toolbar)
			sep1.set_horizontal (False)
			sep1.set_height (20)

			!! sep2.make (Interface_names.t_empty, routine_toolbar)
			sep2.set_horizontal (False)
			sep2.set_height (20)

			!! sep3.make (Interface_names.t_empty, routine_toolbar)
			sep3.set_horizontal (False)
			sep3.set_height (20)

			!! sep4.make (Interface_names.t_empty, routine_toolbar)
			sep4.set_horizontal (False)
			sep4.set_height (20)

				-- Now we do all attachments. This is done here because of speed
			routine_toolbar.attach_left (hole_button, 5)
			routine_toolbar.attach_top (hole_button, 0)
			routine_toolbar.attach_left_widget (hole_button, class_hole_button, 0)
			routine_toolbar.attach_top (class_hole_button, 0)

			if not is_in_project_tool then
				routine_toolbar.attach_top (stop_hole_button, 0)
				routine_toolbar.attach_left_widget (class_hole_button, stop_hole_button, 0)
				routine_toolbar.attach_top (shell_button, 0)
				routine_toolbar.attach_left_widget (stop_hole_button, shell_button, 0)
				routine_toolbar.attach_top (new_class_button, 0)
				routine_toolbar.attach_left_widget (shell_button, new_class_button, 0)

				routine_toolbar.attach_top (sep1, 0)
				routine_toolbar.attach_left_widget (new_class_button, sep1, 5)

			else
				routine_toolbar.attach_top (sep1, 0)
				routine_toolbar.attach_left_widget (class_hole_button, sep1, 5)
			end

			routine_toolbar.attach_top (text_button, 0)
			routine_toolbar.attach_left_widget (sep1, text_button, 5)
			routine_toolbar.attach_top (rout_flat_button, 0)
			routine_toolbar.attach_left_widget (text_button, rout_flat_button, 0)
			routine_toolbar.attach_top (stop_button, 0)
			routine_toolbar.attach_left_widget (rout_flat_button, stop_button, 0)

			routine_toolbar.attach_top (sep2, 0)
			routine_toolbar.attach_left_widget (stop_button, sep2, 5)

			routine_toolbar.attach_top (search_button, 0)
			routine_toolbar.attach_left_widget (sep2, search_button, 5)

			routine_toolbar.attach_top (sep3, 0)
			routine_toolbar.attach_left_widget (search_button, sep3, 5)

			routine_toolbar.attach_top (rout_cli_button, 0)
			routine_toolbar.attach_left_widget (sep3, rout_cli_button, 5)
			routine_toolbar.attach_top (rout_hist_button, 0)
			routine_toolbar.attach_left_widget (rout_cli_button, rout_hist_button, 0)
			routine_toolbar.attach_top (past_button, 0)
			routine_toolbar.attach_left_widget (rout_hist_button, past_button, 0)
			routine_toolbar.attach_top (future_button, 0)
			routine_toolbar.attach_left_widget (past_button, future_button, 0)
			routine_toolbar.attach_top (homonym_button, 0)
			routine_toolbar.attach_left_widget (future_button, homonym_button, 0)

			routine_toolbar.attach_top (sep4, 0)
			routine_toolbar.attach_left_widget (homonym_button, sep4, 5)

			routine_toolbar.attach_top (previous_target_button, 0)
			routine_toolbar.attach_left_widget (sep4, previous_target_button, 5)  
			routine_toolbar.attach_top (next_target_button, 0)
			routine_toolbar.attach_left_widget (previous_target_button, next_target_button, 0)

			routine_toolbar.attach_top (routine_text_field, 0)
			routine_toolbar.attach_left_widget (next_target_button, routine_text_field, 3)
			routine_toolbar.attach_top (label, 0)
			routine_toolbar.attach_bottom (label, 0)
			routine_toolbar.attach_left_widget (routine_text_field, label, 7)
			routine_toolbar.attach_top (class_text_field, 0)
			routine_toolbar.attach_left_widget (label, class_text_field, 0)
		end

feature {NONE} -- Properties

	is_in_project_tool: BOOLEAN
			-- Is the current feature tool in the project tool

feature {TEXT_WINDOW} -- Properties

	tool_name: STRING is
		do
			Result := Interface_names.t_Empty_routine
		end

end -- class ROUTINE_W
