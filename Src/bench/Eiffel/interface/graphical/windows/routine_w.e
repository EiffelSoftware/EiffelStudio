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
			make as normal_create
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets
		end

	BAR_AND_TEXT
		rename
			make as normal_create
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, attach_all
		select
			attach_all
		end

creation

	make
	
feature 

	text_window: ROUTINE_TEXT;

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
		end;

feature

	build_widgets is
		do
			set_size (440, 500);
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
			global_form.detach_right (format_bar);
			global_form.detach_right (edit_bar);

			global_form.attach_right (command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
			global_form.attach_right_widget (command_bar, edit_bar, 0);
			global_form.attach_top (command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
		end

feature {NONE}

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

			!!debug_showbreak.make (command_bar, text_window);
				command_bar.attach_left (debug_showbreak, 0);
				command_bar.attach_top_widget (break_command, debug_showbreak, 0);

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

			!!showpast_command.make (format_bar, text_window);
				format_bar.attach_top (showpast_command, 0);
				format_bar.attach_left_widget (showroutclients_command, showpast_command, 0);

			!!showfuture_command.make (format_bar, text_window);
				format_bar.attach_top (showfuture_command, 0);
				format_bar.attach_left_widget (showpast_command, showfuture_command, 0);

			!!shell_command.make (format_bar, text_window);
				format_bar.attach_top (shell_command, 0);
				format_bar.attach_right (shell_command, 0);
		end;

	build_bar is
			-- Build top bar: editing commands.
		local
			quit_cmd: QUIT_FILE;
		do
			!!hole.make (edit_bar, Current);
			!!class_hole.make (edit_bar, Current);
			!!type_teller.make (new_name, edit_bar);
			type_teller.set_center_alignment;
			!!search_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);
			!!quit_cmd.make (edit_bar, text_window);
				edit_bar.attach_left (hole, 0);
				edit_bar.attach_top (hole, 0);
				edit_bar.attach_left_widget (hole, class_hole, 0);
				edit_bar.attach_top (class_hole, 0);

				clean_type;

				edit_bar.attach_left_widget (class_hole, type_teller, 0);
				edit_bar.attach_top (type_teller, 0);
				edit_bar.attach_right_widget (search_command, type_teller, 0);
				edit_bar.attach_bottom (type_teller, 0);
				edit_bar.attach_top (search_command, 0);
				edit_bar.attach_right_widget (change_font_command, search_command, 25);
				edit_bar.attach_top (change_font_command, 0);
				edit_bar.attach_right_widget (quit_cmd, change_font_command, 25);
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
	debug_quit_command: DEBUG_QUIT;
	showroutclients_command: SHOW_ROUTCLIENTS;
	debug_showbreak: DEBUG_SHOWBREAK;
	showpast_command: SHOW_PAST;
	showfuture_command: SHOW_FUTURE;
	shell_command: SHELL_COMMAND;

end
