indexing

	description:	
		"Window describing an Eiffel routine.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_W 

inherit

	BAR_AND_TEXT
		rename
			attach_all as default_attach_all,
			make as normal_create,
			reset as old_reset
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, set_default_size,
			resize_action
		end

	BAR_AND_TEXT
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, attach_all, reset,
			set_default_size, make, resize_action
		select
			attach_all, reset, make
		end

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a feature tool
		do
			normal_create (a_screen);
			text_window.set_read_only
		end;
	
feature -- Window Properties

	text_window: ROUTINE_TEXT;

feature -- Resetting

	reset is
			-- Reset the window contents
		do
			old_reset;
			class_hole.set_empty_symbol;
			change_class_command.clear;
			change_routine_command.clear;
		end;
	
feature -- Graphical Interface

	update_edit_bar is
			-- Updates the edit bar.
		local
			root_stone: FEATURE_STONE;
			f_name: STRING
		do
			root_stone := text_window.root_stone;
			if root_stone /= Void then
				change_class_command.update_class_name (root_stone.e_class.name);
				change_routine_command.set_text (root_stone.e_feature.name);
			end
		end; 
	
	build_widgets is
			-- Build the widgets for this window.
		do
			set_default_size;
				if tabs_disabled then
					!! text_window.make (new_name, global_form, Current);
				else
					!ROUTINE_TAB_TEXT! text_window.make (new_name, global_form, Current);
				end;
				!! edit_bar.make (new_name, global_form);
				build_bar;
				!! format_bar.make (new_name, global_form);
				build_format_bar;
				!! command_bar.make (new_name, global_form);
				build_command_bar;
				text_window.set_last_format (default_format);
			attach_all	
		end

	attach_all is
			-- Attach all widgets.
		do
			default_attach_all;

			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
		end

feature {ROUTINE_TEXT} -- Forms And Holes

	change_class_form: FORM;

	change_routine_form: FORM;

	hole: ROUTINE_HOLE;
			-- Hole caraterizing current

	class_hole: ROUT_CLASS_HOLE;
			-- Hole for version of routine for a particular class.

	stop_hole: DEBUG_STOPIN;
			-- To set breakpoints

feature {ROUTINE_TEXT} -- Formats

	showroutclients_command: SHOW_ROUTCLIENTS;

	showhomonyms_command: SHOW_HOMONYMS;

	showpast_command: SHOW_PAST;

	showhistory_command: SHOW_ROUT_HIST;

	showfuture_command: SHOW_FUTURE;

	showflat_command: SHOW_ROUT_FLAT;

feature -- Commands

	showstop_command: SHOW_BREAKPOINTS;

	shell_command: SHELL_COMMAND;

	current_target: CURRENT_ROUTINE;

	previous_target: PREVIOUS_TARGET;

	next_target: NEXT_TARGET;

	change_routine_command: CHANGE_ROUTINE;

	change_class_command: CHANGE_CL_ROUT;

feature {NONE} -- Implementation; Window Settings

	resize_action is
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup;
			change_class_command.update_text;
			change_routine_command.update_text;
			change_class_command.choice.update_position;
			change_routine_command.choice.update_position
		end;

	set_default_size is
			-- Set the size of Current to its default.
		do
			set_size (650, 450)
		end;

	close_windows is
			-- Pop down the associated windows.
		do
	   		search_command.close;
	   		change_font_command.close;
			if change_routine_command.choice.is_popped_up then
				change_routine_command.choice.popdown
			end;
			if change_class_command.choice.is_popped_up then
				change_class_command.choice.popdown
			end
	   	 end;

feature {NONE} -- Implementation; Graphical Interface

	build_command_bar is
			-- Build the command bar.
		do
			!! shell_command.make (command_bar, text_window);
			command_bar.attach_left (shell_command, 0);
			command_bar.attach_bottom (shell_command, 0);
			!! current_target.make (command_bar, text_window);
			command_bar.attach_left (current_target, 0);
			command_bar.attach_bottom_widget (shell_command, current_target, 10);
			!! next_target.make (command_bar, text_window);
			command_bar.attach_left (next_target, 0);
			command_bar.attach_bottom_widget (current_target, next_target, 0);
			!! previous_target.make (command_bar, text_window);
			command_bar.attach_left (previous_target, 0);
			command_bar.attach_bottom_widget (next_target, previous_target, 0);
		end;

	build_format_bar is
			-- Build the format bar.
		do
			!! showtext_command.make (format_bar, text_window);
			format_bar.attach_top (showtext_command, 0);
			format_bar.attach_left (showtext_command, 0);

			!! showflat_command.make (format_bar, text_window);
			format_bar.attach_top (showflat_command, 0);
			format_bar.attach_left_widget (showtext_command, showflat_command, 0);

			!! showroutclients_command.make (format_bar, text_window);
			format_bar.attach_top (showroutclients_command, 0);
			format_bar.attach_left_widget (showflat_command, showroutclients_command, 10);

			!! showhistory_command.make (format_bar, text_window);
			format_bar.attach_top (showhistory_command, 0);
			format_bar.attach_left_widget (showroutclients_command, showhistory_command, 0);

			!! showpast_command.make (format_bar, text_window);
			format_bar.attach_top (showpast_command, 0);
			format_bar.attach_left_widget (showhistory_command, showpast_command, 0);

			!! showfuture_command.make (format_bar, text_window);
			format_bar.attach_top (showfuture_command, 0);
			format_bar.attach_left_widget (showpast_command, showfuture_command, 0);

			!! showhomonyms_command.make (format_bar, text_window);
			format_bar.attach_top (showhomonyms_command, 0);
			format_bar.attach_left_widget (showfuture_command, showhomonyms_command, 0);

			!! showstop_command.make (format_bar, text_window);
			format_bar.attach_top (showstop_command, 0);
			format_bar.attach_left_widget (showhomonyms_command, showstop_command, 10);
		end;

	build_bar is
			-- Build top bar: editing commands.
		local
			hole_form: FORM;
			label: LABEL;
		do
			edit_bar.set_fraction_base (31);

			!! hole_form.make (new_name, edit_bar);
			edit_bar.attach_left (hole_form, 0);
			edit_bar.attach_top (hole_form, 0);
			edit_bar.attach_bottom (hole_form, 0);

			!! hole.make (hole_form, Current);
			hole_form.attach_left (hole, 0);
			hole_form.attach_top (hole, 0);
			!! class_hole.make (hole_form, Current);
			hole_form.attach_left_widget (hole, class_hole, 0);
			hole_form.attach_top (class_hole, 0);
			!! stop_hole.make (hole_form, Current);
			hole_form.attach_left_widget (class_hole, stop_hole, 0);
			hole_form.attach_top (stop_hole, 0);

			!! type_teller.make (new_name, edit_bar);
			type_teller.set_center_alignment;
			edit_bar.attach_left_widget (hole_form, type_teller, 0);
			edit_bar.attach_top (type_teller, 0);
			edit_bar.attach_bottom (type_teller, 0);
			edit_bar.attach_right_position (type_teller, 11);
			clean_type;

			!! change_routine_form.make (new_name, edit_bar);
			edit_bar.attach_left_position (change_routine_form, 11);
			edit_bar.attach_top (change_routine_form, 0);
			edit_bar.attach_bottom (change_routine_form, 0);
			edit_bar.attach_right_position (change_routine_form, 17);

			!! change_routine_command.make (change_routine_form, text_window);
			change_routine_command.set_width (80);
			change_routine_form.attach_left (change_routine_command, 0);
			change_routine_form.attach_top (change_routine_command, 0);
			change_routine_form.attach_bottom (change_routine_command, 0);
			change_routine_form.attach_right (change_routine_command, 0);

			!! label.make ("", edit_bar);
			label.set_text ("from: ");
			label.set_right_alignment;
			edit_bar.attach_left_position (label, 17);
			edit_bar.attach_top (label, 0);
			edit_bar.attach_bottom (label, 0);
			edit_bar.attach_right_position (label, 20);

			!! change_class_form.make (new_name, edit_bar);
			edit_bar.attach_left_position (change_class_form, 20);
			edit_bar.attach_top (change_class_form, 0);
			edit_bar.attach_bottom (change_class_form, 0);

			!! change_class_command.make (change_class_form, text_window);
			change_class_command.set_width (80);
			change_class_form.attach_left (change_class_command, 0);
			change_class_form.attach_top (change_class_command, 0);
			change_class_form.attach_bottom (change_class_command, 0);
			change_class_form.attach_right (change_class_command, 0);

			!! quit_command.make (edit_bar, text_window);
			edit_bar.attach_top (quit_command, 0);
			edit_bar.attach_right (quit_command, 0);

			!! change_font_command.make (edit_bar, text_window);
			edit_bar.attach_top (change_font_command, 0);
			edit_bar.attach_right_widget (quit_command, change_font_command, 10);

			!! search_command.make (edit_bar, text_window);
			edit_bar.attach_top (search_command, 0);
			edit_bar.attach_right_widget (change_font_command, search_command, 0);
			edit_bar.attach_right_widget (search_command, change_class_form, 2)
		end;

feature {NONE} -- Properties

	command_bar: FORM;
			-- Bar with the command buttons

feature {ROUTINE_TEXT} -- Properties

	tool_name: STRING is
		do
			Result := l_Routine
		end;

end -- class ROUTINE_W
