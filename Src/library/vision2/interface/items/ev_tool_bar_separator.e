indexing
	description:
		"Scored line separator for use in EV_TOOL_BAR."
	status: "See notice at end of class."
	keywords: "separator, tool, bar, line, devide"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR

inherit
	EV_TOOL_BAR_ITEM
		export
			{NONE} all
		redefine
			implementation
		end

create
	default_create

feature {EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_SEPARATOR_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE}

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_SEPARATOR_IMP} implementation.make (Current)
		end

end -- class EV_TOOL_BAR_SEPARATOR

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
--| Revision 1.10  2000/04/07 22:15:41  brendel
--| Removed EV_SIMPLE_ITEM from inheritance hierarchy.
--|
--| Revision 1.9  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.8  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.7  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.8  2000/02/01 20:15:39  king
--| Now inheriting from ev_tool_bar_item, added parent feature
--|
--| Revision 1.5.6.7  2000/01/28 22:24:20  oconnor
--| released
--|
--| Revision 1.5.6.6  2000/01/28 18:59:12  king
--| Changed parent to new generic structure
--|
--| Revision 1.5.6.5  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.4  2000/01/21 18:14:23  rogers
--| Removed make amd creation procedure to default_create.
--|
--| Revision 1.5.6.3  2000/01/21 18:04:23  rogers
--| Removed make_with_index from redefinitions, add create implementation.
--|
--| Revision 1.5.6.2  2000/01/21 18:00:02  rogers
--| Removed make_with index, as this is now no longer pertinent.
--|
--| Revision 1.5.6.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
