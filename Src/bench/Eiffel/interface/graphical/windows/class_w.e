--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Window describing an Eiffel class.

class CLASS_W 

inherit

	BAR_AND_TEXT
		rename
			_make as normal_create
		redefine
			text_window, build_format_bar, hole
		end

creation

	make

feature 

	make (a_screen: SCREEN) is
			-- Create a class tool.
		do
			normal_create (a_screen)
		end;

	text_window: CLASS_TEXT;

feature {NONE}

	tool_name: STRING is do Result := l_Class end;

	hole: CLASS_HOLE;
			-- Hole caraterizing current
			-- ha ha ha ha ha ha ha hahahaha ...

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
			!!showflat_command.make (format_bar, text_window);
			!!showflatshort_command.make (format_bar, text_window);
			!!showancestors_command.make (format_bar, text_window);
			!!showdescendants_command.make (format_bar, text_window);
			!!showclients_command.make (format_bar, text_window);
			!!showsuppliers_command.make (format_bar, text_window);
			!!showattributes_command.make (format_bar, text_window);
			!!showroutines_command.make (format_bar, text_window);
			!!showdeferreds_command.make (format_bar, text_window);
			!!showonces_command.make (format_bar, text_window);
			!!showcustom_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
				format_bar.attach_top (showflat_command, 0);
				format_bar.attach_left_widget (showtext_command, showflat_command, 0);
				format_bar.attach_top (showflatshort_command, 0);
				format_bar.attach_left_widget (showflat_command, showflatshort_command, 0);
				format_bar.attach_top (showancestors_command, 0);
				format_bar.attach_left_widget (showflatshort_command, showancestors_command, 25);
				format_bar.attach_top (showdescendants_command, 0);
				format_bar.attach_left_widget (showancestors_command, showdescendants_command, 0);
				format_bar.attach_top (showclients_command, 0);
				format_bar.attach_left_widget (showdescendants_command, showclients_command, 0);
				format_bar.attach_top (showsuppliers_command, 0);
				format_bar.attach_left_widget (showclients_command, showsuppliers_command, 0);
				format_bar.attach_top (showattributes_command, 0);
				format_bar.attach_right_widget (showroutines_command, showattributes_command, 25);
				format_bar.attach_top (showroutines_command, 0);
				format_bar.attach_right_widget (showdeferreds_command, showroutines_command, 0);
				format_bar.attach_top (showdeferreds_command, 0);
				format_bar.attach_right_widget (showonces_command, showdeferreds_command, 0);
				format_bar.attach_top (showonces_command, 0);
				format_bar.attach_right_widget (showcustom_command, showonces_command, 25);
				format_bar.attach_top (showcustom_command, 0);
				format_bar.attach_right (showcustom_command, 0);
		end;

	showflat_command: SHOW_FLAT;
	showflatshort_command: SHOW_FS;
	showancestors_command: SHOW_ANCESTORS;
	showdescendants_command: SHOW_DESCENDANTS;
	showclients_command: SHOW_CLIENTS;
	showsuppliers_command: SHOW_SUPPLIERS;
	showattributes_command: SHOW_ATTRIBUTES;
	showroutines_command: SHOW_ROUTINES;
	showdeferreds_command: SHOW_DEFERREDS;
	showonces_command: SHOW_ONCES;
	showcustom_command: SHOW_CUSTOM

end -- class CLASS_W
