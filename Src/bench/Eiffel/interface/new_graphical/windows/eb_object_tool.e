indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_TOOL

inherit
	EB_MULTIFORMAT_EDIT_TOOL
		rename
			edit_bar as object_toolbar,
			build_edit_bar as build_object_toolbar
--			Object_type as stone_type
		redefine
			make, init_commands,
--			hole,
 close_windows,
			empty_tool_name, build_interface,
			set_default_format,
			stone, synchronize, -- process_object,
			destroy, reset, format_list,
-- create_toolbar,
--			set_title,
 history_window_title,
-- help_index,
 icon_id
		end

	EB_OBJECT_TOOL_DATA
		rename
			Object_resources as resources
		end			

	SHARED_APPLICATION_EXECUTION

creation
	make

feature {NONE} -- Initialization

	make (man: EB_TOOL_MANAGER) is
			-- Create an object tool.
		do
			Precursor (man)
			set_default_sp_bounds
		end

--	form_create (a_form: FORM; file_m, edit_m, format_m, special_m: MENU_PULL) is
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
--			set_composite_attributes (a_form)
--			set_composite_attributes (edit_m)
--			set_composite_attributes (format_m)
--			set_composite_attributes (special_m)
--			init_text_window
--		end

	init_formatters is
		do
			create format_list.make (Current)
			set_last_format (format_list.default_format)
		end

	init_commands is
		do
			Precursor
			create slice_cmd.make (Current)
			create current_target_cmd.make (Current)
			create previous_target_cmd.make (Current)
			create next_target_cmd.make (Current)
--			!! history_list_cmd.make (Current)
		end

feature {EB_TOOL_MANAGER} -- Initialize

	build_interface is
		do
			precursor

--			if not is_in_project_tool then
--				build_menus
--			end
--			build_object_toolbar
--			if not is_in_project_tool then
--				fill_menus
--			end
--			build_toolbar_menu
--			set_last_format (default_format)

--			if resources.command_bar.actual_value = False then
--				object_toolbar.remove
--			end

		end

feature -- Window Properties

	empty_tool_name: STRING is
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

--	help_index: INTEGER is 4

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Object_id
		end

	format_bar_is_used: BOOLEAN is False

feature -- Access
 
	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		local
			obj_stone: OBJECT_STONE
			history_list: LINEAR [STONE]
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
			Precursor
			set_default_sp_bounds
			init_text_window
		end
 
	process_object (a_stone: like stone) is
			-- Set `s' to stone.
		local
			status: APPLICATION_STATUS
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				create wd.make_default (parent, Interface_names.t_Warning,
					Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				create wd.make_default (parent, Interface_names.t_Warning,
					Warning_messages.w_System_not_stopped)
			elseif not a_stone.is_valid then
				create wd.make_default (parent, Interface_names.t_Warning,
					Warning_messages.w_Object_not_inspectable)
			else
--				last_format.execute (a_stone)
--				add_to_history (a_stone)
			end
		end
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		local
			status: APPLICATION_STATUS
--			cur: CURSOR
			cur: INTEGER
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				-- Do nothing.
				--| There is no need to warn the user because, this simply means
				--| that we need to refresh the content of the window and his
				--| application is not running under EiffelBench. This case happens
				--| mostly when doing `Apply' in the Preference dialg.
			elseif not status.is_stopped then
				create wd.make_default (parent, Interface_names.t_Warning,
					Warning_messages.w_System_not_stopped)
			else
				cur := text_window.position
				synchronise_stone
				text_window.go_to (cur)
			end
		end

	close_windows is
			-- Close sub-windows.
--		local
--			sc: SLICE_COMMAND
--			sw: SLICE_W
		do
--			{EB_EDITOR} Precursor
--			sc ?= slice_cmd_holder.associated_command
--			sw ?= sc.slice_window
--			if sw /= Void and then sw.is_popped_up then
--				sw.popdown
--			end
		end

feature -- Resetting

	destroy is
			-- Reset
		do
			precursor
--			Project_tool.remove_object_entry (Current)
		end

feature -- Settings

	set_default_format is
			-- Set the format to its default.
		do
			set_last_format (format_list.default_format)
		end

feature -- Commands

	current_target_cmd: EB_CURRENT_OBJECT_CMD

	previous_target_cmd: EB_PREVIOUS_OBJECT_CMD

	next_target_cmd: EB_NEXT_OBJECT_CMD

	slice_cmd: EB_SLICE_COMMAND

feature {NONE} -- Properties; Forms And Holes

--	hole: OBJECT_HOLE
			-- Hole charaterizing Current.

--	command_bar: FORM
			-- Bar with the command buttons

feature {NONE} -- Implementation; Graphical Interface

--	create_toolbar (a_parent: COMPOSITE) is
--			-- Create a toolbar_parent with parent `a_parent'.
--		local
--			sep: THREE_D_SEPARATOR
--		do
--			!! toolbar_parent.make (new_name, a_parent)
--			if not is_in_project_tool then
--				!! sep.make (interface_names.t_empty, toolbar_parent)
--			end
--			toolbar_parent.set_column_layout
--			toolbar_parent.set_free_size	
--			toolbar_parent.set_margin_height (0)
--			toolbar_parent.set_spacing (1)
--			!! object_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
--			if not Platform_constants.is_windows then
--				!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			else
--				object_toolbar.set_height (22)
--			end
--		end

	build_object_toolbar (a_toolbar: EV_BOX) is
			-- Build top bar.
		local
--			search_button: EB_BUTTON
--			quit_button: EB_BUTTON
--			quit_cmd: QUIT_FILE
--			has_close_button: BOOLEAN
--
--			history_list_cmd: LIST_HISTORY
--			previous_target_cmd: PREVIOUS_OBJECT
--			next_target_cmd: NEXT_OBJECT
--			current_target_cmd: CURRENT_OBJECT
--			slice_cmd: SLICE_COMMAND
			b: EV_BUTTON
			sep: EV_VERTICAL_SEPARATOR
--			do_nothing_cmd: DO_NOTHING_CMD
		do
			create format_bar.make (a_toolbar)

--				-- Creation of all the commands, holes, buttons, and menu entries
--			!! hole.make (Current)
--
--				-- Should we have a close button?
--			has_close_button := General_resources.close_button.actual_value
--
--			!! quit_cmd.make (Current)
--			if not is_in_project_tool then
--				if has_close_button then
--					!! quit_button.make (quit_cmd, object_toolbar)
--				end
--				!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)
--
--				!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
--				exit_cmd_holder.set_menu_entry (exit_menu_entry)
--			end
--
--				-- First we create all objects.

			create sep.make (a_toolbar)

			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_Slice)
			b.add_click_command (slice_cmd, Void)
--			slice_button.add_third_button_action

			create sep.make (a_toolbar)

			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_Previous_target)
			b.add_click_command (previous_target_cmd, Void)

			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_Next_target)
			b.add_click_command (next_target_cmd, Void)

--			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)
--			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)

--			search_button := search_cmd_holder.associated_button

		end

feature {NONE} -- Properties

	format_list: EB_OBJECT_FORMATTER_LIST

feature {EB_SLICE_COMMAND} -- Format report

	format_is_show_attibutes: BOOLEAN is
		do
			Result := (last_format = format_list.first)
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Slice)
			i.add_select_command (slice_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Current)
			i.add_select_command (current_target_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Next_target)
			i.add_select_command (next_target_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Previous_target)
			i.add_select_command (previous_target_cmd, Void)
		end

end -- class EB_OBJECT_TOOL
