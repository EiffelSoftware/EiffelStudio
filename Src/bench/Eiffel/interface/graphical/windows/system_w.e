indexing

	description:	
		"Window describing the assembly of an Eiffel system (Ace, universe, ...)";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_W 

inherit
	PROJECT_CONTEXT

	BAR_AND_TEXT
		redefine
			hole, build_format_bar, build_widgets,
			open_cmd_holder, save_cmd_holder,
			tool_name, editable, display, stone, stone_type, 
			synchronise_stone, process_system, parse_file,
			process_class, process_classi, process_ace_syntax, compatible,
			set_mode_for_editing, hide, editable_text_window,
			set_editable_text_window, has_editable_text, read_only_text_window,
			set_read_only_text_window, realized, able_to_edit,
			update_boolean_resource, build_bar,
			update_integer_resource,
			update_array_resource,
			set_default_size,
			resources, close, update_graphical_resources,
			raise, build_save_as_menu_entry, help_index, icon_id
		end

	EB_CONSTANTS

	SHARED_LACE_PARSER

creation
	make

feature -- Initialization

	make is
		do
			System_resources.add_user (Current)
		end;

feature -- Dispatch Resource

	update_array_resource (old_res, new_res: ARRAY_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
		do
			old_res.update_with (new_res)
		end;

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
		local
			sr: like System_resources
		do
			sr := System_resources
			if old_res = sr.command_bar then
				if new_res.actual_value then
					edit_bar.add
				else
					edit_bar.remove
				end
			elseif old_res = sr.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			end;
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
		do
			old_res.update_with (new_res)
		end;

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text window.
		do
			if realized then
				initialize_text_window_resources;
				synchronize
			end
		end;

feature -- Properties

	stone: SYSTEM_STONE

	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := system_type
		end

	in_use: BOOLEAN;
			-- Is the system tool used (not hidden)?

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

	resources: like System_resources is 
			-- System category page in preference tool
		do
			Result := system_resources
		end

	help_index: INTEGER is 7
		
	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_System_id
		end;
 
feature -- Access

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = System_type or else
				a_stone.stone_type = Class_type 
		end;

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
			Result := last_format = showtext_frmt_holder
		end;

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
		do
			Result := last_format = showtext_frmt_holder
		end;

	changed: BOOLEAN is
		do
			Result := realized and then text_window.changed
		end;

	realized: BOOLEAN is
			-- Is Current realized?
		do
			if eb_shell /= Void and then is_a_shell then
				Result := eb_shell.realized
			end
		end

feature -- Status setting

	set_in_use (b: BOOLEAN) is
			-- Assign `b' to `in_use'.
		do
			in_use := b
		end;

	set_mode_for_editing is
			-- Set edit mode on.
		do
			text_window.set_editable
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

	set_default_size is
			-- Set the size of Current to its default.
		do
			eb_shell.set_size (System_resources.tool_width.actual_value,
				System_resources.tool_height.actual_value)
		end;

feature -- Parsing

	parse_file is
		local
			retried: BOOLEAN
			syntax_error: SYNTAX_ERROR
			syntax_stone: ACE_SYNTAX_STONE
			error_msg, msg: STRING
		do
			Parser.parse_file (file_name)

			syntax_error := Parser.last_syntax_error
			if syntax_error /= Void then
				error_msg := "Ace has syntax error"
				msg := syntax_error.syntax_message

				if not msg.empty then
					error_msg.append (" (");
					error_msg.append (msg);
					error_msg.extend (')')
				end
				
				error_msg.append (".%NSee higlighted area")
				!! syntax_stone.make (syntax_error)
				process_ace_syntax (syntax_stone);
				Parser.clear_syntax_error;
				warner (popup_parent).gotcha_call (error_msg);
			else
				text_window.update_clickable_from_stone (stone)
			end
		end

feature -- Update

	raise is
			-- Raise the tool.
		do
			if realized and then shown then
				eb_shell.raise
			end
		end;

	close is
			-- Close the system tool.
		do
			if realized and then shown then
				hide
			end
		end

	process_system (s: SYSTEM_STONE) is
			-- Process system stone.
		do
			if changed then
				showtext_frmt_holder.execute (s);
			else
				last_format.execute (s);
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
			old_do_format: BOOLEAN;
			last_f: FORMAT_HOLDER
		do
			if stone /= Void then
				last_f := last_format;
				!! system_stone;
				old_do_format := last_f.associated_command.do_format;
				last_f.associated_command.set_do_format (true);
				last_f.execute (system_stone);
				last_f.associated_command.set_do_format (old_do_format)
			end
		end;

	show_file_content (a_file_name: STRING) is
			-- Display content of file named `a_file_name'
			-- do not change title, nor file_name
		local
			a_file: PLAIN_TEXT_FILE;
		do
			!!a_file.make_open_read (a_file_name);
			a_file.readstream (a_file.count);
			a_file.close;
			text_window.clear_window;
			set_editable_text;
			show_editable_text;
			text_window.set_text (a_file.laststring);
			set_file_name (a_file_name);
			set_mode_for_editing;
			update_save_symbol;
			reset_stone
		ensure
			up_to_date: not text_window.changed;
			no_stone: stone = Void
		end;

feature -- Graphical Interface

	display is
			-- Display the system tool
		local
			mp: MOUSE_PTR
		do
			if not realized then
				!! mp.set_watch_cursor
				make_shell (Project_tool.screen);
				mp.restore
				set_default_size;
				set_default_format;
				set_default_position;
				eb_shell.display;
				init_text_window
			elseif not shown then
				set_default_format;
				init_text_window;
				set_default_position;
				show
			end;
			raise;
			set_in_use (true)
		end;

	hide is
		do
			stone := Void;
			if realized then
				eb_shell.hide;
				set_in_use (false)
			end
		end;
	
feature {NONE} -- Implementation; Graphical Interface

	build_bar is
		local
			quit_cmd: QUIT_SYSTEM;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			exit_menu_entry: EB_MENU_ENTRY;
			open_cmd: OPEN_SYSTEM;
			open_button: EB_BUTTON;
			open_menu_entry: EB_MENU_ENTRY;
			save_cmd: SAVE_SYSTEM;
			save_button: EB_BUTTON;
			save_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR
		do
			!! hole.make (Current);
			!! hole_button.make (hole, edit_bar);
			!! hole_holder.make_plain (hole);
			hole_holder.set_button (hole_button);
			!! open_cmd.make (Current);
			!! open_button.make (open_cmd, edit_bar);
			!! open_menu_entry.make (open_cmd, file_menu);
			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry);
			!! save_cmd.make (Current);
			!! save_button.make (save_cmd, edit_bar);
			!! save_menu_entry.make (save_cmd, file_menu);
			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry);
			build_save_as_menu_entry;
			build_print_menu_entry;
			build_edit_menu (edit_bar)
			!! quit_cmd.make (Current);
			!! quit_button.make (quit_cmd, edit_bar);
			!! quit_menu_entry.make (quit_cmd, file_menu);
			!! quit.make (quit_cmd, quit_button, quit_menu_entry);
			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu);
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command);
			exit_cmd_holder.set_menu_entry (exit_menu_entry);
			
			edit_bar.attach_left (hole_button, 0);
			edit_bar.attach_top (hole_button, 0);
			edit_bar.attach_top (open_button, 0);
			edit_bar.attach_top (save_button, 0);
			edit_bar.attach_top (search_cmd_holder.associated_button, 0);
			edit_bar.attach_top (quit_button, 0);
			edit_bar.attach_right_widget (save_button, open_button, 0);
			edit_bar.attach_right_widget (search_cmd_holder.associated_button, save_button, 0);
			edit_bar.attach_right_widget (quit_button, search_cmd_holder.associated_button, 5);
			edit_bar.attach_right (quit_button, 0);
		end;

	build_widgets is
		local
			sep: SEPARATOR
		do
			create_toolbar (global_form);

			build_text_windows;
			build_menus;
			build_bar;
			build_format_bar;
			build_command_menu;
			fill_menus;
			set_last_format (default_format);
			build_toolbar_menu;

			if System_resources.command_bar.actual_value = False then
				edit_bar.remove
			end;
			if System_resources.format_bar.actual_value = False then
				format_bar.remove
			end;

			attach_all
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			stat_cmd: SHOW_STATISTICS;
			stat_button: FORMAT_BUTTON;
			stat_menu_entry: EB_TICKABLE_MENU_ENTRY;
			mod_cmd: SHOW_MODIFIED;
			mod_button: FORMAT_BUTTON;
			mod_menu_entry: EB_TICKABLE_MENU_ENTRY;
			list_cmd: SHOW_CLUSTERS;
			list_button: FORMAT_BUTTON;
			list_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showtext_cmd: SHOW_TEXT;
			showtext_button: FORMAT_BUTTON;
			showtext_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showclass_cmd: SHOW_CLASS_LIST;
			showclass_button: FORMAT_BUTTON;
			showclass_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showhier_cmd: SHOW_CLUSTER_HIERARCHY;
			showhier_button: FORMAT_BUTTON;
			showhier_menu_entry: EB_TICKABLE_MENU_ENTRY;
			showindex_cmd: SHOW_INDEXING;
			showindex_button: FORMAT_BUTTON
			showindex_menu_entry: EB_TICKABLE_MENU_ENTRY;
		do

				-- First we create all the objects needed for the attachments.
			!! showtext_cmd.make (Current);
			!! showtext_button.make (showtext_cmd, format_bar);
			!! showtext_menu_entry.make (showtext_cmd, format_menu);
			!! showtext_frmt_holder.make (showtext_cmd, showtext_button, showtext_menu_entry);
			!! list_cmd.make (Current);
			!! list_button.make (list_cmd, format_bar);
			!! list_menu_entry.make (list_cmd, format_menu);
			!! showlist_frmt_holder.make (list_cmd, list_button, list_menu_entry);
			!! showclass_cmd.make (Current);
			!! showclass_button.make (showclass_cmd, format_bar);
			!! showclass_menu_entry.make (showclass_cmd, format_menu);
			!! showclasses_frmt_holder.make (showclass_cmd, showclass_button, showclass_menu_entry);
			!! showhier_cmd.make (Current);
			!! showhier_button.make (showhier_cmd, format_bar);
			!! showhier_menu_entry.make (showhier_cmd, format_menu);
			!! showhier_frmt_holder.make (showhier_cmd, showhier_button, showhier_menu_entry);
			!! stat_cmd.make (Current);
			!! stat_button.make (stat_cmd, format_bar);
			!! stat_menu_entry.make (stat_cmd, format_menu);
			!! showstatistics_frmt_holder.make (stat_cmd, stat_button, stat_menu_entry);
			!! mod_cmd.make (Current);
			!! mod_button.make (mod_cmd, format_bar);
			!! mod_menu_entry.make (mod_cmd, format_menu);
			!! showmodified_frmt_holder.make (mod_cmd, mod_button, mod_menu_entry);
			!! showindex_cmd.make (Current);
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
			format_bar.attach_top (showhier_button, 0);
			format_bar.attach_left_widget (showclass_button, showhier_button, 0);
			format_bar.attach_top (stat_button, 0);
			format_bar.attach_left_widget (showhier_button, stat_button, 0);
			format_bar.attach_top (mod_button, 0);
			format_bar.attach_left_widget (stat_button, mod_button, 0);
			format_bar.attach_top (showindex_button, 0);
			format_bar.attach_left_widget (mod_button, showindex_button, 0);
		end;

	build_command_menu is
		local
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON_HOLE;
			shell_menu_entry: EB_MENU_ENTRY;
			case_storage_cmd: CASE_STORAGE;
			case_storage_button: EB_BUTTON;
			case_storage_menu_entry: EB_MENU_ENTRY;
		do
			!! shell_cmd.make (Current);
			!! shell_button.make (shell_cmd, edit_bar);
			shell_button.add_button_press_action (3, shell_cmd, Void);
			!! shell_menu_entry.make (shell_cmd, special_menu);
			!! shell.make (shell_cmd, shell_button, shell_menu_entry);
			build_filter_menu_entry;

			edit_bar.attach_top (shell_button, 0);
			edit_bar.attach_left_widget (hole_button, shell_button, 0)
		end;

	build_save_as_menu_entry is
			-- Create a save_as command to be inserted into file menu.
		local
			save_as_cmd: SAVE_AS_SYSTEM;
			save_as_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR
		do
			!! save_as_cmd.make (Current);
			!! save_as_menu_entry.make (save_as_cmd, file_menu);
			!! sep.make (Interface_names.t_Empty, file_menu)
		end;

feature {WINDOWS} -- Attributes

	tool_name: STRING is
			-- Name of the tool representwed by Current.
		do
			Result := Interface_names.t_System
		end;

feature {NONE} -- Attributes

	editable:BOOLEAN is True;
			-- Is Current editable?

feature {NONE} -- Attributes; Forms And Holes

	hole: SYSTEM_HOLE;
			-- Hole charaterizing current

feature {NONE} -- Attributes; Commands

	open_cmd_holder: COMMAND_HOLDER;

	save_cmd_holder: TWO_STATE_CMD_HOLDER;

	-- check_command: CHECK_SYSTEM;

	showlist_frmt_holder: FORMAT_HOLDER;

	showclasses_frmt_holder: FORMAT_HOLDER;

	showhier_frmt_holder: FORMAT_HOLDER;

	showmodified_frmt_holder: FORMAT_HOLDER;

	showindexing_frmt_holder: FORMAT_HOLDER;

	showstatistics_frmt_holder: FORMAT_HOLDER;

	shell: COMMAND_HOLDER;

end -- class SYSTEM_W
