indexing
	description:
		"Item for use with EV_STATUS_BAR."
	status: "See notice at end of class."
	keywords: "status, bar, report, message"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM

inherit
	EV_ITEM
		redefine
			implementation,
			create_implementation,
			parent
		end

	EV_TEXTABLE
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	parent: EV_STATUS_BAR is
			-- Contains `Current'.
		do
			Result ?= {EV_ITEM} Precursor
		end

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		end

feature -- Status setting

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
			-- If -1, then the item reach the right of the status bar.
			--| FIXME what kind up hella ungly hack is this?
			--| Screw you guys, I'm going home.
			--| <IRONIC> RESPECT MY AUTHORITAY!! </IRONIC>
		require
			has_parent: parent /= Void
			valid_value: a_width >= -1
			maximise_ok: a_width = -1
				implies (parent.i_th (parent.count) = Current)
		do
			implementation.set_width (a_width)
		ensure
			width_set: (a_width = width) or (a_width = -1)
		end

feature {NONE} -- Implementation

	implementation: EV_STATUS_BAR_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_STATUS_BAR_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_STATUS_BAR_ITEM

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
--| Revision 1.18  2000/04/07 22:15:40  brendel
--| Removed EV_SIMPLE_ITEM from inheritance hierarchy.
--|
--| Revision 1.17  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.16  2000/03/13 22:11:44  king
--| Defined creation procedures
--|
--| Revision 1.15  2000/03/01 20:28:52  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.14  2000/02/29 18:09:08  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.13  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.12  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.4.6  2000/02/07 20:17:12  king
--| Removed invalid creation procedure declarations
--|
--| Revision 1.11.4.5  2000/02/05 02:47:46  oconnor
--| released
--|
--| Revision 1.11.4.4  2000/02/04 21:15:45  king
--| Added has_parent precond to set-width
--|
--| Revision 1.11.4.3  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.4.2  1999/12/17 21:12:19  rogers
--| Advanced make procedures hav been removed, ready for re-implementation.
--|
--| Revision 1.11.4.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
