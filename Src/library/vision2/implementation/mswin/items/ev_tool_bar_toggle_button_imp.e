indexing
	description: "EiffelVision toogle tool bar, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

creation
	make

feature -- Status setting

	enable_select is
			-- Select `Current'.
		do
			is_selected := True
			if parent_imp /= Void then
				parent_imp.check_button (id)
			end
		end

	disable_select is
			-- Deselect `Current'
		do
			is_selected := False
			if parent_imp /= Void then
				parent_imp.uncheck_button (id)
			end
		end

feature -- Status report
	
	is_selected: BOOLEAN
			-- Is `Current selected'?
	
feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

--|-----------------------------------------------------------------------------
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
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.19  2000/06/07 17:27:52  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.5.2.2  2000/05/09 21:23:41  king
--| Implemented to fit in with new selectable abstract class
--|
--| Revision 1.5.2.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.18  2000/04/26 22:19:37  rogers
--| Removed type as now redundent.
--|
--| Revision 1.17  2000/04/26 16:35:12  rogers
--| Removed unecessary redefinition of parent_imp.
--|
--| Revision 1.16  2000/04/24 21:23:58  rogers
--| Removed FIXME_NOT_REVIEWED.
--|
--| Revision 1.15  2000/04/07 00:14:00  rogers
--| Added interface. Both inerited interfaces are now redefined.
--| Formatting.
--|
--| Revision 1.14  2000/04/05 18:22:57  rogers
--| Removed redefinition of on_activate from EV_TOOL_BAR_SELECT_BUTTON_IMP.
--|
--| Revision 1.12  2000/04/05 17:26:43  rogers
--| renamed set_checked -> enable_select.
--|
--| Revision 1.11  2000/04/04 22:47:57  rogers
--| Removed old command association. Fixed disable_select to work
--| when there is no current parent.
--|
--| Revision 1.10  2000/04/04 17:16:48  rogers
--| Now inherits EV_TOOL_BAR_SELECT_BUTTON_IMP. Removed is_selected
--| and set_selected. Implemented on_parented and set_checked.
--|
--| Revision 1.9  2000/02/19 06:34:12  oconnor
--| removed old command stuff
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
--| Revision 1.5.4.4  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.4.3  2000/01/27 01:08:17  rogers
--| Commented out the old event execution and added a FIXME.
--|
--| Revision 1.5.4.2  2000/01/21 20:28:07  rogers
--| selected interface from EV_TOOL_BAR_TOGGLE_BUTTON_I and renamed interface from EV_TOOL_BAR_BUTTON_IMP to ev_tool_bar_button_imp_interface.
--|
--| Revision 1.5.4.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
