--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision Toolbar button, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_BUTTON_I

inherit
	EV_ITEM_I
		redefine
			parent,
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

feature -- Access

	parent: EV_TOOL_BAR is
			-- The parent of the Current widget
			-- Can be void.
		do
			if Precursor /= Void then
				Result ?= Precursor
				check
					parent_is_toolbar: Result /= Void
				end
			end
		end

feature -- Access

	gray_pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		require
			gray_pixmap_not_void: a_gray_pixmap /= Void
		deferred
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		deferred
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is the current button sensitive?
		deferred
		end

feature -- Status setting

	enable_sensitive is
			-- Enable sensitivity to user input events.
		deferred
		ensure
			is_sensitive: is_sensitive
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		deferred
		ensure
			not_is_sensitive: not is_sensitive
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.15  2000/04/07 22:09:23  brendel
--| EV_SIMPLE_ITEM_I -> EV_ITEM_I & EV_TEXTABLE_I.
--|
--| Revision 1.14  2000/03/29 20:23:29  brendel
--| Improved `parent'.
--|
--| Revision 1.13  2000/03/20 23:36:20  pichery
--| - Added gray pixmap notion. Added the possibility to attach a gray pixmap
--|   to a button.
--|
--| Revision 1.12  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.8  2000/02/04 04:02:41  oconnor
--| released
--|
--| Revision 1.10.6.7  2000/02/02 00:48:52  king
--| Corrected inheritence from item_list from tb button to tb item
--|
--| Revision 1.10.6.6  2000/01/28 18:54:18  king
--| Removed redundant features, changed to generic structure of ev_item_list
--|
--| Revision 1.10.6.5  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.4  2000/01/26 23:24:20  king
--| Removed redundant features, changed sensitivity features from set to enable/disable
--|
--| Revision 1.10.6.3  1999/12/22 18:23:11  rogers
--| Removed pixmap_size_ok as it is no longer pertinent.
--|
--| Revision 1.10.6.2  1999/12/17 19:06:27  rogers
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I replaces EV_PND_SOURCE and EV_PND_TARGET.
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
