--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tool-bar separator, mswindows implemenatation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		rename
			parent_imp as tb_parent_imp
		undefine
			parent
		select
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		rename
			interface as ev_tool_bar_button_interface
		redefine
			type
		select
			parent_imp
		end

creation
	make

feature -- Status report

	type: INTEGER is
			-- Type of the button.
			-- See `add_button' of EV_TOOL_BAR_IMP for values
			-- explanation.
		do
			Result := 5
		end
	
	tb_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
				-- The parent of the Current widget
				-- Can be void.
			do
			end

	old_item_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
				-- The parent of the Current widget
				-- Can be void.
			do
			end

end -- class EV_TOOL_BAR_SEPARATOR_IMP

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
--| Revision 1.9  2000/04/10 17:44:09  brendel
--| Removed inheritance of obsolete class EV_SEPARATOR_ITEM.
--|
--| Revision 1.8  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.7  2000/02/19 04:35:44  oconnor
--| added deferred features
--|
--| Revision 1.6  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.3  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/21 18:09:01  rogers
--| Renamed interface inherited from ev_tool_bar_button_imp as ev_tool_bar_button_imp_interface. Selected interface inherited from EV_TOOL_BAR_SEPARATOR_I.
--|
--| Revision 1.5.6.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
