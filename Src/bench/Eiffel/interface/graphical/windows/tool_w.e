indexing

	description:	
		"Ancestor of all tools in the workbench, providing %
					%dragging capabilities (transport)";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOOL_W 

inherit

	NAMER;
	SHARED_PIXMAPS;
	WINDOWS;
	INTERFACE_W;
	HOLE
		export
			{ANY} receive
		end;
	CLOSEABLE;
	SHARED_TABS

feature -- Window Properties

	last_format: FORMAT_HOLDER;
			-- Last format used

	tab_length: INTEGER;
			-- Number of blank characters in a tabulation

	is_a_shell: BOOLEAN is
			-- Is Current part of a shell?
		do
			Result := eb_shell /= Void
		end;

	eb_shell: EB_SHELL is
			-- Shell representing Current
		deferred
		end;

	popup_parent: COMPOSITE is
			-- Parent for popups created for Current tool
		do
			if is_a_shell then
				Result := eb_shell
			else
				Result := global_form
			end
		end;

	global_form: FORM is
			-- Form representing Current
		deferred
		end;

	history: STONE_HISTORY;
			-- History list for Current.

	stone: STONE;
			-- Stone in tool

	file_name: STRING;
			-- Name of the file being displayed

	stone_type: INTEGER is
			-- Stone type
		do
		end;

	text_window: TEXT_WINDOW;
			-- Text window attached to Current

	read_only_text_window: TEXT_WINDOW is
			-- Text window that cannot be edited
		do
			Result := text_window
		end;

	editable_text_window: TEXT_WINDOW is
			-- Text window that can be edited
		do
			Result := text_window
		end;

	tool_name: STRING is 
			-- Name of the tool
		do
		end;

	realized: BOOLEAN is
			-- Is Current realized?
		deferred
		end;

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		deferred
		end;

	title: STRING is
			-- The title of the window.
		deferred
		end;

	save_cmd_holder: TWO_STATE_CMD_HOLDER is
			-- The command to save the contents of Current.
		do
		end;

	reset_stone is
			-- Reset the stone to Void.
		do
			stone := Void
		ensure
			stone = Void
		end;

	search_cmd_holder: COMMAND_HOLDER;
			-- Command to search for a text.

	edit_menu: MENU_PULL;
			-- Edit menu
			-- Only used during debugging

	file_menu: MENU_PULL;
			-- File menu

	toolbar_parent: ROW_COLUMN;
			-- Toolbar parent

	target: WIDGET is
			-- Target of the hole is the text window.
		do
			Result := text_window.hole_target
		end

	hole_button: EB_BUTTON_HOLE is
			-- Button to represent Current's default hole.
			-- By default: Void
		do
		end;

feature -- Access

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
		end;

feature -- Window Implementation

	display is
			-- Display tool.
		do
			set_default_position;
			eb_shell.display;
			init_text_window;
		end;

	show is
			-- Show Current on the screen.
		deferred
		end;

	raise is
			-- Raise Current to the top.
		deferred
		end;

	destroy is
			-- Destroy the window.
		require
			is_a_shell: is_a_shell
		deferred
		end;

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
		end;

	close is
			-- Close Current.
		do
			hide;
			reset
		end;

	initialize_text_window_resources is
			-- Initialize the graphical resources for the text window.
		do
			if read_only_text_window /= editable_text_window then
				read_only_text_window.init_resource_values;
				editable_text_window.init_resource_values
			else
				text_window.init_resource_values
			end
		end;

feature -- Window settings

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require
			format_exists: f /= Void
		do
			if last_format /= f then
				if last_format /= Void then
					last_format.set_selected (False)
				end;
				last_format := f;
				last_format.set_selected (True)
			else
				last_format.set_selected (True)
			end
		ensure
			last_format_set: last_format = f
		end;

	set_default_position is
			-- Set the position to its default.
		deferred
		end;

	set_default_size is
			-- Set the size to its default.
		deferred
		end;

	set_icon_name (s: STRING) is
			-- Set `s' to the name shown just below the icon.
		deferred
		end;

	set_default_format is
			-- Default format of windows.
		do
			-- Do nothing
		end;

	set_title (s: STRING) is
			-- Set `title' to `s'.
		deferred
		end;

	set_mode_for_editing is
			-- Set edit mode for text modification.	
			-- (By default it is set to read only)
		do
			text_window.set_read_only
		end;

	default_font: CELL [FONT] is
			-- Default font
		once
			--!! Result.put (text_window.font)
			!! Result.put (Void)
		end;

	set_tab_length_to_default is
			-- Set `tab_length' to the default tab length.
		local
			was_changed: BOOLEAN
		do
			if tab_length /= default_tab_length.item then
				set_tab_length (default_tab_length.item)
			end
		end;

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		require
			valid_length: new_length > 1
		do
			tab_length := new_length;
			if read_only_text_window /= editable_text_window then
				read_only_text_window.set_tab_length (new_length);
				editable_text_window.set_tab_length (new_length);
			else
				text_window.set_tab_length (new_length);
				if 
					text_window.is_graphical and then 
					not text_window.text.empty 
				then
					synchronize
				end
			end
		ensure
			assigned: tab_length = new_length;
		end;

feature -- Status setting

	set_stone (s: like stone) is
		require
			valid_stone_type: s /= Void implies s.stone_type = stone_type
		do
			stone := s;
			if s = Void then
				set_icon_name (tool_name);
			else
				set_icon_name (s.icon_name);
				if hole_button /= Void then
					hole_button.set_full_symbol
				end;
			end
		ensure
			set: s = stone
		end;

	set_font_to_default is
			-- Set `font' to the default font.
		do
			if default_font.item /= Void then
				--set_font (default_font.item)
			end
		end;

	set_default_font (new_font: FONT) is
			-- Assign `new_font' to `default_font'.
		do
			default_font.put (new_font)
		end;

	set_font (a_font: FONT) is
			-- Set new font `a_font' to window
		do
		end;

	set_file_name (f: STRING) is
			-- Assign `f' to file_name.
		do
			file_name := f;
		end;

feature -- Text window creation

	build_text_windows is
			-- Create `read_text_window' different ways whether
			-- the tabulation mecanism is disable or not
			--| All windows have a read only text window. However,
			--| only certain windows have editable text.
		local
			ro_text_window, ed_text_window: TEXT_WINDOW
		do
			if is_graphics_disabled then
				if tabs_disabled then
					!SCROLLED_TEXT_WINDOW! ro_text_window.make_from_tool (new_name, Current)
				else
					!TABBED_TEXT_WINDOW! ro_text_window.make_from_tool (new_name, Current)
				end;
			else
				!GRAPHICAL_TEXT_WINDOW! 
					ro_text_window.make (new_name, global_form)
			end;
			set_read_only_text_window (ro_text_window);
			--if has_editable_text and then not text_window.is_editable then
			if has_editable_text then 
				if tabs_disabled then
					!SCROLLED_TEXT_WINDOW! 
						ed_text_window.make_from_tool (new_name, Current)
				else
					!TABBED_TEXT_WINDOW! 
						ed_text_window.make_from_tool (new_name, Current)
				end;
				set_editable_text_window (ed_text_window)
				text_window := ed_text_window;
			else
				text_window := ro_text_window;
			end;
			check
				text_window_set: text_window /= Void
			end;
			set_mode_for_editing;
		end;

feature -- Update

	set_read_only_text is
			-- Set `text_window' to `read_only_text_window'.
		do
			text_window := read_only_text_window;
		ensure
			set: text_window = read_only_text_window 
		end;

	show_read_only_text is
			-- Show `read_only_text_window'.
		require
			is_readonly_text: text_window = read_only_text_window;
			realized: realized
		do
			if not read_only_text_window.shown then
				text_window.show;
				editable_text_window.hide	
			end
		ensure
			read_only_shown: read_only_text_window.shown
		end;

	set_editable_text is
			-- Set `text_window' to `editable_text_window'.
		do
			text_window := editable_text_window;
		ensure
			set: text_window = editable_text_window 
		end;

	show_editable_text is
			-- Set `text_window' to `editable_text_window' and
			-- show it if it is not shown.
		require
			is_editable_text: text_window = editable_text_window;
			realized: realized
		do
			if not editable_text_window.shown then
				text_window.show;
				read_only_text_window.hide	
			end
		ensure
			editable_text_shown: editable_text_window.shown
		end;

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
		end;

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
		end;

	show_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. Forget about clicking and stones.
		require
			file_no_void: f /= Void
			valid_file: f.exists and then f.is_readable and then f.is_plain
		do
			f.open_read;
			f.readstream (f.count);
			f.close;
			text_window.clear_window;
			set_editable_text;
			show_editable_text;
			text_window.set_text (f.laststring);
			set_mode_for_editing
			update_save_symbol;
			set_file_name (f.name);
			set_title (f.name);
			set_default_format;
			reset_stone;
		ensure
			up_to_date: not text_window.changed;
			no_stone: stone = Void
		end;

	synchronise_stone is
			-- Synchronize the root stone of the window
			-- and the history's stones.
		local
			old_do_format: BOOLEAN
			f: FORMATTER
		do
			history.extend (stone);
			history.synchronize;
			if
				stone /= Void and then
				stone.synchronized_stone /= Void
			then
					-- The root stone is still valid.
				f := last_format.associated_command;
				old_do_format := f.do_format;
				f.set_do_format (true);
				if history.item.origin_text /= Void then
					f.execute (history.item)
				else
					f.execute (stone)
				end;
				f.set_do_format (old_do_format)
			else
					-- The root stone is not valid anymore.
				history.forth;
				check 
					history.after 
				end;
				set_default_format;
				text_window.clear_window;
				set_file_name (Void);
				set_stone (Void);
				text_window.display;
				update_save_symbol;
				set_title (tool_name);
				if hole_button /= Void then
					hole_button.set_empty_symbol
				end;
			end
		end;

	parse_file is
			-- Parse the file if possible.
			-- (By default, do nothing).
		require
			valid_stone: stone /= Void
		do
		end;

feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			set_title (tool_name);
			set_font_to_default;
			set_default_format;
			set_default_size;
			text_window.clear_window;
			update_save_symbol;
			set_file_name (Void);
			reset_stone;
			history.wipe_out;
			close_windows;
			if hole_button /= Void then
				hole_button.set_empty_symbol
			end;
		end;

	unregister_holes is
			-- Unregister holes.
		do
			if is_a_shell then
				unregister
			end
		ensure
			current_unregistered: not registered
		end;

feature -- Element change

	add_to_history (a_stone: like stone) is
			-- Add `a_stone' to `history'
		require
			valid_history: history /= Void
		do
			history.extend (a_stone)
		ensure
			has_history: history.has (a_stone)
		end;

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
		end;

	is_graphics_disabled: BOOLEAN is
			-- Is Graphics disabled for the text window?
		once 
			Result := resources.get_boolean (r_Graphics_disabled, False) 
		end;

	create_toolbar_parent (a_parent: COMPOSITE) is
			-- Create a toolbar_parent with parent `a_parent'.
		do
			!! toolbar_parent.make (new_name, a_parent);
			toolbar_parent.set_column_layout;
			toolbar_parent.set_free_size;	
			toolbar_parent.set_margin_height (0);
			toolbar_parent.set_spacing (0);
		end;

feature {PROJECT_W} -- Implementation

	build_edit_menu (search_button_parent: COMPOSITE) is
			-- Build a standard edit menu with `a_parent'
		require
			edit_menu_exits: edit_menu /= Void
			parent_exists: search_button_parent /= Void
		local
			cut_button: EB_MENU_ENTRY;
			cut_cmd: EDIT_OPERATIONS;
			copy_button: EB_MENU_ENTRY;
			copy_com: EDIT_OPERATIONS;
			paste_button: EB_MENU_ENTRY;
			paste_cmd: EDIT_OPERATIONS;
			sep: SEPARATOR;
			search_button: EB_BUTTON;
			search_cmd: SEARCH_STRING;
			search_menu_entry: EB_MENU_ENTRY
		do
			!! cut_cmd.make_cut (Current);
			!! cut_button.make (cut_cmd, edit_menu);
			!! copy_com.make_copy (Current);
			!! copy_button.make (copy_com, edit_menu);
			!! paste_cmd.make_paste (Current);
			!! paste_button.make (paste_cmd, edit_menu);

			!! sep.make ("", edit_menu);

            !! search_cmd.make (Current);
            !! search_button.make (search_cmd, search_button_parent);
            !! search_menu_entry.make (search_cmd, edit_menu);
            !! search_cmd_holder.make (search_cmd, search_button, search_menu_entry);
		end;

	init_text_window is
			-- Initiatialize the text window to display text_window.
		require
			realized: realized
		do
			if read_only_text_window /= editable_text_window then
				editable_text_window.init_resource_values;
				read_only_text_window.init_resource_values;
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
			set_tab_length_to_default
		end;

	set_editable_text_window (ed: like editable_text_window) is
			-- Set `editable_text_window' to `ed'.
		require
			valid_ed: ed /= Void and then ed.is_editable;
			has_editable_text: has_editable_text
		do
		ensure
			set: editable_text_window = ed
		end;

	set_read_only_text_window (ed: like read_only_text_window) is
			-- Set `read_only_text_window' to `ed'.
		require
			valid_ed: ed /= Void;
		do
			-- If it not redefined the postcondition is still meet.
		ensure
			set: read_only_text_window = ed
		end;

feature {TEXT_WINDOW} -- Initialization

	init_modify_action (a_text_window: SCROLLED_TEXT_WINDOW) is
			-- Initialization of the text window action.
		do
		end;
 
invariant

	non_void_history: history /= Void

end -- class TOOL_W
