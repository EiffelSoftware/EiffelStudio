indexing
	description: "EiffelVision multi-column list row, mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I

	EV_EVENT_HANDLER_IMP
		export
			{EV_MULTI_COLUMN_LIST_IMP} execute_command
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_LIST_VIEW_ITEM
		rename
			text as wel_text,
			set_text as wel_set_text,
			make as wel_make
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the row with one column by default.
			-- The sub-items start at 2. 1 is the index of
			-- the current item.
		do
			wel_make
			!! subitems.make (2, 1)
		end

	make_with_text (txt: ARRAY [STRING]) is
			-- Create the row with the given text that also
			-- set the length of the row.
		do
			wel_make
			!! subitems.make (2, 1)
			set_columns (txt.count)
			set_text (txt)
		end

feature -- Access

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- List implementation that contain this row

	parent: EV_MULTI_COLUMN_LIST is
			-- List that container this row
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

	subitems: ARRAY [WEL_LIST_VIEW_ITEM]
			-- A list to keep the subitems of the item.

	columns: INTEGER is
			-- Number of columns in the row
		do
			Result := subitems.upper
		end

	index: INTEGER is
			-- Index of the row in the list
		do
			Result := iitem + 1
		end

	text: LINKED_LIST [STRING] is
			-- Return the text of the row
		do
			from
				!! Result.make
				Result.start
			until
				Result.count = columns
			loop
				Result.extend (cell_text (Result.count + 1))
			end
		end

	cell_text (column: INTEGER): STRING is
			-- Return the text of the cell number `column' .
		do
			if column = 1 then
				Result := wel_text
			else
				Result := (subitems @ column).text
			end
		end

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current row destroyed?  
		do
			Result := False
		end

	is_selected: BOOLEAN is
			-- Is the item selected
		local
			flags: INTEGER
		do
			flags := parent_imp.get_item_state (iitem, Lvis_selected)
			Result := flag_set (flags, Lvis_selected)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual object.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			interface := Void
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item.
		local
			i: INTEGER
		do
--			set_iitem (value)
			parent_imp.move_item (value, Current)
			from
				i := 2
			until
				i = columns + 1
			loop
				parent_imp.move_item (value, subitems @ i)
				i := i + 1
			end
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		local
			flags: INTEGER
		do
			if flag then
				flags := set_flag (state, Lvis_selected)
			else
				flags := clear_flag (state, Lvis_selected)
			end
			set_state (flags)
			set_statemask (Lvis_selected)
			parent_imp.update_state (iitem, Current)
		end

	set_columns (value: INTEGER) is
			-- Set the number of columns of the row.
		local
			array: ARRAY [WEL_LIST_VIEW_ITEM]
			an_item: WEL_LIST_VIEW_ITEM
			start: INTEGER
			i: INTEGER
		do
			!! array.make (2, value)
			if subitems.count > 0 then
				array.subcopy (subitems, 2, subitems.upper, 2)
				start := subitems.upper
			else
				start := 2
			end
			from
				i := start
			until
				i = value + 1
			loop
				!! an_item.make_with_attributes (Lvif_text, iitem, i - 1, 0, "")
				array.put (an_item, i)
				i := i + 1
			end
			subitems := array
		end

feature -- Element Change

	set_parent (par: EV_MULTI_COLUMN_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			new_text: ARRAY [STRING]
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_item (Current)
			end
		end

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		do
			if column = 1 then
				wel_set_text (a_text)
			else
				(subitems @ column).set_text (a_text)
			end
			if parent_imp /= Void then
				parent_imp.set_cell_text (column - 1, iitem, a_text)
			end
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is deactivated.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the item is activated.
		do
			remove_command (Cmd_item_activate)			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed
			-- when the item is deactivated.
		do
			remove_command (Cmd_item_deactivate)		
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_rows (value: INTEGER) is
			-- Set the index of the rows in the list
		local
			i: INTEGER
		do
			set_iitem (value)
			from
				i := 2
			until
				i = columns + 1
			loop
				(subitems @ i).set_iitem (value)
				i := i + 1
			end
		end

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
