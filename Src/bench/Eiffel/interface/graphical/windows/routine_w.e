indexing

	description:	
		"Window describing an Eiffel routine.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_W 

inherit

	BAR_AND_TEXT
		rename
			attach_all as default_attach_all,
			make as normal_create,
			reset as old_reset
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, set_default_size,
			resize_action, stone, stone_type,
			set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible
		end

	BAR_AND_TEXT
		redefine
			hole, build_format_bar, text_window,
			build_bar, tool_name, close_windows,
			build_widgets, attach_all, reset,
			set_default_size, make, resize_action,
			stone, stone_type, set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible
		select
			attach_all, reset, make
		end

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a feature tool
		do
			normal_create (a_screen);
			text_window.set_read_only
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
			class_hole.set_empty_symbol;
			change_class_command.clear;
			change_routine_command.clear;
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
			last_format.execute (a_stone);
			history.extend (a_stone);
			update_edit_bar
		end;

	process_breakable (a_stone: BREAKABLE_STONE) is
		do
			stop_hole.receive (a_stone)
		end;

	process_class (a_stone: CLASSC_STONE) is
		local
			--c: E_CLASS;
			--ris: ROUT_ID_SET;
			--i: INTEGER;
			--rout_id: INTEGER;
			--fi: E_FEATURE;
			--fs: FEATURE_STONE;
			--temp: STRING
		do
			--ris := stone.e_feature.rout_id_set;
			--c := a_stone.e_class;
			--from
				--i := 1
			--until
				--i > ris.count
			--loop
				--rout_id := ris.item (i);
				--if rout_id < 0 then
					--rout_id := - rout_id
				--end;
				--fi := c.feature_with_rout_id (rout_id);
				--if (fi /= Void) then
					--i := ris.count
				--end
				--i := i + 1
			--end
			--if (fi /= Void) then
				--!! fs.make (fi, a_stone.e_class);
				--process_feature (fs);
			--else
				--temp := a_stone.e_class.name_in_upper;
				--temp.prepend ("No version of current feature for class ");
				--error_window.clear_window;
				--error_window.put_string ("No version of feature ")
				--stone.e_feature.append_name
							--(error_window,
							--stone.e_feature.written_class);
				--error_window.put_string ("%N   for class ");
				--a_stone.e_class.append_name (error_window);
				--error_window.new_line;
				--error_window.display;
				--project_tool.raise;
			--end;
		end;
	
feature -- Graphical Interface

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone;
			if stone = Void then
				class_hole.set_empty_symbol;
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
			set_default_size;
				if tabs_disabled then
					!! text_window.make (new_name, global_form, Current);
				else
					!ROUTINE_TAB_TEXT! text_window.make (new_name, global_form, Current);
				end;
				!! edit_bar.make (new_name, global_form);
				build_bar;
				!! format_bar.make (new_name, global_form);
				build_format_bar;
				!! command_bar.make (new_name, global_form);
				build_command_bar;
				text_window.set_last_format (default_format);
			attach_all	
		end

	attach_all is
			-- Attach all widgets.
		do
			default_attach_all;

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

	hole: ROUTINE_HOLE;
			-- Hole caraterizing current

	class_hole: ROUT_CLASS_HOLE;
			-- Hole for version of routine for a particular class.

	stop_hole: DEBUG_STOPIN;
			-- To set breakpoints

feature {ROUTINE_TEXT} -- Formats

	showroutclients_frmt_holder: FORMAT_HOLDER;

	showhomonyms_command: SHOW_HOMONYMS;

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
			set_size (650, 450)
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

feature {NONE} -- Implementation; Graphical Interface

	build_command_bar is
			-- Build the command bar.
		local
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON;
			previous_target_cmd: PREVIOUS_TARGET;
			previous_target_button: EB_BUTTON
			next_target_cmd: NEXT_TARGET;
			next_target_button: EB_BUTTON
			current_target_cmd: CURRENT_ROUTINE;
			current_target_button: EB_BUTTON
		do
			!! shell_cmd.make (command_bar, text_window);
			!! shell_button.make (shell_cmd, command_bar);
			shell_button.add_button_click_action (3, shell_cmd, Void);
			!! shell.make (shell_cmd, shell_button);
			command_bar.attach_left (shell_button, 0);
			command_bar.attach_bottom (shell_button, 0);
			!! current_target_cmd.make (text_window);
			!! current_target_button.make (current_target_cmd, command_bar);
			!! current_target_cmd_holder.make (current_target_cmd, current_target_button)
			command_bar.attach_left (current_target_button, 0);
			command_bar.attach_bottom_widget (shell_button, current_target_button, 10);
			!! next_target_cmd.make (text_window);
			!! next_target_button.make (next_target_cmd, command_bar);
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button)
			command_bar.attach_left (next_target_button, 0);
			command_bar.attach_bottom_widget (current_target_button, next_target_button, 0);
			!! previous_target_cmd.make (text_window);
			!! previous_target_button.make (previous_target_cmd, command_bar);
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button)
			command_bar.attach_left (previous_target_button, 0);
			command_bar.attach_bottom_widget (next_target_button, previous_target_button, 0);
		end;

	build_format_bar is
			-- Build the format bar.
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS;
			rout_cli_button: EB_BUTTON;
			rout_hist_cmd: SHOW_ROUT_HIST;
			rout_hist_button: EB_BUTTON;
			past_cmd: SHOW_PAST;
			past_button: EB_BUTTON;
			rout_flat_cmd: SHOW_ROUT_FLAT;
			rout_flat_button: EB_BUTTON;
			future_cmd: SHOW_FUTURE;
			future_button: EB_BUTTON;
			stop_cmd: SHOW_BREAKPOINTS;
			stop_button: EB_BUTTON
		do
			!! showtext_command.make (format_bar, text_window);
			format_bar.attach_top (showtext_command, 0);
			format_bar.attach_left (showtext_command, 0);

			!! rout_flat_cmd.make (text_window);
			!! rout_flat_button.make (rout_flat_cmd, format_bar);
			!! showflat_frmt_holder.make (rout_flat_cmd, rout_flat_button);
			format_bar.attach_top (rout_flat_button, 0);
			format_bar.attach_left_widget (showtext_command, rout_flat_button, 0);

			!! rout_cli_cmd.make (text_window);
			!! rout_cli_button.make (rout_cli_cmd, format_bar);
			!! showroutclients_frmt_holder.make (rout_cli_cmd, rout_cli_button);
			format_bar.attach_top (rout_cli_button, 0);
			format_bar.attach_left_widget (rout_flat_button, rout_cli_button, 10);

			!! rout_hist_cmd.make (text_window);
			!! rout_hist_button.make (rout_hist_cmd, format_bar);
			!! showhistory_frmt_holder.make (rout_hist_cmd, rout_hist_button);
			format_bar.attach_top (rout_hist_button, 0);
			format_bar.attach_left_widget (rout_cli_button, rout_hist_button, 0);

			!! past_cmd.make (text_window);
			!! past_button.make (past_cmd, format_bar);
			!! showpast_frmt_holder.make (past_cmd, past_button);
			format_bar.attach_top (past_button, 0);
			format_bar.attach_left_widget (rout_hist_button, past_button, 0);

			!! future_cmd.make (text_window);
			!! future_button.make (future_cmd, format_bar);
			!! showfuture_frmt_holder.make (future_cmd, future_button);
			format_bar.attach_top (future_button, 0);
			format_bar.attach_left_widget (past_button, future_button, 0);

			!! showhomonyms_command.make (format_bar, text_window);
			format_bar.attach_top (showhomonyms_command, 0);
			format_bar.attach_left_widget (future_button, showhomonyms_command, 0);

			!! stop_cmd.make (text_window);
			!! stop_button.make (stop_cmd, format_bar);
			!! showstop_frmt_holder.make (stop_cmd, stop_button);
			format_bar.attach_top (stop_button, 0);
			format_bar.attach_left_widget (showhomonyms_command, stop_button, 10);
		end;

	build_bar is
			-- Build top bar: editing commands.
		local
			hole_form: FORM;
			label: LABEL;
			quit_cmd: QUIT_FILE;
			quit_button: EB_BUTTON;
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON
			search_cmd: SEARCH_STRING;
			search_button: EB_BUTTON
		do
			edit_bar.set_fraction_base (31);

			!! hole_form.make (new_name, edit_bar);
			edit_bar.attach_left (hole_form, 0);
			edit_bar.attach_top (hole_form, 0);
			edit_bar.attach_bottom (hole_form, 0);

			!! hole.make (hole_form, Current);
			hole_form.attach_left (hole, 0);
			hole_form.attach_top (hole, 0);
			!! class_hole.make (hole_form, Current);
			hole_form.attach_left_widget (hole, class_hole, 0);
			hole_form.attach_top (class_hole, 0);
			!! stop_hole.make (hole_form, Current);
			hole_form.attach_left_widget (class_hole, stop_hole, 0);
			hole_form.attach_top (stop_hole, 0);

			!! change_routine_form.make (new_name, edit_bar);
			edit_bar.attach_left_position (change_routine_form, 11);
			edit_bar.attach_top (change_routine_form, 0);
			edit_bar.attach_bottom (change_routine_form, 0);
			edit_bar.attach_right_position (change_routine_form, 17);

			!! change_routine_command.make (change_routine_form, text_window);
			change_routine_command.set_width (80);
			change_routine_form.attach_left (change_routine_command, 0);
			change_routine_form.attach_top (change_routine_command, 0);
			change_routine_form.attach_bottom (change_routine_command, 0);
			change_routine_form.attach_right (change_routine_command, 0);

			!! label.make ("", edit_bar);
			label.set_text ("from: ");
			label.set_right_alignment;
			edit_bar.attach_left_position (label, 17);
			edit_bar.attach_top (label, 0);
			edit_bar.attach_bottom (label, 0);
			edit_bar.attach_right_position (label, 20);

			!! change_class_form.make (new_name, edit_bar);
			edit_bar.attach_left_position (change_class_form, 20);
			edit_bar.attach_top (change_class_form, 0);
			edit_bar.attach_bottom (change_class_form, 0);

			!! change_class_command.make (change_class_form, text_window);
			change_class_command.set_width (80);
			change_class_form.attach_left (change_class_command, 0);
			change_class_form.attach_top (change_class_command, 0);
			change_class_form.attach_bottom (change_class_command, 0);
			change_class_form.attach_right (change_class_command, 0);

			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			!! quit.make (quit_cmd, quit_button);
			edit_bar.attach_top (quit_button, 0);
			edit_bar.attach_right (quit_button, 0);

			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, edit_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button);
			edit_bar.attach_top (change_font_button, 0);
			edit_bar.attach_right_widget (quit_button, change_font_button, 10);

			!! search_cmd.make (edit_bar, text_window);
			!! search_button.make (search_cmd, edit_bar);
			!! search_cmd_holder.make (search_cmd, search_button);
			edit_bar.attach_top (search_button, 0);
			edit_bar.attach_right_widget (change_font_button, search_button, 0);
			edit_bar.attach_right_widget (search_button, change_class_form, 2)
		end;

feature {NONE} -- Properties

	command_bar: FORM;
			-- Bar with the command buttons

feature {ROUTINE_TEXT} -- Properties

	tool_name: STRING is
		do
			Result := l_Routine
		end;

end -- class ROUTINE_W
