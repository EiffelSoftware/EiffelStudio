indexing
	description: "Window describing the assembly of an Eiffel system (Ace, universe, ...)"
	date: "$Date$"
	revision: "$Revision$"

class SYSTEM_W 

inherit
	BAR_AND_TEXT
		rename
			System_resources as resources,
			edit_bar as system_toolbar,
			System_type as stone_type
		redefine
			make, hole, build_widgets, create_toolbar, build_toolbar_menu,
			open_cmd_holder, save_cmd_holder,
			tool_name, editable, display, stone, 
			synchronise_stone, process_system, parse_file,
			process_class, process_classi, process_ace_syntax, compatible,
			set_mode_for_editing, hide, editable_text_window,
			set_editable_text_window, has_editable_text, read_only_text_window,
			set_read_only_text_window, realized, able_to_edit,
			close, raise, build_save_as_menu_entry, help_index, icon_id
		end

	PROJECT_CONTEXT

	SHARED_LACE_PARSER

creation
	make

feature -- Initialization

	make (a_screen: SCREEN) is
		do
			resources.add_user (Current)
			{BAR_AND_TEXT} Precursor (a_screen)
			set_default_size
			set_default_format
			set_default_position
			eb_shell.display
			init_text_window
		end

feature -- Properties

	stone: SYSTEM_STONE

	in_use: BOOLEAN
			-- Is the system tool used (not hidden)?

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

	help_index: INTEGER is 7
		
	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_System_id
		end
 
feature -- Access

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = stone_type or else
				a_stone.stone_type = Class_type 
		end

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
			Result := last_format = showtext_frmt_holder
		end

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
		do
			Result := last_format = showtext_frmt_holder
		end

	changed: BOOLEAN is
		do
			Result := realized and then text_window.changed
		end

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
		end

	set_mode_for_editing is
			-- Set edit mode on.
		do
			text_window.set_editable
		end

	set_editable_text_window (ed: like editable_text_window) is
			-- Set `editable_text_window' to `ed'.
		do
			editable_text_window := ed
		end

	set_read_only_text_window (ed: like read_only_text_window) is
			-- Set `read_only_text_window' to `ed'.
		do
			read_only_text_window := ed
		end

feature -- Parsing

	parse_file: BOOLEAN is
		local
			syntax_error: SYNTAX_ERROR
			syntax_stone: ACE_SYNTAX_STONE
			error_msg, msg: STRING
		do
			Parser.parse_file (file_name, False)

			syntax_error := Parser.last_syntax_error
			if syntax_error /= Void then
				error_msg := "Ace has syntax error"
				msg := syntax_error.syntax_message

				if not msg.is_empty then
					error_msg.append (" (")
					error_msg.append (msg)
					error_msg.extend (')')
				end
				
				error_msg.append (".%NSee highlighted area")
				!! syntax_stone.make (syntax_error)
				process_ace_syntax (syntax_stone)
				Parser.clear_syntax_error
				warner (popup_parent).gotcha_call (error_msg)
			else
				text_window.update_clickable_from_stone (stone)
				Result := True
			end
		end

feature -- Update

	raise is
			-- Raise the tool.
		do
			if realized and then shown then
				eb_shell.raise
			end
		end

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
			last_format.execute (s)
		end

	process_ace_syntax (syn: ACE_SYNTAX_STONE) is
			-- Display the syntax error in the System tool.
			--| If the text has been modified, we are loosing the changes.
		do
			showtext_frmt_holder.execute (syn)
			text_window.deselect_all
			text_window.set_cursor_position (syn.start_position)
			text_window.highlight_selected (syn.start_position, syn.end_position)
			update_save_symbol
		end

	process_class (a_stone: CLASSC_STONE) is
			-- Select the root class if `a_stone' is the root
			-- class, otherwise do nothing.
			--| If the text has been modified we do not do anything,
			--| So the result can be messy
		do
			text_window.search_stone (a_stone)
		end

	process_classi (a_stone: CLASSI_STONE) is
			-- Select the root class if `a_stone' is the root
			-- class, otherwise do nothing.
			--| If the text has been modified we do not do anything,
			--| So the result can be messy
		do
			text_window.search_stone (a_stone)
		end

	synchronise_stone is
			-- Synchronize the root stone of the window.
		local
			system_stone: SYSTEM_STONE
			old_do_format: BOOLEAN
			last_f: FORMAT_HOLDER
		do
			if stone /= Void then
				last_f := last_format
				!! system_stone
				old_do_format := last_f.associated_command.do_format
				last_f.associated_command.set_do_format (true)
				last_f.execute (system_stone)
				last_f.associated_command.set_do_format (old_do_format)
			end
		end

	show_file_content (a_file_name: STRING) is
			-- Display content of file named `a_file_name'
			-- do not change title, nor file_name
		local
			a_file: PLAIN_TEXT_FILE
		do
			!!a_file.make_open_read (a_file_name)
			a_file.readstream (a_file.count)
			a_file.close
			text_window.clear_window
			set_editable_text
			show_editable_text
			text_window.set_text (a_file.laststring)
			set_file_name (a_file_name)
			set_mode_for_editing
			update_save_symbol
			reset_stone
		ensure
			up_to_date: not text_window.changed
			no_stone: stone = Void
		end

feature -- Graphical Interface

	display is
			-- Display the system tool
		do
			if not shown then
				set_default_format
				set_default_position
				init_text_window
				show
			end
			raise
			set_in_use (true)
		end

	hide is
		do
			stone := Void
			if realized then
				eb_shell.hide
				set_in_use (false)
			end
		end
	
feature {NONE} -- Implementation Graphical Interface

	build_widgets is
		do
			create_toolbar (global_form)

			build_text_windows (global_form)
			build_menus
			build_system_toolbar
			fill_menus
			set_last_format (default_format)
			build_toolbar_menu

			if resources.command_bar.actual_value = False then
				system_toolbar.remove
			end

			attach_all
		end

	build_save_as_menu_entry is
			-- Create a save_as command to be inserted into file menu.
		local
			save_as_cmd: SAVE_AS_SYSTEM
			save_as_menu_entry: EB_MENU_ENTRY
		do
			!! save_as_cmd.make (Current)
			!! save_as_menu_entry.make (save_as_cmd, file_menu)
		end

	create_toolbar (a_parent: COMPOSITE) is
			-- Create a toolbar_parent with parent `a_parent'.
		local
			sep: THREE_D_SEPARATOR
		do
			!! toolbar_parent.make (new_name, a_parent)
			!! sep.make (Interface_names.t_Empty, toolbar_parent)
			toolbar_parent.set_column_layout
			toolbar_parent.set_free_size	
			toolbar_parent.set_margin_height (0)
			toolbar_parent.set_spacing (1)
			!! system_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
			if not Platform_constants.is_windows then
				!! sep.make (Interface_names.t_Empty, toolbar_parent)
			else
				system_toolbar.set_height (22)
			end
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, special_menu)
			!! toolbar_t.make (system_toolbar.identifier, special_menu)
			system_toolbar.init_toggle (toolbar_t)
		end

	build_system_toolbar is
		local
			quit_cmd: QUIT_SYSTEM
			quit_button: EB_BUTTON
			has_close_button: BOOLEAN
			quit_menu_entry: EB_MENU_ENTRY
			exit_menu_entry: EB_MENU_ENTRY
			open_cmd: OPEN_SYSTEM
			open_button: EB_BUTTON
			open_menu_entry: EB_MENU_ENTRY
			save_cmd: SAVE_SYSTEM
			save_button: EB_BUTTON
			save_menu_entry: EB_MENU_ENTRY
			sep1, sep2, sep3: THREE_D_SEPARATOR
			stat_cmd: SHOW_STATISTICS
			stat_button: FORMAT_BUTTON
			stat_menu_entry: EB_TICKABLE_MENU_ENTRY
			mod_cmd: SHOW_MODIFIED
			mod_button: FORMAT_BUTTON
			mod_menu_entry: EB_TICKABLE_MENU_ENTRY
			list_cmd: SHOW_CLUSTERS
			list_button: FORMAT_BUTTON
			list_menu_entry: EB_TICKABLE_MENU_ENTRY
			showtext_cmd: SHOW_TEXT
			showtext_button: FORMAT_BUTTON
			showtext_menu_entry: EB_TICKABLE_MENU_ENTRY
			showclass_cmd: SHOW_CLASS_LIST
			showclass_button: FORMAT_BUTTON
			showclass_menu_entry: EB_TICKABLE_MENU_ENTRY
			showhier_cmd: SHOW_CLUSTER_HIERARCHY
			showhier_button: FORMAT_BUTTON
			showhier_menu_entry: EB_TICKABLE_MENU_ENTRY
			showindex_cmd: SHOW_INDEXING
			showindex_button: FORMAT_BUTTON
			showindex_menu_entry: EB_TICKABLE_MENU_ENTRY
			shell_cmd: SHELL_COMMAND
			shell_button: EB_BUTTON_HOLE
			shell_menu_entry: EB_MENU_ENTRY
		do
				-- Should we have a close button?
			has_close_button := General_resources.close_button.actual_value

			!! hole.make (Current)
			!! hole_button.make (hole, system_toolbar)
			!! hole_holder.make_plain (hole)
			hole_holder.set_button (hole_button)

			!! open_cmd.make (Current)
			!! open_button.make (open_cmd, system_toolbar)
			!! open_menu_entry.make (open_cmd, file_menu)
			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry)

			!! save_cmd.make (Current)
			!! save_button.make (save_cmd, system_toolbar)
			!! save_menu_entry.make (save_cmd, file_menu)
			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry)

			build_save_as_menu_entry
			build_print_menu_entry
			build_edit_menu (system_toolbar)

			!! quit_cmd.make (Current)
			!! quit_menu_entry.make (quit_cmd, file_menu)
			if has_close_button then
				!! quit_button.make (quit_cmd, system_toolbar)
			end
			!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)

			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
			exit_cmd_holder.set_menu_entry (exit_menu_entry)

			!! showtext_cmd.make (Current)
			!! showtext_button.make (showtext_cmd, system_toolbar)
			!! showtext_menu_entry.make (showtext_cmd, format_menu)
			!! showtext_frmt_holder.make (showtext_cmd, showtext_button, showtext_menu_entry)

			!! list_cmd.make (Current)
			!! list_button.make (list_cmd, system_toolbar)
			!! list_menu_entry.make (list_cmd, format_menu)
			!! showlist_frmt_holder.make (list_cmd, list_button, list_menu_entry)

			!! showclass_cmd.make (Current)
			!! showclass_button.make (showclass_cmd, system_toolbar)
			!! showclass_menu_entry.make (showclass_cmd, format_menu)
			!! showclasses_frmt_holder.make (showclass_cmd, showclass_button, showclass_menu_entry)

			!! showhier_cmd.make (Current)
			!! showhier_button.make (showhier_cmd, system_toolbar)
			!! showhier_menu_entry.make (showhier_cmd, format_menu)
			!! showhier_frmt_holder.make (showhier_cmd, showhier_button, showhier_menu_entry)

			!! stat_cmd.make (Current)
			!! stat_button.make (stat_cmd, system_toolbar)
			!! stat_menu_entry.make (stat_cmd, format_menu)
			!! showstatistics_frmt_holder.make (stat_cmd, stat_button, stat_menu_entry)

			!! mod_cmd.make (Current)
			!! mod_button.make (mod_cmd, system_toolbar)
			!! mod_menu_entry.make (mod_cmd, format_menu)
			!! showmodified_frmt_holder.make (mod_cmd, mod_button, mod_menu_entry)

			!! showindex_cmd.make (Current)
			!! showindex_button.make (showindex_cmd, system_toolbar)
			!! showindex_menu_entry.make (showindex_cmd, format_menu)
			!! showindexing_frmt_holder.make (showindex_cmd, showindex_button, showindex_menu_entry)

			!! shell_cmd.make (Current)
			!! shell_button.make (shell_cmd, system_toolbar)
			shell_button.add_button_press_action (3, shell_cmd, Void)
			!! shell_menu_entry.make (shell_cmd, special_menu)
			!! shell.make (shell_cmd, shell_button, shell_menu_entry)

			build_filter_menu_entry

			!! sep1.make (interface_names.t_empty, system_toolbar)
			sep1.set_horizontal (False)
			sep1.set_height (20)

			!! sep2.make (interface_names.t_empty, system_toolbar)
			sep2.set_horizontal (False)
			sep2.set_height (20)

			!! sep3.make (interface_names.t_empty, system_toolbar)
			sep3.set_horizontal (False)
			sep3.set_height (20)

				-- Now we attach everything (this is done here for reason of speed).
			system_toolbar.attach_top (open_button, 0)
			system_toolbar.attach_left (open_button, 5)
			system_toolbar.attach_top (save_button, 0)
			system_toolbar.attach_left_widget (open_button, save_button, 0)

			system_toolbar.attach_top (sep1, 0)
			system_toolbar.attach_left_widget (save_button, sep1, 5)

			system_toolbar.attach_top (search_cmd_holder.associated_button, 0)
			system_toolbar.attach_left_widget (sep1, search_cmd_holder.associated_button, 5)

			system_toolbar.attach_top (sep2, 0)
			system_toolbar.attach_left_widget (search_cmd_holder.associated_button, sep2, 5)

			system_toolbar.attach_top (hole_button, 0)
			system_toolbar.attach_left_widget (sep2, hole_button, 5)
			system_toolbar.attach_top (shell_button, 0)
			system_toolbar.attach_left_widget (hole_button, shell_button, 0)

			system_toolbar.attach_top (sep3, 0)
			system_toolbar.attach_left_widget (shell_button, sep3, 5)

			system_toolbar.attach_top (showtext_button, 0)
			system_toolbar.attach_left_widget (sep3, showtext_button, 10)
			system_toolbar.attach_top (list_button, 0)
			system_toolbar.attach_left_widget (showtext_button, list_button, 0)
			system_toolbar.attach_top (showclass_button, 0)
			system_toolbar.attach_left_widget (list_button, showclass_button, 0)
			system_toolbar.attach_top (showhier_button, 0)
			system_toolbar.attach_left_widget (showclass_button, showhier_button, 0)
			system_toolbar.attach_top (stat_button, 0)
			system_toolbar.attach_left_widget (showhier_button, stat_button, 0)
			system_toolbar.attach_top (mod_button, 0)
			system_toolbar.attach_left_widget (stat_button, mod_button, 0)
			system_toolbar.attach_top (showindex_button, 0)
			system_toolbar.attach_left_widget (mod_button, showindex_button, 0)

			if has_close_button then
				system_toolbar.attach_top (quit_button, 0)
				system_toolbar.attach_right (quit_button, 5)
			end
		end

feature {WINDOWS} -- Attributes

	tool_name: STRING is
			-- Name of the tool representwed by Current.
		do
			Result := Interface_names.t_System
		end

feature {NONE} -- Attributes

	editable:BOOLEAN is True
			-- Is Current editable?

feature {NONE} -- Attributes Forms And Holes

	hole: SYSTEM_HOLE
			-- Hole charaterizing current

feature {NONE} -- Attributes Commands

	open_cmd_holder: COMMAND_HOLDER

	save_cmd_holder: TWO_STATE_CMD_HOLDER

	showlist_frmt_holder: FORMAT_HOLDER

	showclasses_frmt_holder: FORMAT_HOLDER

	showhier_frmt_holder: FORMAT_HOLDER

	showmodified_frmt_holder: FORMAT_HOLDER

	showindexing_frmt_holder: FORMAT_HOLDER

	showstatistics_frmt_holder: FORMAT_HOLDER

	shell: COMMAND_HOLDER

end -- class SYSTEM_W
