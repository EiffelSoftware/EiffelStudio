indexing

	description:	
		"Window describing an Eiffel routine.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_W 

inherit

	BAR_AND_TEXT
		rename
			reset as old_reset,
			make_shell as bar_and_text_make_shell
		redefine
			hole, hole_button, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, set_default_size, attach_all,
			resize_action, stone, stone_type,
			set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible,
			close
		end

	BAR_AND_TEXT
		redefine
			hole, hole_button, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, attach_all, reset,
			set_default_size, resize_action,
			stone, stone_type, set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible,
			make_shell, close
		select
			reset, make_shell
		end

creation

	make_shell, form_create

feature -- Initialization

	make_shell (a_shell: EB_SHELL) is
			-- Create a feature tool
		do
			show_menus := True;
			bar_and_text_make_shell (a_shell);
			text_window.set_read_only
		end;

	form_create (a_form: FORM) is
			-- Create a feature tool from a form.
		do
			show_menus := False;
			make_form (a_form)
		end;

feature -- Window Properties

	text_window: ROUTINE_TEXT;

	stone: FEATURE_STONE
			-- Stone in tool

	stone_type: INTEGER is
			-- Accept feature type stone
		do
			Result := Routine_type
		end

feature -- Resetting

	reset is
			-- Reset the window contents
		do
			old_reset;
			-- class_hole.set_empty_symbol;
			change_class_command.clear;
			change_routine_command.clear;
		end;

	close is
			-- Close Current.
		do
			if is_a_shell then
				hide;
				reset
			else
				Project_tool.display_feature_cmd_holder.associated_command.work (Void)
			end
		end;

feature -- Access

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = Routine_type or else
				a_stone.stone_type = Breakable_type or else
				a_stone.stone_type = Class_type
		end;

	close_windows is
			-- Pop down the associated windows.
		local
			cf: CHANGE_FONT;
			ss: SEARCH_STRING
		do
	   		ss ?= search_cmd_holder.associated_command;
			ss.close;
			cf ?= change_font_cmd_holder.associated_command;
			cf.close;
			if change_routine_command.choice.is_popped_up then
				change_routine_command.choice.popdown
			end;
			if change_class_command.choice.is_popped_up then
				change_class_command.choice.popdown
			end
	   	 end;

feature {TEXT_WINDOW} -- Update

	set_stone (s: like stone) is
			-- Update stone from `s'.
		do
			stone := s;
			if s = Void then
				set_icon_name (tool_name)
			else
				update_edit_bar;
				set_icon_name (s.icon_name);
				hole.set_full_symbol;
				class_hole.set_full_symbol
			end
		end;

feature -- Stone updating

	process_feature (a_stone: FEATURE_STONE) is
		do
			text_window.last_format.execute (a_stone);
			history.extend (a_stone);
			update_edit_bar
		end;

	process_breakable (a_stone: BREAKABLE_STONE) is
		do
			stop_hole.receive (a_stone)
		end;

	process_class (a_stone: CLASSC_STONE) is
		local
			c: E_CLASS;
			ris: ROUT_ID_SET;
			i: INTEGER;
			rout_id: ROUTINE_ID;
			fi: E_FEATURE;
			fs: FEATURE_STONE;
			text: STRUCTURED_TEXT;
			s: STRING
		do
			ris := stone.e_feature.rout_id_set;
			c := a_stone.e_class;
			from
				i := 1
			until
				i > ris.count
			loop
				rout_id := ris.item (i);
				fi := c.feature_with_rout_id (rout_id);
				if (fi /= Void) then
					i := ris.count
				end
				i := i + 1
			end
			if (fi /= Void) then
				!! fs.make (fi, a_stone.e_class);
				process_feature (fs);
			else
				error_window.clear_window;
				!! text.make;
				text.add_string ("No version of feature ");
				text.add_feature (stone.e_feature, stone.e_feature.written_class, stone.e_feature.name);
				text.add_string ("%N   for class ");
				s := c.name_in_upper;
				text.add_classi (stone.e_feature.written_class.lace_class, s);
				error_window.process_text (text);
				error_window.display;
				project_tool.raise;
			end;
		end;
	
feature -- Graphical Interface

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone;
			if stone = Void then
				-- class_hole.set_empty_symbol;
				change_class_command.clear;
				change_routine_command.clear
			else
				update_edit_bar
			end
		end;

	update_edit_bar is
			-- Updates the edit bar.
		local
			f_name: STRING
		do
			if stone /= Void then
				change_class_command.update_class_name (stone.e_class.name);
				change_routine_command.set_text (stone.e_feature.name);
			end
		end; 
	
	build_widgets is
			-- Build the widgets for this window.
		do
			if is_a_shell then
				set_default_size
			end;
			if tabs_disabled then
				!! text_window.make (new_name, Current, Current)
			else
				!ROUTINE_TAB_TEXT! text_window.make (new_name, Current, Current)
			end;
			if show_menus then
				build_menus
			end;
			!! edit_bar.make (new_name, global_form);
			build_bar;
			!! format_bar.make (new_name, global_form);
			build_format_bar;
			!! command_bar.make (new_name, global_form);
			build_command_bar;
			if show_menus then
				fill_menus
			end;
			text_window.set_last_format (default_format);
			attach_all	
		end;

	attach_all is
			-- Attach all widgets.
		do
			if show_menus then
				global_form.attach_left (menu_bar, 0);
				global_form.attach_right (menu_bar, 0);
				global_form.attach_top (menu_bar, 0)
			end;

			global_form.attach_left (edit_bar, 0);
			global_form.attach_right (edit_bar, 0);
			if show_menus then
				global_form.attach_top_widget (menu_bar, edit_bar, 0)
			else
				global_form.attach_top (edit_bar, 0)
			end

			global_form.attach_left (text_window, 0);
			global_form.attach_right (text_window, 0);
			global_form.attach_bottom_widget (format_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, text_window, 0);

			global_form.attach_left (format_bar, 0);
			global_form.attach_right (format_bar, 0);
			global_form.attach_bottom (format_bar, 0);

			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
		end

feature {ROUTINE_TEXT} -- Forms And Holes

	change_class_form: FORM;

	change_routine_form: FORM;

	hole: ROUTINE_CMD;
			-- Hole charaterizing Current.

	hole_button: ROUTINE_HOLE;
			-- Hole characterizing Current.

	class_hole: ROUT_CLASS_CMD;
			-- Hole for version of routine for a particular class.

	stop_hole: DEBUG_STOPIN_CMD;
			-- To set breakpoints

feature {ROUTINE_TEXT, PROJECT_W} -- Formats

	showroutclients_frmt_holder: FORMAT_HOLDER;

	showhomonyms_frmt_holder: FORMAT_HOLDER;

	showpast_frmt_holder: FORMAT_HOLDER;

	showhistory_frmt_holder: FORMAT_HOLDER;

	showfuture_frmt_holder: FORMAT_HOLDER;

	showflat_frmt_holder: FORMAT_HOLDER;

feature -- Commands

	showstop_frmt_holder: FORMAT_HOLDER;

	shell: COMMAND_HOLDER;

	current_target_cmd_holder: COMMAND_HOLDER;

	previous_target_cmd_holder: COMMAND_HOLDER;

	next_target_cmd_holder: COMMAND_HOLDER;

	change_routine_command: CHANGE_ROUTINE;

	change_class_command: CHANGE_CL_ROUT;

feature {NONE} -- Implementation; Window Settings

	resize_action is
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup;
			change_class_command.update_text;
			change_routine_command.update_text;
			change_class_command.choice.update_position;
			change_routine_command.choice.update_position
		end;

	set_default_size is
			-- Set the size of Current to its default.
		do
			eb_shell.set_size (650, 450)
		end;

feature {NONE} -- Implementation; Graphical Interface

	build_command_bar is
			-- Build the command bar.
		local
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON;
			shell_menu_entry: EB_MENU_ENTRY;
			previous_target_cmd: PREVIOUS_TARGET;
			previous_target_button: EB_BUTTON;
			previous_target_menu_entry: EB_MENU_ENTRY;
			next_target_cmd: NEXT_TARGET;
			next_target_button: EB_BUTTON;
			next_target_menu_entry: EB_MENU_ENTRY;
			current_target_cmd: CURRENT_ROUTINE;
			current_target_button: EB_BUTTON;
			current_target_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR;
			history_list_cmd: ROUTINE_HISTORY
		do
			!! shell_cmd.make (command_bar, text_window);
			!! shell_button.make (shell_cmd, command_bar);
			shell_button.add_button_click_action (3, shell_cmd, Void);
			if show_menus then
				!! shell_menu_entry.make (shell_cmd, special_menu);
				!! shell.make (shell_cmd, shell_button, shell_menu_entry);
			else
				!! shell.make_plain (shell_cmd);
				shell.set_button (shell_button);
			end;
			!! current_target_cmd.make (text_window);
			!! current_target_button.make (current_target_cmd, command_bar);
			if show_menus then
				!! sep.make (new_name, special_menu);
				!! current_target_menu_entry.make (current_target_cmd, special_menu);
				!! current_target_cmd_holder.make (current_target_cmd, current_target_button, current_target_menu_entry)
			else
				!! current_target_cmd_holder.make_plain (current_target_cmd);
				current_target_cmd_holder.set_button (current_target_button)
			end;
			!! next_target_cmd.make (text_window);
			!! next_target_button.make (next_target_cmd, command_bar);
			if show_menus then
				!! next_target_menu_entry.make (next_target_cmd, special_menu);
				!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry)
			else
				!! next_target_cmd_holder.make_plain (next_target_cmd);
				next_target_cmd_holder.set_button (next_target_button)
			end;
			!! previous_target_cmd.make (text_window);
			!! previous_target_button.make (previous_target_cmd, command_bar);
			if show_menus then
				!! previous_target_menu_entry.make (previous_target_cmd, special_menu);
				!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry)
			else
				!! previous_target_cmd_holder.make_plain (previous_target_cmd);
				previous_target_cmd_holder.set_button (previous_target_button)
			end;

			!! history_list_cmd.make (text_window);
			next_target_button.add_button_click_action (3, history_list_cmd, next_target_button);
			previous_target_button.add_button_click_action (3, history_list_cmd, previous_target_button);

			command_bar.attach_left (shell_button, 0);
			command_bar.attach_bottom (shell_button, 0);
			command_bar.attach_left (current_target_button, 0);
			command_bar.attach_bottom_widget (shell_button, current_target_button, 10);
			command_bar.attach_left (next_target_button, 0);
			command_bar.attach_bottom_widget (current_target_button, next_target_button, 0);
			command_bar.attach_left (previous_target_button, 0);
			command_bar.attach_bottom_widget (next_target_button, previous_target_button, 0);
		end;

	build_format_bar is
			-- Build the format bar.
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS;
			rout_cli_button: EB_BUTTON;
			rout_cli_menu_entry: EB_TICKABLE_MENU_ENTRY;
			rout_hist_cmd: SHOW_ROUT_HIST;
			rout_hist_button: EB_BUTTON;
			rout_hist_menu_entry: EB_TICKABLE_MENU_ENTRY;
			past_cmd: SHOW_PAST;
			past_button: EB_BUTTON;
			past_menu_entry: EB_TICKABLE_MENU_ENTRY;
			rout_flat_cmd: SHOW_ROUT_FLAT;
			rout_flat_button: EB_BUTTON;
			rout_flat_menu_entry: EB_TICKABLE_MENU_ENTRY;
			future_cmd: SHOW_FUTURE;
			future_button: EB_BUTTON;
			future_menu_entry: EB_TICKABLE_MENU_ENTRY;
			stop_cmd: SHOW_BREAKPOINTS;
			stop_button: EB_BUTTON;
			stop_menu_entry: EB_TICKABLE_MENU_ENTRY;
			text_cmd: SHOW_TEXT;
			text_button: EB_BUTTON;
			text_menu_entry: EB_TICKABLE_MENU_ENTRY;
			homonym_cmd: SHOW_HOMONYMS;
			homonym_button: EB_BUTTON;
			homonym_menu_entry: EB_TICKABLE_MENU_ENTRY;
			sep: SEPARATOR
		do
				-- First we create all needed objects.
			!! text_cmd.make (text_window);
			!! text_button.make (text_cmd, format_bar);
			if show_menus then
				!! text_menu_entry.make (text_cmd, format_menu);
				!! showtext_frmt_holder.make (text_cmd, text_button, text_menu_entry)
			else
				!! showtext_frmt_holder.make_plain (text_cmd);
				showtext_frmt_holder.set_button (text_button)
			end;
			!! rout_flat_cmd.make (text_window);
			!! rout_flat_button.make (rout_flat_cmd, format_bar);
			if show_menus then
				!! rout_flat_menu_entry.make (rout_flat_cmd, format_menu);
				!! showflat_frmt_holder.make (rout_flat_cmd, rout_flat_button, rout_flat_menu_entry)
			else
				!! showflat_frmt_holder.make_plain (rout_flat_cmd);
				showflat_frmt_holder.set_button (rout_flat_button)
			end;
			!! rout_cli_cmd.make (text_window);
			!! rout_cli_button.make (rout_cli_cmd, format_bar);
			if show_menus then
				!! sep.make (new_name, format_menu);
				!! rout_cli_menu_entry.make (rout_cli_cmd, format_menu);
				!! showroutclients_frmt_holder.make (rout_cli_cmd, rout_cli_button, rout_cli_menu_entry)
			else
				!! showroutclients_frmt_holder.make_plain (rout_cli_cmd);
				showroutclients_frmt_holder.set_button (rout_cli_button)
			end;
			!! rout_hist_cmd.make (text_window);
			!! rout_hist_button.make (rout_hist_cmd, format_bar);
			if show_menus then
				!! rout_hist_menu_entry.make (rout_hist_cmd, format_menu);
				!! showhistory_frmt_holder.make (rout_hist_cmd, rout_hist_button, rout_hist_menu_entry)
			else
				!! showhistory_frmt_holder.make_plain (rout_hist_cmd);
				showhistory_frmt_holder.set_button (rout_hist_button)
			end;
			!! past_cmd.make (text_window);
			!! past_button.make (past_cmd, format_bar);
			if show_menus then
				!! past_menu_entry.make (past_cmd, format_menu);
				!! showpast_frmt_holder.make (past_cmd, past_button, past_menu_entry)
			else
				!! showpast_frmt_holder.make_plain (past_cmd);
				showpast_frmt_holder.set_button (past_button)
			end;
			!! future_cmd.make (text_window);
			!! future_button.make (future_cmd, format_bar);
			if show_menus then
				!! future_menu_entry.make (future_cmd, format_menu);
				!! showfuture_frmt_holder.make (future_cmd, future_button, future_menu_entry)
			else
				!! showfuture_frmt_holder.make_plain (future_cmd);
				showfuture_frmt_holder.set_button (future_button)
			end;
			!! homonym_cmd.make (text_window);
			!! homonym_button.make (homonym_cmd, format_bar);
			if show_menus then
				!! homonym_menu_entry.make (homonym_cmd, format_menu);
				!! showhomonyms_frmt_holder.make (homonym_cmd, homonym_button, homonym_menu_entry)
			else
				!! showhomonyms_frmt_holder.make_plain (homonym_cmd);
				showhomonyms_frmt_holder.set_button (homonym_button)
			end;
			!! stop_cmd.make (text_window);
			!! stop_button.make (stop_cmd, format_bar);
			if show_menus then
				!! sep.make (new_name, format_menu);
				!! stop_menu_entry.make (stop_cmd, format_menu);
				!! showstop_frmt_holder.make (stop_cmd, stop_button, stop_menu_entry)
			else
				!! showstop_frmt_holder.make_plain (stop_cmd);
				showstop_frmt_holder.set_button (stop_button)
			end;

				-- Now we do all attachments. This is done here because of speed.
			format_bar.attach_top (text_button, 0);
			format_bar.attach_left (text_button, 0);
			format_bar.attach_top (rout_flat_button, 0);
			format_bar.attach_left_widget (text_button, rout_flat_button, 0);
			format_bar.attach_top (rout_cli_button, 0);
			format_bar.attach_left_widget (rout_flat_button, rout_cli_button, 10);
			format_bar.attach_top (rout_hist_button, 0);
			format_bar.attach_left_widget (rout_cli_button, rout_hist_button, 0);
			format_bar.attach_top (past_button, 0);
			format_bar.attach_left_widget (rout_hist_button, past_button, 0);
			format_bar.attach_top (future_button, 0);
			format_bar.attach_left_widget (past_button, future_button, 0);
			format_bar.attach_top (homonym_button, 0);
			format_bar.attach_left_widget (future_button, homonym_button, 0);
			format_bar.attach_top (stop_button, 0);
			format_bar.attach_left_widget (homonym_button, stop_button, 10);
		end;

	build_bar is
			-- Build top bar: editing commands.
		local
			hole_form: FORM;
			label: LABEL;
			quit_cmd: QUIT_FILE;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			exit_menu_entry: EB_MENU_ENTRY;
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON;
			change_font_menu_entry: EB_MENU_ENTRY;
			search_cmd: SEARCH_STRING;
			search_button: EB_BUTTON;
			search_menu_entry: EB_MENU_ENTRY;
			class_hole_button: ROUT_CLASS_HOLE;
			class_hole_holder: HOLE_HOLDER;
			stop_hole_button: DEBUG_STOPIN;
			stop_hole_holder: HOLE_HOLDER
		do
			edit_bar.set_fraction_base (31);

				-- First we create the needed objects.
			!! hole_form.make (new_name, edit_bar);
			!! hole.make (text_window);
			!! hole_button.make (hole, hole_form);
			!! hole_holder.make_plain (hole);
			hole_holder.set_button (hole_button);
			!! class_hole.make (text_window);
			!! class_hole_button.make (class_hole, hole_form);
			!! class_hole_holder.make_plain (class_hole);
			class_hole_holder.set_button (class_hole_button);
			!! stop_hole.make (text_window);
			!! stop_hole_button.make (stop_hole, hole_form);
			!! stop_hole_holder.make_plain (stop_hole);
			stop_hole_holder.set_button (stop_hole_button);
			!! change_routine_form.make (new_name, edit_bar);
			!! change_routine_command.make (change_routine_form, text_window);
			!! label.make ("", edit_bar);
			!! change_class_form.make (new_name, edit_bar);
			!! change_class_command.make (change_class_form, text_window);
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			if show_menus then
				!! quit_menu_entry.make (quit_cmd, file_menu);
				!! quit.make (quit_cmd, quit_button, quit_menu_entry)
			else
				!! quit.make_plain (quit_cmd);
				quit.set_button (quit_button)
			end
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command);
			if show_menus then
				!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu);
				exit_cmd_holder.set_menu_entry (exit_menu_entry)
			end;
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, edit_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			if show_menus then
				!! change_font_menu_entry.make (change_font_cmd, preference_menu);
				!! change_font_cmd_holder.make (change_font_cmd, change_font_button, change_font_menu_entry)
			else
				!! change_font_cmd_holder.make_plain (change_font_cmd);
				change_font_cmd_holder.set_button (change_font_button)
			end;
			!! search_cmd.make (edit_bar, text_window);
			!! search_button.make (search_cmd, edit_bar);
			if show_menus then
				!! search_menu_entry.make (search_cmd, edit_menu);
				!! search_cmd_holder.make (search_cmd, search_button, search_menu_entry)
			else
				!! search_cmd_holder.make_plain (search_cmd);
				search_cmd_holder.set_button (search_button)
			end;

				-- Now we do all the attachments. This is done here for speed.
			edit_bar.attach_left (hole_form, 0);
			edit_bar.attach_top (hole_form, 0);
			edit_bar.attach_bottom (hole_form, 0);
			hole_form.attach_left (hole_button, 0);
			hole_form.attach_top (hole_button, 0);
			hole_form.attach_left_widget (hole_button, class_hole_button, 0);
			hole_form.attach_top (class_hole_button, 0);
			hole_form.attach_left_widget (class_hole_button, stop_hole_button, 0);
			hole_form.attach_top (stop_hole_button, 0);
			edit_bar.attach_left_position (change_routine_form, 11);
			edit_bar.attach_top (change_routine_form, 0);
			edit_bar.attach_bottom (change_routine_form, 0);
			edit_bar.attach_right_position (change_routine_form, 17);
			change_routine_command.set_width (80);
			change_routine_form.attach_left (change_routine_command, 0);
			change_routine_form.attach_top (change_routine_command, 0);
			change_routine_form.attach_bottom (change_routine_command, 0);
			change_routine_form.attach_right (change_routine_command, 0);
			label.set_text ("from: ");
			label.set_right_alignment;
			edit_bar.attach_left_position (label, 17);
			edit_bar.attach_top (label, 0);
			edit_bar.attach_bottom (label, 0);
			edit_bar.attach_right_position (label, 20);
			edit_bar.attach_left_position (change_class_form, 20);
			edit_bar.attach_top (change_class_form, 0);
			edit_bar.attach_bottom (change_class_form, 0);
			change_class_command.set_width (80);
			change_class_form.attach_left (change_class_command, 0);
			change_class_form.attach_top (change_class_command, 0);
			change_class_form.attach_bottom (change_class_command, 0);
			change_class_form.attach_right (change_class_command, 0);
			edit_bar.attach_top (quit_button, 0);
			edit_bar.attach_right (quit_button, 0);
			edit_bar.attach_top (change_font_button, 0);
			edit_bar.attach_right_widget (quit_button, change_font_button, 10);
			edit_bar.attach_top (search_button, 0);
			edit_bar.attach_right_widget (change_font_button, search_button, 0);
			edit_bar.attach_right_widget (search_button, change_class_form, 2)
		end;

feature {NONE} -- Properties

	command_bar: FORM;
			-- Bar with the command buttons

	show_menus: BOOLEAN;
			-- Should the menus be shown?

feature {ROUTINE_TEXT} -- Properties

	tool_name: STRING is
		do
			Result := l_Routine
		end;

end -- class ROUTINE_W
