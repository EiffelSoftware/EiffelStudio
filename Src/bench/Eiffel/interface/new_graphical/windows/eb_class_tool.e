indexing
	description: "Tool describing an Eiffel class."
	date: "$Date$"

class
	EB_CLASS_TOOL

inherit
	EB_EDIT_TOOL
		rename
--			class_type as stone_type
		redefine
--			hole,
			init_commands,
			empty_tool_name,
			close_windows,
			synchronize, set_stone,
--			process_class_syntax, process_feature_error,
--			process_feature, process_class, process_classi,
--			compatible,
			set_mode_for_editing,
			has_editable_text,
--			able_to_edit,
			history_dialog_title,
			format_list, set_default_format,
			build_file_menu,
			build_special_menu,
			reset,
			parse_file
		end

	EB_CLASS_TOOL_DATA

	SHARED_COMPILATION_MODES


creation
	make

feature {NONE} -- Initialization

--	form_create (a_form: FORM file_m, edit_m, format_m, special_m: MENU_PULL) is
--			-- Create a feature tool from a form.
--		require
--			valid_args: a_form /= Void and then edit_m /= Void and then	
--				format_m /= Void and then special_m /= Void
--		do
--			is_in_project_tool := True
--			file_menu := file_m
--			edit_menu := edit_m
--			format_menu := format_m
--			special_menu := special_m
--			make_form (a_form)
--			init_text_area
--			set_composite_attributes (a_form)
--			set_composite_attributes (file_m)
--			set_composite_attributes (edit_m)
--			set_composite_attributes (format_m)
--			set_composite_attributes (special_m)
--		end
--| FIXME
--| Christophe, 20 oct 1999
--| This feature was made obsolete by the tool-manager mechanism

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
			create open_cmd.make (Current)
			create save_cmd.make (Current)
			create version_cmd.make (Current)
			create shell_cmd.make (Current)
			create filter_cmd.make (Current)
			create super_melt_cmd.make (Current)

			create current_target_cmd.make (Current)
			create show_history_cmd.make (Current)
			create next_target_cmd.make (Current)
			create previous_target_cmd.make (Current)
			
		end

feature -- Access

	version_cmd: EB_SHOW_CLASS_VERSIONS

	format_bar_is_used: BOOLEAN is True
			-- Do the tool need an effective format_bar?
			-- (a: Yes)

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text area?
		do
			Result := True
		end

--	compatible (a_stone: STONE): BOOLEAN is
--			-- Is Current hole compatible with `a_stone'?
--		do
--			Result :=
--				a_stone.stone_type = Routine_type or else
--				a_stone.stone_type = Breakable_type or else
--				a_stone.stone_type = stone_type
--		end
--| FIXME
--| Christophe, 20 oct 1999
--| Old drag-and-drop mechanism feature. To be changed
--| when drag-and-drop is implemented in gtk

	cluster: CLUSTER_I is
			-- Cluster associated with stone, if any
		local
			c: CLASSC_STONE
			ci: CLASSI_STONE
		do
			c ?= stone
			if c /= Void then
				Result := c.e_class.cluster
			else
				ci ?= stone
				if ci /= Void then
					Result := ci.class_i.cluster
				end
			end
		end

	history_dialog_title: STRING is
			-- Title of the history dialog
		do
			Result := Interface_names.t_Select_class
		end

feature -- Status setting

	display is
			-- Show Current
		obsolete
			"Use raise instead"
		do
			raise
		end
 
	set_stone (s: like stone) is
			-- make `s' the new value of stone.
		local
			c: CLASS_STONE
		do
			if not s.same_as (stone) then
				Precursor (s)
--				execute_last_format (s)
				synchronize
			end
--| FIXME
--| Christophe, 3 nov 1999
--| Currently overriding `process_class'/`process_classi'.
--| This mechanism has to be clarified.
			c ?= stone
			if c /= Void then
				update_class_name (clone (c.class_name))
			end
		end

	set_mode_for_editing is
			-- Set the text mode to be editable.
		do
			text_area.set_editable (True)
		end

	set_read_only is
			-- set the class_tool as READ_ONLY
		local
			tmp: STRING
		do
			text_area.set_editable (False)
			tmp := clone (title)
			tmp.append_string (" [READ-ONLY]");
			set_title (tmp) 
		end

	execute_last_format (s: like stone) is
			-- Execute the last format with stone `s'.
			-- If `last_format' is not allowed for `s' (when
			-- class is a precompile and is hidden) default
			-- `last_format' to a valid format.
		require
			valid_s: s /= Void and then s.is_valid
		local
			c: CLASSC_STONE
			ci: CLASSI_STONE
			class_i: CLASS_I
			arg: EV_ARGUMENT1 [ANY]
		do
			c ?= s
			ci ?= s
			if c /= Void then
				class_i := c.e_class.lace_class	
			else
				class_i := ci.class_i	
			end
			if class_i.hide_implementation then
				format_list.set_implementation_formats_insensitive (True)
--				if 
--					last_format = showtext or else
--					last_format = showflat or else
--					last_format = showclick 
--				then
--					last_format.set_selected (False)
--					last_format := showshort_frmt
--				end
			else
				format_list.set_implementation_formats_insensitive (False)
			end
			create arg.make (s)
			last_format.launch_cmd.execute (arg, Void)
			add_to_history (s)
		end
 
feature -- Stone process
 
	process_class (s: CLASS_STONE) is
			-- Process class stone
		obsolete
			"Not really obsolete but its role must %
			%be reviewed"
		do
			execute_last_format (s)
		end
 
	process_feature_error (s: FEATURE_ERROR_STONE) is
			-- Process feature error stone.
		local
			cl_stone: CLASSC_STONE
			e_class: CLASS_C
			txt: STRING
			pos, end_pos: INTEGER
		do
			e_class := s.e_feature.written_class
			create cl_stone.make (e_class)

			if e_class.lace_class.hide_implementation then
				set_default_format
				process_class (cl_stone)
				text_area.search_stone (s)
			else
--				format_list.text_format.format (cl_stone)
				add_to_history (stone)
				text_area.deselect_all
				pos := s.error_position
				txt := text_area.text
				if txt.count > pos then
					if txt.item (pos) = '%N' then	
						end_pos := txt.index_of ('%N', pos + 1)
					else
						end_pos := txt.index_of ('%N', pos)
					end
					if pos /= 0 then
						text_area.highlight_selected (pos, end_pos)
					end
				end
				text_area.set_position (pos)
			end
		end
 
	process_feature (s: FEATURE_STONE) is
			-- Process feature stone.
		local
			cl_stone: CLASSC_STONE
			e_class: CLASS_C
		do
			e_class := s.e_feature.written_class
			create cl_stone.make (e_class)

			if e_class.lace_class.hide_implementation then
				set_default_format
				process_class (cl_stone)
				text_area.search_stone (s)
			else
--				format_list.text_format.format (cl_stone)
				add_to_history (stone)
				text_area.deselect_all
				text_area.set_position (s.start_position)
				text_area.highlight_selected (s.start_position, s.end_position)
			end
		end
--| FIXME
--| Christophe, 5 nov 1999
--| features to be remade.
 
	process_class_syntax (s: CL_SYNTAX_STONE) is
			-- Process class syntax.
		local
			cl_stone: CLASSC_STONE
		do
			create cl_stone.make (s.associated_class)
			set_stone (cl_stone)
			text_area.deselect_all
			text_area.set_position (s.start_position)
			text_area.highlight_selected (s.start_position, s.end_position)
		end
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
			if stone = Void then
				class_text_field.set_text("")
			end
		end

	set_default_format is
			-- Default format of windows.
		local
--			c: CLASSC_STONE
--			ci: CLASSI_STONE
--			class_i: CLASS_I
		do
--			if stone /= Void then
--				c ?= stone
--				ci ?= stone
--				if c /= Void then
--					class_i := c.e_class.lace_class	
--				else
--					class_i := ci.class_i	
--				end
--				if class_i.hide_implementation then
--					set_last_format (showshort_frmt_holder)
--				else
--					set_last_format (default_format)
--				end
--			else
--				set_last_format (default_format)
--			end
		end

feature -- Update

	register is
			-- Ask the resource manager to notify Current (i.e. to call `update') each
			-- time one of the resources he needs has changed.
			-- Is called by `make'.
		do
			register_to ("class_tool_command_bar")
			register_to ("class_tool_format_bar")
		end

	update is
			-- Update Current with the registred resources.
		do
			if class_tool_command_bar then
				toolbar.show
			else
				toolbar.hide
			end
			if toolbar_menu_item /= Void then
				toolbar_menu_item.set_selected (class_tool_command_bar)
			end
			if class_tool_format_bar then
				format_bar.show
			else
				format_bar.hide
			end	
			if format_bar_menu_item /= Void then
				format_bar_menu_item.set_selected (class_tool_format_bar)
			end
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed.
			-- Is called by `destroy'.
		do
			unregister_to ("class_tool_command_bar")
			unregister_to ("class_tool_format_bar")
		end

	reset is
			-- Reset the window contents
		do
			Precursor
			format_list.set_implementation_formats_insensitive (False)
			class_text_field.set_text("")
		end

	reset_format_buttons is
			-- Reset the format buttons to the original state.
		do
--			showtext_frmt_holder.set_sensitive (True)
--			showflat_frmt_holder.set_sensitive (True)
--			showclick_frmt_holder.set_sensitive (True)
		end

	update_class_name (s: STRING) is
			-- Write `s' (converted in capital letters)
			-- in the toolbar text field.
		require
			valid_arg: s /= Void
		do
			s.to_upper
			class_text_field.set_text (s)
		end

	update_clickable_format (e_class: CLASS_C) is
			-- Update clickable elements.
			-- used by `parse_file'
		local
			new_title: STRING
		do
			if not has_class_name_changed (e_class) then
					-- Update the clickable position of the tool.
				text_area.update_clickable_from_stone (stone)
			else
					-- Change the title of the corresponding tool.
				new_title := clone (written_class_name (e_class))
				new_title.to_upper
				new_title.prepend ("New class: ")
				new_title.append (" (Not in System)")
				set_title (new_title)
				Compilation_modes.set_need_melt
			end
		end

	parse_file is
			-- Parse the file if possible.
			-- If not, display an error message.
		local
			syn_error: SYNTAX_ERROR
			classc_stone: CLASSC_STONE
			syn_stone: CL_SYNTAX_STONE
			e_class: CLASS_C
			txt, msg: STRING
			error_message: STRING
			error_code: INTEGER
			wd: EV_WARNING_DIALOG
		do
			classc_stone ?= stone
			if classc_stone /= Void then
				e_class := classc_stone.e_class
				if not e_class.is_precompiled then
						-- No need to parse a precompiled class.
					e_class.parse_ast
					syn_error := e_class.last_syntax_error

					if syn_error /= Void then	
							-- Syntax error occurred. We must notify the user.
						msg := syn_error.syntax_message
						error_message := syn_error.error_message
						error_code := syn_error.error_code

						txt := "Class has syntax error.%NSee highlighted area."
						create syn_stone.make (syn_error, e_class)
						process_class_syntax (syn_stone)
						e_class.clear_syntax_error
						create wd.make_default (parent, Interface_names.t_Warning, txt)
					else
						update_clickable_format (e_class)
						if not has_class_name_changed (e_class) then
							update_format
						end
		end
				end
			end
		end

feature -- Window Settings

	close_windows is
			-- Close sub-windows.
		do
--			Precursor {EB_EDITOR}
--			version_cmd.close_choice_dialog
		end

feature -- Widgets

	class_text_field: EB_CLASS_TEXT_FIELD
			-- Text field in the toolbar
			-- Allow user to enter the name
			-- of the class he wants to edit.

feature -- Formats

	format_list: EB_CLASS_FORMATTER_LIST
		-- List of formats available in the tool

feature -- Graphical Interface

	raise_shell_popup is
			-- Raise the shell command popup dialog if it is popped up.
		local
--			shell_dialog: SHELL_W
		do
--			shell_cmd ?= shell.associated_command
--			shell_dialog := shell_cmd.shell_dialog
--			if shell_dialog /= Void and then shell_dialog.is_popped_up then
--				shell_dialog.raise
--			end
		end
			
feature {NONE} -- Tool Properties

	editable: BOOLEAN is True
			-- Is Current editable?

	empty_tool_name: STRING is
			-- Name given to Current when it is empty.
		do
			Result := Interface_names.t_Empty_class
		end

--	hole: CLASS_HOLE
			-- Hole caraterizing current
 
feature {EB_HTML_TEXT_FORMATTER} -- Parsing checking

	has_class_name_changed (e_class: CLASS_C): BOOLEAN is
			-- Has the name of the class been changed during its editing?
		do
			Result := not e_class.name.is_equal (written_class_name (e_class))
		end
	
	written_class_name (e_class: CLASS_C): STRING is
			-- Name of class as it is written in the text.
			-- (this name can have been modified during edition)
		require
			e_class_exists: e_class /= Void
		local
			class_as_b: CLASS_AS
		do
			class_as_b ?= e_class.click_list.area.item (0).node
			if class_as_b /= Void then
				Result := clone (class_as_b.class_name)
			else
				check
					should_not_be_void: False
				end
			end
		end

feature {NONE} -- Commands

	save_as_cmd: EB_SAVE_FILE_AS_CMD

	shell_cmd: EB_OPEN_SHELL_CMD

	filter_cmd: EB_FILTER_CMD

	super_melt_cmd: EB_SUPER_MELT_CMD

	current_target_cmd: EB_CURRENT_CLASS_CMD

	show_history_cmd: EB_SHOW_HISTORY_CMD

	previous_target_cmd: EB_PREVIOUS_TARGET_CMD

	next_target_cmd: EB_NEXT_TARGET_CMD

feature {NONE} -- Implementation Graphical Interface

	create_edit_buttons (tb: EV_TOOL_BAR) is
			-- build "Open", "Save", "Quit" buttons in `tb'
		local
			b: EV_TOOL_BAR_BUTTON
		do
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Open)
			b.add_click_command (open_cmd, Void)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Modified)
			save_cmd.set_button (b)

			if close_button_in_every_tool then
				create b.make (tb)
				b.set_pixmap (Pixmaps.bm_Quit)
				b.add_click_command (close_cmd, Void)
			end
		end

	build_toolbar (a_toolbar: EV_BOX) is
			-- create edit toolbar items inside `a_toolbar'
		local
			tb: EV_TOOL_BAR
			sep: EV_TOOL_BAR_SEPARATOR
--			history_list_cmd: LIST_HISTORY
			new_class_cmd: EB_CREATE_CLASS_CMD
--			do_nothing_cmd: DO_NOTHING_CMD
			b: EV_TOOL_BAR_BUTTON
		do
			create tb.make (a_toolbar)
			a_toolbar.set_child_expandable (tb, False)

			create_edit_buttons (tb)

			create sep.make (tb)

--			create hole.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Class_dot)
--			b.add_click_command (hole_holder)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Shell)
--			shell_button.add_third_button_action
			b.add_click_command (shell_cmd, Void)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Class)
			create new_class_cmd.make (Current)
			b.add_click_command (new_class_cmd, Void)

			create sep.make (tb)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Previous_target)
			b.add_click_command (previous_target_cmd, Void)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Next_target)
			b.add_click_command (next_target_cmd, Void)

--			create history_list_cmd.make (Current)
--			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)
--			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)

			create class_text_field.make_with_tool (toolbar, Current)
--			class_text_field.set_width (200)

		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_file_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Fill `a_menu' with file managing entries
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Open)
			i.add_select_command (open_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Save)
			save_cmd.set_menu_item (i)

			Precursor (a_menu)
		end	

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Fill `a_menu' with "special menu" entries
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Version)
			i.add_select_command (version_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Shell)
			i.add_select_command (shell_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Filter)
			i.add_select_command (filter_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Stoppable)
			i.add_select_command (super_melt_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Current)
			i.add_select_command (show_history_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Current)
			i.add_select_command (current_target_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Next_target)
			i.add_select_command (next_target_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Previous_target)
			i.add_select_command (previous_target_cmd, Void)

			Precursor (a_menu)
		end

end -- class EB_CLASS_TOOL
