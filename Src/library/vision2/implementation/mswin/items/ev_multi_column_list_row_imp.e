indexing
	description:
		"Eiffel Vision multi column list row. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			parent_imp,
			interface
		select
			pixmap
		end

	EV_ITEM_IMP
		rename
			pixmap as ev_item_imp_pixmap
		undefine
			parent,
			set_pixmap,
			remove_pixmap,
			pixmap_equal_to
		redefine
			parent_imp,
			interface,
			on_parented
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the row with one column by default.
			-- The sub-items start at 2. 1 is the index of
			-- the current item.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			is_initialized := True
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			Result := parent_imp.internal_is_selected (Current)
		end
		
	tooltip: STRING is
			-- Text of tooltip assigned to `Current'.
		do
			if internal_tooltip_string = Void then
				Result := ""
			else
				Result := internal_tooltip_string.twin	
			end
		end

feature -- Status setting

	enable_select is
			-- Select `Current'.
		do
			parent_imp.internal_select (Current)
		end

	disable_select is
			-- Deselect Current.
		do
			parent_imp.internal_deselect (Current)
		end

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.twin
		end

feature {EV_ANY_I} -- Access

	index: INTEGER is
			-- Index of `Current' in `Parent_imp'.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
		-- The parent of `Current'.

	on_parented is
			-- `Current' just parented.
		do
		end

	set_parent_imp (par_imp: like parent_imp) is
			-- Assign `par_imp' to `parent_imp'.
			--| Make `par_imp' the new parent of `Current'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end
		
	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := a_pix.twin
			if parent_imp /= Void then
				parent_imp.set_row_pixmap (parent_imp.ev_children.index_of (Current, 1), a_pix)
			end
		end
		
	remove_pixmap is
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := Void
			if parent_imp /= Void then
				parent_imp.remove_row_pixmap (parent_imp.ev_children.index_of (Current, 1))
			end
		end
		
	on_item_added_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' has been added to index `item_index'.
		do
			if parent_imp /= Void then
				parent_imp.on_item_added_at (Current, an_item, item_index)
			end
		end

	on_item_removed_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' has been removed from index `item_index'.
		do
			if parent_imp /= Void then
				parent_imp.on_item_removed_at (Current, an_item, item_index)
			end
		end
		
feature {NONE} -- Implementation

	internal_tooltip_string: STRING
		-- Internal text of tooltip assigned to `Current'.

feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

