--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			parent_imp,
			interface
		end
	
	EV_SIMPLE_ITEM_IMP
		undefine
			parent
		redefine
			set_text,
			set_pixmap,
			remove_pixmap,
			parent_imp,
			interface
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget.
		do
			base_make (an_interface)
			width := 50
			text := ""
		end

	initialize is
		do
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	parent_imp: EV_STATUS_BAR_IMP

       set_parent (par: like parent) is
                       -- Make `par' the new parent of the widget.
                       -- `par' can be Void then the parent is the screen.
               do
				if par /= Void then
					parent_imp ?= par.implementation
				else
					parent_imp := Void
				end
               end

feature -- Measurement

	width: INTEGER
			-- The width of the item in the status bar.

feature -- Status setting

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

	remove_pixmap is
			-- If a pixmap is set, then unset it.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor
			parent_imp.set_child_owner_draw (Current, False)
		end

feature {NONE}

	interface: EV_STATUS_BAR_ITEM

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.4.5  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.12.4.4  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.4.3  1999/12/22 18:21:15  rogers
--| Removed undefinition of pixmap_size_ok, as it is no longer inherited at all.
--|
--| Revision 1.12.4.2  1999/12/17 17:31:19  rogers
--| Altered to fit in with the review branch.
--|
--| Revision 1.12.4.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
