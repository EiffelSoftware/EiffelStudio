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
			attach_all as default_attach_all,
			reset as old_reset, 
			close_windows as old_close_windows
		redefine
			text_window, build_format_bar, hole,
			tool_name, open_command, save_command,
			save_as_command, quit_command, editable,
			create_edit_buttons, set_default_size,
			build_widgets, resize_action,
			build_edit_bar
		end;
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole,
			tool_name, open_command, save_command,
			save_as_command, quit_command, editable,
			build_edit_bar, create_edit_buttons, reset,
			make, set_default_size, build_widgets, attach_all,
			close_windows, resize_action
		select
			reset, make, attach_all, close_windows
		end

creation

	make

feature 

	make (a_screen: SCREEN) is
			-- Create a class tool.
		do
			normal_create (a_screen);
			set_composite_attributes (Current)
		end;

	text_window: CLASS_TEXT;

	class_entered: STONE is
			-- Stone corresponding the name entered in
			-- the class text. (Void if can not find one). 
		do
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!

			--Result := class_name_tf.text.empty or else
						--Universe.class_stone (class_name_tf.text)
		end;

	reset is
			-- Reset the window contents
		do
			old_reset;
			change_class_command.clear
		end;

	close_windows is
			-- Close sub-windows.
		do
			old_close_windows;
			if change_class_command.choice.is_popped_up then
				change_class_command.choice.popdown
			end;
			if filter_command.filter_window.is_popped_up then
				filter_command.filter_window.popdown
			end
		end;

	save_new_class (c_name: STRING; f_name: STRING) is
			-- Create a class with class name `c_name' with
			-- file name `f_name'.
		do
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!
-- FIXME !!!!!!
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

	change_class_command: CHANGE_CLASS;
	change_class_form: FORM;

	update_class_name (s: STRING) is
		require
			valid_arg: s /= Void
		do
			s.to_upper;
			change_class_command.set_text (s);
		end;

feature

	build_widgets is
		do
			set_default_size;
			if tabs_disabled then
				!!text_window.make (new_name, global_form, Current);
			else
				!CLASS_TAB_TEXT!text_window.make (new_name, global_form, Current);
			end;
			!!edit_bar.make (new_name, global_form);
			build_bar;
			!!format_bar.make (new_name, global_form);
			build_format_bar;
			!!command_bar.make (new_name, global_form);
			build_command_bar;
			text_window.set_last_format (default_format);
			attach_all 
		end;

	attach_all is
		do
			default_attach_all;
			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_bottom_widget (format_bar, command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_right (format_bar, 0);
		end;

feature

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			shell_window: SHELL_W
		do
			shell_window := shell_command.shell_window;
			if shell_window.is_popped_up then
				shell_window.raise
			end
		end;
			
feature {NONE}

	editable: BOOLEAN is True;

	tool_name: STRING is do Result := l_Class end;

	hole: CLASS_HOLE;
			-- Hole caraterizing current

	set_default_size is
		do
			set_size (475, 500)
		end;

	open_command: OPEN_FILE;
	save_command: SAVE_FILE;
	save_as_command: SAVE_AS_FILE;
	quit_command: QUIT_FILE; 

	resize_action is 
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup;
			change_class_command.update_text;
			change_class_command.choice.update_position
		end;

	create_edit_buttons is
		do
			!!change_class_form.make (new_name, edit_bar);
			!!change_class_command.make (change_class_form, text_window);
			!!open_command.make (edit_bar, text_window);
			!!save_command.make (edit_bar, text_window);
			!!save_as_command.make (edit_bar, text_window);
			!!quit_command.make (edit_bar, text_window);
		end;

	command_bar: FORM;
			-- Bar with the command buttons

	build_command_bar is
		do
			!!shell_command.make (command_bar, text_window);
			command_bar.attach_left (shell_command, 0);
			command_bar.attach_bottom (shell_command, 10);
			!! filter_command.make (command_bar, text_window);
			command_bar.attach_left (filter_command, 0);
			command_bar.attach_right (filter_command, 0);
			command_bar.attach_bottom_widget (shell_command, filter_command, 0);
			!! current_target.make (command_bar, text_window);
			command_bar.attach_left (current_target, 0);
			command_bar.attach_bottom_widget (filter_command, current_target, 10);
			!! next_target.make (command_bar, text_window);
			command_bar.attach_left (next_target, 0);
			command_bar.attach_bottom_widget (current_target, next_target, 0);
			!! previous_target.make (command_bar, text_window);
			command_bar.attach_left (previous_target, 0);
			command_bar.attach_bottom_widget (next_target, previous_target, 0)
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
			!!showflat_command.make (format_bar, text_window);
			!!showflatshort_command.make (format_bar, text_window);
			!!showshort_command.make (format_bar, text_window);
			!!showclick_command.make (format_bar, text_window);
			!!showancestors_command.make (format_bar, text_window);
			!!showdescendants_command.make (format_bar, text_window);
			!!showclients_command.make (format_bar, text_window);
			!!showsuppliers_command.make (format_bar, text_window);
			!!showattributes_command.make (format_bar, text_window);
			!!showroutines_command.make (format_bar, text_window);
			!!showdeferreds_command.make (format_bar, text_window);
			!!showexternals_command.make (format_bar, text_window);
			!!showexported_command.make (format_bar, text_window);
			!!showonces_command.make (format_bar, text_window);
			--!!showcustom_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
				format_bar.attach_top (showflat_command, 0);
				format_bar.attach_left_widget (showtext_command, showclick_command, 0);
				format_bar.attach_top (showflatshort_command, 0);
				format_bar.attach_left_widget (showclick_command, showflat_command, 0);
				format_bar.attach_top (showshort_command, 0);
				format_bar.attach_left_widget (showflat_command, showshort_command, 0);
				format_bar.attach_top (showclick_command, 0);
				format_bar.attach_left_widget (showshort_command, showflatshort_command, 0);
				format_bar.attach_top (showancestors_command, 0);
				format_bar.attach_left_widget (showflatshort_command, showancestors_command, 15);
				format_bar.attach_top (showdescendants_command, 0);
				format_bar.attach_left_widget (showancestors_command, showdescendants_command, 0);
				format_bar.attach_top (showclients_command, 0);
				format_bar.attach_left_widget (showdescendants_command, showclients_command, 0);
				format_bar.attach_top (showsuppliers_command, 0);
				format_bar.attach_left_widget (showclients_command, showsuppliers_command, 0);
				format_bar.attach_top (showattributes_command, 0);
				format_bar.attach_right_widget (showroutines_command, showattributes_command, 0);
				format_bar.attach_top (showroutines_command, 0);
				format_bar.attach_right_widget (showdeferreds_command, showroutines_command, 0);
				format_bar.attach_top (showdeferreds_command, 0);
				format_bar.attach_right_widget (showonces_command, showdeferreds_command, 0);
				format_bar.attach_top (showonces_command, 0);
				format_bar.attach_right_widget (showexternals_command, showonces_command, 0);
				format_bar.attach_top (showexternals_command, 0);
				format_bar.attach_right_widget (showexported_command, showexternals_command, 0);
				format_bar.attach_top (showexported_command, 0);
				format_bar.attach_right (showexported_command, 0);
		end;
 
	format_label: LABEL;
	class_name_tf: TEXT_FIELD;

	build_edit_bar is
			-- Build top bar: editing commands
		do
			edit_bar.set_fraction_base (21);
			!!hole.make (edit_bar, Current);
			create_edit_buttons;
			!!type_teller.make (new_name, edit_bar);
			type_teller.set_center_alignment;
			clean_type
			!!search_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);

			edit_bar.attach_left (hole, 0);
			edit_bar.attach_top (hole, 0);
			edit_bar.attach_left_widget (hole, type_teller, 0);
			edit_bar.attach_top (type_teller, 0);
			edit_bar.attach_bottom (type_teller, 0);
			edit_bar.attach_right_position (type_teller, 7);
			change_class_form.attach_left (change_class_command, 0);
			change_class_form.attach_right (change_class_command, 0);
			change_class_form.attach_top (change_class_command, 0);
			change_class_form.attach_bottom (change_class_command, 0);
			edit_bar.attach_top (change_class_form, 0);
			edit_bar.attach_left_position (change_class_form, 7);
			edit_bar.attach_right_widget (open_command, change_class_form, 2);
			edit_bar.attach_right (quit_command, 0);
			edit_bar.attach_top (quit_command, 0);
			edit_bar.attach_top (change_font_command, 0);
			edit_bar.attach_right_widget (quit_command, change_font_command, 5);
			edit_bar.attach_top (search_command, 0);
			edit_bar.attach_right_widget (change_font_command, search_command, 0);
			edit_bar.attach_top (save_as_command, 0);
			edit_bar.attach_right_widget (search_command, save_as_command, 0);
			edit_bar.attach_top (save_command, 0);
			edit_bar.attach_right_widget (save_as_command, save_command, 0);
			edit_bar.attach_top (open_command, 0);
			edit_bar.attach_right_widget (save_command, open_command, 0)
		end;

	set_format_label (s: STRING) is
		require
			valid_arg: (s /= Void) and then not s.empty
		do
			format_label.set_text (s);
		end;

	shell_command: SHELL_COMMAND;
	current_target: CURRENT_CLASS;
	previous_target: PREVIOUS_TARGET;
	next_target: NEXT_TARGET;
	filter_command: FILTER_COMMAND

feature -- Formats

	showflat_command: SHOW_FLAT;
	showflatshort_command: SHOW_FS;
	showancestors_command: SHOW_ANCESTORS;
	showdescendants_command: SHOW_DESCENDANTS;
	showclients_command: SHOW_CLIENTS;
	showsuppliers_command: SHOW_SUPPLIERS;
	showattributes_command: SHOW_ATTRIBUTES;
	showroutines_command: SHOW_ROUTINES;
	showshort_command: SHOW_SHORT;
	showclick_command: SHOW_CLICK_CL;
	showdeferreds_command: SHOW_DEFERREDS;
	showexternals_command: SHOW_EXTERNALS;
	showonces_command: SHOW_ONCES;
	showexported_command: SHOW_EXPORTED;
	--showcustom_command: SHOW_CUSTOM

end -- class CLASS_W
