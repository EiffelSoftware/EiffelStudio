indexing

	description:	
		"Window describing an Eiffel object."
	date: "$Date$"
	revision: "$Revision$"

class OBJECT_W 

inherit
	BAR_AND_TEXT
		rename
			Object_resources as resources,
			edit_bar as object_toolbar,
			Object_type as stone_type
		redefine
			make, hole, close_windows, build_toolbar_menu,
			tool_name, build_widgets, attach_all, set_default_format,
			stone, synchronize, process_object,
			close, reset, default_format, create_toolbar,
			set_title, history_window_title, help_index, icon_id
		end

	SHARED_APPLICATION_EXECUTION

creation
	make, form_create

feature {NONE} -- Initialization

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			is_in_project_tool := False
			{BAR_AND_TEXT} Precursor (a_screen)
			set_default_sp_bounds
		end

	form_create (a_form: FORM; file_m, edit_m, format_m, special_m: MENU_PULL) is
			-- Create a feature tool from a form.
		require
			valid_args: a_form /= Void and then edit_m /= Void and then
				format_m /= Void and then special_m /= Void
		do
			is_in_project_tool := True
			set_default_sp_bounds
			file_menu := file_m
			edit_menu := edit_m
			format_menu := format_m
			special_menu := special_m
			make_form (a_form)
			set_composite_attributes (a_form)
			set_composite_attributes (edit_m)
			set_composite_attributes (format_m)
			set_composite_attributes (special_m)
		end

feature -- Window Properties

	tool_name: STRING is
		do
			Result := Interface_names.t_Empty_object
		end

	stone: OBJECT_STONE
			-- Stone in tool
 
	history_window_title: STRING is
			-- Title of the history window
		do
			Result := Interface_names.t_Select_object
		end

	help_index: INTEGER is 4

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Object_id
		end
 
feature -- Access
 
	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		local
			obj_stone: OBJECT_STONE
			pos: INTEGER
		do
			Result := text_window.kept_objects
			from
				pos := history.index
				history.start
			until
				history.after
			loop
				obj_stone ?= history.item
				Result.extend (obj_stone.object_address)
				history.forth
			end
			history.go_i_th (pos)
		end

feature -- Status report

	sp_lower, sp_upper: INTEGER
			-- Bounds for special object inspection
			-- A negative value for `sp_upper' stands for the
			-- upper bound of the inspected special object

	sp_capacity: INTEGER
			-- Capacity of the last special object displayed in
			-- the object window

feature -- Status seting

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s)
				Project_tool.change_object_entry (Current)
			end
		end

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			sp_lower := l
			sp_upper := u
		end

	set_sp_capacity (c: INTEGER) is
			-- Assign `c' to `sp_capacity'.
		do
			sp_capacity := c
		end

	set_default_sp_bounds is
			-- Set the default bounds for special object inspection.
		do
			sp_capacity := 0
			sp_lower := 0
			sp_upper := Application.displayed_string_size
		end

feature -- Update

	hang_on is
			-- Make object addresses unclickable.
		do
			text_window.hang_on
		end

	reset is
			-- Reset the contents of the object window.
		do
			{BAR_AND_TEXT} Precursor
			set_default_sp_bounds
			init_text_window
		end
 
	process_object (a_stone: like stone) is
			-- Set `s' to stone.
		local
			status: APPLICATION_STATUS
			shell: COMPOSITE
		do
			status := Application.status
			if is_a_shell then
				shell := eb_shell
			else
				shell := Project_tool
			end

			if status = Void then
				warner (shell).gotcha_call (Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				warner (shell).gotcha_call (Warning_messages.w_System_not_stopped)
			elseif not a_stone.is_valid then
				warner (shell).gotcha_call (Warning_messages.w_Object_not_inspectable)
			else
				last_format.execute (a_stone)
				add_to_history (a_stone)
			end
		end
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		local
			status: APPLICATION_STATUS
			cur: CURSOR
			shell: COMPOSITE
		do
			status := Application.status
			if is_a_shell then
				shell := eb_shell
			else
				shell := Project_tool
			end

			if status = Void then
				-- Do nothing.
				--| There is no need to warn the user because, this simply means
				--| that we need to refresh the content of the window and his
				--| application is not running under EiffelBench. This case happens
				--| mostly when doing `Apply' in the Preference dialg.
			elseif not status.is_stopped then
				warner (shell).gotcha_call (Warning_messages.w_System_not_stopped)
			else
				cur := text_window.cursor
				synchronise_stone
				text_window.go_to (cur)
			end
		end

	close_windows is
			-- Close sub-windows.
		local
			sc: SLICE_COMMAND
			sw: SLICE_W
		do
			{BAR_AND_TEXT} Precursor
			sc ?= slice_cmd_holder.associated_command
			sw ?= sc.slice_window
			if sw /= Void and then sw.is_popped_up then
				sw.popdown
			end
		end

feature -- Resetting

	close is
			-- Reset
		do
			if is_a_shell then
				Project_tool.remove_object_entry (Current)
				hide
				reset
			else
				Project_tool.display_object_cmd_holder.associated_command.work (Void)
			end
		end

feature -- Settings

	set_default_format is
			-- Set the format to its default.
		do
			set_last_format (default_format)
		end

feature -- Commands

	showattr_frmt_holder: FORMAT_HOLDER

	showonce_frmt_holder: FORMAT_HOLDER

	current_target_cmd_holder: COMMAND_HOLDER

	previous_target_cmd_holder: COMMAND_HOLDER

	next_target_cmd_holder: COMMAND_HOLDER

	slice_cmd_holder: COMMAND_HOLDER

feature {NONE} -- Properties; Forms And Holes

	hole: OBJECT_HOLE
			-- Hole charaterizing Current.

	command_bar: FORM
			-- Bar with the command buttons

feature {NONE} -- Implementation; Graphical Interface

	create_toolbar (a_parent: COMPOSITE) is
			-- Create a toolbar_parent with parent `a_parent'.
		local
			sep: THREE_D_SEPARATOR
		do
			!! toolbar_parent.make (new_name, a_parent)
			if not is_in_project_tool then
				!! sep.make (interface_names.t_empty, toolbar_parent)
			end
			toolbar_parent.set_column_layout
			toolbar_parent.set_free_size	
			toolbar_parent.set_margin_height (0)
			toolbar_parent.set_spacing (1)
			!! object_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
			if not Platform_constants.is_windows then
				!! sep.make (Interface_names.t_Empty, toolbar_parent)
			else
				object_toolbar.set_height (22)
			end
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, special_menu)
			!! toolbar_t.make (object_toolbar.identifier, special_menu)
			object_toolbar.init_toggle (toolbar_t)
		end

	build_object_toolbar is
			-- Build top bar.
		local
			search_button: EB_BUTTON
			quit_button: EB_BUTTON
			quit_cmd: QUIT_FILE
			has_close_button: BOOLEAN
			quit_menu_entry: EB_MENU_ENTRY
			exit_menu_entry: EB_MENU_ENTRY

			history_list_cmd: LIST_HISTORY
			previous_target_cmd: PREVIOUS_OBJECT
			previous_target_button: EB_BUTTON
			previous_target_menu_entry: EB_MENU_ENTRY
			next_target_cmd: NEXT_OBJECT
			next_target_button: EB_BUTTON
			next_target_menu_entry: EB_MENU_ENTRY
			current_target_cmd: CURRENT_OBJECT
			current_target_menu_entry: EB_MENU_ENTRY
			slice_cmd: SLICE_COMMAND
			slice_button: EB_BUTTON
			slice_menu_entry: EB_MENU_ENTRY
			sep: SEPARATOR
			sep1, sep2, sep3: THREE_D_SEPARATOR
			once_cmd: SHOW_ONCE_RESULTS
			once_button: FORMAT_BUTTON
			once_menu_entry: EB_TICKABLE_MENU_ENTRY
			attr_cmd: SHOW_ATTR_VALUES
			attr_button: FORMAT_BUTTON
			attr_menu_entry: EB_TICKABLE_MENU_ENTRY
			do_nothing_cmd: DO_NOTHING_CMD
		do
				-- Creation of all the commands, holes, buttons, and menu entries
			!! hole.make (Current)
			build_edit_menu (object_toolbar)
			build_save_as_menu_entry
			build_print_menu_entry

				-- Should we have a close button?
			has_close_button := General_resources.close_button.actual_value

			!! quit_cmd.make (Current)
			if not is_in_project_tool then
				!! quit_menu_entry.make (quit_cmd, file_menu)
				if has_close_button then
					!! quit_button.make (quit_cmd, object_toolbar)
				end
				!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)

				!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
				!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
				exit_cmd_holder.set_menu_entry (exit_menu_entry)
			end

				-- First we create all objects.
			!! once_cmd.make (Current)
			!! once_button.make (once_cmd, object_toolbar)
			!! once_menu_entry.make (once_cmd, format_menu)
			!! showonce_frmt_holder.make (once_cmd, once_button, once_menu_entry)
			!! attr_cmd.make (Current)
			!! attr_button.make (attr_cmd, object_toolbar)
			!! attr_menu_entry.make (attr_cmd, format_menu)
			!! showattr_frmt_holder.make (attr_cmd, attr_button, attr_menu_entry)

				-- Here we create all objects needed for the attachments.
			!! slice_cmd.make (Current)
			!! slice_button.make (slice_cmd, object_toolbar)
			slice_button.add_third_button_action
			!! slice_menu_entry.make_button_only (slice_cmd, special_menu)
			slice_menu_entry.add_activate_action (slice_cmd, slice_cmd.button_three_action)
			!! slice_cmd_holder.make (slice_cmd, slice_button, slice_menu_entry)
			!! current_target_cmd.make (Current)
			!! sep.make (new_name, special_menu)
			!! current_target_menu_entry.make (current_target_cmd, special_menu)
			!! current_target_cmd_holder.make_plain (current_target_cmd)
			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)
			!! next_target_cmd.make (Current)
			!! next_target_button.make (next_target_cmd, object_toolbar)
			!! next_target_menu_entry.make (next_target_cmd, special_menu)
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry)
			!! previous_target_cmd.make (Current)
			!! previous_target_button.make (previous_target_cmd, object_toolbar)
			!! previous_target_menu_entry.make (previous_target_cmd, special_menu)
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry)

			!! history_list_cmd.make (Current)
			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)
			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)

			!! sep1.make (interface_names.t_empty, object_toolbar)
			sep1.set_horizontal (False)
			sep1.set_height (20)

			!! sep2.make (interface_names.t_empty, object_toolbar)
			sep2.set_horizontal (False)
			sep2.set_height (20)

			!! sep3.make (interface_names.t_empty, object_toolbar)
			sep3.set_horizontal (False)
			sep3.set_height (20)

				-- Attachments are done here, because of speed.
				-- I know it's not really maintainable.
			search_button := search_cmd_holder.associated_button

			object_toolbar.attach_top (attr_button, 0)
			object_toolbar.attach_left (attr_button, 5)
			object_toolbar.attach_top (once_button, 0)
			object_toolbar.attach_left_widget (attr_button, once_button, 0)

			object_toolbar.attach_top (sep1, 0)
			object_toolbar.attach_left_widget (once_button, sep1, 5)

			object_toolbar.attach_top (slice_button, 0)
			object_toolbar.attach_left_widget (sep1, slice_button, 5)

			object_toolbar.attach_top (sep2, 0)
			object_toolbar.attach_left_widget (slice_button, sep2, 5)

			object_toolbar.attach_top (search_button, 0)
			object_toolbar.attach_left_widget (sep2, search_button, 10)

			object_toolbar.attach_top (sep3, 0)
			object_toolbar.attach_left_widget (search_button, sep3, 5)

			object_toolbar.attach_top (previous_target_button, 0)
			object_toolbar.attach_left_widget (sep3, previous_target_button, 5)
			object_toolbar.attach_top (next_target_button, 0)
			object_toolbar.attach_left_widget (previous_target_button, next_target_button, 0)
			!! do_nothing_cmd
			object_toolbar.set_action ("c<BtnDown>", do_nothing_cmd, Void)

			if not is_in_project_tool and then has_close_button then
				object_toolbar.attach_top (quit_button, 0)
				object_toolbar.attach_right (quit_button, 5)
			end
		end

	attach_all is
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

			global_form.attach_left (text_window.widget, 0)
			global_form.attach_right (text_window.widget, 0)
			global_form.attach_bottom (text_window.widget, 0)
			global_form.attach_top_widget (toolbar_parent, text_window.widget, 0)
		end

feature {DEBUG_DYNAMIC_EVAL_HOLE} -- Implementation

	build_widgets is
		do
			create_toolbar (global_form)

			build_text_windows (global_form)
			if not is_in_project_tool then
				build_menus
			end
			build_object_toolbar
			if not is_in_project_tool then
				fill_menus
			end
			build_toolbar_menu
			set_last_format (default_format)

			if resources.command_bar.actual_value = False then
				object_toolbar.remove
			end

			attach_all
		end

feature {NONE} -- Properties

	default_format: FORMAT_HOLDER is
			-- Default format shows attributes' values
		do
			Result := showattr_frmt_holder
		end

	is_in_project_tool: BOOLEAN
			-- Is the current object tool in the project tool window?

end -- class OBJECT_W
