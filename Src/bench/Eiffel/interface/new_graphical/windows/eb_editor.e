indexing
	description:
		"EiffelBench editor. A tool that enables to display files%
		%(or at least a part of a file)."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EDITOR

inherit
	EB_TOOL
		redefine
			make
		end

feature {NONE} -- Initialization

	make (man: EB_TOOL_MANAGER) is
		do
			create history.make

			Precursor (man)
		end

	build_interface is
			-- Build system widget.
		do
			set_title (empty_tool_name)

			create container.make (parent)

			create_toolbar (container)
			
			build_text_window (container)

--			build_menus
			build_edit_bar
--			build_toolbar_menu
		end

feature -- Window Properties

	tab_length: INTEGER
			-- Length of tabulation.

	history: STONE_HISTORY
			-- History list for Current.

	stone: STONE
			-- Stone in tool

	file_name: STRING
			-- Name of the file being displayed

	text_window: EB_FORMATTED_TEXT
			-- Text window attached to Current

	reset_stone is
			-- Reset the stone to Void.
		do
			stone := Void
		ensure
			stone = Void
		end

	search_cmd_holder: COMMAND_HOLDER
			-- Command to search for a text

	print_cmd_holder: COMMAND_HOLDER
			-- Command to print text

	edit_bar: EV_HORIZONTAL_BOX
			-- Main button bar

--	target: WIDGET is
--			-- Target of the hole is the text window.
--		do
--			Result := text_window.hole_target
--		end

	hole_button: EB_BUTTON_HOLE
			-- Button to represent Current's default hole.

	history_window_title: STRING is
			-- Title of the history window
		do
			Result := Interface_names.t_Empty
		end

feature -- Access

	resources: EB_PARAMETERS is
			-- Resources for current tool
		deferred
		end

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
		end

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
		do
		end

--	associated_help_widget: EV_WIDGET is
--			-- Associated parent widget for help window
--		do
--			Result := popup_parent
--		end

feature -- Window Implementation

--	show is
--			-- Display tool.
--		do
--			set_default_position
--			set_default_size
--			show
--			init_text_window
--		end


	force_raise is
		obsolete
			"Use `raise' instead"
			-- Raise Current (even if popped down).
		do
			raise
		end


	close_windows is
			-- Close the related windows.
			-- Used for popping down.
		deferred
		end

	close is
			-- Close Current.
		obsolete 
			"use hide or destroy instead"
		do
			hide
		end

	initialize_text_window_resources is
			-- Initialize the graphical resources for the text window.
		do
			text_window.init_resource_values
		end

--	close_search_window is
--			-- Close search window.
--		local
--			ss: SEARCH_STRING
--		do
--			ss ?= search_cmd_holder.associated_command
--			ss.close_search_window
--		end

--	close_print_window is
--			-- Close print window.
--		local
--			pc: PRINT_COMMAND
--		do
--			pc ?= print_cmd_holder.associated_command
--			pc.close_print_window
--		end

feature -- Window settings

--	set_default_position is
--			-- Set the position to its default.
--		deferred
--		end

--	set_default_size is
--			-- Set the size to its default.
--		deferred
--		end

	set_mode_for_editing is
			-- Set edit mode for text modification.	
			-- (By default it is set to read only)
		do
			text_window.set_editable (False)
		end

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		do
--			tab_length := new_length
--			text_window.set_changed (True)
--			text_window.set_tab_length (new_length)
--			text_window.set_changed (False)
--			end
		end

feature -- Status setting

	set_stone (s: like stone) is
		require
--			valid_stone_type: s /= Void implies s.stone_type = stone_type
		do
			stone := s
			if s = Void then
				set_icon_name (empty_tool_name)
					-- a retoucher
			else
				set_icon_name (s.icon_name)
--				if hole_button /= Void then
--					hole_button.set_full_symbol
--				end
			end
		ensure
			set: s = stone
		end

	set_font_to_default is
			-- Set `font' to the default font.
		do
--			text_window.set_font_to_default
		end

	set_file_name (f: STRING) is
			-- Assign `f' to file_name.
		do
			file_name := f
		end

feature -- Text window creation

	build_text_window (par: EV_CONTAINER) is
			-- Create `text_window'.
		do
			create {EB_CLICKABLE_RICH_TEXT} text_window.make_from_tool (par, Current)
			check
				text_window_set: text_window /= Void
			end
			set_mode_for_editing
		end

feature -- Update

	update_save_symbol is
			-- Update the save symbol in tool.
		do
--			if save_cmd_holder /= Void then
--				if text_window.changed then
--					save_cmd_holder.change_state (False)
--				else
--					save_cmd_holder.change_state (True)
--				end
--			end
		end

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
		end

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text window.
		do
			initialize_text_window_resources
			synchronize
		end

	set_text_from_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. 
		require
			file_no_void: f /= Void
			valid_file: f.exists and then f.is_readable and then f.is_plain
		do
			f.open_read
			f.readstream (f.count)
			f.close
			text_window.clear_window
			show
			text_window.set_text (f.laststring)
			set_mode_for_editing
			text_window.set_changed (True)
			update_save_symbol
		ensure
			up_to_date: text_window.changed
		end

	show_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. Forget about clicking and stones.
		require
			file_no_void: f /= Void
			valid_file: f.exists and then f.is_readable and then f.is_plain
		do
			f.open_read
			f.readstream (f.count)
			f.close
			text_window.clear_window
			show
			text_window.set_text (f.laststring)
			set_mode_for_editing
			update_save_symbol
			set_file_name (f.name)
			set_title (f.name)
			reset_stone
		ensure
			up_to_date: not text_window.changed
			no_stone: stone = Void
		end

	synchronise_stone is
			-- Synchronize the root stone of the window
			-- and the history's stones.
		local
--			old_do_format: BOOLEAN
--			f: EB_FORMATTER
		do
--			if
--				stone /= Void and then
--				stone.synchronized_stone /= Void
--			then
--				add_to_history (stone)
--				history.synchronize
--
--					-- The root stone is still valid.
--				f := last_format.associated_command
--				old_do_format := f.do_format
--				f.set_do_format (true)
--				if history.item.origin_text /= Void then
--					f.execute (history.item)
--				else
--					f.execute (stone)
--				end
--				f.set_do_format (old_do_format)
--			else
--				history.synchronize
--					-- The root stone is not valid anymore.
--				history.forth
--				check 
--					history.after 
--				end
--				set_default_format
--				text_window.clear_window
--				set_file_name (Void)
--				set_stone (Void)
--				text_window.display
--				update_save_symbol
--				set_title (empty_tool_name)
--				if hole_button /= Void then
--					hole_button.set_empty_symbol
--				end
--			end
		end

	parse_file: BOOLEAN is 
			-- Parse the file if possible.
			-- (By default, the result is True).
		require
			valid_stone: stone /= Void
		do
			Result := True
		end

feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			set_title (empty_tool_name)
			set_font_to_default
			text_window.reset
			update_save_symbol
			set_file_name (Void)
			reset_stone
			history.wipe_out
--			close_windows
			if hole_button /= Void then
				hole_button.set_empty_symbol
			end
		end

feature -- Element change

	add_to_history (a_stone: like stone) is
			-- Add `a_stone' to `history'
		require
			valid_history: history /= Void
		do
			history.extend (a_stone)
		ensure
			has_history: history.has (a_stone)
		end

feature {NONE} -- Implementation

	create_toolbar (par: EV_CONTAINER) is
			-- Create all toolbars with parent `a_parent'.
		do
			create edit_bar.make (par)
			edit_bar.set_expand (False)
--			edit_bar.set_minimum_height (22)
		end

	build_edit_bar is
		deferred
		end

feature {EB_TOOL_MANAGER} -- Implementation

	build_edit_menu (search_button_parent: COMPOSITE) is
			-- Build a standard edit menu with `a_parent'
		require
--			edit_menu_exits: edit_menu /= Void
--			parent_exists: search_button_parent /= Void
		local
--			cut_button: EB_MENU_ENTRY
--			cut_cmd: EDIT_OPERATIONS
--			copy_button: EB_MENU_ENTRY
--			copy_com: EDIT_OPERATIONS
--			paste_button: EB_MENU_ENTRY
--			paste_cmd: EDIT_OPERATIONS
--			sep: SEPARATOR
--			search_button: EB_BUTTON
--			search_cmd: SEARCH_STRING
--			search_menu_entry: EB_MENU_ENTRY
		do
--			!! cut_cmd.make_cut (Current)
--			!! cut_button.make (cut_cmd, edit_menu)
--			!! copy_com.make_copy (Current)
--			!! copy_button.make (copy_com, edit_menu)
--			!! paste_cmd.make_paste (Current)
--			!! paste_button.make (paste_cmd, edit_menu)
--
--			!! sep.make (Interface_names.t_Empty, edit_menu)
--
--			!! search_cmd.make (Current)
--			!! search_button.make (search_cmd, search_button_parent)
--			!! search_menu_entry.make (search_cmd, edit_menu)
--			!! search_cmd_holder.make (search_cmd, search_button, search_menu_entry)
		end

	build_help_menu is
			-- Create a print command to be inserted into a menu.
		require
--			valid_bar: menu_bar /= Void
		local
--			help_cmd: HELP_COMMAND
--			help_menu_entry: EB_MENU_ENTRY
		do
--			!! help_menu.make (Interface_names.m_Help, menu_bar)
--			!! help_cmd.make (Current)
--			!! help_menu_entry.make_default (help_cmd, help_menu)
--			menu_bar.set_help_button (help_menu.menu_button)
		end

	build_print_menu_entry is
			-- Create a print command to be inserted into file menu.
		require
--			valid_file_menu: file_menu /= Void
		local
--			print_cmd: PRINT_COMMAND
--			print_menu_entry: EB_MENU_ENTRY
--			sep: SEPARATOR
		do
--			!! sep.make (Interface_names.t_Empty, file_menu)
--			!! print_cmd.make (Current)
--			!! print_menu_entry.make (print_cmd, file_menu)
--			!! print_cmd_holder.make_plain (print_cmd)
--			!! sep.make (Interface_names.t_Empty, file_menu)
		end

	build_save_as_menu_entry is
			-- Create a save_as command to be inserted into file menu.
		require
--			valid_file_menu: file_menu /= Void
		local
--			save_as_cmd: SAVE_AS_FILE
--			save_as_menu_entry: EB_MENU_ENTRY
		do
--			!! save_as_cmd.make (Current)
--			!! save_as_menu_entry.make (save_as_cmd, file_menu)
		end

	init_text_window is
			-- Initiatialize the text window to display text_window.
		require
		do
--			text_window.init_resource_values
		end

	set_text_window (ed: like text_window) is
			-- Set `text_window' to `ed'.
		require
			valid_ed: ed /= Void
		do
			text_window := ed
		ensure
			set: text_window = ed
		end

feature {EV_FORMATTED_TEXT} -- Initialization

	init_change_command (a_text_window: EB_CLICKABLE_RICH_TEXT) is
			-- Initialization of the text window action.
		local
			rc: EV_ROUTINE_COMMAND
		do
			create rc.make (~modify)
			a_text_window.add_change_command (rc, Void)	
		end

	modify (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
		end

feature {NONE} -- Implementation

	container: EV_VERTICAL_BOX
			-- Form representing Current

	edit_menu: EV_MENU
			-- Edit menu
			-- Only used during debugging

	file_menu: EV_MENU
			-- File menu

	help_menu: EV_MENU
			-- Help menu

end -- class EB_TOOL
