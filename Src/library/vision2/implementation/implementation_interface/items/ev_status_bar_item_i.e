--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STATUS_BAR_ITEM_I

inherit
	EV_SIMPLE_ITEM_I
		redefine
			parent
		end

feature -- Access

	parent: EV_STATUS_BAR is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_SIMPLE_ITEM_I} Precursor
		end

feature -- Measurement

	width: INTEGER is
			-- The width of the item in the status bar.
		require
		deferred
		end

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item reach the right of the status
			-- bar.
		require
			has_parent: parent_imp /= Void
			valid_value: value >= 0 or value = -1
		deferred
		ensure
			width_set: (width = value) or (value = -1)
		end

feature -- Element change

--	set_parent (par: EV_STATUS_BAR) is
--			-- Make `par' the new parent of the widget.
--			-- `par' can be Void then the parent is the screen.
--		deferred
--		end

end -- class EV_STATUS_BAR_ITEM_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.4  2000/02/05 02:47:46  oconnor
--| released
--|
--| Revision 1.10.6.3  2000/02/04 21:30:24  king
--| Added has_parent precond to set_width
--|
--| Revision 1.10.6.2  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
