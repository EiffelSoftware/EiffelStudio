indexing

	description:	
		"Window describing an Eiffel class.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_W 

inherit

	BAR_AND_TEXT
		rename
			reset as old_reset, 
			close_windows as old_close_windows,
			set_stone as old_set_stone
		redefine
			build_format_bar, hole, 
			tool_name, open_cmd_holder, save_cmd_holder,
			save_as_cmd_holder, editable,
			create_edit_buttons, set_default_size,
			build_widgets, resize_action,
			build_edit_bar, stone_type, synchronize,
			process_class_syntax, process_feature,
			process_class, process_classi, compatible,
			set_mode_for_editing, set_font, editable_text_window,
			set_editable_text_window, has_editable_text, read_only_text_window,
			set_read_only_text_window,
			update_boolean_resource,
			update_integer_resource
		end;
	BAR_AND_TEXT
		redefine
			build_format_bar, hole, hole_button,
			tool_name, open_cmd_holder, save_cmd_holder,
			save_as_cmd_holder, editable,
			build_edit_bar, create_edit_buttons, reset,
			set_default_size, build_widgets,
			close_windows, resize_action, stone_type,
			synchronize, set_stone, process_class_syntax,
			process_feature, process_class, process_classi,
			compatible, set_mode_for_editing, set_font, editable_text_window,
			set_editable_text_window, has_editable_text, read_only_text_window,
			set_read_only_text_window,
			update_boolean_resource,
			update_integer_resource
		select
			reset, close_windows, set_stone
		end;
	EB_CONSTANTS

creation

	make_shell

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update Current, according to `old_res' and `new_res'.
		local
			cr: like Class_tool_resources
		do
			cr := Class_tool_resources;
			if old_res = cr.command_bar then
				if new_res.actual_value then
					edit_bar.add
				else
					edit_bar.remove
				end
			elseif old_res = cr.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			end;
			old_res.update_with (new_res)
		end

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			cr: like Class_tool_resources
		do
			cr := Class_tool_resources;
			if new_res.actual_value > 0 then
				if old_res = cr.tool_height then
					if old_res.actual_value /= new_res.actual_value then
						set_height (new_res.actual_value)
					end
				elseif old_res = cr.tool_width then
					if old_res.actual_value /= new_res.actual_value then
						set_width (new_res.actual_value)
					end
				end;
				old_res.update_with (new_res)
			end
		end

feature -- Properties

	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := Class_type
		end;

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

feature -- Access

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
			Result := True
		end;

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = Routine_type or else
				a_stone.stone_type = Breakable_type or else
				a_stone.stone_type = Class_type
		end;

	cluster: CLUSTER_I is
			-- Cluster associated with root_stone
		local
			c: CLASSC_STONE;
			ci: CLASSI_STONE
		do
			c ?= stone;
			ci ?= stone;
			if c /= Void then
				Result := c.e_class.cluster
			elseif ci /= Void then
				Result := ci.class_i.cluster
			end
		end;

feature -- Status setting
 
	set_stone (s: like stone) is
		local
			c: CLASSC_STONE;
			ci: CLASSI_STONE
		do
			old_set_stone (s);
			c ?= stone;
			ci ?= stone;
			if c /= Void then
				update_class_name (clone (c.e_class.name))
			elseif ci /= Void then
				update_class_name (clone (ci.class_i.class_name))
			end
		end;

	set_mode_for_editing is
			-- Set the text mode to be editable.
		do
			text_window.set_editable
		end;

	set_font (a_font: FONT) is
			-- Set new font `a_font' to window
		do
			class_text_field.set_font (a_font)
		end

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
 
feature -- Stone process
 
	process_classi (s: CLASSI_STONE) is
		do
			if text_window.changed then
				showtext_frmt_holder.execute (s);
			else
				last_format.execute (s);
				history.extend (s)
			end
		end;
 
	process_class (s: CLASSC_STONE) is
		do
			if text_window.changed then
				showtext_frmt_holder.execute (s);
			else
				last_format.execute (s);
				history.extend (s)
			end
		end;
 
	process_feature (s: FEATURE_STONE) is
			-- Proces feature stone.
		local
			cl_stone: CLASSC_STONE;
			e_class: E_CLASS
		do
			if text_window.changed then
				showtext_frmt_holder.execute (s);
			else
				e_class := s.e_feature.written_class;
				!! cl_stone.make (e_class);
				showtext_frmt_holder.execute (cl_stone);
				history.extend (stone);
				text_window.deselect_all;
				text_window.set_cursor_position (s.start_position);
				text_window.highlight_selected
						(s.start_position, s.end_position)
			end
		end;
 
	process_class_syntax (s: CL_SYNTAX_STONE) is
			-- Process class syntax.
		local
			cl_stone: CLASSC_STONE
		do
			if text_window.changed then
				showtext_frmt_holder.execute (s)
			else
				!! cl_stone.make (s.associated_class);
				showtext_frmt_holder.execute (cl_stone);
				text_window.deselect_all;
				text_window.set_cursor_position
						(s.start_position);
				text_window.highlight_selected
						(s.start_position,
						s.end_position);
			end
		end;
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone;
			if stone = Void then
				class_text_field.clear
			end
		end;

feature -- Update

	reset is
			-- Reset the window contents
		do
			old_reset;
			class_text_field.clear
		end;

	update_class_name (s: STRING) is
		require
			valid_arg: s /= Void
		do
			s.to_upper;
			class_text_field.set_text (s);
		end;

feature -- Window Settings

	close_windows is
			-- Close sub-windows.
		do
			old_close_windows;
			class_text_field.close_choice_window;
			filter_command.close_filter_window;
		end;

feature -- Widgets

	class_text_field: CLASS_TEXT_FIELD;

feature -- Formats

	showflat_frmt_holder: FORMAT_HOLDER;

	showflatshort_frmt_holder: FORMAT_HOLDER;

	showancestors_frmt_holder: FORMAT_HOLDER;

	showdescendants_frmt_holder: FORMAT_HOLDER;

	showclients_frmt_holder: FORMAT_HOLDER;

	showsuppliers_frmt_holder: FORMAT_HOLDER;

	showattributes_frmt_holder: FORMAT_HOLDER;

	showroutines_frmt_holder: FORMAT_HOLDER;

	showshort_frmt_holder: FORMAT_HOLDER;

	showclick_frmt_holder: FORMAT_HOLDER;

	showdeferreds_frmt_holder: FORMAT_HOLDER;

	showexternals_frmt_holder: FORMAT_HOLDER;

	showonces_frmt_holder: FORMAT_HOLDER;

	showexported_frmt_holder: FORMAT_HOLDER;

feature -- Grahpical Interface

	build_widgets is
		local
			popup_cmd: TOOLBAR_CMD
		do
			if eb_shell /= Void then
				set_default_size
			end;

			!! toolbar_parent.make (new_name, global_form, Current);
			toolbar_parent.set_column_layout;
			toolbar_parent.set_free_size;
			!! popup_cmd.make (Current);
			toolbar_parent.add_button_press_action (3, popup_cmd, Void);

			build_text_windows;
			build_menus;
			!! edit_bar.make (l_Command_bar_name, toolbar_parent, Current);
			build_bar;
			!! toolbar_separator.make (new_name, toolbar_parent);
			!! format_bar.make (l_Format_bar_name, toolbar_parent, Current);
			build_format_bar;
			build_command_bar;
			fill_menus;
			set_last_format (default_format);

			if Class_tool_resources.command_bar.actual_value = False then
				edit_bar.remove
			end;
			if Class_tool_resources.format_bar.actual_value = False then
				format_bar.remove
			end;

			attach_all
		end;

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			shell_window: SHELL_W
			shell_cmd: SHELL_COMMAND
		do
			shell_cmd ?= shell.associated_command;
			shell_window := shell_cmd.shell_window;
			if shell_window /= Void and then shell_window.is_popped_up then
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
			eb_shell.set_size (Class_tool_resources.tool_width.actual_value,
				Class_tool_resources.tool_height.actual_value)
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
			class_text_field.update_text;
			class_text_field.update_choice_position
		end;

feature {NONE} -- Commands

	open_cmd_holder: COMMAND_HOLDER;

	save_cmd_holder: TWO_STATE_CMD_HOLDER;

	save_as_cmd_holder: COMMAND_HOLDER;

	shell: COMMAND_HOLDER;

	current_target_cmd_holder: COMMAND_HOLDER;

	previous_target_cmd_holder: COMMAND_HOLDER;

	next_target_cmd_holder: COMMAND_HOLDER;

	super_melt_menu_entry: EB_MENU_ENTRY;

	filter_menu_entry: EB_MENU_ENTRY;

	filter_command: FILTER_COMMAND;

feature {NONE} -- Implementation; Graphical Interface

	create_edit_buttons is
		local
			quit_cmd: QUIT_FILE;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			exit_menu_entry: EB_MENU_ENTRY;
			change_font_cmd: CHANGE_FONT;
			change_font_menu_entry: EB_MENU_ENTRY;
			search_cmd: SEARCH_STRING;
			search_button: EB_BUTTON;
			search_menu_entry: EB_MENU_ENTRY;
			open_cmd: OPEN_FILE;
			open_button: EB_BUTTON;
			open_menu_entry: EB_MENU_ENTRY;
			save_cmd: SAVE_FILE;
			save_button: EB_BUTTON;
			save_menu_entry: EB_MENU_ENTRY;
			save_as_cmd: SAVE_AS_FILE;
			save_as_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR;
			history_list_cmd: LIST_HISTORY
		do
			!! class_text_field.make (edit_bar, Current);
			!! open_cmd.make (text_window);
			!! open_button.make (open_cmd, edit_bar);
			!! open_menu_entry.make (open_cmd, file_menu);
			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry);
			!! save_cmd.make (text_window);
			!! save_button.make (save_cmd, edit_bar);
			!! save_menu_entry.make (save_cmd, file_menu);
			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry);
			!! save_as_cmd.make (text_window);
			!! save_as_menu_entry.make (save_as_cmd, file_menu);
			!! save_as_cmd_holder.make_plain (save_as_cmd);
			save_as_cmd_holder.set_menu_entry (save_as_menu_entry);
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			!! sep.make (new_name, file_menu);
			!! quit_menu_entry.make (quit_cmd, file_menu);
			!! quit.make (quit_cmd, quit_button, quit_menu_entry);
			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu);
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command);
			exit_cmd_holder.set_menu_entry (exit_menu_entry);
			!! change_font_cmd.make (text_window);
			!! change_font_menu_entry.make (change_font_cmd, preference_menu);
			!! change_font_cmd_holder.make_plain (change_font_cmd);
			change_font_cmd_holder.set_menu_entry (change_font_menu_entry);
			!! search_cmd.make (Current);
			!! search_button.make (search_cmd, edit_bar);
			!! search_menu_entry.make (search_cmd, edit_menu);
			!! search_cmd_holder.make (search_cmd, search_button, search_menu_entry);
		end;

	build_command_bar is
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
			current_target_cmd: CURRENT_CLASS;
			current_target_button: EB_BUTTON;
			current_target_menu_entry: EB_MENU_ENTRY;
			super_melt_cmd: SUPER_MELT;
			sep: SEPARATOR;
			history_list_cmd: LIST_HISTORY;
			new_class_button: EB_BUTTON_HOLE
		do
			!! shell_cmd.make (text_window);
			!! shell_button.make (shell_cmd, edit_bar);
			shell_button.add_third_button_action;
			!! shell_menu_entry.make (shell_cmd, special_menu);
			!! shell.make (shell_cmd, shell_button, shell_menu_entry);

			!! filter_command.make (Current);
			!! filter_menu_entry.make (filter_command, special_menu);

			!! super_melt_cmd.make (Current);
			!! super_melt_menu_entry.make (super_melt_cmd, special_menu);

			!! current_target_cmd.make (text_window);
			!! sep.make (new_name, special_menu);
			!! current_target_menu_entry.make (current_target_cmd, special_menu);
			!! current_target_cmd_holder.make_plain (current_target_cmd);
			current_target_cmd_holder.set_menu_entry (current_target_menu_entry);
			!! next_target_cmd.make (text_window);
			!! next_target_button.make (next_target_cmd, edit_bar);
			!! next_target_menu_entry.make (next_target_cmd, special_menu);
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry);
			!! previous_target_cmd.make (text_window);
			!! previous_target_button.make (previous_target_cmd, edit_bar);
			!! previous_target_menu_entry.make (previous_target_cmd, special_menu);
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry);

			!! history_list_cmd.make (text_window);
			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button);
			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button);

			!! new_class_button.make
					(Project_tool.class_hole_holder.associated_command,
					edit_bar);
			edit_bar.attach_left_widget (hole_button, shell_button, 0);
			edit_bar.attach_left_widget (shell_button, new_class_button, 0);
			edit_bar.attach_top (shell_button, 0);
			edit_bar.attach_top (new_class_button, 0);

			edit_bar.attach_top (next_target_button, 0);
			edit_bar.attach_top (previous_target_button, 0);
			edit_bar.attach_right_widget (class_text_field, next_target_button, 2);
			edit_bar.attach_right_widget (next_target_button, previous_target_button, 0)
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			anc_cmd: SHOW_ANCESTORS;
			anc_button: FORMAT_BUTTON;
			anc_menu_entry: EB_TICKABLE_MENU_ENTRY;
			des_cmd: SHOW_DESCENDANTS;
			des_button: FORMAT_BUTTON;
			des_menu_entry: EB_TICKABLE_MENU_ENTRY;
			cli_cmd: SHOW_CLIENTS;
			cli_button: FORMAT_BUTTON;
			cli_menu_entry: EB_TICKABLE_MENU_ENTRY;
			sup_cmd: SHOW_SUPPLIERS;
			sup_button: FORMAT_BUTTON;
			sup_menu_entry: EB_TICKABLE_MENU_ENTRY;
			att_cmd: SHOW_ATTRIBUTES;
			att_button: FORMAT_BUTTON;
			att_menu_entry: EB_TICKABLE_MENU_ENTRY;
			rou_cmd: SHOW_ROUTINES;
			rou_button: FORMAT_BUTTON;
			rou_menu_entry: EB_TICKABLE_MENU_ENTRY;
			def_cmd: SHOW_DEFERREDS;
			def_button: FORMAT_BUTTON;
			def_menu_entry: EB_TICKABLE_MENU_ENTRY;
			ext_cmd: SHOW_EXTERNALS;
			ext_button: FORMAT_BUTTON;
			ext_menu_entry: EB_TICKABLE_MENU_ENTRY;
			onc_cmd: SHOW_ONCES;
			onc_button: FORMAT_BUTTON;
			onc_menu_entry: EB_TICKABLE_MENU_ENTRY;
			exp_cmd: SHOW_EXPORTED;
			exp_button: FORMAT_BUTTON;
			exp_menu_entry: EB_TICKABLE_MENU_ENTRY;
			tex_cmd: SHOW_TEXT;
			tex_button: FORMAT_BUTTON;
			tex_menu_entry: EB_TICKABLE_MENU_ENTRY;
			fla_cmd: SHOW_FLAT;
			fla_button: FORMAT_BUTTON;
			fla_menu_entry: EB_TICKABLE_MENU_ENTRY;
			fs_cmd: SHOW_FS;
			fs_button: FORMAT_BUTTON;
			fs_menu_entry: EB_TICKABLE_MENU_ENTRY;
			sho_cmd: SHOW_SHORT;
			sho_button: FORMAT_BUTTON;
			sho_menu_entry: EB_TICKABLE_MENU_ENTRY;
			click_cmd: SHOW_CLICK_CL;
			click_button: FORMAT_BUTTON;
			click_menu_entry: EB_TICKABLE_MENU_ENTRY;
			sep: SEPARATOR
		do
				-- First we create all objects.
			!! tex_cmd.make (text_window);
			!! tex_button.make (tex_cmd, format_bar);
			!! tex_menu_entry.make (tex_cmd, format_menu);
			!! showtext_frmt_holder.make (tex_cmd, tex_button, tex_menu_entry);
			!! fla_cmd.make (text_window);
			!! fla_button.make (fla_cmd, format_bar);
			!! fla_menu_entry.make (fla_cmd, format_menu);
			!! showflat_frmt_holder.make (fla_cmd, fla_button, fla_menu_entry);
			!! fs_cmd.make (text_window);
			!! fs_button.make (fs_cmd, format_bar);
			!! fs_menu_entry.make (fs_cmd, format_menu);
			!! showflatshort_frmt_holder.make (fs_cmd, fs_button, fs_menu_entry);
			!! sho_cmd.make (text_window);
			!! sho_button.make (sho_cmd, format_bar);
			!! sho_menu_entry.make (sho_cmd, format_menu);
			!! showshort_frmt_holder.make (sho_cmd, sho_button, sho_menu_entry);
			!! click_cmd.make (Current);
			!! click_button.make (click_cmd, format_bar);
			!! click_menu_entry.make (click_cmd, format_menu);
			!! sep.make (new_name, format_menu);
			!! showclick_frmt_holder.make (click_cmd, click_button, click_menu_entry);
			!! anc_cmd.make (text_window);
			!! anc_button.make (anc_cmd, format_bar);
			!! anc_menu_entry.make (anc_cmd, format_menu);
			!! showancestors_frmt_holder.make (anc_cmd, anc_button, anc_menu_entry);
			!! des_cmd.make (text_window);
			!! des_button.make (des_cmd, format_bar);
			!! des_menu_entry.make (des_cmd, format_menu);
			!! showdescendants_frmt_holder.make (des_cmd, des_button, des_menu_entry);
			!! cli_cmd.make (text_window);
			!! cli_button.make (cli_cmd, format_bar);
			!! cli_menu_entry.make (cli_cmd, format_menu);
			!! showclients_frmt_holder.make (cli_cmd, cli_button, cli_menu_entry);
			!! sup_cmd.make (text_window);
			!! sup_button.make (sup_cmd, format_bar);
			!! sup_menu_entry.make (sup_cmd, format_menu);
			!! sep.make (new_name, format_menu);
			!! showsuppliers_frmt_holder.make (sup_cmd, sup_button, sup_menu_entry);
			!! att_cmd.make (text_window);
			!! att_button.make (att_cmd, format_bar);
			!! att_menu_entry.make (att_cmd, format_menu);
			!! showattributes_frmt_holder.make (att_cmd, att_button, att_menu_entry);
			!! rou_cmd.make (text_window);
			!! rou_button.make (rou_cmd, format_bar);
			!! rou_menu_entry.make (rou_cmd, format_menu);
			!! showroutines_frmt_holder.make (rou_cmd, rou_button, rou_menu_entry);
			!! def_cmd.make (text_window);
			!! def_button.make (def_cmd, format_bar);
			!! def_menu_entry.make (def_cmd, format_menu);
			!! showdeferreds_frmt_holder.make (def_cmd, def_button, def_menu_entry);
			!! ext_cmd.make (text_window);
			!! ext_button.make (ext_cmd, format_bar);
			!! ext_menu_entry.make (ext_cmd, format_menu);
			!! showexternals_frmt_holder.make (ext_cmd, ext_button, ext_menu_entry);
			!! exp_cmd.make (text_window);
			!! exp_button.make (exp_cmd, format_bar);
			!! exp_menu_entry.make (exp_cmd, format_menu);
			!! showexported_frmt_holder.make (exp_cmd, exp_button, exp_menu_entry);
			!! onc_cmd.make (text_window);
			!! onc_button.make (onc_cmd, format_bar);
			!! onc_menu_entry.make (onc_cmd, format_menu);
			!! showonces_frmt_holder.make (onc_cmd, onc_button, onc_menu_entry);

				-- And now we attach everything (this is done this way
				-- because of speed)
			format_bar.attach_top (tex_button, 0);
			format_bar.attach_left (tex_button, 0);
			format_bar.attach_top (fla_button, 0);
			format_bar.attach_left_widget (tex_button, click_button, 0);
			format_bar.attach_top (fs_button, 0);
			format_bar.attach_left_widget (click_button, fla_button, 0);
			format_bar.attach_top (sho_button, 0);
			format_bar.attach_left_widget (fla_button, sho_button, 0);
			format_bar.attach_top (click_button, 0);
			format_bar.attach_left_widget (sho_button, fs_button, 0);
			format_bar.attach_top (anc_button, 0);
			format_bar.attach_left_widget (fs_button, anc_button, 15);
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
			format_bar.attach_top (exp_button, 0);
			format_bar.attach_right (exp_button, 0);
		end;

	build_edit_bar is
			-- Build top bar: editing commands
		do
			edit_bar.set_fraction_base (21);
			!! hole.make (Current);
			!! hole_button.make (hole, edit_bar);
			!! hole_holder.make_plain (hole);
			hole_holder.set_button (hole_button);
			create_edit_buttons;

			edit_bar.attach_left (hole_button, 0);
			edit_bar.attach_top (hole_button, 0);

			edit_bar.attach_top (class_text_field, 0);
			edit_bar.attach_left_position (class_text_field, 7);
			edit_bar.attach_right_widget (open_cmd_holder.associated_button, class_text_field, 2);
			edit_bar.attach_right (quit.associated_button, 0);
			edit_bar.attach_top (quit.associated_button, 0);
			edit_bar.attach_top (search_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (quit.associated_button, search_cmd_holder.associated_button, 5);
			edit_bar.attach_top (save_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (search_cmd_holder.associated_button, save_cmd_holder.associated_button, 0);
			edit_bar.attach_top (open_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (save_cmd_holder.associated_button, open_cmd_holder.associated_button, 0)
		end;

end -- class CLASS_W
