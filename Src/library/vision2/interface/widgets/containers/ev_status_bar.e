--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end

	EV_ITEM_LIST [EV_STATUS_BAR_ITEM]
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create

feature -- Implementation

	implementation: EV_STATUS_BAR_I
			-- Platform dependent access.
	
	create_implementation is
			-- Create implementation of status bar.
		do
			create {EV_STATUS_BAR_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_PRIMITIVE} Precursor
			{EV_ITEM_LIST} Precursor
		end

end -- class EV_STATUS_BAR

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
--| Revision 1.10  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.9  2000/02/05 02:04:56  brendel
--| Put back inheritance from EV_PRIMITIVE because it does not work at all.
--|
--| Revision 1.9.6.8  2000/02/05 01:03:47  oconnor
--| released
--|
--| Revision 1.9.6.7  2000/02/04 22:47:00  king
--| Removed inheritence from primitive
--|
--| Revision 1.9.6.6  2000/02/04 21:19:10  king
--| Removed redundant clutter
--|
--| Revision 1.9.6.5  2000/01/29 01:05:05  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.9.6.4  2000/01/27 19:30:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.3  1999/12/17 19:19:55  rogers
--| parent_needed is no longer redefined.
--|
--| Revision 1.9.6.2  1999/11/30 22:38:44  oconnor
--| removed item_type
--|
--| Revision 1.9.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.5  1999/11/23 23:01:49  oconnor
--| undefine create_action_sequences on repeated inherit
--|
--| Revision 1.9.2.4  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.9.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
