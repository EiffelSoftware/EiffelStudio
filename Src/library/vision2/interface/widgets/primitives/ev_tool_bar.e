--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision toolbar. Only toolbar items%
		% can be placed into a tool-bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

	EV_ITEM_LIST [EV_TOOL_BAR_ITEM]
		undefine
			create_action_sequences
		redefine
			implementation
		end

create
	default_create

feature -- Initialization

	implementation: EV_TOOL_BAR_I
			-- Platform dependent access.

	create_implementation is
			-- Create implementation of button.
		do
			create {EV_TOOL_BAR_IMP} implementation.make (Current)
		end

end -- class EV_TOOL_BAR

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
--| Revision 1.7  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.9  2000/02/01 20:17:47  king
--| Changed inheritence structure to use tool_bar_items
--|
--| Revision 1.6.6.8  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.6.6.7  2000/01/28 19:05:29  king
--| Altered to new generic structure of ev_item_list
--|
--| Revision 1.6.6.6  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.5  2000/01/26 23:17:24  king
--| Removed redundant features from interface
--|
--| Revision 1.6.6.4  2000/01/20 16:48:56  rogers
--| Implemented create_implementation.
--|
--| Revision 1.6.6.3  1999/12/17 19:24:32  rogers
--| item_type is no longer inherited and therfore is not redefined.
--|
--| Revision 1.6.6.2  1999/12/01 19:13:56  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER to EV_ITEM_LIST
--|
--| Revision 1.6.6.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
