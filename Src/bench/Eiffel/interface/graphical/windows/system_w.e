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
	BAR_AND_TEXT
		redefine
			hole, build_format_bar,
			open_command, save_as_command, quit_command,
			text_window
		end

creation

	make

feature {NONE}

	tool_name: STRING is do Result := l_System end;

feature 

	text_window: SYSTEM_TEXT;

	
feature {NONE}

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
			!!showlist_command.make (format_bar, text_window);
				format_bar.attach_top (showlist_command, 0);
				format_bar.attach_left_widget (showtext_command, showlist_command, 0);
		end;

	hole: SYSTEM_HOLE;
			-- Hole caraterizing current

	open_command: OPEN_SYSTEM;
	save_as_command: SAVE_AS_SYSTEM;
--	check_command: CHECK_SYSTEM;
	quit_command: QUIT_SYSTEM;
	showlist_command: SHOW_CLUSTERS

end
