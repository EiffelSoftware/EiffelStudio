--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Window describing the assembly of an Eiffel system (Ace, universe, ...)

class SYSTEM_W 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	BAR_AND_TEXT
		redefine
			hole, build_format_bar,
			open_command, save_as_command, quit_command, save_command,
			text_window, tool_name, editable, create_edit_buttons
		end

creation

	make

feature {NONE}

	tool_name: STRING is do Result := l_System end;

	editable:BOOLEAN is True;
		-- System window is editable

feature 

	text_window: SYSTEM_TEXT;

	display is
		do
			if not realized then
				set_default_format;
				realize
			elseif not shown then
				set_default_format;
				set_default_position;
				show
			end;
			raise;
		end;
	
feature {NONE}
	
	create_edit_buttons is
		do
			!!open_command.make (edit_bar, text_window);
			!!save_command.make (edit_bar, text_window);
			!!save_as_command.make (edit_bar, text_window);
			!!quit_command.make (edit_bar, text_window);
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
			!!showlist_command.make (format_bar, text_window);
				format_bar.attach_top (showlist_command, 0);
				format_bar.attach_left_widget (showtext_command, showlist_command, 0);
			!!showmodified_command.make (format_bar, text_window);
				format_bar.attach_top (showmodified_command, 0);
				format_bar.attach_left_widget (showlist_command, showmodified_command, 0);
			!!showindexing_command.make (format_bar, text_window);
				format_bar.attach_top (showindexing_command, 0);
				format_bar.attach_left_widget (showmodified_command, showindexing_command, 0);
			!!shell_command.make (format_bar, text_window);
				format_bar.attach_top (shell_command, 0);
				format_bar.attach_right (shell_command, 0);
		end;

	hole: SYSTEM_HOLE;
			-- Hole caraterizing current

	open_command: OPEN_SYSTEM;
	save_command: SAVE_SYSTEM;
	save_as_command: SAVE_AS_SYSTEM;
--	check_command: CHECK_SYSTEM;
	quit_command: QUIT_SYSTEM;
	showlist_command: SHOW_CLUSTERS;
	showmodified_command: SHOW_MODIFIED;
	showindexing_command: SHOW_INDEXING;
	shell_command: SHELL_COMMAND

end
