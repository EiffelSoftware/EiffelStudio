indexing
	description: "Window describing the assembly of an Eiffel system (Ace, universe, ...)"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_TOOL 

inherit
	EB_MULTIFORMAT_EDIT_TOOL
		rename
			edit_bar as system_toolbar,
			build_edit_bar as build_system_toolbar
--			System_type as stone_type
		redefine
			make, build_interface,
			init_commands,
			save_text,
			empty_tool_name, stone, 
			synchronise_stone,
--			process_system,
			format_list,
			parse_file,
--			process_class, process_classi,
--			process_ace_syntax, compatible,
			set_mode_for_editing,
			has_editable_text,
			able_to_edit, icon_id,
			build_file_menu
		end

	EB_SYSTEM_TOOL_DATA
		rename
			System_resources as resources
		end
		
	PROJECT_CONTEXT

	SHARED_LACE_PARSER

creation
	make

feature -- Initialization

	make (man: EB_TOOL_MANAGER) is
		do
--			resources.add_user (Current)
			Precursor (man)
--			set_default_size
--			set_default_format
--			set_default_position
		end

	init_formatters is
		do
			create format_list.make (Current)
			set_last_format (format_list.default_format)
		end

	init_commands is
		do
			Precursor
			create open_cmd.make (Current)
			create save_cmd.make (Current)
			create save_as_cmd.make (Current)
			create shell_cmd.make (Current)
			create filter_cmd.make (Current)
		end

feature {EB_TOOL_MANAGER} -- Initialize

	build_interface is
		do
			precursor

			if resources.command_bar.actual_value = False then
				system_toolbar.hide
			end
		end

feature -- Access

	stone: SYSTEM_STONE

--	help_index: INTEGER is 7
		
	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_System_id
		end

	format_list: EB_SYSTEM_FORMATTER_LIST

feature -- Window Settings

	close_windows is
			-- Close sub-windows.
		do
		end
 
feature -- Access

	format_bar_is_used: Boolean is False

--	compatible (a_stone: STONE): BOOLEAN is
--			-- Is Current hole compatible with `a_stone'?
--		do
--			Result :=
--				a_stone.stone_type = stone_type or else
--				a_stone.stone_type = Class_type 
--		end

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
			Result := (last_format = format_list.text_format)
		end

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
		do
			Result := (last_format = format_list.text_format)
		end

	changed: BOOLEAN is
		do
			Result := text_window.changed
		end

feature -- Status setting

	set_mode_for_editing is
			-- Set edit mode on.
		do
			text_window.set_editable (True)
		end

feature -- Parsing

	parse_file: BOOLEAN is
		local
			retried: BOOLEAN
			syntax_error: SYNTAX_ERROR
			syntax_stone: ACE_SYNTAX_STONE
			error_msg, msg: STRING
			wd: EV_WARNING_DIALOG
		do
			Parser.parse_file (file_name)

			syntax_error := Parser.last_syntax_error
			if syntax_error /= Void then
				error_msg := "Ace has syntax error"
				msg := syntax_error.syntax_message

				if not msg.empty then
					error_msg.append (" (")
					error_msg.append (msg)
					error_msg.extend (')')
				end
				
				error_msg.append (".%NSee higlighted area")
				create syntax_stone.make (syntax_error)
				process_ace_syntax (syntax_stone)
				Parser.clear_syntax_error
				create wd.make_default (parent, Interface_names.t_Warning, error_msg)
			else
				text_window.update_clickable_from_stone (stone)
				Result := True
			end
		end

feature -- Update

	process_system (s: SYSTEM_STONE) is
			-- Process system stone.
		do
			last_format.format (s)
		end

	process_ace_syntax (syn: ACE_SYNTAX_STONE) is
			-- Display the syntax error in the System tool.
			--| If the text has been modified, we are loosing the changes.
		local
			arg: EV_ARGUMENT1 [ANY]
		do
			create arg.make (syn)
			format_list.text_format.launch_cmd.execute (arg, Void)
			text_window.deselect_all
			text_window.set_position (syn.start_position)
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
			last_f: EB_FORMATTER
		do
			if stone /= Void then
				last_f := last_format
				!! system_stone
				old_do_format := last_f.do_format
				last_f.set_do_format (true)
				last_f.format (system_stone)
				last_f.set_do_format (old_do_format)
			end
		end

	show_file_content (a_file_name: STRING) is
			-- Display content of file named `a_file_name'
			-- do not change title, nor file_name
		local
			a_file: PLAIN_TEXT_FILE
		do
			create a_file.make_open_read (a_file_name)
			a_file.readstream (a_file.count)
			a_file.close
			text_window.clear_window
--			set_editable_text
--			show_editable_text
			text_window.set_text (a_file.laststring)
			set_file_name (a_file_name)
			set_mode_for_editing
			update_save_symbol
			reset_stone
		ensure
			up_to_date: not text_window.changed
			no_stone: stone = Void
		end

feature {NONE} -- Implementation Graphical Interface

--	build_save_as_menu_entry is
--			-- Create a save_as command to be inserted into file menu.
--		local
--			save_as_cmd: SAVE_AS_SYSTEM
--			save_as_menu_entry: EB_MENU_ENTRY
--		do
--			!! save_as_cmd.make (Current)
--			!! save_as_menu_entry.make (save_as_cmd, file_menu)
--		end

--	create_toolbar (a_parent: COMPOSITE) is
--			-- Create a toolbar_parent with parent `a_parent'.
--		local
--			sep: THREE_D_SEPARATOR
--		do
--			!! toolbar_parent.make (new_name, a_parent)
--			!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			toolbar_parent.set_column_layout
--			toolbar_parent.set_free_size	
--			toolbar_parent.set_margin_height (0)
--			toolbar_parent.set_spacing (1)
--			!! system_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
--			if not Platform_constants.is_windows then
--				!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			else
--				system_toolbar.set_height (22)
--			end
--		end

--	build_toolbar_menu is
--			-- Build the toolbar menu under the special sub menu.
--		local
--			sep: SEPARATOR
--			toolbar_t: TOGGLE_B
--		do
--			!! sep.make (Interface_names.t_Empty, special_menu)
--			!! toolbar_t.make (system_toolbar.identifier, special_menu)
--			system_toolbar.init_toggle (toolbar_t)
--		end

	build_system_toolbar (a_toolbar: EV_BOX) is
		local
--			quit_cmd: QUIT_SYSTEM
--			has_close_button: BOOLEAN
--			case_storage_cmd: CASE_STORAGE
--			case_storage_button: EB_BUTTON
--			case_storage_menu_entry: EB_MENU_ENTRY
			b: EV_BUTTON
			sep: EV_VERTICAL_SEPARATOR
		do
			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_Open)
			b.add_click_command (open_cmd, Void)

			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_Save)
			b.add_click_command (save_cmd, Void)

			create sep.make (a_toolbar)

				-- Should we have a close button?
--			has_close_button := General_resources.close_button.actual_value

--			create hole.make (Current)
			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_System_dot)
--			b.add_click_command (hole, Void)

			create b.make (a_toolbar)
			b.set_pixmap (Pixmaps.bm_Shell)
--			shell_button.add_button_press_action (3, shell_cmd, Void)
			b.add_click_command (shell_cmd, Void)

			create sep.make (a_toolbar)

			create format_bar.make (a_toolbar)

				-- Should we have a close button?
--			has_close_button := Tool_resources.close_button.actual_value

--			if has_close_button then
--				create sep.make (a_toolbar)
--				create b.make (a_toolbar)
--				b.set_pixmap (Pixmaps.bm_Quit)
--				b.add_click_command (close_cmd, Void)
--			end
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_file_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Open)
			i.add_select_command (open_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Save)
			i.add_select_command (save_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Save_as)
			i.add_select_command (save_as_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exit)
			i.add_select_command (close_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exit_project)
			i.add_select_command (exit_app_cmd, Void)

		end

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Shell)
			i.add_select_command (shell_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Filter)
			i.add_select_command (filter_cmd, Void)
		end

feature {NONE} -- Attributes

	empty_tool_name: STRING is
			-- Name of the tool represented by Current.
		do
			Result := Interface_names.t_System
		end

feature {NONE} -- Attributes

	editable:BOOLEAN is True
			-- Is Current editable?

feature

	save_text is
			-- launches the save command, if any.
		do
			save_cmd.execute (Void, Void)
		end

feature {NONE} -- Attributes Forms And Holes

--	hole: SYSTEM_HOLE
			-- Hole charaterizing current

feature {NONE} -- Commands

	open_cmd: EB_OPEN_SYSTEM_CMD

	save_cmd: EB_SAVE_SYSTEM_CMD

	save_as_cmd: EB_SAVE_SYSTEM_AS_CMD

	shell_cmd: EB_OPEN_SHELL_CMD

	filter_cmd: EB_FILTER_CMD

end -- class EB_SYSTEM_TOOL
