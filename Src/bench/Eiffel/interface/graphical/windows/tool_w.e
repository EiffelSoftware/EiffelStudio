indexing
	description: "Ancestor of all tools in the workbench, providing %
					%dragging capabilities (transport)"
	date: "$Date$"
	revision: "$Revision$"

deferred class TOOL_W 

inherit
	NAMER

	HOLE

	CLOSEABLE

	HELPABLE

	TAB_INFORMATION

	SHARED_CONFIGURE_RESOURCES

	SHARED_PLATFORM_CONSTANTS

	EB_CONSTANTS

feature -- Window Properties

	last_format: FORMAT_HOLDER
			-- Last format used

	tab_length: INTEGER
			-- Length of tabulation.

	is_a_shell: BOOLEAN is
			-- Is Current part of a shell?
		do
			Result := eb_shell /= Void
		end

	eb_shell: EB_SHELL is
			-- Shell representing Current
		deferred
		end

	popup_parent: COMPOSITE is
			-- Parent for popups created for Current tool
		do
			if is_a_shell then
				Result := eb_shell
			else
				Result := global_form
			end
		end

	global_form: FORM is
			-- Form representing Current
		deferred
		end

	history: STONE_HISTORY
			-- History list for Current.

	stone: STONE
			-- Stone in tool

	file_name: STRING
			-- Name of the file being displayed

	text_window: TEXT_WINDOW
			-- Text window attached to Current

	read_only_text_window, editable_text_window: TEXT_WINDOW is
			-- Text window that cannot be edited
			-- Text window that can be edited
		do
			Result := text_window
		end

	tool_name: STRING is 
			-- Name of the tool
		do
		end

	realized: BOOLEAN is
			-- Is Current realized?
		deferred
		end

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		deferred
		end

	title: STRING is
			-- The title of the window.
		deferred
		end

	save_cmd_holder: TWO_STATE_CMD_HOLDER is
			-- The command to save the contents of Current.
		do
		end

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

	menu_bar: BAR
			-- Menu bar

	edit_menu: MENU_PULL
			-- Edit menu
			-- Only used during debugging

	file_menu: MENU_PULL
			-- File menu

	help_menu: MENU_PULL
			-- Help menu

	toolbar_parent: ROW_COLUMN
			-- Toolbar parent

	edit_bar, format_bar: TOOLBAR
			-- Main and format button bars

	target: WIDGET is
			-- Target of the hole is the text window.
		do
			Result := text_window.hole_target
		end

	hole_button: EB_BUTTON_HOLE
			-- Button to represent Current's default hole.

	history_window_title: STRING is
			-- Title of the history window
		do
			Result := Interface_names.t_Empty
		end

	icon_id: INTEGER is
			-- Icon id for window (for windows)
		do
		end

feature -- Access

	resources: RESOURCE_CATEGORY is
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

	help_index: INTEGER is
			-- Index of help file nmae
		do
		end

	help_file_name: FILE_NAME is
			-- Help file name
		do
		end

	associated_help_widget: WIDGET is
			-- Associated parent widget for help window
		do
			Result := popup_parent
		end

feature -- Window Implementation

	display is
			-- Display tool.
		do
			set_default_position
			set_default_size
			eb_shell.display
			init_text_window
		end

	show is
			-- Show Current on the screen.
		deferred
		end

	raise is
			-- Raise Current to the top.
		deferred
		end

	force_raise is
			-- Raise Current (even if popped down).
		do
			if is_a_shell then
				if eb_shell.is_iconic_state then
					eb_shell.set_normal_state
				end
				eb_shell.raise
			end
		end

	destroy is
			-- Destroy the window.
		require
			is_a_shell: is_a_shell
		deferred
		end

	hide is
			-- Hide Current from the screen.
		require
			is_a_shell: is_a_shell
		deferred
		end

	close_windows is
			-- Close the related windows.
			-- Used for popping down.
		deferred
		end

	close is
			-- Close Current.
		do
			hide
			reset
		end

	initialize_text_window_resources is
			-- Initialize the graphical resources for the text window.
		do
			if read_only_text_window /= editable_text_window then
				read_only_text_window.init_resource_values
				editable_text_window.init_resource_values
			else
				text_window.init_resource_values
			end
		end

	close_search_window is
			-- Close search window.
		local
			ss: SEARCH_STRING
		do
			ss ?= search_cmd_holder.associated_command
			ss.close_search_window
		end

	close_print_window is
			-- Close print window.
		local
			pc: PRINT_COMMAND
		do
			pc ?= print_cmd_holder.associated_command
			pc.close_print_window
		end

feature -- Window settings

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require
			format_exists: f /= Void
		do
			if last_format /= f then
				if last_format /= Void then
					last_format.set_selected (False)
				end
				last_format := f
				last_format.set_selected (True)
			else
				last_format.set_selected (True)
			end
		ensure
			last_format_set: last_format = f
		end

	set_default_position is
			-- Set the position to its default.
		deferred
		end

	set_default_size is
			-- Set the size to its default.
		deferred
		end

	set_default_format is
			-- Default format of windows.
		do
		end

	set_icon_name (s: STRING) is
			-- Set `s' to the name shown just below the icon.
		deferred
		end

	set_title (s: STRING) is
			-- Set `title' to `s'.
		deferred
		end

	set_mode_for_editing is
			-- Set edit mode for text modification.	
			-- (By default it is set to read only)
		do
			text_window.set_read_only
		end

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		do
			tab_length := new_length
			if read_only_text_window /= editable_text_window then
				read_only_text_window.set_changed (True)
				read_only_text_window.set_tab_length (new_length)
				read_only_text_window.set_changed (False)
				editable_text_window.set_changed (True)
				editable_text_window.set_tab_length (new_length)
				editable_text_window.set_changed (False)
			else
				text_window.set_changed (True)
				text_window.set_tab_length (new_length)
				text_window.set_changed (False)
				if text_window.is_graphical and then not (file_name /= Void) then
					synchronize
				end
			end
		end

feature -- Status setting

	set_stone (s: like stone) is
		require
			valid_stone_type: s /= Void implies s.stone_type = stone_type
		do
			stone := s
			if s = Void then
				set_icon_name (tool_name)
			else
				set_icon_name (s.icon_name)
				if hole_button /= Void then
					hole_button.set_full_symbol
				end
			end
		ensure
			set: s = stone
		end

	set_font_to_default is
			-- Set `font' to the default font.
		do
			text_window.set_font_to_default
		end

	set_file_name (f: STRING) is
			-- Assign `f' to file_name.
		do
			file_name := f
		end

feature -- Text window creation

	build_text_windows (parent_form: COMPOSITE) is
			-- Create `read_text_window' and `editable_text_window'.
			--| All windows have a read only text window. However,
			--| only certain windows have editable text.
		local
			ro_text_window, ed_text_window: TEXT_WINDOW
		do
			if is_graphics_disabled then
				!SCROLLED_TEXT_WINDOW! ro_text_window.make_from_tool (new_name, parent_form, Current)
			else
				!GRAPHICAL_TEXT_WINDOW! ro_text_window.make_from_tool (new_name, parent_form, Current)
			end
			set_read_only_text_window (ro_text_window)
			if has_editable_text and then not ro_text_window.is_editable then
				!SCROLLED_TEXT_WINDOW! ed_text_window.make_from_tool (new_name, parent_form, Current)
				set_editable_text_window (ed_text_window)
				text_window := ed_text_window
			else
				if has_editable_text then
					set_editable_text_window (ro_text_window)
					text_window := ro_text_window
				end
				text_window := ro_text_window
			end
			check
				text_window_set: text_window /= Void
			end
			set_mode_for_editing
		end

feature -- Update

	set_read_only_text is
			-- Set `text_window' to `read_only_text_window'.
		do
			text_window := read_only_text_window
		ensure
			set: text_window = read_only_text_window 
		end

	show_read_only_text is
			-- Show `read_only_text_window'.
		require
			is_readonly_text: text_window = read_only_text_window
			realized: realized
		do
			if 
				read_only_text_window /= editable_text_window and then
				not read_only_text_window.shown 
			then
				text_window.show
				editable_text_window.hide	
			end
		ensure
			read_only_shown: read_only_text_window.shown
		end

	set_editable_text is
			-- Set `text_window' to `editable_text_window'.
		do
			text_window := editable_text_window
		ensure
			set: text_window = editable_text_window 
		end

	show_editable_text is
			-- Set `text_window' to `editable_text_window' and
			-- show it if it is not shown.
		require
			is_editable_text: text_window = editable_text_window
			realized: realized
		do
			if read_only_text_window /= editable_text_window and then
				not editable_text_window.shown 
			then
				text_window.show
				read_only_text_window.hide	
			end
		ensure
			editable_text_shown: editable_text_window.shown
		end

	update_save_symbol is
			-- Update the save symbol in tool.
		do
			if save_cmd_holder /= Void then
				if text_window.changed then
					save_cmd_holder.change_state (False)
				else
					save_cmd_holder.change_state (True)
				end
			end
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
			set_editable_text
			show_editable_text
			text_window.set_text (f.laststring)
			set_mode_for_editing
			text_window.set_changed (True)
			update_save_symbol
			set_default_format
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
			set_editable_text
			show_editable_text
			text_window.set_text (f.laststring)
			set_mode_for_editing
			update_save_symbol
			set_file_name (f.name)
			set_title (f.name)
			set_default_format
			reset_stone
		ensure
			up_to_date: not text_window.changed
			no_stone: stone = Void
		end

	synchronise_stone is
			-- Synchronize the root stone of the window
			-- and the history's stones.
		local
			old_do_format: BOOLEAN
			f: FORMATTER
		do
			if
				stone /= Void and then
				stone.synchronized_stone /= Void
			then
				add_to_history (stone)
				history.synchronize

					-- The root stone is still valid.
				f := last_format.associated_command
				old_do_format := f.do_format
				f.set_do_format (true)
				if history.item.origin_text /= Void then
					f.execute (history.item)
				else
					f.execute (stone)
				end
				f.set_do_format (old_do_format)
			else
				history.synchronize
					-- The root stone is not valid anymore.
				history.forth
				check 
					history.after 
				end
				set_default_format
				text_window.clear_window
				set_file_name (Void)
				set_stone (Void)
				text_window.display
				update_save_symbol
				set_title (tool_name)
				if hole_button /= Void then
					hole_button.set_empty_symbol
				end
			end
		end

	update is
			-- Update the content of the window (only after saving the content of
			-- the tool.
		local
			old_do_format: BOOLEAN
			f: FORMATTER
		do
			f := last_format.associated_command
			old_do_format := f.do_format
			f.set_do_format (True)
			f.execute (stone)
			f.set_do_format (old_do_format)
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
			set_title (tool_name)
			set_font_to_default
			set_default_format
			text_window.reset
			update_save_symbol
			set_file_name (Void)
			reset_stone
			history.wipe_out
			close_windows
			if hole_button /= Void then
				hole_button.set_empty_symbol
			end
		end

	unregister_holes is
			-- Unregister holes.
		do
			if is_a_shell then
				unregister
			end
		ensure
			current_unregistered: not registered
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

	raise_grabbed_popup is
			-- Raise popup windows with exclusive grab set.
		do
			if 
				last_warner /= Void and then
				not last_warner.destroyed and then
				last_warner.is_popped_up and then
				last_warner.is_exclusive_grab 
			then
				last_warner.raise
			elseif 
				last_confirmer /= Void and then 
				last_confirmer.is_popped_up 
			then
				last_confirmer.raise
			elseif
				last_name_chooser /= Void and then
				last_name_chooser.is_popped_up
			then
				last_name_chooser.raise
			else
				window_manager.class_win_mgr.raise_shell_popup
			end
		end

	is_graphics_disabled: BOOLEAN is
			-- Is Graphics disabled for the text window?
		once 
			Result := Configure_resources.get_boolean (r_Graphics_disabled, False) 
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
			!! edit_bar.make (Interface_names.n_Command_bar_name, toolbar_parent)
			!! sep.make (Interface_names.t_Empty, toolbar_parent)
			!! format_bar.make (Interface_names.n_Format_bar_name, toolbar_parent)
			if not Platform_constants.is_windows then
				!! sep.make (Interface_names.t_Empty, toolbar_parent)
			end
		end

feature {PROJECT_W} -- Implementation

	build_edit_menu (search_button_parent: COMPOSITE) is
			-- Build a standard edit menu with `a_parent'
		require
			edit_menu_exits: edit_menu /= Void
			parent_exists: search_button_parent /= Void
		local
			cut_button: EB_MENU_ENTRY
			cut_cmd: EDIT_OPERATIONS
			copy_button: EB_MENU_ENTRY
			copy_com: EDIT_OPERATIONS
			paste_button: EB_MENU_ENTRY
			paste_cmd: EDIT_OPERATIONS
			sep: SEPARATOR
			search_button: EB_BUTTON
			search_cmd: SEARCH_STRING
			search_menu_entry: EB_MENU_ENTRY
		do
			!! cut_cmd.make_cut (Current)
			!! cut_button.make (cut_cmd, edit_menu)
			!! copy_com.make_copy (Current)
			!! copy_button.make (copy_com, edit_menu)
			!! paste_cmd.make_paste (Current)
			!! paste_button.make (paste_cmd, edit_menu)

			!! sep.make (Interface_names.t_Empty, edit_menu)

			!! search_cmd.make (Current)
			!! search_button.make (search_cmd, search_button_parent)
			!! search_menu_entry.make (search_cmd, edit_menu)
			!! search_cmd_holder.make (search_cmd, search_button, search_menu_entry)
		end

	build_help_menu is
			-- Create a print command to be inserted into a menu.
		require
			valid_bar: menu_bar /= Void
		local
			help_cmd: HELP_COMMAND
			help_menu_entry: EB_MENU_ENTRY
		do
			!! help_menu.make (Interface_names.m_Help, menu_bar)
			!! help_cmd.make (Current)
			!! help_menu_entry.make_default (help_cmd, help_menu)
			menu_bar.set_help_button (help_menu.menu_button)
		end

	build_print_menu_entry is
			-- Create a print command to be inserted into file menu.
		require
			valid_file_menu: file_menu /= Void
		local
			print_cmd: PRINT_COMMAND
			print_menu_entry: EB_MENU_ENTRY
			sep: SEPARATOR
		do
			!! sep.make (Interface_names.t_Empty, file_menu)
			!! print_cmd.make (Current)
			!! print_menu_entry.make (print_cmd, file_menu)
			!! print_cmd_holder.make_plain (print_cmd)
			!! sep.make (Interface_names.t_Empty, file_menu)
		end

	build_save_as_menu_entry is
			-- Create a save_as command to be inserted into file menu.
		require
			valid_file_menu: file_menu /= Void
		local
			save_as_cmd: SAVE_AS_FILE
			save_as_menu_entry: EB_MENU_ENTRY
		do
			!! save_as_cmd.make (Current)
			!! save_as_menu_entry.make (save_as_cmd, file_menu)
		end

	init_text_window is
			-- Initiatialize the text window to display text_window.
		require
			realized: realized
		do
			if read_only_text_window /= editable_text_window then
				editable_text_window.init_resource_values
				read_only_text_window.init_resource_values
				if text_window = editable_text_window then
					read_only_text_window.hide
					editable_text_window.show
				else
					editable_text_window.hide
					read_only_text_window.show
				end
			else
				text_window.init_resource_values
			end
		end

	set_editable_text_window (ed: like editable_text_window) is
			-- Set `editable_text_window' to `ed'.
		require
			valid_ed: ed /= Void and then ed.is_editable
			has_editable_text: has_editable_text
		do
		ensure
			set: editable_text_window = ed
		end

	set_read_only_text_window (ed: like read_only_text_window) is
			-- Set `read_only_text_window' to `ed'.
		require
			valid_ed: ed /= Void
		do
			-- If it is not redefined the postcondition is still meet.
		ensure
--			set: read_only_text_window = ed
		end

feature {TEXT_WINDOW} -- Initialization

	init_modify_action (a_text_window: SCROLLED_TEXT_WINDOW) is
			-- Initialization of the text window action.
		do
		end
 
invariant

	non_void_history: history /= Void

end -- class TOOL_W
