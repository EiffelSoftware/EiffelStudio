indexing

	description:	
		"Window describing an Eiffel class.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_W 

inherit

	BAR_AND_TEXT
		rename
			make as normal_create,
			attach_all as default_attach_all,
			reset as old_reset, 
			close_windows as old_close_windows
		redefine
			text_window, build_format_bar, hole,
			tool_name, open_cmd_holder, save_cmd_holder,
			save_as_cmd_holder, editable,
			create_edit_buttons, set_default_size,
			build_widgets, resize_action,
			build_edit_bar
		end;
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole,
			tool_name, open_cmd_holder, save_cmd_holder,
			save_as_cmd_holder, editable,
			build_edit_bar, create_edit_buttons, reset,
			make, set_default_size, build_widgets, attach_all,
			close_windows, resize_action
		select
			reset, make, attach_all, close_windows
		end

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a class tool.
		do
			normal_create (a_screen);
			set_composite_attributes (Current)
		end;

feature -- Window Properties

	text_window: CLASS_TEXT;

feature -- Update

	reset is
			-- Reset the window contents
		do
			old_reset;
			change_class_command.clear
		end;

	update_class_name (s: STRING) is
		require
			valid_arg: s /= Void
		do
			s.to_upper;
			change_class_command.set_text (s);
		end;

feature -- Window Settings

	close_windows is
			-- Close sub-windows.
		local
			fw: FILTER_W;
			fc: FILTER_COMMAND
		do
			old_close_windows;
			if change_class_command.choice.is_popped_up then
				change_class_command.choice.popdown
			end;
			fc ?= filter_cmd_holder.associated_command;
			fw ?= fc.filter_window;
			if fw.is_popped_up then
				fw.popdown
			end
		end;

feature -- Save (FIXME*******************)

	save_new_class (c_name: STRING; f_name: STRING) is
			-- Create a class with class name `c_name' with
			-- file name `f_name'.
		do
			--!! new_file.make (f_name);
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

feature -- Commands

	change_class_command: CHANGE_CLASS;

feature -- Forms And Holes

	change_class_form: FORM;

feature -- Formats

	showflat_command: SHOW_FLAT;

	showflatshort_command: SHOW_FS;

	showancestors_frmt_holder: FORMAT_HOLDER;

	showdescendants_frmt_holder: FORMAT_HOLDER;

	showclients_frmt_holder: FORMAT_HOLDER;

	showsuppliers_frmt_holder: FORMAT_HOLDER;

	showattributes_frmt_holder: FORMAT_HOLDER;

	showroutines_frmt_holder: FORMAT_HOLDER;

	showshort_command: SHOW_SHORT;

	showclick_command: SHOW_CLICK_CL;

	showdeferreds_frmt_holder: FORMAT_HOLDER;

	showexternals_frmt_holder: FORMAT_HOLDER;

	showonces_frmt_holder: FORMAT_HOLDER;

	showexported_frmt_holder: FORMAT_HOLDER;

	showcustom_frmt_holder: FORMAT_HOLDER;

feature -- Grahpical Interface

	build_widgets is
		do
			set_default_size;
			if tabs_disabled then
				!! text_window.make (new_name, global_form, Current);
			else
				!CLASS_TAB_TEXT! text_window.make (new_name, global_form, Current);
			end;
			!! edit_bar.make (new_name, global_form);
			build_bar;
			!! format_bar.make (new_name, global_form);
			build_format_bar;
			!! command_bar.make (new_name, global_form);
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

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			shell_window: SHELL_W
			shell_cmd: SHELL_COMMAND
		do
			shell_cmd ?= shell.associated_command;
			shell_window := shell_cmd.shell_window;
			if shell_window.is_popped_up then
				shell_window.raise
			end
		end;
			
feature {NONE} -- Properties; Window Properties

	editable: BOOLEAN is True;
			-- Is Current editable?

	tool_name: STRING is
			-- The name of this tool.
		do
			Result := l_Class
		end;

	hole: CLASS_HOLE;
			-- Hole caraterizing current
 
	format_label: LABEL;

	class_name_tf: TEXT_FIELD;

feature {NONE} -- Implemetation; Window Settings

	set_default_size is
			-- Set the size of Current to its default.
		do
			set_size (475, 500)
		end;

	set_format_label (s: STRING) is
			-- Set the format label to `s'.
		require
			valid_arg: (s /= Void) and then not s.empty
		do
			format_label.set_text (s);
		end;

	resize_action is 
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup;
			change_class_command.update_text;
			change_class_command.choice.update_position
		end;

feature {NONE} -- Commands

	open_cmd_holder: COMMAND_HOLDER;

	save_cmd_holder: COMMAND_HOLDER;

	save_as_cmd_holder: COMMAND_HOLDER;

	shell: COMMAND_HOLDER;

	current_target_cmd_holder: COMMAND_HOLDER;

	previous_target_cmd_holder: COMMAND_HOLDER;

	next_target_cmd_holder: COMMAND_HOLDER;

	filter_cmd_holder: COMMAND_HOLDER

feature {NONE} -- Forms And Holes

	command_bar: FORM;
			-- Bar with the command buttons

feature {NONE} -- Implementation; Graphical Interface

	create_edit_buttons is
		local
			quit_cmd: QUIT_FILE
			quit_button: EB_BUTTON
			change_font_cmd: CHANGE_FONT
			change_font_button: EB_BUTTON
			search_cmd: SEARCH_STRING
			search_button: EB_BUTTON
			open_cmd: OPEN_FILE;
			open_button: EB_BUTTON;
			save_cmd: SAVE_FILE;
			save_button: EB_BUTTON;
			save_as_cmd: SAVE_AS_FILE;
			save_as_button: EB_BUTTON;
		do
			!! change_class_form.make (new_name, edit_bar);
			!! change_class_command.make (change_class_form, text_window);
			!! open_cmd.make (text_window);
			!! open_button.make (open_cmd, edit_bar);
			!! open_cmd_holder.make (open_cmd, open_button);
			!! save_cmd.make (text_window);
			!! save_button.make (save_cmd, edit_bar);
			!! save_cmd_holder.make (save_cmd, save_button);
			!! save_as_cmd.make (text_window);
			!! save_as_button.make (save_as_cmd, edit_bar);
			!! save_as_cmd_holder.make (save_as_cmd, save_as_button);
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			!! quit.make (quit_cmd, quit_button);
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, edit_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button);
			!! search_cmd.make (edit_bar, text_window);
			!! search_button.make (search_cmd, edit_bar);
			!! search_cmd_holder.make (search_cmd, search_button);
		end;

	build_command_bar is
		local
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON;
			previous_target_cmd: PREVIOUS_TARGET;
			previous_target_button: EB_BUTTON
			next_target_cmd: NEXT_TARGET;
			next_target_button: EB_BUTTON
			current_target_cmd: CURRENT_CLASS;
			current_target_button: EB_BUTTON;
			filter_cmd: FILTER_COMMAND;
			filter_button: EB_BUTTON
		do
			!! shell_cmd.make (command_bar, text_window);
			!! shell_button.make (shell_cmd, command_bar);
			shell_button.add_button_click_action (3, shell_cmd, Void);
			!! shell.make (shell_cmd, shell_button);
			command_bar.attach_left (shell_button, 0);
			command_bar.attach_bottom (shell_button, 10);
			!! filter_cmd.make (command_bar, text_window);
			!! filter_button.make (filter_cmd, command_bar);
			filter_button.add_button_click_action (3, filter_cmd, Void);
			!! filter_cmd_holder.make (filter_cmd, filter_button);
			command_bar.attach_left (filter_button, 0);
			command_bar.attach_right (filter_button, 0);
			command_bar.attach_bottom_widget (shell_button, filter_button, 0);
			!! current_target_cmd.make (text_window);
			!! current_target_button.make (current_target_cmd, command_bar);
			!! current_target_cmd_holder.make (current_target_cmd, current_target_button);
			command_bar.attach_left (current_target_button, 0);
			command_bar.attach_bottom_widget (filter_button, current_target_button, 10);
			!! next_target_cmd.make (text_window);
			!! next_target_button.make (next_target_cmd, command_bar);
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button);
			command_bar.attach_left (next_target_button, 0);
			command_bar.attach_bottom_widget (current_target_button, next_target_button, 0);
			!! previous_target_cmd.make (text_window);
			!! previous_target_button.make (previous_target_cmd, command_bar);
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button);
			command_bar.attach_left (previous_target_button, 0);
			command_bar.attach_bottom_widget (next_target_button, previous_target_button, 0)
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			anc_cmd: SHOW_ANCESTORS;
			anc_button: EB_BUTTON;
			des_cmd: SHOW_DESCENDANTS;
			des_button: EB_BUTTON;
			cli_cmd: SHOW_CLIENTS;
			cli_button: EB_BUTTON;
			sup_cmd: SHOW_SUPPLIERS;
			sup_button: EB_BUTTON;
			att_cmd: SHOW_ATTRIBUTES;
			att_button: EB_BUTTON;
			rou_cmd: SHOW_ROUTINES;
			rou_button: EB_BUTTON;
			def_cmd: SHOW_DEFERREDS;
			def_button: EB_BUTTON;
			ext_cmd: SHOW_EXTERNALS;
			ext_button: EB_BUTTON;
			onc_cmd: SHOW_ONCES;
			onc_button: EB_BUTTON;
			exp_cmd: SHOW_EXPORTED;
			exp_button: EB_BUTTON;
			cus_cmd: SHOW_CUSTOM;
			cus_button: EB_BUTTON
		do
			!! showtext_command.make (format_bar, text_window);
			!! showflat_command.make (format_bar, text_window);
			!! showflatshort_command.make (format_bar, text_window);
			!! showshort_command.make (format_bar, text_window);
			!! showclick_command.make (format_bar, text_window);
			!! anc_cmd.make (text_window);
			!! anc_button.make (anc_cmd, format_bar);
			!! showancestors_frmt_holder.make (anc_cmd, anc_button);
			!! des_cmd.make (text_window);
			!! des_button.make (des_cmd, format_bar);
			!! showdescendants_frmt_holder.make (des_cmd, des_button);
			!! cli_cmd.make (text_window);
			!! cli_button.make (cli_cmd, format_bar);
			!! showclients_frmt_holder.make (cli_cmd, cli_button);
			!! sup_cmd.make (text_window);
			!! sup_button.make (sup_cmd, format_bar);
			!! showsuppliers_frmt_holder.make (sup_cmd, sup_button);
			!! att_cmd.make (text_window);
			!! att_button.make (att_cmd, format_bar);
			!! showattributes_frmt_holder.make (att_cmd, att_button);
			!! rou_cmd.make (text_window);
			!! rou_button.make (rou_cmd, format_bar);
			!! showroutines_frmt_holder.make (rou_cmd, rou_button);
			!! def_cmd.make (text_window);
			!! def_button.make (def_cmd, format_bar);
			!! showdeferreds_frmt_holder.make (def_cmd, def_button);
			!! ext_cmd.make (text_window);
			!! ext_button.make (ext_cmd, format_bar);
			!! showexternals_frmt_holder.make (ext_cmd, ext_button);
			!! exp_cmd.make (text_window);
			!! exp_button.make (exp_cmd, format_bar);
			!! showexported_frmt_holder.make (exp_cmd, exp_button);
			!! onc_cmd.make (text_window);
			!! onc_button.make (onc_cmd, format_bar);
			!! showonces_frmt_holder.make (onc_cmd, onc_button);
			!! cus_cmd.make (text_window);
			!! cus_button.make (cus_cmd, format_bar);
			cus_button.add_button_press_action (3, cus_cmd, cus_cmd);
			!! showcustom_frmt_holder.make (cus_cmd, cus_button);

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
			format_bar.attach_top (anc_button, 0);
			format_bar.attach_left_widget (showflatshort_command, anc_button, 15);
			format_bar.attach_top (des_button, 0);
			format_bar.attach_left_widget (anc_button, des_button, 0);
			format_bar.attach_top (cli_button, 0);
			format_bar.attach_left_widget (des_button, cli_button, 0);
			format_bar.attach_top (sup_button, 0);
			format_bar.attach_left_widget (cli_button, sup_button, 0);
			format_bar.attach_top (att_button, 0);
			format_bar.attach_right_widget (rou_button, att_button, 0);
			format_bar.attach_top (rou_button, 0);
			format_bar.attach_right_widget (def_button, rou_button, 0);
			format_bar.attach_top (def_button, 0);
			format_bar.attach_right_widget (onc_button, def_button, 0);
			format_bar.attach_top (onc_button, 0);
			format_bar.attach_right_widget (ext_button, onc_button, 0);
			format_bar.attach_top (ext_button, 0);
			format_bar.attach_right_widget (exp_button, ext_button, 0);
			format_bar.attach_right_widget (cus_button, exp_button, 0);
			format_bar.attach_top (cus_button, 0);
			format_bar.attach_right (cus_button, 0);
		end;

	build_edit_bar is
			-- Build top bar: editing commands
		do
			edit_bar.set_fraction_base (21);
			!! hole.make (edit_bar, Current);
			create_edit_buttons;

			edit_bar.attach_left (hole, 0);
			edit_bar.attach_top (hole, 0);

			change_class_form.attach_left (change_class_command, 0);
			change_class_form.attach_right (change_class_command, 0);
			change_class_form.attach_top (change_class_command, 0);
			change_class_form.attach_bottom (change_class_command, 0);

			edit_bar.attach_top (change_class_form, 0);
			edit_bar.attach_left_position (change_class_form, 7);
			edit_bar.attach_right_widget (open_cmd_holder.associated_button, change_class_form, 2);
			edit_bar.attach_right (quit.associated_button, 0);
			edit_bar.attach_top (quit.associated_button, 0);
			edit_bar.attach_top (change_font_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (quit.associated_button, change_font_cmd_holder.associated_button, 5);
			edit_bar.attach_top (search_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (change_font_cmd_holder.associated_button, search_cmd_holder.associated_button, 0);
			edit_bar.attach_top (save_as_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (search_cmd_holder.associated_button, save_as_cmd_holder.associated_button, 0);
			edit_bar.attach_top (save_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (save_as_cmd_holder.associated_button, save_cmd_holder.associated_button, 0);
			edit_bar.attach_top (open_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (save_cmd_holder.associated_button, open_cmd_holder.associated_button, 0)
		end;

end -- class CLASS_W
