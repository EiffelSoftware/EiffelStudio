indexing

	description:	
		"Window describing the assembly of an Eiffel system (Ace, universe, ...)";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_W 

inherit

	PROJECT_CONTEXT;
	BAR_AND_TEXT
		rename
			attach_all as default_attach_all
		redefine
			hole, build_format_bar, build_widgets,
			open_cmd_holder, save_as_cmd_holder, save_cmd_holder,
			text_window, tool_name, editable, create_edit_buttons,
			display, stone, stone_type, synchronise_stone, process_system,
			process_class, process_classi, process_ace_syntax, compatible
		end;
	BAR_AND_TEXT
		redefine
			hole, build_format_bar, attach_all, build_widgets,
			open_cmd_holder, save_as_cmd_holder, save_cmd_holder,
			text_window, tool_name, editable, create_edit_buttons,
			display, stone, stone_type, synchronise_stone, process_system,
			process_class, process_classi, process_ace_syntax,
			compatible
		select
			attach_all
		end

creation

	make

feature -- Properties

	text_window: SYSTEM_TEXT;

	stone: SYSTEM_STONE

	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := system_type
		end

feature -- Access

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = System_type or else
				a_stone.stone_type = Class_type 
		end;

feature -- Update

	process_system (s: SYSTEM_STONE) is
			-- Process system stone.
		do
			if text_window.changed then
				showtext_frmt_holder.execute (s);
			else
				text_window.last_format.execute (s);
				history.extend (s)
			end
		end;

	process_ace_syntax (syn: ACE_SYNTAX_STONE) is
			-- Process syntax error.
		do
			if text_window.changed then
				showtext_frmt_holder.execute (syn);
			else
				showtext_frmt_holder.execute (syn);
				text_window.deselect_all;
				text_window.set_cursor_position (syn.start_position);
				text_window.highlight_selected (syn.start_position,
							syn.end_position);
				text_window.set_changed (false);
				update_save_symbol
			end
		end;

	process_class (a_stone: CLASSC_STONE) is
		do
			if text_window.changed then
				showtext_frmt_holder.execute (a_stone);
			else
				text_window.search_stone (a_stone)
			end
		end;

	process_classi (a_stone: CLASSI_STONE) is
		do
			if text_window.changed then
				showtext_frmt_holder.execute (a_stone);
			else
				text_window.search_stone (a_stone)
			end
		end;

	synchronise_stone is
			-- Synchronize the root stone of the window.
		local
			system_stone: SYSTEM_STONE;
			old_do_format: BOOLEAN
		do
			if stone /= Void then
				!! system_stone;
				old_do_format := text_window.last_format.associated_command.do_format;
				text_window.last_format.associated_command.set_do_format (true);
				text_window.last_format.execute (system_stone);
				text_window.last_format.associated_command.set_do_format (old_do_format)
			end
		end;

feature -- Graphical Interface

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
	
feature {NONE} -- Implementation; Graphical Interface

	create_edit_buttons is
		local
			quit_cmd: QUIT_SYSTEM;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			exit_menu_entry: EB_MENU_ENTRY;
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON;
			change_font_menu_entry: EB_MENU_ENTRY;
			search_cmd: SEARCH_STRING;
			search_button: EB_BUTTON;
			search_menu_entry: EB_MENU_ENTRY;
			open_cmd: OPEN_SYSTEM;
			open_button: EB_BUTTON;
			open_menu_entry: EB_MENU_ENTRY;
			save_cmd: SAVE_SYSTEM;
			save_button: EB_BUTTON;
			save_menu_entry: EB_MENU_ENTRY;
			save_as_cmd: SAVE_AS_SYSTEM;
			save_as_button: EB_BUTTON;
			save_as_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR
		do
			!! open_cmd.make (text_window);
			!! open_button.make (open_cmd, edit_bar);
			!! open_menu_entry.make (open_cmd, file_menu);
			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry);
			!! save_cmd.make (text_window);
			!! save_button.make (save_cmd, edit_bar);
			!! save_menu_entry.make (save_cmd, file_menu);
			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry);
			!! save_as_cmd.make (text_window);
			!! save_as_button.make (save_as_cmd, edit_bar);
			!! save_as_menu_entry.make (save_as_cmd, file_menu);
			!! save_as_cmd_holder.make (save_as_cmd, save_as_button, save_as_menu_entry);
			!! sep.make (new_name, file_menu);
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			!! quit_menu_entry.make (quit_cmd, file_menu);
			!! quit.make (quit_cmd, quit_button, quit_menu_entry);
			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu);
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command);
			exit_cmd_holder.set_menu_entry (exit_menu_entry);
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, edit_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_menu_entry.make (change_font_cmd, preference_menu);
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button, change_font_menu_entry);
			!! search_cmd.make (edit_bar, text_window);
			!! search_button.make (search_cmd, edit_bar);
			!! search_menu_entry.make (search_cmd, edit_menu);
			!! search_cmd_holder.make (search_cmd, search_button, search_menu_entry);
		end;

	build_widgets is
		do
			set_default_size;
			if tabs_disabled then
				!! text_window.make (new_name, global_form, Current);
			else
				!SYSTEM_TAB_TEXT! text_window.make (new_name, global_form, Current);
			end;
			build_menus;
			!! edit_bar.make (new_name, global_form);
			build_bar;
			!! format_bar.make (new_name, global_form);
			build_format_bar;
			!! command_bar.make (new_name, global_form);
			build_command_bar;
			fill_menus;
			text_window.set_last_format (default_format);
			attach_all
		end;

	attach_all is
		do
			default_attach_all;
			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			stat_cmd: SHOW_STATISTICS;
			stat_button: EB_BUTTON;
			stat_menu_entry: EB_TICKABLE_MENU_ENTRY;
			mod_cmd: SHOW_MODIFIED;
			mod_button: EB_BUTTON;
			mod_menu_entry: EB_TICKABLE_MENU_ENTRY;
			list_cmd: SHOW_CLUSTERS;
			list_button: EB_BUTTON;
			list_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showtext_cmd: SHOW_TEXT;
			showtext_button: EB_BUTTON;
			showtext_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showclass_cmd: SHOW_CLASS_LIST;
			showclass_button: EB_BUTTON;
			showclass_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showindex_cmd: SHOW_INDEXING;
			showindex_button: EB_BUTTON
			showindex_menu_entry: EB_TICKABLE_MENU_ENTRY;
		do
				-- First we create all the objects needed for the attachments.
			!! showtext_cmd.make (text_window);
			!! showtext_button.make (showtext_cmd, format_bar);
			!! showtext_menu_entry.make (showtext_cmd, format_menu);
			!! showtext_frmt_holder.make (showtext_cmd, showtext_button, showtext_menu_entry);
			!! list_cmd.make (text_window);
			!! list_button.make (list_cmd, format_bar);
			!! list_menu_entry.make (list_cmd, format_menu);
			!! showlist_frmt_holder.make (list_cmd, list_button, list_menu_entry);
			!! showclass_cmd.make (text_window);
			!! showclass_button.make (showclass_cmd, format_bar);
			!! showclass_menu_entry.make (showclass_cmd, format_menu);
			!! showclasses_frmt_holder.make (showclass_cmd, showclass_button, showclass_menu_entry);
			!! stat_cmd.make (text_window);
			!! stat_button.make (stat_cmd, format_bar);
			!! stat_menu_entry.make (stat_cmd, format_menu);
			!! showstatistics_frmt_holder.make (stat_cmd, stat_button, stat_menu_entry);
			!! mod_cmd.make (text_window);
			!! mod_button.make (mod_cmd, format_bar);
			!! mod_menu_entry.make (mod_cmd, format_menu);
			!! showmodified_frmt_holder.make (mod_cmd, mod_button, mod_menu_entry);
			!! showindex_cmd.make (text_window);
			!! showindex_button.make (showindex_cmd, format_bar);
			!! showindex_menu_entry.make (showindex_cmd, format_menu);
			!! showindexing_frmt_holder.make (showindex_cmd, showindex_button, showindex_menu_entry);

				-- Now we attach everything (this is done here for reason of speed).
			format_bar.attach_top (showtext_button, 0);
			format_bar.attach_left (showtext_button, 0);
			format_bar.attach_top (list_button, 0);
			format_bar.attach_left_widget (showtext_button, list_button, 0);
			format_bar.attach_top (showclass_button, 0);
			format_bar.attach_left_widget (list_button, showclass_button, 0);
			format_bar.attach_top (stat_button, 0);
			format_bar.attach_left_widget (showclass_button, stat_button, 0);
			format_bar.attach_top (mod_button, 0);
			format_bar.attach_left_widget (stat_button, mod_button, 0);
			format_bar.attach_top (showindex_button, 0);
			format_bar.attach_left_widget (mod_button, showindex_button, 0);
		end;

	build_command_bar is
		local
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON;
			shell_menu_entry: EB_MENU_ENTRY;
			case_storage_cmd: CASE_STORAGE;
			case_storage_button: EB_BUTTON;
			case_storage_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR
		do
			!! shell_cmd.make (command_bar, text_window);
			!! shell_button.make (shell_cmd, command_bar);
			shell_button.add_button_click_action (3, shell_cmd, Void);
			!! shell_menu_entry.make (shell_cmd, special_menu);
			!! shell.make (shell_cmd, shell_button, shell_menu_entry);
			!! case_storage_cmd.make (text_window);
			!! case_storage_button.make (case_storage_cmd, command_bar);
			case_storage_button.set_action ("!c<Btn1Down>", case_storage_cmd, case_storage_cmd.control_click);
			!! sep.make (new_name, special_menu);
			!! case_storage_menu_entry.make (case_storage_cmd, special_menu);
			!! case_storage_cmd_holder.make (case_storage_cmd, case_storage_button, case_storage_menu_entry);

			command_bar.attach_right (shell_button, 0);
			command_bar.attach_left (shell_button, 0);
			command_bar.attach_bottom (shell_button, 0);
			command_bar.attach_left (case_storage_button, 0);
			command_bar.attach_bottom_widget (shell_button, case_storage_button, 10)
		end;

feature {NONE} -- Attributes

	tool_name: STRING is
			-- Name of the tool representwed by Current.
		do
			Result := l_System
		end;

	editable:BOOLEAN is True;
			-- Is Current editable?

feature {NONE} -- Attributes; Forms And Holes

	command_bar: FORM;
			-- Bar with the command buttons

	hole: SYSTEM_cmd;
			-- Hole charaterizing current

feature {NONE} -- Attributes; Commands

	open_cmd_holder: COMMAND_HOLDER;

	save_cmd_holder: COMMAND_HOLDER;

	save_as_cmd_holder: COMMAND_HOLDER;

	-- check_command: CHECK_SYSTEM;

	showlist_frmt_holder: FORMAT_HOLDER;

	showclasses_frmt_holder: FORMAT_HOLDER;

	showmodified_frmt_holder: FORMAT_HOLDER;

	showindexing_frmt_holder: FORMAT_HOLDER;

	showstatistics_frmt_holder: FORMAT_HOLDER;

	shell: COMMAND_HOLDER;

	case_storage_cmd_holder: COMMAND_HOLDER;

end -- class SYSTEM_W
