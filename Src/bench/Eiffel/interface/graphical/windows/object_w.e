indexing

	description:	
		"Window describing an Eiffel object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_W 

inherit

	BAR_AND_TEXT
		rename
			default_format as old_default_format,
			close_windows as old_close_windows,
			make_shell as old_make_shell,
			reset as old_reset
		redefine
			build_format_bar, hole, build_widgets, attach_all,
			tool_name, set_default_format, stone, stone_type, synchronize,
			process_object, build_basic_bar,
			close, set_default_size,
			update_boolean_resource,
			update_integer_resource,
			set_title
		end;
	BAR_AND_TEXT
		rename
			default_format as old_default_format
		redefine
			build_format_bar, hole, close_windows,
			tool_name, build_widgets, attach_all, set_default_format,
			stone, stone_type, synchronize, process_object,
			build_basic_bar, close, make_shell, reset,
			update_boolean_resource, set_default_size,
			update_integer_resource,
			set_title
		select
			close_windows, make_shell, reset
		end;
	SHARED_APPLICATION_EXECUTION;
	WARNING_MESSAGES;
	EB_CONSTANTS

creation

	make_shell, form_create

feature {NONE} -- Initialization

	make_shell (a_shell: EB_SHELL) is
			-- Create an object tool.
		do
			create_menus := True;
			old_make_shell (a_shell);
			set_default_sp_bounds
		end;

	form_create (a_form: FORM; edit_m, format_m, special_m: MENU_PULL) is
			-- Create a feature tool from a form.
		require
			valid_args: a_form /= Void and then edit_m /= Void and then
				format_m /= Void and then special_m /= Void
		do
			create_menus := False;
			edit_menu := edit_m;
			format_menu := format_m;
			special_menu := special_m;
			make_form (a_form);
			set_composite_attributes (a_form);
            set_composite_attributes (edit_m);
            set_composite_attributes (format_m);
            set_composite_attributes (special_m)
		end;

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
		local
			otr: like Object_tool_resources
		do
			otr := Object_tool_resources
			if old_res = otr.command_bar then
				if new_res.actual_value then
					edit_bar.add
				else
					edit_bar.remove
				end
			elseif old_res = otr.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			end;
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			otr: like Object_tool_resources
		do
			otr := Object_tool_resources;
			if new_res.actual_value > 0 then
				if old_res = otr.tool_height then
					if old_res.actual_value /= new_res.actual_value then
						set_height (new_res.actual_value)
					end
				elseif old_res = otr.tool_width then
					if old_res.actual_value /= new_res.actual_value then
						set_width (new_res.actual_value)
					end
				end;
				old_res.update_with (new_res)
			end
		end

feature -- Window Properties

	tool_name: STRING is
		do
			Result := l_Empty_object
		end;

	stone: OBJECT_STONE
			-- Stone in tool
 
	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := Object_type
		end
 
feature -- Access
 
	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		local
			obj_stone: OBJECT_STONE;
			history_list: LINEAR [STONE];
			pos: INTEGER
		do
			Result := text_window.kept_objects;
			from
				pos := history.index;
				history.start
			until
				history.after
			loop
				obj_stone ?= history.item;
				Result.extend (obj_stone.object_address);
				history.forth
			end;
			history.go_i_th (pos)
		end;

feature -- Status report

	sp_lower, sp_upper: INTEGER;
			-- Bounds for special object inspection;
			-- A negative value for `sp_upper' stands for the
			-- upper bound of the inspected special object

	sp_capacity: INTEGER;
			-- Capacity of the last special object displayed in
			-- the object window

feature -- Status seting

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s);
				Project_tool.change_object_entry (Current)
			end
		end;

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			sp_lower := l;
			sp_upper := u
		end;

	set_sp_capacity (c: INTEGER) is
			-- Assign `c' to `sp_capacity'.
		do
			sp_capacity := c
		end;

	set_default_sp_bounds is
			-- Set the default bounds for special object inspection.
		do
			sp_capacity := 0;
			sp_lower := 0;
			sp_upper := Application.displayed_string_size
		end;

feature -- Update

	hang_on is
			-- Make object addresses unclickable.
		do
			text_window.hang_on
		end;

	reset is
			-- Reset the contents of the object window.
		do
			old_reset;
			set_default_sp_bounds
		end;
 
	process_object (a_stone: like stone) is
			-- Set `s' to stone.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if status = Void then
				warner (eb_shell).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (eb_shell).gotcha_call (w_System_not_stopped)
			elseif not a_stone.is_valid then
				warner (eb_shell).gotcha_call (w_Object_not_inspectable)
			else
				last_format.execute (a_stone);
				history.extend (a_stone)
			end
		end;
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		local
			status: APPLICATION_STATUS;
			cur: CURSOR;
		do
			status := Application.status;
			if status = Void then
				warner (eb_shell).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (eb_shell).gotcha_call (w_System_not_stopped)
			else
				cur := text_window.cursor;
				synchronise_stone;
				text_window.go_to (cur)
			end
		end

	close_windows is
			-- Close sub-windows.
		local
			sc: SLICE_COMMAND;
			sw: SLICE_W
		do
			old_close_windows;
			sc ?= slice_cmd_holder.associated_command;
			sw ?= sc.slice_window
			if sw.is_popped_up then
				sw.popdown
			end
		end;

feature -- Resetting

	close is
			-- Reset
		do
			if is_a_shell then
				Project_tool.remove_object_entry (Current);
				hide;
				reset
			else
				Project_tool.display_object_cmd_holder.associated_command.work (Void)
			end
		end;

feature -- Settings

	set_default_format is
			-- Set the format to its default.
		do
			set_last_format (default_format);
		end;

	set_default_size is
			-- Set the size of Current to its default.
		do
			if eb_shell /= Void then
				eb_shell.set_size 
					(Object_tool_resources.tool_width.actual_value,
					Object_tool_resources.tool_height.actual_value)
			end
		end;
		
feature -- Commands

	showattr_frmt_holder: FORMAT_HOLDER;

	showonce_frmt_holder: FORMAT_HOLDER;

	current_target_cmd_holder: COMMAND_HOLDER;

	previous_target_cmd_holder: COMMAND_HOLDER;

	next_target_cmd_holder: COMMAND_HOLDER;

	slice_cmd_holder: COMMAND_HOLDER;

feature {NONE} -- Properties; Forms And Holes

	hole: OBJECT_HOLE;
			-- Hole charaterizing Current.

	command_bar: FORM;
			-- Bar with the command buttons

feature {NONE} -- Implementation; Graphical Interface

	build_basic_bar is
			-- Build top bar (only the basics).
		local
			quit_cmd: QUIT_FILE;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			exit_menu_entry: EB_MENU_ENTRY
		do
				-- Creation of all the commands, holes, buttons, and menu entries
			!! hole.make (Current);
			!! hole_button.make (hole, edit_bar);
			!! hole_holder.make_plain (hole);
			hole_holder.set_button (hole_button);
			build_edit_menu (edit_bar);
			!! quit_cmd.make (Current);
			!! quit_button.make (quit_cmd, edit_bar);
			if create_menus then
				!! quit_menu_entry.make (quit_cmd, file_menu);
				!! quit.make (quit_cmd, quit_button, quit_menu_entry);

				!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu);
				!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command);
				exit_cmd_holder.set_menu_entry (exit_menu_entry)
			else
				!! quit.make_plain (quit_cmd);
				quit.set_button (quit_button)
			end;

				-- Attachments are done here, because of speed.
				-- I know it's not really maintainable.
			edit_bar.attach_left (hole_button, 0);
			edit_bar.attach_top (hole_button, 0);
			edit_bar.attach_top (search_cmd_holder.associated_button, 0);
			edit_bar.attach_top (quit_button, 0);
			edit_bar.attach_right (quit_button, 0);
			edit_bar.detach_left (quit_button);
			edit_bar.attach_right_widget (quit_button, search_cmd_holder.associated_button, 5);
			edit_bar.detach_left (search_cmd_holder.associated_button)
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			once_cmd: SHOW_ONCE_RESULTS;
			once_button: FORMAT_BUTTON;
			once_menu_entry: EB_TICKABLE_MENU_ENTRY;
			attr_cmd: SHOW_ATTR_VALUES;
			attr_button: FORMAT_BUTTON;
			attr_menu_entry: EB_TICKABLE_MENU_ENTRY;
		do
				-- First we create all objects.
			!! once_cmd.make (Current);
			!! once_button.make (once_cmd, format_bar);
			!! once_menu_entry.make (once_cmd, format_menu);
			!! showonce_frmt_holder.make (once_cmd, once_button, once_menu_entry)
			!! attr_cmd.make (Current);
			!! attr_button.make (attr_cmd, format_bar);
			!! attr_menu_entry.make (attr_cmd, format_menu);
			!! showattr_frmt_holder.make (attr_cmd, attr_button, attr_menu_entry);

				-- Now we do the attachments (for reason of speed).
			format_bar.attach_top (attr_button, 0);
			format_bar.attach_left (attr_button, 0);
			format_bar.attach_top (once_button, 0);
			format_bar.detach_right (attr_button);
			format_bar.attach_left_widget (attr_button, once_button,0)
		end;

	build_widgets is
		local
			sep: SEPARATOR
		do
			if eb_shell /= Void then
				set_default_size
			end;

			create_toolbar_parent (global_form);

			build_text_windows;
			if create_menus then
				build_menus
			end
			!! edit_bar.make (l_Command_bar_name, toolbar_parent);
			!! sep.make ("", toolbar_parent);
			build_bar;
			!! format_bar.make (l_Format_bar_name, toolbar_parent);
			build_format_bar;
			build_command_bar;
			if create_menus then
				fill_menus;
			end;
			build_toolbar_menu
			set_last_format (default_format);

			if Object_tool_resources.command_bar.actual_value = False then
				edit_bar.remove
			end;
			if Object_tool_resources.format_bar.actual_value = False then
				format_bar.remove
			end;

			attach_all
		end;

	attach_all is
		do
			if create_menus then
				global_form.attach_left (menu_bar, 0);
				global_form.attach_right (menu_bar, 0);
				global_form.attach_top (menu_bar, 0)
			end;

			global_form.attach_left (toolbar_parent, 0);
			global_form.attach_right (toolbar_parent, 0);
			if create_menus then
				global_form.attach_top_widget (menu_bar, toolbar_parent, 0)
			else
				global_form.attach_top (toolbar_parent, 0)
			end

			global_form.attach_left (text_window.widget, 0);
			global_form.attach_right (text_window.widget, 0);
			global_form.attach_bottom (text_window.widget, 0);
			global_form.attach_top_widget (toolbar_parent, text_window.widget, 0);
		end;

	build_command_bar is
		local
			previous_target_cmd: PREVIOUS_OBJECT;
			previous_target_button: EB_BUTTON;
			previous_target_menu_entry: EB_MENU_ENTRY;
			next_target_cmd: NEXT_OBJECT;
			next_target_button: EB_BUTTON;
			next_target_menu_entry: EB_MENU_ENTRY;
			current_target_cmd: CURRENT_OBJECT;
			current_target_menu_entry: EB_MENU_ENTRY;
			slice_cmd: SLICE_COMMAND;
			slice_button: EB_BUTTON;
			slice_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR;
			history_list_cmd: LIST_HISTORY
		do
				-- Here we create all objects needed for the attachments.
			!! slice_cmd.make (format_bar, Current);
			!! slice_button.make (slice_cmd, format_bar);
			slice_button.add_third_button_action;
			!! slice_menu_entry.make_button_only (slice_cmd, special_menu);
			slice_menu_entry.add_activate_action (slice_cmd, Void);
			!! slice_cmd_holder.make (slice_cmd, slice_button, slice_menu_entry)
			!! current_target_cmd.make (Current);
			!! sep.make (new_name, special_menu);
			!! current_target_menu_entry.make (current_target_cmd, special_menu);
			!! current_target_cmd_holder.make_plain (current_target_cmd);
			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)
			!! next_target_cmd.make (Current);
			!! next_target_button.make (next_target_cmd, edit_bar);
			!! next_target_menu_entry.make (next_target_cmd, special_menu);
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry);
			!! previous_target_cmd.make (Current);
			!! previous_target_button.make (previous_target_cmd, edit_bar);
			!! previous_target_menu_entry.make (previous_target_cmd, special_menu);
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry);

			!! history_list_cmd.make (Current);
			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button);
			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button);

				-- Here we do the attachments (for reasons of speed).
			format_bar.attach_right (slice_button, 1);
			format_bar.attach_top (slice_button, 0);
			format_bar.detach_left (slice_button);

			edit_bar.attach_left_widget (hole_button, previous_target_button, 10);
			edit_bar.attach_top (next_target_button, 0);
			edit_bar.attach_left_widget (previous_target_button, next_target_button, 0);
			edit_bar.attach_top (previous_target_button, 0)
		end;

feature {NONE} -- Properties

	default_format: FORMAT_HOLDER is
			-- Default format shows attributes' values
		do
			Result := showattr_frmt_holder
		end;

	create_menus: BOOLEAN
			-- Did the menus get created for this tool?

end -- class OBJECT_W
