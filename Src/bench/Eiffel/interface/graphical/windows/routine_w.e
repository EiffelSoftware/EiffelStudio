--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Window describing an Eiffel routine.

class ROUTINE_W 

inherit

	BAR_AND_TEXT
		rename
			attach_all as default_attach_all,
			make as normal_create,
			reset as old_reset,
			execute as old_execute
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, set_default_size,
			set_default_position
		end

	BAR_AND_TEXT
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, attach_all, reset,
			set_default_size, set_default_position,	
			make, execute
		select
			attach_all, reset, make, execute
		end

creation

	make
	
feature 

	text_window: ROUTINE_TEXT;

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
			text_window.set_read_only;
			set_action ("<Configure>" , Current, resize_action);
		end;

	reset is
			-- Reset the window contents
		do
			old_reset;
			change_class_command.clear;
			change_routine_command.clear;
		end;
	
	update_edit_bar is
		local
			root_stone: FEATURE_STONE;
			f_name: STRING
		do
			root_stone := text_window.root_stone;
			if root_stone /= Void then
				change_class_command.update_classc (root_stone.class_c);
				change_routine_command.set_text (root_stone.feature_i.feature_name);
			end
		end; 
	
feature

	build_widgets is
		do
			set_default_size;
				!!text_window.make (new_name, global_form, Current);
				!!edit_bar.make (new_name, global_form);
				build_bar;
				!!format_bar.make (new_name, global_form);
				build_format_bar;
				!!command_bar.make (new_name, global_form);
				build_command_bar;
				text_window.set_last_format (default_format);
			attach_all	
		end

	attach_all is
		do
			default_attach_all;

			global_form.detach_right (text_window);

			global_form.attach_right (command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_bottom_widget (format_bar, command_bar, 0);
		end

	change_class_command: CHANGE_CL_ROUT;
	change_routine_command: CHANGE_ROUTINE;

feature {NONE}

	resize_action: ANY is
		once
			!! Result
		end

	execute (argument: ANY) is
		do
			if argument = resize_action then
				change_class_command.update_text;
				change_routine_command.update_text;
			else
				old_execute (argument)
			end
		end;

	set_default_size is
		do
			set_size (600, 450)
		end;

	set_default_position is
		local
			i: INTEGER;
		do
			i := 10 * window_manager.routine_windows_count;
			set_x_y (500 + i, i)
		end;

	close_windows is
		do
	   		search_command.close;
	   		change_font_command.close (text_window);
			debug_run_command.close
	   	 end;

	tool_name: STRING is do Result := l_Routine end;

	hole: ROUTINE_HOLE;
			-- Hole caraterizing current
	class_hole: ROUT_CLASS_HOLE;
			-- Hole for version of routine for a particular class.

	command_bar: FORM;
			-- Bar with the command buttons (set stoppoint, run...)

	build_command_bar is
		do
-- Left out in version 3.1 and 3.2
--			!!step_command.make (format_bar, text_window);
--			!!next_command.make (format_bar, text_window);
--			!!line_command.make (format_bar, text_window);
--			!!continue_command.make (format_bar, text_window);
			!!break_command.make (command_bar, text_window);
				command_bar.attach_left (break_command, 0);
				command_bar.attach_top (break_command, 100);

			!!unbreak_command.make (command_bar, text_window);
				command_bar.attach_left (unbreak_command, 0);
				command_bar.attach_top_widget (break_command, unbreak_command, 0);

			!!debug_showbreak.make (command_bar, text_window);
				command_bar.attach_left (debug_showbreak, 0);
				command_bar.attach_top_widget (unbreak_command, debug_showbreak, 0);

			!!debug_run_command.make (command_bar, text_window);
				command_bar.attach_left (debug_run_command, 0);
				command_bar.attach_top_widget (debug_showbreak, debug_run_command, 25);

			!!debug_quit_command.make (command_bar, text_window);
				command_bar.attach_left (debug_quit_command, 0);
				command_bar.attach_top_widget (debug_run_command, debug_quit_command, 25);
		end;

	build_format_bar is
			-- Build debugging buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);

			!!showroutclients_command.make (format_bar, text_window);
				format_bar.attach_top (showroutclients_command, 0);
				format_bar.attach_left_widget (showtext_command, showroutclients_command, 0);

			!!showhistory_command.make (format_bar, text_window);
				format_bar.attach_top (showhistory_command, 0);
				format_bar.attach_left_widget (showroutclients_command, showhistory_command, 0);

			!!showpast_command.make (format_bar, text_window);
				format_bar.attach_top (showpast_command, 0);
				format_bar.attach_left_widget (showhistory_command, showpast_command, 0);

			!!showfuture_command.make (format_bar, text_window);
				format_bar.attach_top (showfuture_command, 0);
				format_bar.attach_left_widget (showpast_command, showfuture_command, 0);

			!!showflat_command.make (format_bar, text_window);
				format_bar.attach_top (showflat_command, 0);
				format_bar.attach_left_widget (showfuture_command, showflat_command, 0);

			!!shell_command.make (format_bar, text_window);
				format_bar.attach_top (shell_command, 0);
				format_bar.attach_right (shell_command, 0);
		end;

	build_bar is
			-- Build top bar: editing commands.
		local
			quit_cmd: QUIT_FILE;
			form: FORM;
			label: LABEL;
		do
			edit_bar.set_fraction_base (2);
			!!form.make ("", edit_bar);
				!!label.make ("", form);
				label.set_text ("from: ");
				!!change_class_command.make (form, text_window);
				form.attach_top (change_class_command, 0);
				form.attach_top (label, 0);
				form.attach_bottom (label, 0);
				form.attach_left (label, 0);
				form.attach_left_widget (label, change_class_command, 0);
				form.attach_right (change_class_command, 0);
			!!hole.make (edit_bar, Current);
			!!class_hole.make (edit_bar, Current);
			!!type_teller.make (new_name, edit_bar);
			!!change_routine_command.make (edit_bar, text_window);
			type_teller.set_center_alignment;
			!!search_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);
			!!quit_cmd.make (edit_bar, text_window);
				edit_bar.attach_left (hole, 0);
				edit_bar.attach_top (hole, 0);
				edit_bar.attach_left_widget (hole, class_hole, 0);
				edit_bar.attach_top (class_hole, 0);

				clean_type;

				edit_bar.attach_top (form, 0);
				edit_bar.attach_bottom (form, 0);
				edit_bar.attach_top (change_routine_command, 0);
				edit_bar.attach_bottom (change_routine_command, 0);
				edit_bar.attach_top (type_teller, 0);
				edit_bar.attach_left_widget (class_hole, type_teller, 0);
				edit_bar.attach_left (change_routine_command, 175);
				edit_bar.attach_bottom (type_teller, 0);
				edit_bar.attach_top (search_command, 0);
				edit_bar.attach_left_position (form, 1);
				edit_bar.attach_right_position (change_routine_command, 1);
				edit_bar.attach_right_widget (change_routine_command, type_teller, 0);
				edit_bar.attach_right_widget (search_command, form, 0);
				edit_bar.attach_right_widget (change_font_command, search_command, 0);
				edit_bar.attach_top (change_font_command, 0);
				edit_bar.attach_right_widget (quit_cmd, change_font_command, 10);
				edit_bar.attach_top (quit_cmd, 0);
				edit_bar.attach_right (quit_cmd, 0);
		end;

	debug_run_command: DEBUG_RUN;
--	step_command: STEP;
--	next_command: NEXT;
--	line_command: TIL_LINE;
--	continue_command: CONTINUE;
--	break_command: SET_BREAKPOINT;
	break_command: DEBUG_STOPIN;	
	unbreak_command: DEBUG_NOSTOPIN;	
	debug_quit_command: DEBUG_QUIT;
	showroutclients_command: SHOW_ROUTCLIENTS;
	debug_showbreak: DEBUG_SHOWBREAK;
	showpast_command: SHOW_PAST;
	showhistory_command: SHOW_ROUT_HIST;
	showfuture_command: SHOW_FUTURE;
	showflat_command: SHOW_ROUT_FLAT;
	shell_command: SHELL_COMMAND;

end
