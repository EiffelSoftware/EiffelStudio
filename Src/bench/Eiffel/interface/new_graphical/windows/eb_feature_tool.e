indexing
	description: "Tool describing an Eiffel feature."
	date: "$Date$"

class
	EB_FEATURE_TOOL

inherit
	EB_MULTIFORMAT_EDIT_TOOL
		rename
			edit_bar as feature_toolbar
--			Routine_type as stone_type
		redefine
			make,
-- hole,
 empty_tool_name,
-- close_windows,
			build_interface, reset,
			stone, set_stone, synchronize,
-- process_feature,
--			process_class, process_breakable, compatible,
--			update_boolean_resource, create_toolbar, build_toolbar_menu,
			set_mode_for_editing, parse_file, raise,
			history_window_title, has_editable_text,
-- help_index,
 icon_id,
			format_list, build_edit_bar

		end
	EB_FEATURE_TOOL_DATA
		rename
			Feature_resources as resources
		end			

creation
	make

feature -- Initialization

	make (man: EB_TOOL_MANAGER) is
			-- Create a feature tool.
		do
			has_double_line_toolbar := resources.double_line_toolbar.actual_value
 			Precursor (man)
		end

--	form_create (a_form: EV_CONTAINER; file_m, edit_m, format_m, special_m: EV_MENU) is
--			-- Create a feature tool from a form.
--		require
--			valid_args: a_form /= Void and then edit_m /= Void and then	
--				format_m /= Void and then special_m /= Void
--		do
--			is_in_project_tool := True
--			has_double_line_toolbar := resources.double_line_toolbar.actual_value
--			file_menu := file_m
--			edit_menu := edit_m
--			format_menu := format_m
--			special_menu := special_m
--			make_form (a_form)
--			set_composite_attributes (a_form)
--			set_composite_attributes (file_m)
--			set_composite_attributes (edit_m)
--			set_composite_attributes (format_m)
--			set_composite_attributes (special_m)
--  			init_text_window
--		end

	build_interface is
			-- Build the widgets for this window.
		do
			precursor

--			if not resources.keep_toolbar.actual_value then
--				feature_toolbar.remove
--				if has_double_line_toolbar then
--					format_bar.remove
--				end
--			end
		end

	init_formatters is
		do
			create format_list.make (Current)
			set_last_format (format_list.default_format)
		end

feature -- Update Resources

	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS
			stop_cmd: SHOW_BREAKPOINTS
		do
-- 			if old_res = resources.show_all_callers then
--				rout_cli_cmd ?= showroutclients_frmt_holder.associated_command
--				rout_cli_cmd.set_show_all_callers (new_res.actual_value)
--			elseif old_res = resources.do_flat_in_breakpoints then
--				stop_cmd ?= showstop_frmt_holder.associated_command
--				stop_cmd.set_format_mode (new_res.actual_value)
--			elseif old_res = resources.keep_toolbar then
--				if new_res.actual_value then
--					if has_double_line_toolbar then
--						feature_toolbar.add
--						format_bar.add
--					else
--						feature_toolbar.add
--					end
--				else
--					if has_double_line_toolbar then
--						feature_toolbar.remove
--						format_bar.remove
--					else
--						feature_toolbar.remove
--					end
--				end
--			end
		end

feature -- Window Properties

	stone: FEATURE_STONE
			-- Stone in tool

	history_window_title: STRING is
			-- Title of the history window
		do
			Result := Interface_names.t_Select_feature
		end

	has_editable_text: BOOLEAN is True

--	help_index: INTEGER is 3

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Feature_id
		end
 
feature -- Resetting

	reset is
			-- Reset the window contents
		do
			Precursor
			-- class_hole.set_empty_symbol
			class_text_field.set_text("")
			feature_text_field.set_text("")
		end

feature -- Access

--	compatible (a_stone: STONE): BOOLEAN is
--			-- Is Current hole compatible with `a_stone'?
--		do
--			Result := a_stone.stone_type = stone_type or else
--				a_stone.stone_type = Breakable_type or else
--				a_stone.stone_type = Class_type
--		end

	in_debug_format: BOOLEAN is
			-- Does window show breakable points of feature?
		do
--			Result := last_format = showstop_frmt_holder
		end

feature -- Update

	parse_file: BOOLEAN is
			-- Parse the file if possible.
			-- (By default, do nothing).
		local
			syn_error: SYNTAX_ERROR
			e_class: CLASS_C
			txt, msg: STRING
			wd: EV_WARNING_DIALOG
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
				text_window.set_position (syn_error.start_position)
				e_class.clear_syntax_error
				create wd.make_default (parent, Interface_names.t_Warning, txt)
			else
				text_window.update_clickable_from_stone (stone)
				Result := true
			end
		end

	set_mode_for_editing is
			-- Set the text mode to be editable.
		do
			text_window.set_editable (True)
		end
 
	close_windows is
			-- Pop down the associated windows.
		local
			ss: SEARCH_STRING
		do
-- 			Precursor
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
			-- Resynchronize debugged feature window with feature `feat'.
			-- If `feat' resynchronize feature window.
		local
--			cur: CURSOR
			cur: INTEGER
			old_do_format: BOOLEAN
			f: EB_FORMATTER
		do
			if (in_debug_format and then stone /= Void and then
				stone.e_feature /= Void) and then
			 	(feat = Void or else 
				feat.body_id.is_equal (stone.e_feature.body_id))
			then
				cur := text_window.position
				f := format_list.stop_points_format
				old_do_format := f.do_format
				f.set_do_format (true)
--				f.execute (stone)
				f.set_do_format (old_do_format)
				text_window.go_to (cur)
			end
		end

	set_debug_format is 
			-- Set the current format to be in `debug_format'.		
		do
			text_window.set_editable (False)
			set_last_format (format_list.stop_points_format)
			synchronize
		ensure
			set: format_list.stop_points_format = last_format
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
				elseif last_format = format_list.text_format then
					-- Update the title bar of the feature tool.
					-- "(stop)" if the feature has a stop point set.
					format_list.text_format.display_header (stone)
				end
			end
		end

feature -- Status setting

	raise is
		do
			Precursor
--			feature_text_field.set_focus
		end

	set_stone (s: like stone) is
			-- Update stone from `s'.
		do
			stone := s
--			if s = Void then
--				set_icon_name (tool_name)
--			else
--				update_feature_toolbar
--				set_icon_name (s.icon_name)
--				hole_button.set_full_symbol
--				class_hole_button.set_full_symbol
--			end
		end

feature -- Stone updating

	process_feature (a_stone: FEATURE_STONE) is
			-- Process the feature stone `a_stone'. 
		do
			last_format.format (a_stone)
			add_to_history (a_stone)
			update_feature_toolbar
		end

--	process_breakable (a_stone: BREAKABLE_STONE) is
--		do
--			Project_tool.process_breakable (a_stone)
--		end

--	process_class (a_stone: CLASSC_STONE) is
--		local
--			c: CLASS_C
--			ris: ROUT_ID_SET
--			i: INTEGER
--			rout_id: ROUTINE_ID
--			fi: E_FEATURE
--			fs: FEATURE_STONE
--			text: STRUCTURED_TEXT
--			s: STRING
--		do
--			if stone /= Void then
--				ris := stone.e_feature.rout_id_set
--				c := a_stone.e_class
--				from
--					i := 1
--				until
--					i > ris.count
--				loop
--					rout_id := ris.item (i)
--					fi := c.feature_with_rout_id (rout_id)
--					if (fi /= Void) then
--						i := ris.count
--					end
--					i := i + 1
--				end
--				if (fi /= Void) then
--					!! fs.make (fi)
--					process_feature (fs)
--				else
--					error_window.clear_window
--					!! text.make
--					text.add_string ("No version of feature ")
--					text.add_feature (stone.e_feature, stone.e_feature.name)
--					text.add_new_line
--					text.add_string ("   for class ")
--					s := c.name_in_upper
--					text.add_classi (c.lace_class, s)
--					error_window.process_text (text)
--					error_window.display
--					project_tool.raise
--				end
--			end
--		end
	
feature -- Graphical Interface

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
--			synchronise_stone
--			if stone = Void then
--				-- class_hole.set_empty_symbol
--				class_text_field.set_text("")
--				feature_text_field.set_text("")
--			else
--				update_feature_toolbar
--			end
		end

	update_feature_toolbar is
			-- Updates the edit bar.
		do
 			if stone /= Void then
				class_text_field.update_class_name (stone.e_class.name)
				feature_text_field.set_text (stone.e_feature.name)
			end
		end 
	
feature {EB_FORMATTED_TEXT} -- Forms And Holes

	hole: ROUTINE_HOLE
			-- Hole charaterizing Current.

	class_hole: ROUT_CLASS_HOLE
			-- Hole for version of feature for a particular class.

	class_hole_button: EB_BUTTON_HOLE
			-- Button for the class hole

	stop_hole: DEBUG_STOPIN_HOLE
			-- To set breakpoints

	stop_hole_button: EB_BUTTON_HOLE
			-- Button for the stop points hole

feature -- Formats

	format_list: EB_FEATURE_FORMATTER_LIST

	showroutclients_frmt_holder: FORMAT_HOLDER

	showhomonyms_frmt_holder: FORMAT_HOLDER

	showpast_frmt_holder: FORMAT_HOLDER

	showhistory_frmt_holder: FORMAT_HOLDER

	showfuture_frmt_holder: FORMAT_HOLDER

	showflat_frmt_holder: FORMAT_HOLDER

feature -- Commands

	showstop_frmt_holder: FORMAT_HOLDER

	shell_cmd: EB_OPEN_SHELL_CMD

	filter_cmd: EB_FILTER_CMD

	super_melt_cmd: EB_SUPER_MELT_CMD

	current_target_cmd_holder: COMMAND_HOLDER

	previous_target_cmd_holder: COMMAND_HOLDER

	next_target_cmd_holder: COMMAND_HOLDER

	feature_text_field: EB_FEATURE_TEXT_FIELD

	class_text_field: EB_FEATURE_CLASS_TEXT_FIELD

	super_melt_menu_entry: EB_MENU_ENTRY

feature {NONE} -- Implementation Window Settings

	resize_action is
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
--			raise
--			class_text_field.update_text
--			feature_text_field.update_text
--			--class_text_field.update_choice_position
--			--feature_text_field.update_choice_position
		end

feature {NONE} -- Implementation Graphical Interface

	create_toolbar (a_parent: EV_CONTAINER) is
		local
--			sep: THREE_D_SEPARATOR
		do
--			!! toolbar_parent.make (new_name, a_parent)
--			if not is_in_project_tool then
--				!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			end
--			toolbar_parent.set_column_layout
--			toolbar_parent.set_free_size	
--			toolbar_parent.set_margin_height (0)
--			toolbar_parent.set_spacing (1)
--			!! feature_toolbar.make (Interface_names.n_Command_bar_name, toolbar_parent)
--			if not Platform_constants.is_windows or else has_double_line_toolbar then
--				!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			end
--			if Platform_constants.is_windows then
--	 			feature_toolbar.set_height (23)
--			end
--			if has_double_line_toolbar then
--				!! format_bar.make (Interface_names.n_Format_bar_name, toolbar_parent)
--				if not Platform_constants.is_windows then
--					!! sep.make (Interface_names.t_Empty, toolbar_parent)
--				else
--					format_bar.set_height (23)
--				end
--			end
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
--			sep: SEPARATOR
--			toolbar_t: EV_CHECK_MENU_ITEM
		do
--			create sep.make (Interface_names.t_Empty, special_menu)
--			create toolbar_t.make (feature_toolbar.identifier, special_menu)
--			feature_toolbar.set_state (toolbar_t)
--			if has_double_line_toolbar then
--				create toolbar_t.make (format_bar.identifier, special_menu)
--				format_bar.set_state (toolbar_t)
--			end
		end

	build_edit_bar is
			-- Build feature toolbar
		local
--			shell_cmd: SHELL_COMMAND
--			shell_button: EB_BUTTON_HOLE
--			shell_menu_entry: EB_MENU_ENTRY
--			super_melt_cmd: SUPER_MELT
--			previous_target_cmd: PREVIOUS_TARGET
--			previous_target_button: EB_BUTTON
--			previous_target_menu_entry: EB_MENU_ENTRY
--			next_target_cmd: NEXT_TARGET
--			next_target_button: EB_BUTTON
--			next_target_menu_entry: EB_MENU_ENTRY
--			current_target_cmd: CURRENT_ROUTINE
--			current_target_button: EB_BUTTON
--			current_target_menu_entry: EB_MENU_ENTRY
--			sep: SEPARATOR
--			sep1, sep2, sep3, sep4: THREE_D_SEPARATOR
--			new_class_button: EB_BUTTON_HOLE
--			rout_cli_cmd: SHOW_ROUTCLIENTS
--			rout_cli_button: FORMAT_BUTTON
--			rout_cli_menu_entry: EB_TICKABLE_MENU_ENTRY
--			rout_hist_cmd: SHOW_ROUT_HIST
--			rout_hist_button: FORMAT_BUTTON
--			rout_hist_menu_entry: EB_TICKABLE_MENU_ENTRY
--			past_cmd: SHOW_PAST
--			past_button: FORMAT_BUTTON
--			past_menu_entry: EB_TICKABLE_MENU_ENTRY
--			rout_flat_cmd: SHOW_ROUT_FLAT
--			rout_flat_button: FORMAT_BUTTON
--			rout_flat_menu_entry: EB_TICKABLE_MENU_ENTRY
--			future_cmd: SHOW_FUTURE
--			future_button: FORMAT_BUTTON
--			future_menu_entry: EB_TICKABLE_MENU_ENTRY
--			stop_cmd: SHOW_BREAKPOINTS
--			stop_button: FORMAT_BUTTON
--			stop_menu_entry: EB_TICKABLE_MENU_ENTRY
--			text_cmd: SHOW_TEXT
--			text_button: FORMAT_BUTTON
--			text_menu_entry: EB_TICKABLE_MENU_ENTRY
--			homonym_cmd: SHOW_HOMONYMS
--			homonym_button: FORMAT_BUTTON
--			homonym_menu_entry: EB_TICKABLE_MENU_ENTRY
			label: EV_LABEL
--			quit_cmd: QUIT_FILE
--			quit_button: EB_BUTTON
--			has_close_button: BOOLEAN
--			quit_menu_entry: EB_MENU_ENTRY
--			exit_menu_entry: EB_MENU_ENTRY
--			class_hole_holder: HOLE_HOLDER
--			stop_hole_holder: HOLE_HOLDER
--			rc: ROW_COLUMN
--			search_button: EB_BUTTON
--			history_list_cmd: LIST_HISTORY
--			current_bar: TOOLBAR
--			do_nothing_cmd: DO_NOTHING_CMD
		do
--				-- The current toolbar is by default `feature_toolbar'
--				--| It can be changed to `format_bar' when needed
--				--| for displaying two levels.
--			current_bar := feature_toolbar
--
--				-- Do we have a close button to create?
--			has_close_button := general_resources.close_button.actual_value
--
--				-- First we create the needed objects.
--			!! hole.make (Current)
--			!! hole_button.make (hole, current_bar)
--			!! hole_holder.make_plain (hole)
--			hole_holder.set_button (hole_button)
--
--			!! class_hole.make (Current)
--			!! class_hole_button.make (class_hole, current_bar)
--			!! class_hole_holder.make_plain (class_hole)
--			class_hole_holder.set_button (class_hole_button)
--
--			if not is_in_project_tool then
--				!! stop_hole.make (Current)
--				!! stop_hole_button.make (stop_hole, current_bar)
--				!! stop_hole_holder.make_plain (stop_hole)
--				stop_hole_holder.set_button (stop_hole_button)
--
--				!! shell_cmd.make (Current)
--				!! shell_button.make (shell_cmd, current_bar)
--				shell_button.add_third_button_action
--
--				!! shell_menu_entry.make (shell_cmd, special_menu)
--				!! shell.make (shell_cmd, shell_button, shell_menu_entry)
--				!! new_class_button.make (Project_tool.class_hole_holder.associated_command, current_bar)
--			end
--
--			build_edit_menu (current_bar)
--			build_save_as_menu_entry
--			build_print_menu_entry
--
--			!! super_melt_cmd.make (Current)
--			!! super_melt_menu_entry.make (super_melt_cmd, special_menu)
--
--			build_filter_menu_entry
--
--			!! current_target_cmd.make (Current)
--			!! sep.make (new_name, special_menu)
--			!! current_target_menu_entry.make (current_target_cmd, special_menu)
--			!! current_target_cmd_holder.make_plain (current_target_cmd)
--			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)
--
--			!! sep1.make (Interface_names.t_empty, current_bar)
--			sep1.set_horizontal (False)
--			sep1.set_height (20)
--
--				--| We can now compute the search button
--			search_button := search_cmd_holder.associated_button 
--
--			!! sep2.make (Interface_names.t_empty, current_bar)
--			sep2.set_horizontal (False)
--			sep2.set_height (20)
--			
--			!! history_list_cmd.make (Current)
--
--			!! next_target_cmd.make (Current)
--			!! next_target_button.make (next_target_cmd, current_bar)
--			!! next_target_menu_entry.make (next_target_cmd, special_menu)
--			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry)
--			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)
--
--			!! previous_target_cmd.make (Current)
--			!! previous_target_button.make (previous_target_cmd, current_bar)
--			!! previous_target_menu_entry.make (previous_target_cmd, special_menu)
--			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button,
--					previous_target_menu_entry)
--			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)
			
			create feature_text_field.make_with_tool (feature_toolbar, Current)
--			feature_text_field.debug_tab (class_text_field)
			create label.make_with_text (feature_toolbar, "from: ")
			label.set_right_alignment
			create class_text_field.make_with_tool (feature_toolbar, Current)
--			class_text_field.debug_tab (feature_text_field)
--			if class_text_field.toolkit.name.is_equal ("MOTIF") then
--				class_text_field.set_width (class_text_field.width - 10)
--				feature_text_field.set_width (feature_text_field.width - 10)
--			end

--			!! quit_cmd.make (Current)
--			if not is_in_project_tool then
--				!! quit_menu_entry.make (quit_cmd, file_menu)
--				if has_close_button then
--					!! quit_button.make (quit_cmd, current_bar)
--				end
--				!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)
--
--				!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
--				!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
--				exit_cmd_holder.set_menu_entry (exit_menu_entry)
--			end
--
--			if has_double_line_toolbar then
--				current_bar := format_bar
--			end
--
--			!! text_cmd.make (Current)
--			!! text_button.make (text_cmd, current_bar)
--			!! text_menu_entry.make (text_cmd, format_menu)
--			!! showtext_frmt_holder.make (text_cmd, text_button, text_menu_entry)
--
--			!! rout_flat_cmd.make (Current)
--			!! rout_flat_button.make (rout_flat_cmd, current_bar)
--			!! rout_flat_menu_entry.make (rout_flat_cmd, format_menu)
--			!! showflat_frmt_holder.make (rout_flat_cmd, rout_flat_button, rout_flat_menu_entry)
--
--			!! stop_cmd.make (Current)
--			!! stop_button.make (stop_cmd, current_bar)
--			!! stop_menu_entry.make (stop_cmd, format_menu)
--			!! showstop_frmt_holder.make (stop_cmd, stop_button, stop_menu_entry)
--			stop_button.add_third_button_action
--
--			!! sep.make (new_name, format_menu)
--
--			!! sep3.make (Interface_names.t_empty, current_bar)
--			sep3.set_horizontal (False)
--			sep3.set_height (20)
--
--			!! rout_cli_cmd.make (Current)
--			!! rout_cli_button.make (rout_cli_cmd, current_bar)
--			!! rout_cli_menu_entry.make (rout_cli_cmd, format_menu)
--			!! showroutclients_frmt_holder.make (rout_cli_cmd, rout_cli_button, rout_cli_menu_entry)
--			rout_cli_button.add_third_button_action
--
-- 			!! rout_hist_cmd.make (Current)
--			!! rout_hist_button.make (rout_hist_cmd, current_bar)
--			!! rout_hist_menu_entry.make (rout_hist_cmd, format_menu)
--			!! showhistory_frmt_holder.make (rout_hist_cmd, rout_hist_button, rout_hist_menu_entry)
--
--			!! past_cmd.make (Current)
--			!! past_button.make (past_cmd, current_bar)
--			!! past_menu_entry.make (past_cmd, format_menu)
--			!! showpast_frmt_holder.make (past_cmd, past_button, past_menu_entry)
--
--			!! future_cmd.make (Current)
--			!! future_button.make (future_cmd, current_bar)
--			!! future_menu_entry.make (future_cmd, format_menu)
--			!! showfuture_frmt_holder.make (future_cmd, future_button, future_menu_entry)
--
--			!! homonym_cmd.make (Current)
--			!! homonym_button.make (homonym_cmd, current_bar)
--			!! homonym_menu_entry.make (homonym_cmd, format_menu)
--			!! showhomonyms_frmt_holder.make (homonym_cmd, homonym_button, homonym_menu_entry)
--
--			if not has_double_line_toolbar then
--				!! sep4.make (Interface_names.t_empty, feature_toolbar)
--				sep4.set_horizontal (False)
--				sep4.set_height (20)
--			end
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
		do
			create shell_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Shell)
			i.add_select_command (shell_cmd, Void)

			create filter_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Filter)
			i.add_select_command (filter_cmd, Void)

			create super_melt_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Stoppable)
			i.add_select_command (super_melt_cmd, Void)
		end

feature {NONE} -- Properties

	has_double_line_toolbar: BOOLEAN
			-- Are we displaying two lines in the toolbar?

feature {EB_FORMATTED_TEXT} -- Properties

	empty_tool_name: STRING is
		do
			Result := Interface_names.t_Empty_routine
		end

end -- class EB_FEATURE_TOOL
