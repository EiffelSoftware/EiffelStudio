indexing

	description:
		"EiffelVision multi-column list row, gtk implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I

	EV_GTK_ITEMS_EXTERNALS

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create an row with one empty column.
		do
			create text.make
			text.extend ("")
		end

	make_with_text (txt: ARRAY [STRING]) is
			-- Create a row with text in it.
		local
			i: INTEGER
		do
			from
				create text.make
				i := txt.lower
			until
				i > txt.upper
			loop
				text.extend (txt @ i)
				i := i + 1
			end
 		end

	make_with_index (par:EV_MULTI_COLUMN_LIST; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		do
		end

	make_with_all (par:EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		do
		end

feature -- Access

	parent: EV_MULTI_COLUMN_LIST is
		do
			if parent_imp /= void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

	columns: INTEGER is
			-- Number of columns in the row
		do
			Result := text.count
		end

	index: INTEGER
			-- Index of the row in the list

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := text = Void
		end

	is_selected: BOOLEAN is
			-- Is the item selected
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			row ?= Current.interface			
			Result := (parent_imp.selected_items.has (row))
			 or (parent_imp.selected_item = row)
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		local
		do
			text := Void
			pixmaps := Void
			parent_imp := Void	
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item.
		do
			index := value
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				gtk_clist_select_row (parent_imp.widget, index, 0)
			else
				gtk_clist_unselect_row (parent_imp.widget, index, 0)
			end
		end

	set_columns (value: INTEGER) is
			-- if value > number of columns, add empty columns 
			-- if value < number of columns, remove the last columns
			-- does nothing if equal.
		local
			test, the_count: INTEGER
		do
			test := columns
			if (value > columns) then
				from
					text.finish
				until
					text.count = value
				loop
					text.extend ("")
					the_count := text.count
				end
			elseif (value < columns) then
				from
					text.finish
				until
					text.count = value
				loop
					text.remove
					text.finish
				end
			end
				
		end

	cell_text (column: INTEGER): STRING is
		local
			p: POINTER
			ok: INTEGER
		do
			!!Result.make (0)
			ok := gtk_clist_get_text (parent_imp.widget, index, column, $p)
			check
				get_text_ok: ok > 0
			end
			Result.from_c (p)
		end


feature -- Element Change

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		local
			ctxt: ANY
		do
			ctxt := a_text.to_c
			gtk_clist_set_text (parent_imp.widget, index, column - 1, $ctxt)
		end

	set_parent (par: EV_MULTI_COLUMN_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if (par /= void) then
				parent_imp ?= par.implementation
				check
					parent_not_void: parent_imp /= Void
				end
				parent_imp.add_item (Current)
			end					
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		do
			check false end
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is deactivated.
		do
			check false end
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the item is activated.
		do			
			check false end
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed
			-- when the item is deactivated.
		do
			check false end
		end

feature {NONE} -- Implementation

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
		-- Multi-column list that own the current object 

	pixmaps: ARRAY [EV_PIXMAP]
		-- Pixmaps in the cells

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	text: LINKED_LIST [STRING]
		-- Text in the cells

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
