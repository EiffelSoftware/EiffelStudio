indexing

	description:	
		"Window describing an Eiffel object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_W 

inherit

	BAR_AND_TEXT
		rename
			attach_all as default_attach_all,
			make as normal_create,
			default_format as old_default_format,
			close_windows as old_close_windows
		redefine
			text_window, build_format_bar, hole, build_widgets,
			tool_name, set_default_format, stone, stone_type, synchronize,
			process_object, hole_button
		end;
	BAR_AND_TEXT
		rename
			default_format as old_default_format
		redefine
			text_window, build_format_bar, hole, close_windows,
			tool_name, make, build_widgets, attach_all, set_default_format,
			stone, stone_type, synchronize, process_object, hole_button
		select
			make, attach_all, close_windows
		end;
	SHARED_APPLICATION_EXECUTION;
	WARNING_MESSAGES

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
			text_window.set_read_only;
		end;

feature -- Window Properties

	text_window: OBJECT_TEXT;
			-- Window to display the text in.

	tool_name: STRING is
		do
			Result := l_Object
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
 
  feature -- Update
 
	hang_on is
			-- Make object addresses unclickable.
		do
			text_window.hang_on
		end;
 
	process_object (a_stone: like stone) is
			-- Set `s' to stone.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if status = Void then
				warner (Current).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (Current).gotcha_call (w_System_not_stopped)
			elseif not a_stone.is_valid then
				warner (Current).gotcha_call (w_Object_not_inspectable)
			else
				text_window.last_format_2.execute (a_stone);
				history.extend (a_stone)
			end
		end;
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if status = Void then
				warner (Current).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (Current).gotcha_call (w_System_not_stopped)
			else
				synchronise_stone
			end
		end

feature -- Settings

	set_default_format is
			-- Set the format to its default.
		do
			text_window.set_last_format_2 (default_format);
		end;

feature -- Commands

	showattr_frmt_holder: FORMAT_HOLDER;

	showonce_frmt_holder: FORMAT_HOLDER;

	current_target_cmd_holder: COMMAND_HOLDER;

	previous_target_cmd_holder: COMMAND_HOLDER;

	next_target_cmd_holder: COMMAND_HOLDER;

	slice_cmd_holder: COMMAND_HOLDER;

feature {NONE} -- Properties; Forms And Holes

	hole: OBJECT_CMD;
			-- Hole charaterizing Current.

	hole_button: OBJECT_HOLE;
			-- Hole to represent Current.

	command_bar: FORM;
			-- Bar with the command buttons

feature {NONE} -- Implementation; Window Settings

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

feature {NONE} -- Implementation; Graphical Interface

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			once_cmd: SHOW_ONCE_RESULTS;
			once_button: EB_BUTTON;
			attr_cmd: SHOW_ATTR_VALUES;
			attr_button: EB_BUTTON
		do
			!! once_cmd.make (text_window);
			!! once_button.make (once_cmd, format_bar);
			!! showonce_frmt_holder.make (once_cmd, once_button);
			!! attr_cmd.make (text_window);
			!! attr_button.make (attr_cmd, format_bar);
			!! showattr_frmt_holder.make (attr_cmd, attr_button);
			format_bar.attach_top (attr_button, 0);
			format_bar.attach_left (attr_button, 0);
			format_bar.attach_top (once_button, 0);
			format_bar.attach_left_widget (attr_button, once_button,0)
		end;

	build_widgets is
		do
			set_default_size;
			if tabs_disabled then
				!! text_window.make (new_name, global_form, Current);
			else
				!OBJECT_TAB_TEXT! text_window.make (new_name, global_form, Current);
			end;
			!! edit_bar.make (new_name, global_form);
			build_bar;
			!! format_bar.make (new_name, global_form);
			build_format_bar;
				!! command_bar.make (new_name, global_form);
			build_command_bar;
			text_window.set_last_format_2 (default_format);
			attach_all
		end;

	attach_all is
		do
			default_attach_all;
			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
		end;

	build_command_bar is
		local
			previous_target_cmd: PREVIOUS_OBJECT;
			previous_target_button: EB_BUTTON;
			next_target_cmd: NEXT_OBJECT;
			next_target_button: EB_BUTTON;
			current_target_cmd: CURRENT_OBJECT;
			current_target_button: EB_BUTTON;
			slice_cmd: SLICE_COMMAND;
			slice_button: EB_BUTTON
		do
			!! slice_cmd.make (command_bar, text_window);
			!! slice_button.make (slice_cmd, command_bar);
			slice_button.add_button_click_action (3, slice_cmd, Void);
			!! slice_cmd_holder.make (slice_cmd, slice_button);
			command_bar.attach_left (slice_button, 0);
			command_bar.attach_right (slice_button, 0);
			command_bar.attach_bottom (slice_button, 0)
			!! current_target_cmd.make (text_window);
			!! current_target_button.make (current_target_cmd, command_bar);
			!! current_target_cmd_holder.make (current_target_cmd, current_target_button);
			command_bar.attach_left (current_target_button, 0);
			command_bar.attach_right (current_target_button, 0);
			command_bar.attach_bottom_widget (slice_button, current_target_button, 10)
			!! next_target_cmd.make (text_window);
			!! next_target_button.make (next_target_cmd, command_bar);
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button);
			command_bar.attach_left (next_target_button, 0);
			command_bar.attach_right (next_target_button, 0);
			command_bar.attach_bottom_widget (current_target_button, next_target_button, 0);
			!! previous_target_cmd.make (text_window);
			!! previous_target_button.make (previous_target_cmd, command_bar);
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button);
			command_bar.attach_left (previous_target_button, 0);
			command_bar.attach_right (previous_target_button, 0);
			command_bar.attach_bottom_widget (next_target_button, previous_target_button, 0);
		end;

	default_format: FORMAT_HOLDER is
			-- Default format shows attributes' values
		do
			Result := showattr_frmt_holder
		end;

end -- class OBJECT_W
