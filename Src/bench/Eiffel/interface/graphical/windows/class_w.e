--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Window describing an Eiffel class.

class CLASS_W 

inherit

	SHARED_WORKBENCH;
	BAR_AND_TEXT
		rename
			make as normal_create,
			build_edit_bar as old_build_edit_bar
		redefine
			text_window, build_format_bar, hole,
			tool_name, open_command, save_command,
			save_as_command, quit_command, editable,
			create_edit_buttons
		end;
	BAR_AND_TEXT
		rename
			make as normal_create
		redefine
			text_window, build_format_bar, hole,
			tool_name, open_command, save_command,
			save_as_command, quit_command, editable,
			build_edit_bar, create_edit_buttons
		select
			build_edit_bar
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

	class_entered: STONE is
			-- Stone corresponding the name entered in
			-- the class text. (Void if can not find one). 
		do
			--Result := class_name_tf.text.empty or else
						--Universe.class_stone (class_name_tf.text)
		end;

	save_new_class (c_name: STRING; f_name: STRING) is
			-- Create a class with class name `c_name' with
			-- file name `f_name'.
		do
			--!!new_file.make (f_name);
			--new_file.open_write;
			--new_file.putstring ("class ");
			--c_name.to_upper;
			--new_file.putstring (c_name);
			--new_file.putstring ("%N%Nfeature%N%Nend");
			--if not (to_write.item (to_write.count) = '%N') then
				-- Add a carriage return like vi if there's none at the end
				--new_file.putchar ('%N')
			--end;
			--new_file.close;
			--if text_window.file_name /= Void then
				---- Not a format shown
				--text_window.set_file_name (f_name);
			   	--text_window.set_changed (false);
			--end
		end;

feature {NONE}

	editable: BOOLEAN is True;

	tool_name: STRING is do Result := l_Class end;

	hole: CLASS_HOLE;
			-- Hole caraterizing current
			-- ha ha ha ha ha ha ha hahahaha ...

	open_command: OPEN_FILE;
	save_command: SAVE_FILE;
	save_as_command: SAVE_AS_FILE;
	quit_command: QUIT_FILE; 

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
			!!showflat_command.make (format_bar, text_window);
			!!showflatshort_command.make (format_bar, text_window);
			!!showancestors_command.make (format_bar, text_window);
			!!showdescendants_command.make (format_bar, text_window);
			!!showclients_command.make (format_bar, text_window);
			!!showsuppliers_command.make (format_bar, text_window);
			!!showattributes_command.make (format_bar, text_window);
			!!showroutines_command.make (format_bar, text_window);
			!!showdeferreds_command.make (format_bar, text_window);
			!!showexternals_command.make (format_bar, text_window);
			!!showonces_command.make (format_bar, text_window);
			--!!showcustom_command.make (format_bar, text_window);
			!!shell_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
				format_bar.attach_top (showflat_command, 0);
				format_bar.attach_left_widget (showtext_command, showflat_command, 0);
				format_bar.attach_top (showflatshort_command, 0);
				format_bar.attach_left_widget (showflat_command, showflatshort_command, 0);
				format_bar.attach_top (showancestors_command, 0);
				format_bar.attach_left_widget (showflatshort_command, showancestors_command, 15);
				format_bar.attach_top (showdescendants_command, 0);
				format_bar.attach_left_widget (showancestors_command, showdescendants_command, 0);
				format_bar.attach_top (showclients_command, 0);
				format_bar.attach_left_widget (showdescendants_command, showclients_command, 0);
				format_bar.attach_top (showsuppliers_command, 0);
				format_bar.attach_left_widget (showclients_command, showsuppliers_command, 0);
				format_bar.attach_top (showattributes_command, 0);
				format_bar.attach_right_widget (showroutines_command, showattributes_command, 15);
				format_bar.attach_top (showroutines_command, 0);
				format_bar.attach_right_widget (showdeferreds_command, showroutines_command, 0);
				format_bar.attach_top (showdeferreds_command, 0);
				format_bar.attach_right_widget (showonces_command, showdeferreds_command, 0);
				format_bar.attach_top (showonces_command, 0);
				format_bar.attach_right_widget (showexternals_command, showonces_command, 0);
				format_bar.attach_top (showexternals_command, 0);
				--format_bar.attach_right_widget (showcustom_command, showexternals_command, 15);
				format_bar.attach_right_widget (shell_command, showexternals_command, 15);
				--format_bar.attach_top (showcustom_command, 0);
				format_bar.attach_top (shell_command, 0);
				--format_bar.attach_right (showcustom_command, 0);
				format_bar.attach_right (shell_command, 0);
		end;
 
	format_label: LABEL;
	class_name_tf: TEXT_FIELD;

	build_edit_bar is
			-- Build top bar: editing commands
		local
			change_class_command: CHANGE_CLASS
		do
			old_build_edit_bar;
			--format_label.make ("Format", text_window);	
			--class_name_tf.make ("Class_name", text_window);	
			--change_class_command.make (Current);	
		end;

	set_format_label (s: STRING) is
		require
			valid_arg: (s /= Void) and then not s.empty
		do
			format_label.set_text (s);
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
	showexternals_command: SHOW_EXTERNALS;
	showonces_command: SHOW_ONCES;
	--showcustom_command: SHOW_CUSTOM
	shell_command: SHELL_COMMAND;

end -- class CLASS_W
