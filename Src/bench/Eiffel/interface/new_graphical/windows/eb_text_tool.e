indexing
	description:
		"A tool with a display area."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TEXT_TOOL

inherit
	EB_TOOL
		redefine
			make, destroy_imp
		end

feature {NONE} -- Initialization

	make (man: EB_TOOL_MANAGER) is
			-- Build Current with `man' as manager.
		do
			create history.make

			Precursor (man)
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
			-- Build system widget.
		do
			set_title (default_name)

			create container.make (parent)

			create_toolbar (container)
			
			build_text_area

			build_toolbar (toolbar)
		end

feature {EB_TOOL_MANAGER} -- Widget Implementation

	destroy_imp is
			-- Close Current.
		do
			history.destroy
			Precursor
		end

feature -- Window Properties

	tab_length: INTEGER
			-- Length of tabulation.

	history: STONE_HISTORY
			-- History list for Current.

	stone: STONE
			-- Stone in tool; can be Void.

	text_area: EB_FORMATTED_TEXT
			-- Text area attached to Current

	reset_stone is
			-- Reset the stone to Void.
			-- As a consequence, reset display.
		do
			stone := Void
		ensure
			stone = Void
		end

--	search_cmd_holder: COMMAND_HOLDER
			-- Command to search for a text
			--| Not implemented yet

--	print_cmd_holder: COMMAND_HOLDER
			-- Command to print text
			--| Not implemented yet

	toolbar: EV_HORIZONTAL_BOX
			-- Main button bar

	toolbar_menu_item: EV_CHECK_MENU_ITEM
			-- Item used to set if toolbar is visible.

--	hole_button: EB_BUTTON_HOLE
			-- Button to represent Current's default hole.
			--| Not implemented yet

	history_dialog_title: STRING is
			-- Title of the history dialog
		do
			Result := Interface_names.t_Empty
		end

feature -- Access

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text area?
			-- False by default.
		do
		end

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
			-- False by default
		do
		end

feature -- Window Implementation

--	raise is
--			-- Display tool.
--		do
--			set_default_position
--			set_default_size
--			show
--			init_text_area
--		end
--
--| FIXME
--| Christophe, 14 oct 1999
--| Not used but might be handy

	force_raise is
			-- Raise Current (even if popped down).
		obsolete
			"Use `raise' instead"
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

	initialize_text_area_resources is
			-- Initialize the graphical resources for the text area.
		do
			text_area.init_resource_values
		end

--	close_search_dialog is
--			-- Close search dialog.
--		local
--			ss: SEARCH_STRING
--		do
--			ss ?= search_cmd_holder.associated_command
--			ss.close_search_dialog
--		end
--| FIXME
--| Christophe, 14 oct 1999
--| No search dialog now.

--	close_print_dialog is
--			-- Close print dialog.
--		local
--			pc: PRINT_COMMAND
--		do
--			pc ?= print_cmd_holder.associated_command
--			pc.close_print_dialog
--		end
--| FIXME
--| Christophe, 14 oct 1999
--| The closing dialog policy not defined.

feature -- Window settings

--	set_default_position is
--			-- Set the position to its default.
--		deferred
--		end

--	set_default_size is
--			-- Set the size to its default.
--		deferred
--		end

--| FIXME
--| Christophe, 14 oct 1999
--| Related to commented raise: might become handy.

	set_mode_for_editing is
			-- Set edit mode for text modification.	
			-- (By default it is set to read only)
		do
			text_area.set_editable (False)
		end

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		do
--			tab_length := new_length
--			text_area.set_changed (True)
--			text_area.set_tab_length (new_length)
--			text_area.set_changed (False)
--			end
		end

feature -- Status setting

	set_stone (s: like stone) is
			-- make `s' the new value of stone.
			-- Changes display as a consequence, to preserve the fact
			-- that the tool displays the content of the stone
			-- (when there is a stone).
		require
--			valid_stone_type: s /= Void implies s.stone_type = stone_type
		do
			stone := s
--			if s = Void then
--				set_icon_name (default_name)
--			else
--				set_icon_name (s.icon_name)
--				if hole_button /= Void then
--					hole_button.set_full_symbol
--				end
--			end
--| FIXME
--| Christophe, 3 nov 1999
--| `set_icon_name' not implemented

		ensure
			set: s.same_as (stone)
		end

	set_font_to_default is
			-- Set `font' to the default font.
			--| FIXME
			--| Christophe 15 oct 1999
			--| What is the use of this feature?
			--| What is a default font?
		do
--			text_area.set_font_to_default
		end

feature -- Text area creation

	build_text_area is
			-- Create the text component where the information will be displayed.
		do
			create {EB_CLICKABLE_RICH_TEXT} text_area.make (container)
			check
				text_area_set: text_area /= Void
			end
			set_mode_for_editing
		end

feature -- Update

	toolbar_menu_update (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Action performed when user presses
			-- the "Standard toolbar" menu
		require
			menu_item_exists: toolbar_menu_item /= Void
		do
			if toolbar_menu_item.is_selected then
				toolbar.show
			else
				toolbar.hide
			end
		ensure
			toolbar_and_entry_consistent: 
				toolbar_menu_item.is_selected = toolbar.shown
		end

	synchronize is
			-- Synchronize clickable elements with text, if possible.
			-- Nothing to do in default case.
		do
		end

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text area.
		do
			initialize_text_area_resources
			synchronize
		end

feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			set_title (default_name)
			set_font_to_default
			text_area.reset
			reset_stone
			history.wipe_out
--			close_windows
--			if hole_button /= Void then
--				hole_button.set_empty_symbol
--			end
		end

feature -- Element change

	add_to_history (a_stone: like stone) is
			-- Add `a_stone' to `history'
		require
			valid_history: history /= Void
		do
			history.add_stone (a_stone)
--|		ensure
--|			has_history: history.has (a_stone)
--| FIXME
--| Christophe, 10 nov 1999
--| `a_stone' is not always added, therefore ensure clause is
--| not true, we need to find another ensure clause.
		end

feature {NONE} -- Implementation

	create_toolbar (par: EV_BOX) is
			-- Create the toolbar with parent `par'.
		do
			create toolbar.make (par)
			par.set_child_expandable (toolbar, False)
--			toolbar.set_minimum_height (22)
		ensure
			toolbar_exists: toolbar /= Void
		end

	build_toolbar (tb: EV_BOX) is
			-- Build editing buttons in `tb'
		deferred
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_file_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Build a basic file menu with "Save as",
			-- "Print", "Close" and "Exit" entries inside `a_menu'
		require
			a_menu_exits: a_menu /= Void
		local
			i: EV_MENU_ITEM
			print_cmd: EB_PRINT_CMD
			save_as_cmd: EB_SAVE_FILE_AS_CMD
		do
			create save_as_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Save_as)
			i.add_select_command (save_as_cmd, Void)

			create print_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Print)
			i.add_select_command (print_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exit)
			i.add_select_command (close_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exit_project)
			i.add_select_command (exit_app_cmd, Void)
		end	

	build_edit_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Build standard edit menu entries in `a_menu'
--| FIXME
--| Christophe, 3 nov 1999
--| Non fonctionnal yet.
		require
			a_menu_exits: a_menu /= Void
		local
			i: EV_MENU_ITEM
--			cut_cmd: EDIT_OPERATIONS
--			copy_cmd: EDIT_OPERATIONS
--			paste_cmd: EDIT_OPERATIONS
--			sep: SEPARATOR
--			search_cmd: SEARCH_STRING
		do
--			create cut_cmd.make_cut (Current)
--			create i.make_with_text (a_menu, "Cut")
--			i.add_select_command (cut_cmd, Void)

--			create copy_cmd.make_copy (Current)
--			create i.make_with_text (a_menu, "Copy")
--			i.add_select_command (copy_cmd, Void)

--			create paste_cmd.make_paste (Current)
--			create i.make_with_text (a_menu, "Paste")
--			i.add_select_command (paste_cmd, Void)

--			create sep.make (a_menu)

--			create search_cmd.make (Current)
--			create i.make_with_text (a_menu, "Search")
--			i.add_select_command (search_cmd, Void)
		end

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Build in `a_menu' an entry allowing to popup/down `toolbar'
		require
			a_menu_exits: a_menu /= Void
		local
			cmd: EV_ROUTINE_COMMAND
		do
			create toolbar_menu_item.make_with_text (a_menu, Interface_names.n_Command_bar_name)
			create cmd.make (~toolbar_menu_update)
			toolbar_menu_item.add_select_command (cmd, Void)
			toolbar_menu_item.add_unselect_command (cmd, Void)
		end

	init_text_area is
			-- Initiatialize the tool's text area.
		require
		do
--			text_area.init_resource_values
		end

	set_text_area (ta: like text_area) is
			-- set `ta' as the area where information will be displayed.
		require
			valid_ta: ta /= Void
		do
			text_area := ta
		ensure
			set: text_area = ta
		end

feature {NONE} -- Implementation

	container: EV_VERTICAL_BOX
			-- Form representing Current

invariant
	stone_meaningful: (stone /= Void) implies stone.is_valid

end -- class EB_TEXT_TOOL
