indexing
	description: "Model for workbench windows"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BAR_AND_TEXT

inherit
	TOOL_W
		redefine
			init_modify_action,
			resources, set_default_format
		end

	COMMAND
 
	WINDOW_ATTRIBUTES

	RESOURCE_USER
		redefine
			update_integer_resource,
			update_boolean_resource
		end

feature {NONE} -- Initialization

	make (a_screen: SCREEN) is
			-- Create an assembly tool with `a_screen'.
		require
			a_screen_not_void: a_screen /= Void
		local
			ts: EB_TOP_SHELL
		do
			!! ts.make (icon_id, a_screen)
			ts.set_title (tool_name)
			make_form (ts.associated_form)
			eb_shell := ts
			ts.set_action ("<Configure>", Current, remapped)
			ts.set_action ("<Visible>", Current, remapped)
			if hole.icon_symbol.is_valid then
				eb_shell.set_icon_pixmap (hole.icon_symbol)
			end
			set_icon_name (tool_name)
			eb_shell.set_delete_command (quit_cmd_holder.associated_command)
			set_font_to_default
			set_composite_attributes (ts)
		end

	make_form (a_form: FORM) is
			-- Create Current on a form.
		require
			a_form_not_void: a_form /= Void
		do
			eb_shell := Void
			global_form := a_form
			!! history.make
			build_widgets
			register
		end

	init_modify_action (a_text_window: SCROLLED_TEXT_WINDOW) is
			-- Initialization of the text window action.
		do
			a_text_window.add_modify_action (Current, modify)
		end

feature -- Update resources

	resources: EDITOR_RESOURCE_CATEGORY is
			-- Resources for current editor tool.
		deferred
		end

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		do
			if new_res.actual_value > 0 then
				if old_res = resources.tool_height then
					if old_res.actual_value /= new_res.actual_value then
						set_height (new_res.actual_value)
					end
				elseif old_res = resources.tool_width then
					if old_res.actual_value /= new_res.actual_value then
						set_width (new_res.actual_value)
					end
				end
			end
			{RESOURCE_USER} Precursor (old_res, new_res)
		end

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
		do
			if old_res = resources.command_bar then
				if new_res.actual_value then
					edit_bar.add
				else
					edit_bar.remove
				end
			elseif old_res = resources.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			end
			{RESOURCE_USER} Precursor (old_res, new_res)
		end

feature -- Standard Interface

	build_filter_menu_entry is
			-- Build the filter menu entry
		require
			special_menu_not_void: special_menu /= Void
		local
			filter_menu_entry: EB_MENU_ENTRY
		do
			!! filter_command.make (Current)
			!! filter_menu_entry.make (filter_command, special_menu)
		end

	build_widgets is
			-- Build system widget.
		do
			create_toolbar (global_form)
			
			build_text_windows (global_form)
			build_menus
			build_bar
			build_format_bar
			build_toolbar_menu
			set_last_format (default_format)
			attach_all
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, special_menu)
			!! toolbar_t.make (edit_bar.identifier, special_menu)
			edit_bar.init_toggle (toolbar_t)
			!! toolbar_t.make (format_bar.identifier, special_menu)
			format_bar.init_toggle (toolbar_t)
		end

	build_menus is
			-- Create the menus.
		do
			!! menu_bar.make (new_name, global_form)
			!! file_menu.make (Interface_names.m_File, menu_bar)
			!! edit_menu.make (Interface_names.m_Edit, menu_bar)
			!! format_menu.make (Interface_names.m_Formats, menu_bar)
			!! special_menu.make (Interface_names.m_Special, menu_bar)
			!! window_menu.make (Interface_names.m_window, menu_bar)
			build_help_menu
		end

	build_bar is
			-- Build the top most bar (basic bar).
		local
			quit_cmd: QUIT_FILE
			quit_button: EB_BUTTON
			has_close_button: BOOLEAN
			quit_menu_entry: EB_MENU_ENTRY
			exit_menu_entry: EB_MENU_ENTRY
		do
				-- Creation of all the commands, holes, buttons, and menu entries
			!! hole.make (Current)
			!! hole_button.make (hole, edit_bar)
			!! hole_holder.make_plain (hole)
			hole_holder.set_button (hole_button)
			build_edit_menu (edit_bar)
			build_save_as_menu_entry
			build_print_menu_entry
			!! quit_cmd.make (Current)
			!! quit_menu_entry.make (quit_cmd, file_menu)

			has_close_button := General_resources.close_button.actual_value
			if has_close_button then
				!! quit_button.make (quit_cmd, edit_bar)
			end
			!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)

			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
			exit_cmd_holder.set_menu_entry (exit_menu_entry)

				-- Attachments are done here, because of speed.
				-- I know it's not really maintainable.
			edit_bar.attach_left (hole_button, 0)
			edit_bar.attach_top (hole_button, 0)
			edit_bar.attach_top (search_cmd_holder.associated_button, 0)
			edit_bar.attach_left_widget (hole_button, search_cmd_holder.associated_button, 5)

			if has_close_button then
				edit_bar.attach_right (quit_button, 5)
				edit_bar.attach_top (quit_button, 0)
			end
		end

	build_format_bar is
			-- Build bottom bar: formatting commands.
		do
		end

	attach_all is
			-- Attach button bar and windows below together.
		do
			global_form.attach_left (menu_bar, 0)
			global_form.attach_right (menu_bar, 0)
			global_form.attach_top (menu_bar, 0)

			global_form.attach_left (toolbar_parent, 0)
			global_form.attach_right (toolbar_parent, 0)
			global_form.attach_top_widget (menu_bar, toolbar_parent, 0)

			if editable_text_window /= read_only_text_window then
				global_form.attach_left (editable_text_window.widget, 0)
				global_form.attach_right (editable_text_window.widget, 0)
				global_form.attach_bottom (editable_text_window.widget, 0)
				global_form.attach_top_widget (toolbar_parent, 
						editable_text_window.widget, 0)

				global_form.attach_left (read_only_text_window.widget, 0)
				global_form.attach_right (read_only_text_window.widget, 0)
				global_form.attach_bottom (read_only_text_window.widget, 0)
				global_form.attach_top_widget (toolbar_parent, 
						read_only_text_window.widget, 0)
			else
				global_form.attach_left (text_window.widget, 0)
				global_form.attach_right (text_window.widget, 0)
				global_form.attach_bottom (text_window.widget, 0)
				global_form.attach_top_widget (toolbar_parent, text_window.widget, 0)
			end
		end

feature -- Access

	realized: BOOLEAN is
			-- Is Current realized?
		do
			if is_a_shell then
				Result := eb_shell.realized
			else
				Result := True
			end
		end

	shown: BOOLEAN is
			-- Is Current shown?
		require else
			is_a_shell: is_a_shell
		do
			Result := eb_shell.shown
		end

feature -- Window Implementation

	fill_menus is
			-- Adds entries to the `Window' menu.
		local
			show_pref_cmd: SHOW_PREFERENCE_TOOL
			show_pref_menu_entry: EB_MENU_ENTRY
			menu_entry: EB_MENU_ENTRY
			raise_tool_cmd: RAISE_TOOL_CMD
			sep: SEPARATOR
		do
			!! menu_entry.make (Project_tool.class_hole_holder.associated_command, window_menu)
			!! menu_entry.make (Project_tool.routine_hole_holder.associated_command, window_menu)
			!! menu_entry.make (Project_tool.object_hole_holder.associated_command, window_menu)
			!! sep.make (Interface_names.t_Empty, window_menu)
			!! show_pref_cmd.make (resources)
			!! show_pref_menu_entry.make_default (show_pref_cmd, window_menu)
			!! raise_tool_cmd.make (Project_tool)
			!! menu_entry.make (raise_tool_cmd, window_menu)
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set Current's position.
		require
			is_a_shell: is_a_shell
		do
			eb_shell.set_x_y (new_x, new_y)
		end

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require
			is_a_shell: is_a_shell
		do
			eb_shell.set_height (new_height)
		end

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		require
			is_a_shell: is_a_shell
		do
			eb_shell.set_width (new_width)
		end

	destroy is
			-- Destroy Current.
		do
			unregister_holes
			eb_shell.destroy
		end

	show is
			-- Show Current.
		require else
			is_a_shell: is_a_shell
		do
			eb_shell.show
		end

	hide is
			-- Hide Current.
		do
			eb_shell.hide
		end

	raise is
			-- Raise Current
		require else
			is_a_shell: is_a_shell
		do
			eb_shell.raise
		end

	close_filter_window is
			-- Close the filter window.
		do
			if filter_command /= Void then
				filter_command.close_filter_window
			end
		end

	close_windows is
			-- Close sub-windows.
		do
			close_search_window
			close_filter_window
			close_print_window
		end

	resize_action is
			-- If the window is raised, moved or resized, then raise
			-- popups with an exclusive grab.
		do
			raise_grabbed_popup
		end

feature -- Window Settings

	set_default_size is
			-- Set the size of Current to its default.
		do
			if eb_shell /= Void then
				eb_shell.set_size 
					(resources.tool_width.actual_value, 
					resources.tool_height.actual_value)
			end
		end

	set_default_position is
			-- Display the window at the cursor position.
			-- Try to display the window in the screen.
		require else
			is_a_shell: is_a_shell
		local
			new_x, new_y: INTEGER
			s: SCREEN
		do
			if not General_resources.default_window_position.actual_value then
				s := eb_shell.screen
				new_x := s.x
				new_y := s.y
				if new_x + eb_shell.width > s.width then
					new_x := s.width - eb_shell.width
				end
				if new_x < 0 then
					new_x := 0
				end
				if new_y + eb_shell.height > s.height then
					new_y := s.height - eb_shell.height
				end
				if new_y < 0 then
					new_y := 0
				end
				eb_shell.set_x_y (new_x, new_y)
			end
		end

	set_default_format is
			-- Default format of windows.
		do
			set_last_format (default_format)
		end

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s)
			end
		end

	set_icon_name (s: STRING) is
			-- Set `icon_name' to `s'.
		do
			if is_a_shell then
				eb_shell.set_icon_name (s)
			end
		end

feature -- Window Properties

	eb_shell: EB_SHELL
			-- Shell to represent Current

	title: STRING is
			-- Title as displayed in the title bar of `parent'
		do
			if is_a_shell then
				Result := eb_shell.title
			else
				!! Result.make (1)
			end
		end

	icon_name: STRING is
			-- String shown when Current is popped down
		do
			if is_a_shell then
				Result := eb_shell.icon_name
			end
		end

	format_menu: MENU_PULL

	special_menu: MENU_PULL

	window_menu: MENU_PULL

	hole: DEFAULT_HOLE_COMMAND
			-- Hole characterizing Current.

	hole_holder: HOLE_HOLDER
			-- Holder for both the button and the hole.

	filter_command: FILTER_COMMAND
			-- Filter command to display filter window

	global_form: FORM
			-- Form created by the client of Current

	showtext_frmt_holder: FORMAT_HOLDER
			-- Command to show text od text window's root stone,
			-- default format by default.

	default_format: FORMAT_HOLDER is
		do
			Result := showtext_frmt_holder
		end

	editable: BOOLEAN is
			-- Is Current window editable (default is false)?
		do
		end

	open_cmd_holder: COMMAND_HOLDER is
			-- Command to open a file.
		do
		end

	quit_cmd_holder: COMMAND_HOLDER
			-- Command used to exit from Current.

	exit_cmd_holder: COMMAND_HOLDER
			-- Command used to end the session.

feature -- Execution Implementation

	execute (argument: ANY) is
			-- Execution the commands associated to Current.
		do
			if argument = popdown then
				close_windows
			elseif argument = remapped then
					-- The tool is being raised,
					-- moved, or resized.
				resize_action
			elseif argument = modify and then not text_window.changed then
				text_window.set_changed (True)
				update_save_symbol
			end
		end

feature -- Properties

	popdown: ANY is
			-- Argument used to indicate that Current is being
			-- popped down. Needed for `execute'.
		once
			!! Result
		end

	remapped: ANY is
			-- Argument used to indicate that Current is being
			-- remapped. Needed for `execute'.
		once
			!! Result
		end

	modify: ANY is
			-- Argument used to indicate that text_window is being
			-- modified.
		once
			!! Result
		end

end -- class BAR_AND_TEXT
