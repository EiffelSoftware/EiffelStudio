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
			make as normal_create
		redefine
			hole, build_format_bar, text_window
		end

creation

	make
	
feature 

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
			text_window.set_read_only
		end;

feature {NONE}

	tool_name: STRING is do Result := l_Routine end;

feature 

	text_window: ROUTINE_TEXT;

	
feature {NONE}

	hole: ROUTINE_HOLE;
			-- Hole caraterizing current

	build_format_bar is
			-- Build debugging buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);

			!!showroutclients_command.make (format_bar, text_window);
				format_bar.attach_top (showroutclients_command, 0);
				format_bar.attach_left_widget (showtext_command, showroutclients_command, 0);

			!!debug_run_command.make (format_bar, text_window);
				format_bar.attach_top (debug_run_command, 0);
				format_bar.attach_left_widget (showroutclients_command, debug_run_command, 50);

			!!step_command.make (format_bar, text_window);
				format_bar.attach_top (step_command, 0);
				format_bar.attach_left_widget (debug_run_command, step_command, 50);
			!!next_command.make (format_bar, text_window);
				format_bar.attach_top (next_command, 0);
				format_bar.attach_left_widget (step_command, next_command, 0);
			!!line_command.make (format_bar, text_window);
				format_bar.attach_top (line_command, 0);
				format_bar.attach_left_widget (next_command, line_command, 0);
			!!continue_command.make (format_bar, text_window);
				format_bar.attach_top (continue_command, 0);
				format_bar.attach_left_widget (line_command, continue_command, 0);
			!!debug_quit_command.make (format_bar, text_window);
				format_bar.attach_top (debug_quit_command, 0);
				format_bar.attach_left_widget (continue_command, debug_quit_command, 0);
			!!break_command.make (format_bar, text_window);
				format_bar.attach_top (break_command, 0);
				format_bar.attach_right (break_command, 0)
		end;

	debug_run_command: DEBUG_RUN;
	step_command: STEP;
	next_command: NEXT;
	line_command: TIL_LINE;
	continue_command: CONTINUE;
--	break_command: SET_BREAKPOINT;
	break_command: SHOW_BREAKPOINTS;	
	debug_quit_command: DEBUG_QUIT;
	showroutclients_command: SHOW_ROUTCLIENTS;

end
