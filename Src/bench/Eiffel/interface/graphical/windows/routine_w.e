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
			hole, build_format_bar, 
			build_bar, tool_name, close_windows,
			build_widgets, set_default_size, attach_all,
			resize_action, stone, stone_type,
			set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible,
			close, set_font, editable_text_window,
			set_editable_text_window, has_editable_text, 
			read_only_text_window, set_read_only_text_window,
			update_boolean_resource,
			update_integer_resource,
			set_title
		end

	BAR_AND_TEXT
		redefine
			hole, build_format_bar, 
			build_bar, tool_name, close_windows,
			build_widgets, attach_all, reset,
			set_default_size, resize_action,
			stone, stone_type, set_stone, synchronize, process_feature,
			process_class, process_breakable, compatible,
			make_shell, close, set_font, editable_text_window,
			set_editable_text_window, has_editable_text,
			read_only_text_window, set_read_only_text_window,
			update_boolean_resource,
			update_integer_resource,
			set_title
		select
			reset, make_shell
		end;
	EB_CONSTANTS

creation

	make_shell, form_create

feature -- Initialization

	make_shell (a_shell: EB_SHELL) is
			-- Create a feature tool
		do
			create_menus := True;
			bar_and_text_make_shell (a_shell);
		end;

	form_create (a_form: FORM; edit_m, format_m, special_m: MENU_PULL) is
			-- Create a feature tool from a form.
		require
			valid_args: a_form /= Void and then edit_m /= Void and then	
				format_m /= Void and then special_m /= Void
		do
			create_menus := False;
			edit_menu := edit_m;
			format_menu := format_m;
			special_menu := special_m;
			make_form (a_form);
			init_text_window;
			set_composite_attributes (a_form)
		end;

feature -- Update Resources

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS;
			stop_cmd: SHOW_BREAKPOINTS;
			fr: like Feature_tool_resources
		do
			fr := Feature_tool_resources
			if old_res = fr.command_bar then
				if new_res.actual_value then
					edit_bar.add
				else
					edit_bar.remove
				end
			elseif old_res = fr.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			elseif old_res = fr.show_all_callers then
				rout_cli_cmd ?= 
					showroutclients_frmt_holder.associated_command;
				rout_cli_cmd.set_show_all_callers (new_res.actual_value)
			elseif old_res = fr.do_flat_in_breakpoints then
				stop_cmd ?= 
					showstop_frmt_holder.associated_command;
				stop_cmd.set_format_mode (new_res.actual_value)
			end;
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			fr: like Feature_tool_resources
		do
			fr := Feature_tool_resources;
			if new_res.actual_value > 0 then
				if old_res = fr.tool_height then
					if old_res.actual_value /= new_res.actual_value then
						set_height (new_res.actual_value)
					end
				elseif old_res = fr.tool_width then
					if old_res.actual_value /= new_res.actual_value then
						set_width (new_res.actual_value)
					end
				end;
				old_res.update_with (new_res)
			end
		end

feature -- Window Properties

	stone: FEATURE_STONE
			-- Stone in tool

	stone_type: INTEGER is
			-- Accept feature type stone
		do
			Result := Routine_type
		end

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

feature -- Resetting

	reset is
			-- Reset the window contents
		do
			old_reset;
			-- class_hole.set_empty_symbol;
			class_text_field.clear;
			routine_text_field.clear;
		end;

	close is
			-- Close Current.
		do
			if is_a_shell then
				Project_tool.remove_routine_entry (Current);
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

	in_debug_format: BOOLEAN is
			-- Does window show breakable points of routine?
		do
			Result := last_format = showstop_frmt_holder
		end;

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
			Result := True
		end;

feature -- Update

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
			routine_text_field.close_choice_window
			class_text_field.close_choice_window
		end;

	highlight_breakable (index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		require
			positive_index: index >= 1
		do
			if in_debug_format then
				text_window.highlight_breakable (stone.e_feature, index)
			end
		end

	resynchronize_debugger (feat: E_FEATURE) is
			-- Resynchronize debugged routine window with feature `feat'.
			-- If `feat' resynchronize routine window.
		local
			cur: CURSOR;
			old_do_format: BOOLEAN;
			f: FORMATTER
		do
			if (in_debug_format and then stone /= Void and then
				stone.e_feature /= Void) and then
			 	(feat = Void or else 
				feat.body_id.is_equal (stone.e_feature.body_id))
			then
				cur := text_window.cursor;
				f := showstop_frmt_holder.associated_command;
				old_do_format := f.do_format;
				f.set_do_format (true);
				f.execute (stone);
				f.set_do_format (old_do_format)
				text_window.go_to (cur)
			end
		end;

	set_debug_format is 
			-- Set the current format to be in `debug_format'.		
		do
			set_read_only_text;
			set_last_format (showstop_frmt_holder);
		ensure
			set: showstop_frmt_holder = last_format
		end;

	show_stoppoint (f: E_FEATURE; index: INTEGER) is
			-- If stone feature is equal to feature `f' and if in debug
			-- mode then redisplay the sign of the `index'-th breakable point.
			-- Otherwize, update the title of feature tool (to print `stop').
		require
			valid_feature: f /= Void and then f.body_id /= Void;
			positive_index: index >= 1
		do
			if stone /= Void and then
				stone.e_feature /= Void and then
				f.body_id.is_equal (stone.e_feature.body_id)
			then
				if in_debug_format then
					text_window.redisplay_breakable_mark (stone.e_feature,
						index)
				elseif last_format = showtext_frmt_holder then
					-- Update the title bar of the feature tool.
					-- "(stop)" if the routine has a stop point set.
					showtext_frmt_holder.associated_command.display_header
													(stone)
				end
			end
		end;

feature -- Status setting

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s);
				Project_tool.change_routine_entry (Current)
			end
		end;

	set_editable_text_window (ed: like editable_text_window) is
			-- Set `editable_text_window' to `ed'.
		do
			editable_text_window := ed
		end;

	set_read_only_text_window (ed: like read_only_text_window) is
			-- Set `read_only_text_window' to `ed'.
		do
			read_only_text_window := ed
		end;

	set_stone (s: like stone) is
			-- Update stone from `s'.
		do
			stone := s;
			if s = Void then
				set_icon_name (tool_name)
			else
				update_edit_bar;
				set_icon_name (s.icon_name);
				hole_button.set_full_symbol;
				class_hole_button.set_full_symbol
			end
		end;

	set_font (a_font: FONT) is
			-- Set new font `a_font' to window
		do
			class_text_field.set_font (a_font);
			routine_text_field.set_font (a_font)
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
			stop_hole_button.associated_command.process_breakable (a_stone)
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
				!! fs.make (fi);
				process_feature (fs);
			else
				error_window.clear_window;
				!! text.make;
				text.add_string ("No version of feature ");
				text.add_feature (stone.e_feature, stone.e_feature.name);
				text.add_new_line;
				text.add_string ("   for class ");
				s := c.name_in_upper;
				text.add_classi (c.lace_class, s);
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
				class_text_field.clear;
				routine_text_field.clear
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
				class_text_field.update_class_name (stone.e_class.name);
				routine_text_field.set_text (stone.e_feature.name);
			end
		end; 
	
	build_widgets is
			-- Build the widgets for this window.
		local
			sep: SEPARATOR
		do
			if is_a_shell then
				set_default_size
			end;
			build_text_windows;
			if create_menus then
				build_menus
			end;

			create_toolbar_parent (global_form);

			!! edit_bar.make (l_Command_bar_name, toolbar_parent);
			build_bar;
			!! sep.make ("", toolbar_parent);
			!! format_bar.make (l_Format_bar_name, toolbar_parent);
			build_format_bar;
			build_command_bar;
			if create_menus then
				fill_menus;
			end;
			build_toolbar_menu;
			set_last_format (default_format);

			if Feature_tool_resources.command_bar.actual_value = False then
				edit_bar.remove
			end;
			if Feature_tool_resources.format_bar.actual_value = False then
				format_bar.remove
			end;

			attach_all	
		end;

	attach_all is
			-- Attach all widgets.
		do
			if create_menus then
				global_form.attach_left (menu_bar, 0);
				global_form.attach_right (menu_bar, 0);
				global_form.attach_top (menu_bar, 0)
			end;

			global_form.attach_left (toolbar_parent, 0);
			global_form.attach_right (toolbar_parent, 0);
			if create_menus then
				global_form.attach_top_widget (menu_bar, toolbar_parent, 0)
			else
				global_form.attach_top (toolbar_parent, 0)
			end;

			global_form.attach_left (editable_text_window.widget, 0);
			global_form.attach_right (editable_text_window.widget, 0);
			global_form.attach_bottom (editable_text_window.widget, 0);
			global_form.attach_top_widget (toolbar_parent, editable_text_window.widget, 0);
			if editable_text_window /= read_only_text_window then
				global_form.attach_left (read_only_text_window.widget, 0);
				global_form.attach_right (read_only_text_window.widget, 0);
				global_form.attach_bottom (read_only_text_window.widget, 0);
				global_form.attach_top_widget (toolbar_parent, read_only_text_window.widget, 0);
			end
		end

feature {TEXT_WINDOW} -- Forms And Holes

	hole: ROUTINE_HOLE;
			-- Hole charaterizing Current.

	class_hole: ROUT_CLASS_HOLE;
			-- Hole for version of routine for a particular class.

	class_hole_button: EB_BUTTON_HOLE;
			-- Button for the class hole

	stop_hole: DEBUG_STOPIN_HOLE;
			-- To set breakpoints

	stop_hole_button: EB_BUTTON_HOLE;
			-- Button for the stop points hole

feature {TEXT_WINDOW, PROJECT_W} -- Formats

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

	routine_text_field: ROUTINE_TEXT_FIELD;

	class_text_field: ROUTINE_CLASS_TEXT_FIELD;

	super_melt_menu_entry: EB_MENU_ENTRY;

feature {NONE} -- Implementation; Window Settings

	resize_action is
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup;
			class_text_field.update_text;
			routine_text_field.update_text;
			class_text_field.update_choice_position;
			routine_text_field.update_choice_position
		end;

	set_default_size is
			-- Set the size of Current to its default.
		do
			if eb_shell /= Void then
				eb_shell.set_size 
					(Feature_tool_resources.tool_width.actual_value, 
					Feature_tool_resources.tool_height.actual_value)
			end
		end;

feature {NONE} -- Implementation; Graphical Interface

	build_command_bar is
			-- Build the command bar.
		local
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON;
			shell_menu_entry: EB_MENU_ENTRY;
			super_melt_cmd: SUPER_MELT;
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
			history_list_cmd: LIST_HISTORY;
			new_class_button: EB_BUTTON_HOLE
		do
			!! shell_cmd.make (text_window);
			!! shell_button.make (shell_cmd, edit_bar);
			shell_button.add_third_button_action;

			!! shell_menu_entry.make (shell_cmd, special_menu);
			!! shell.make (shell_cmd, shell_button, shell_menu_entry);
			!! super_melt_cmd.make (Current);
			!! super_melt_menu_entry.make (super_melt_cmd, special_menu);
			!! current_target_cmd.make (Current);
			!! sep.make (new_name, special_menu);
			!! current_target_menu_entry.make (current_target_cmd, special_menu);
			!! current_target_cmd_holder.make_plain (current_target_cmd);
			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)
			!! next_target_cmd.make (text_window);
			!! next_target_button.make (next_target_cmd, edit_bar);
			!! next_target_menu_entry.make (next_target_cmd, special_menu);
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry)
			!! previous_target_cmd.make (text_window);
			!! previous_target_button.make (previous_target_cmd, edit_bar);
			!! previous_target_menu_entry.make (previous_target_cmd, special_menu);
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry)
			!! history_list_cmd.make (text_window);
			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button);
			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button);

			!! new_class_button.make
					(Project_tool.class_hole_holder.associated_command, 
					edit_bar);
			edit_bar.attach_left_widget (stop_hole_button, shell_button, 0);
			edit_bar.attach_left_widget (shell_button, new_class_button, 0);
			edit_bar.attach_top (shell_button, 0);
			edit_bar.attach_top (new_class_button, 0);
			previous_target_button.unmanage;
			next_target_button.unmanage;
			edit_bar.attach_top (next_target_button, 0);
			edit_bar.attach_top (previous_target_button, 0);
			edit_bar.detach_left (previous_target_button);
			edit_bar.detach_left (next_target_button);
			edit_bar.attach_right_widget (next_target_button, previous_target_button, 0);
			edit_bar.attach_right_position (next_target_button, 10);
			next_target_button.manage;
			previous_target_button.manage;
		end;

	build_format_bar is
			-- Build the format bar.
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS;
			rout_cli_button: FORMAT_BUTTON;
			rout_cli_menu_entry: EB_TICKABLE_MENU_ENTRY;
			rout_hist_cmd: SHOW_ROUT_HIST;
			rout_hist_button: FORMAT_BUTTON;
			rout_hist_menu_entry: EB_TICKABLE_MENU_ENTRY;
			past_cmd: SHOW_PAST;
			past_button: FORMAT_BUTTON;
			past_menu_entry: EB_TICKABLE_MENU_ENTRY;
			rout_flat_cmd: SHOW_ROUT_FLAT;
			rout_flat_button: FORMAT_BUTTON;
			rout_flat_menu_entry: EB_TICKABLE_MENU_ENTRY;
			future_cmd: SHOW_FUTURE;
			future_button: FORMAT_BUTTON;
			future_menu_entry: EB_TICKABLE_MENU_ENTRY;
			stop_cmd: SHOW_BREAKPOINTS;
			stop_button: FORMAT_BUTTON;
			stop_menu_entry: EB_TICKABLE_MENU_ENTRY;
			text_cmd: SHOW_TEXT;
			text_button: FORMAT_BUTTON;
			text_menu_entry: EB_TICKABLE_MENU_ENTRY;
			homonym_cmd: SHOW_HOMONYMS;
			homonym_button: FORMAT_BUTTON;
			homonym_menu_entry: EB_TICKABLE_MENU_ENTRY;
			sep: SEPARATOR
		do
				-- First we create all needed objects.
			!! text_cmd.make (text_window);
			!! text_button.make (text_cmd, format_bar);
			!! text_menu_entry.make (text_cmd, format_menu);
			!! showtext_frmt_holder.make (text_cmd, text_button, text_menu_entry)
			!! rout_flat_cmd.make (text_window);
			!! rout_flat_button.make (rout_flat_cmd, format_bar);
			!! rout_flat_menu_entry.make (rout_flat_cmd, format_menu);
			!! showflat_frmt_holder.make (rout_flat_cmd, rout_flat_button, rout_flat_menu_entry)
			!! rout_cli_cmd.make (text_window);
			!! rout_cli_button.make (rout_cli_cmd, format_bar);
			rout_cli_button.add_third_button_action;
			!! sep.make (new_name, format_menu);
			!! rout_cli_menu_entry.make (rout_cli_cmd, format_menu);
			!! showroutclients_frmt_holder.make (rout_cli_cmd, rout_cli_button, rout_cli_menu_entry)
			!! rout_hist_cmd.make (text_window);
			!! rout_hist_button.make (rout_hist_cmd, format_bar);
			!! rout_hist_menu_entry.make (rout_hist_cmd, format_menu);
			!! showhistory_frmt_holder.make (rout_hist_cmd, rout_hist_button, rout_hist_menu_entry)
			!! past_cmd.make (text_window);
			!! past_button.make (past_cmd, format_bar);
			!! past_menu_entry.make (past_cmd, format_menu);
			!! showpast_frmt_holder.make (past_cmd, past_button, past_menu_entry)
			!! future_cmd.make (text_window);
			!! future_button.make (future_cmd, format_bar);
			!! future_menu_entry.make (future_cmd, format_menu);
			!! showfuture_frmt_holder.make (future_cmd, future_button, future_menu_entry)
			!! homonym_cmd.make (text_window);
			!! homonym_button.make (homonym_cmd, format_bar);
			!! homonym_menu_entry.make (homonym_cmd, format_menu);
			!! showhomonyms_frmt_holder.make (homonym_cmd, homonym_button, homonym_menu_entry)
			!! stop_cmd.make (text_window);
			!! stop_button.make (stop_cmd, format_bar);
			stop_button.add_third_button_action;
			!! sep.make (new_name, format_menu);
			!! stop_menu_entry.make (stop_cmd, format_menu);
			!! showstop_frmt_holder.make (stop_cmd, stop_button, stop_menu_entry)

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
			class_hole_holder: HOLE_HOLDER;
			stop_hole_holder: HOLE_HOLDER;
		do
			edit_bar.set_fraction_base (31);

				-- First we create the needed objects.
			!! hole.make (Current);
			!! hole_button.make (hole, edit_bar);
			!! hole_holder.make_plain (hole);
			hole_holder.set_button (hole_button);
			!! class_hole.make (Current);
			!! class_hole_button.make (class_hole, edit_bar);
			!! class_hole_holder.make_plain (class_hole);
			class_hole_holder.set_button (class_hole_button);
			!! stop_hole.make (Current);
			!! stop_hole_button.make (stop_hole, edit_bar);
			!! stop_hole_holder.make_plain (stop_hole);
			stop_hole_holder.set_button (stop_hole_button);
			!! routine_text_field.make (edit_bar, Current);
			!! label.make ("", edit_bar);
			!! class_text_field.make (edit_bar, Current);
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			if create_menus then
				!! quit_menu_entry.make (quit_cmd, file_menu);
				!! quit.make (quit_cmd, quit_button, quit_menu_entry)
			else
				!! quit.make_plain (quit_cmd);
				quit.set_button (quit_button)
			end
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command);
			if create_menus then
				!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu);
				exit_cmd_holder.set_menu_entry (exit_menu_entry)
			end;
			!! change_font_cmd.make (text_window);
			if create_menus then
				!! change_font_menu_entry.make (change_font_cmd, preference_menu);
				!! change_font_cmd_holder.make_plain (change_font_cmd);
				change_font_cmd_holder.set_menu_entry (change_font_menu_entry)
			else
				!! change_font_cmd_holder.make_plain (change_font_cmd)
			end;
			!! search_cmd.make (Current);
			!! search_button.make (search_cmd, edit_bar);
			!! search_menu_entry.make (search_cmd, edit_menu);
			!! search_cmd_holder.make (search_cmd, search_button, search_menu_entry)

				-- Now we do all the attachments. This is done here for speed.
			edit_bar.attach_left (hole_button, 0);
			edit_bar.attach_top (hole_button, 0);
			edit_bar.attach_left_widget (hole_button, class_hole_button, 0);
			edit_bar.attach_top (class_hole_button, 0);
			edit_bar.attach_left_widget (class_hole_button, stop_hole_button, 0);
			edit_bar.attach_top (stop_hole_button, 0);
			routine_text_field.unmanage;
			edit_bar.attach_left_position (routine_text_field, 11);
			edit_bar.attach_top (routine_text_field, 0);
			edit_bar.attach_bottom (routine_text_field, 0);
			edit_bar.attach_right_position (routine_text_field, 17);
			routine_text_field.set_width (80);
			routine_text_field.manage;
			label.set_text ("from: ");
			label.set_right_alignment;
			label.unmanage;
			edit_bar.attach_left_position (label, 17);
			edit_bar.attach_top (label, 0);
			edit_bar.attach_bottom (label, 0);
			edit_bar.attach_right_position (label, 20);
			label.manage;
			edit_bar.attach_left_position (class_text_field, 20);
			edit_bar.attach_top (class_text_field, 0);
			edit_bar.attach_bottom (class_text_field, 0);
			class_text_field.set_width (80);
			edit_bar.attach_top (quit_button, 0);
			edit_bar.attach_right (quit_button, 0);
			edit_bar.detach_left (quit_button);
			edit_bar.attach_right_widget (quit_button, search_button, 10);
			edit_bar.attach_top (search_button, 0);
			edit_bar.detach_left (search_button);
			edit_bar.attach_right_widget (search_button, class_text_field, 2)
		end;

feature {NONE} -- Properties

	create_menus: BOOLEAN;
			-- Did the menus be created for current tool?

feature {TEXT_WINDOW} -- Properties

	tool_name: STRING is
		do
			Result := l_Routine
		end;

end -- class ROUTINE_W
