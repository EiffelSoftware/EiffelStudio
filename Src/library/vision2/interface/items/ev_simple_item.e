--| FIXME NOT_REVIEWED this file has not been reviewed
--| FIXME Needs a name change, simple means, well, not very much at all.
indexing	
	description: 
		"Base class for items that are EV_TEXTABLE, EV_PIXMAPABLEa and%
		%EV_PICK_AND_DROPABLE"
	status: "See notice at end of class"
	--| FIXME needs keywords.
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_SIMPLE_ITEM

inherit
	EV_ITEM
		redefine
			implementation,
			create_action_sequences
		end

	--| FIXME Menu items and separators are not PND-able
	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			create_action_sequences
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

	EV_TEXTABLE
		redefine
			implementation
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_SIMPLE_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_ITEM} Precursor
			{EV_PICK_AND_DROPABLE} Precursor
		end

end -- class EV_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.24  2000/03/27 23:52:50  brendel
--| Added FIXME that menu items are not PND-able.
--|
--| Revision 1.23  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.22  2000/03/09 21:39:14  king
--| Added inheritance from PND
--|
--| Revision 1.21  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.20  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.19.6.7  2000/02/04 21:14:47  king
--| Now inheriting from textable
--|
--| Revision 1.19.6.6  2000/01/28 22:24:20  oconnor
--| released
--|
--| Revision 1.19.6.5  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.19.6.4  2000/01/26 23:21:49  king
--| Moved make_with_text up to ev_simple_item
--|
--| Revision 1.19.6.3  2000/01/14 22:28:44  oconnor
--| removed obsolete creation features
--|
--| Revision 1.19.6.2  1999/11/30 22:43:23  oconnor
--| commented out make_with_parent_and_text
--|
--| Revision 1.19.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.19.2.3  1999/11/04 23:10:51  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.19.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
