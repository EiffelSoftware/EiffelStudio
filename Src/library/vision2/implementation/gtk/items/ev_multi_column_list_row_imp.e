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
	make

feature {NONE} -- Initialization

	make (par: EV_MULTI_COLUMN_LIST) is
		-- Create an empty row.
		do
			parent_imp ?= par.implementation
		end

feature -- Access

	parent: EV_MULTI_COLUMN_LIST is
			-- List that container this row
		do
			Result ?= parent_imp.interface
		end

	columns: INTEGER is
			-- Number of columns in the row
		do
			Result := parent_imp.columns
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		do
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				gtk_clist_select_row (parent_imp.widget, index, 0)
			else
				gtk_clist_unselect_row (parent_imp.widget, index, 0)
			end
		end

feature -- Element Change

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		local
			ctxt: ANY
		do
			ctxt ?= a_text.to_c
			gtk_clist_set_text (parent_imp.widget, index, column - 1, $ctxt)
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_index (value: INTEGER) is
			-- Make `value' the new index.
		do
			index := value
		end

feature {NONE} -- Implementation

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
		-- Multi-column list that own the current object 

	index: INTEGER
		-- Index of the row in the parent list

	text: ARRAY [STRING]
		-- Text in the cells

	pixmaps: ARRAY [EV_PIXMAP]
		-- Pixmaps in the cells

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
