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
			remove_pixmap
		redefine
			parent_imp,
			interface,
			on_parented
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)is
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
			dirty_child
			parent_imp.update_children
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

