indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM_IMP

inherit
	EV_STATUS_BAR_ITEM_I
		redefine
			parent_imp
		end
	
	EV_SIMPLE_ITEM_IMP
		undefine
			parent
		redefine
			set_text,
			set_pixmap,
			unset_pixmap,
			parent_imp
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		do
			width := 50
			text := ""
		end

	make_with_text (txt: STRING) is
			-- Create a row with text in it.
		do
			width := 50
			text := txt
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	parent_imp: EV_STATUS_BAR_IMP

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed
		do
			Result := False
		end

feature -- Measurement

	width: INTEGER
			-- The width of the item in the status bar.

feature -- Status setting

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
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

--	destroy is
--			-- Destroy the current item
--		do
--			if parent_imp /= Void then
--				parent_imp.remove_item (Current)
--				parent_imp := Void
---			end
--			interface.remove_implementation
--			interface := Void
--		end

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
		do
			width := value
			if parent_imp /= Void then
				parent_imp.update_edges
			end
		end

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_imp.internal_set_text (Current, txt)
			end
		end

	set_pixmap (pix: EV_PIXMAP) is
			-- Assign `pixmap' to `Current'.
			-- Notify parent to set owner draw for `Current'
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (pix)
			parent_imp.set_child_owner_draw (Current, True)
		end

	unset_pixmap is
			-- If a pixmap is set, then unset it.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor
			parent_imp.set_child_owner_draw (Current, False)
		end

end -- class EV_STATUS_BAR_ITEM_IMP

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
