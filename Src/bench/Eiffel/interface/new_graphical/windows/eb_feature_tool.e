indexing
	description: "Tool describing an Eiffel feature."
	date: "$Date$"

class
	EB_FEATURE_TOOL

inherit
	EB_EDIT_TOOL
		rename
			toolbar as feature_toolbar
--			Routine_type as stone_type
		redefine
--			hole,
			empty_tool_name,
--			close_windows,
			init_commands,
			reset,
			stone, set_stone, synchronize,
--			process_feature,
--			process_class, process_breakable, compatible,
--			update_boolean_resource, build_toolbar_menu,
			set_mode_for_editing,
--			history_window_title,
			has_editable_text,
			format_list, build_toolbar,
			build_special_menu,
			parse_file
		end

	EB_FEATURE_TOOL_DATA

	EB_SHARED_INTERFACE_TOOLS

creation
	make

feature {NONE} -- Initialization

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
--  			init_text_area
--		end

	init_formatters is
			-- Create the list of formats,
			-- initialize default format values.
		do
			create format_list.make (Current)
			set_last_format (format_list.default_format)
		end

	init_commands is
			-- Initialize commands.
		do
			Precursor
			create shell_cmd.make (Current)
			create filter_cmd.make (Current)
			create super_melt_cmd.make (Current)
			create current_target_cmd.make (Current)
			create previous_target_cmd.make (Current)
			create next_target_cmd.make (Current)
		end

feature -- Update Resources

	register is
			-- Ask the resource manager to notify Current (i.e. to call `update') each
			-- time one of the resources he needs has changed.
			-- Is called by `make'.
		do
			register_to ("feature_tool_command_bar")
			register_to ("feature_tool_format_bar")
		end

	update is
			-- Update Current with the registred resources.
		do
			if feature_tool_command_bar then
				feature_toolbar.show
			else
				feature_toolbar.hide
			end
			if toolbar_menu_item /= Void then
				toolbar_menu_item.set_selected (feature_tool_command_bar)
			end
			if feature_tool_format_bar then
				format_bar.show
			else
				format_bar.hide
			end	
			if format_bar_menu_item /= Void then
				format_bar_menu_item.set_selected (feature_tool_format_bar)
			end
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed.
			-- Is called by `destroy'.
		do
			unregister_to ("feature_tool_command_bar")
			unregister_to ("feature_tool_format_bar")
		end

--	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
--			-- Update `old_res' with the value of `new_res',
--			-- if the value of `new_res' is applicable.
--			-- Also update the interface.
--		local
--			rout_cli_cmd: SHOW_ROUTCLIENTS
--			stop_cmd: SHOW_BREAKPOINTS
--		do
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
--		end

feature -- Window Properties

	stone: FEATURE_STONE
			-- Stone in tool

--	history_window_title: STRING is
--			-- Title of the history window
--		do
--			Result := Interface_names.t_Select_feature
--		end

	format_bar_is_used: BOOLEAN is True
			-- Do the tool need an effective format_bar?
			-- (a: Yes)

	has_editable_text: BOOLEAN is True
			-- Does Current tool have an editable text area?

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

	parse_file is
			-- Parse the file if possible.
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
				text_area.highlight_selected (syn_error.start_position,
									syn_error.end_position)
				text_area.set_position (syn_error.start_position)
				e_class.clear_syntax_error
				create wd.make_default (parent, Interface_names.t_Warning, txt)
			else
				text_area.update_clickable_from_stone (stone)
--				Result := true
			end
		end

	set_mode_for_editing is
			-- Set the text mode not to be editable.
			-- Do not ask me why
			-- OK, if you insist: text is never editable in a feature tool
			-- BTW, it may change in a near future.
		do
			text_area.set_editable (False)
		end
 
	close_windows is
			-- Pop down the associated windows.
		local
--			ss: SEARCH_STRING
		do
-- 			Precursor
		end

	highlight_breakable (index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		require
			positive_index: index >= 1
		do
			if in_debug_format then
				text_area.highlight_breakable (stone.e_feature, index)
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
				cur := text_area.position
				f := format_list.stop_points_format
				old_do_format := f.do_format
				f.set_do_format (true)
--				f.execute (stone)
				f.set_do_format (old_do_format)
				text_area.go_to (cur)
			end
		end

	set_debug_format is 
			-- Set the current format to be in `debug_format'.		
		do
			text_area.set_editable (False)
			set_last_format (format_list.stop_points_format)
			synchronize
		ensure
			set: format_list.stop_points_format = last_format
		end

	show_stoppoint (f: E_FEATURE; index: INTEGER) is
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
					text_area.redisplay_breakable_mark (stone.e_feature, index)
				elseif last_format = format_list.text_format then
					-- Update the title bar of the feature tool.
					-- "(stop)" if the feature has a stop point set.
					format_list.text_format.display_header (stone)
				end
			end
		end

feature -- Status setting

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

	process_breakable (a_stone: BREAKABLE_STONE) is
			-- Process the breakpoint stone `a_stone'.
		do
			Project_tool.process_breakable (a_stone)
		end

	process_class (a_stone: CLASSC_STONE) is
			-- Process class stone `a_stone' (compiled class, of course).
		local
			c: CLASS_C
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
					create fs.make (fi)
					process_feature (fs)
				else
					error_window.clear_window
					create text.make
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
				class_text_field.set_text("")
				feature_text_field.set_text("")
			else
				update_feature_toolbar
			end
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

--	hole: ROUTINE_HOLE
			-- Hole charaterizing Current.

--	class_hole: ROUT_CLASS_HOLE
			-- Hole for version of feature for a particular class.

--	class_hole_button: EB_BUTTON_HOLE
			-- Button for the class hole

--	stop_hole: DEBUG_STOPIN_HOLE
			-- To set breakpoints

--	stop_hole_button: EB_BUTTON_HOLE
			-- Button for the stop points hole

feature -- Formats

	format_list: EB_FEATURE_FORMATTER_LIST
		-- List of formats available in the tool

feature -- Commands

	shell_cmd: EB_OPEN_SHELL_CMD

	filter_cmd: EB_FILTER_CMD

	super_melt_cmd: EB_SUPER_MELT_CMD

	current_target_cmd: EB_CURRENT_FEATURE_CMD

	previous_target_cmd: EB_PREVIOUS_TARGET_CMD

	next_target_cmd: EB_NEXT_TARGET_CMD

	feature_text_field: EB_FEATURE_TEXT_FIELD

	class_text_field: EB_FEATURE_CLASS_TEXT_FIELD

feature {NONE} -- Implementation Window Settings

	resize_action is
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice dialog and update the text field.
		do
--			raise
--			class_text_field.update_text
--			feature_text_field.update_text
--			--class_text_field.update_choice_position
--			--feature_text_field.update_choice_position
		end

feature {NONE} -- Implementation Graphical Interface

	build_toolbar (tb: EV_BOX) is
			-- Build feature toolbar
		local
--			new_class_button: EB_CREATE_CLASS_CMD
			label: EV_LABEL
--			quit_cmd: QUIT_FILE
--			class_hole_holder: HOLE_HOLDER
--			stop_hole_holder: HOLE_HOLDER
--			rc: ROW_COLUMN
--			search_button: EB_BUTTON
--			history_list_cmd: LIST_HISTORY
--			current_bar: TOOLBAR
--			do_nothing_cmd: DO_NOTHING_CMD
			b: EV_BUTTON
			sep: EV_VERTICAL_SEPARATOR
		do
--				-- The current toolbar is by default `feature_toolbar'
--				--| It can be changed to `format_bar' when needed
--				--| for displaying two levels.
--			current_bar := feature_toolbar
--
--				-- Do we have a close button to create?
--
--				-- First we create the needed objects.
--			create hole.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Routine_dot)
--			b.add_click_command (hole_holder)

--			create class_hole.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Class_dot)
--			b.add_click_command (class_hole_holder)
--			class_hole_holder.set_button (class_hole_button)

--			create stop_hole.make (Current)
--			create stop_hole_button.make (stop_hole, current_bar)
--			create stop_hole_holder.make_plain (stop_hole)
--			stop_hole_holder.set_button (stop_hole_button)

			create b.make (tb)
--			shell_button.add_third_button_action
			b.set_pixmap (Pixmaps.bm_Shell)
			b.add_click_command (shell_cmd, Void)

--			build_edit_menu (current_bar)

			create sep.make (tb)

--			create current_target_cmd.make (Current)
--			create sep.make (new_name, special_menu)
--			create current_target_menu_entry.make (current_target_cmd, special_menu)
--			create current_target_cmd_holder.make_plain (current_target_cmd)
--			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)
--
--			create sep1.make (Interface_names.t_empty, current_bar)
--			sep1.set_horizontal (False)
--			sep1.set_height (20)
--
--				--| We can now compute the search button
--			search_button := search_cmd_holder.associated_button 

			
--			create history_list_cmd.make (Current)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Previous_target)
			b.add_click_command (previous_target_cmd, Void)
--			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Next_target)
			b.add_click_command (next_target_cmd, Void)
--			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)
			
			create feature_text_field.make_with_tool (feature_toolbar, Current)
			create label.make_with_text (feature_toolbar, "from: ")
			label.set_right_alignment
			create class_text_field.make_with_tool (feature_toolbar, Current)

				if close_button_in_every_tool then
					create b.make (tb)
					b.set_pixmap (Pixmaps.bm_Quit)
					b.add_click_command (close_cmd, Void)
				end
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Fill `a_menu' with "special menu" entries
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Shell)
			i.add_select_command (shell_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Filter)
			i.add_select_command (filter_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Stoppable)
			i.add_select_command (super_melt_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Current)
			i.add_select_command (current_target_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Next_target)
			i.add_select_command (next_target_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Previous_target)
			i.add_select_command (previous_target_cmd, Void)

			Precursor (a_menu)
		end

feature {EB_FORMATTED_TEXT} -- Properties

	empty_tool_name: STRING is
			-- Name given to Current when it is empty.
		do
			Result := Interface_names.t_Empty_routine
		end

end -- class EB_FEATURE_TOOL
