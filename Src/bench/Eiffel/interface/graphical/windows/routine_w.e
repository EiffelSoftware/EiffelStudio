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
			hole, build_format_bar, text_window,
			build_edit_bar, tool_name
		end

creation

	make
	
feature 

	text_window: ROUTINE_TEXT;

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
			text_window.set_read_only
		end;

feature {NONE}

	tool_name: STRING is do Result := l_Routine end;

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

			!!showpast_command.make (format_bar, text_window);
				format_bar.attach_top (showpast_command, 0);
				format_bar.attach_left_widget (showroutclients_command, showpast_command, 0);

			!!showfuture_command.make (format_bar, text_window);
				format_bar.attach_top (showfuture_command, 0);
				format_bar.attach_left_widget (showpast_command, showfuture_command, 0);

			!!debug_run_command.make (format_bar, text_window);
				format_bar.attach_top (debug_run_command, 0);
				format_bar.attach_left_widget (showroutclients_command, debug_run_command, 50);

--			!!step_command.make (format_bar, text_window);
--				format_bar.attach_top (step_command, 0);
--				format_bar.attach_left_widget (debug_run_command, step_command, 50);
--			!!next_command.make (format_bar, text_window);
--				format_bar.attach_top (next_command, 0);
--				format_bar.attach_left_widget (step_command, next_command, 0);
			!!debug_showbreak.make (format_bar, text_window);
				format_bar.attach_top (debug_showbreak, 0);
				format_bar.attach_left_widget (debug_run_command, debug_showbreak, 0);
--			!!line_command.make (format_bar, text_window);
--				format_bar.attach_top (line_command, 0);
--				format_bar.attach_left_widget (debug_run_command, line_command, 0);
--				format_bar.attach_left_widget (next_command, line_command, 0);
--			!!continue_command.make (format_bar, text_window);
--				format_bar.attach_top (continue_command, 0);
--				format_bar.attach_left_widget (line_command, continue_command, 0);

			!!debug_quit_command.make (format_bar, text_window);
				format_bar.attach_top (debug_quit_command, 0);
				format_bar.attach_left_widget (debug_showbreak, debug_quit_command, 0);
			!!break_command.make (format_bar, text_window);
				format_bar.attach_top (break_command, 0);
				format_bar.attach_right (break_command, 0);
		end;

	build_edit_bar is
			-- Build top bar: editing commands.
		do
				!!hole.make (edit_bar, Current);
				!!type_teller.make (new_name, edit_bar);
				type_teller.set_center_alignment;
				!!search_command.make (edit_bar, text_window);
				!!change_font_command.make (edit_bar, text_window);
				!!quit_command.make (edit_bar, text_window);
					edit_bar.attach_left (hole, 0);
					edit_bar.attach_top (hole, 0);
					clean_type;
					edit_bar.attach_left_widget (hole, type_teller, 0);
					edit_bar.attach_top (type_teller, 0);
					edit_bar.attach_right_widget (search_command, type_teller, 0);
					edit_bar.attach_bottom (type_teller, 0);
					edit_bar.attach_top (search_command, 0);
					edit_bar.attach_right_widget (change_font_command, search_command, 25);
					edit_bar.attach_top (change_font_command, 0);
					edit_bar.attach_right_widget (quit_command, change_font_command, 25);
					edit_bar.attach_top (quit_command, 0);
					edit_bar.attach_right (quit_command, 0);
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

end
