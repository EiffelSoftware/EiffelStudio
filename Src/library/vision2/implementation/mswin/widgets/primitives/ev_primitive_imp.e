indexing
	description: "EiffelVision primitive, mswin implementation.%N%
			%This class would be the equivalent of a wel_control in%N%
			% the wel hierarchy."
	status: "See notice at end of class,"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PRIMITIVE_IMP
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_WIDGET_IMP
		redefine
			update_for_pick_and_drop,
			interface
		end

	EV_SIZEABLE_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			tooltip_window
		end

feature -- Access

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			par_imp: EV_CONTAINER_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				par_imp ?= par.implementation
				ww ?= par.implementation
				wel_set_parent (ww)
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
			elseif parent_imp /= Void then
				wel_set_parent (default_parent)
			end
		end
	
	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
		end

feature -- Basic operations

	tab_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through to the tab
			-- key. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := next_dlgtabitem (top_level_window_imp.wel_item,
			wel_item, direction)
			window := window_of_item (hwnd)
			if window /= Void then
				window.set_focus
			end
		end

	arrow_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus throughthe arrow
			-- keys. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd: POINTER
			window: EV_WIDGET_IMP
		do
			hwnd := next_dlggroupitem (top_level_window_imp.wel_item,
			wel_item, direction)
			window ?= window_of_item (hwnd)
			check
				valid_cast: window /= Void
			end
			if parent_imp = window.parent_imp then
				-- The next widget must have the same parent as the
				-- widget which currently has the focus.
				window.set_focus
			end
		end

	process_tab_key (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control needs to process this kind of keys.
		do
			if virtual_key = Wel_input_constants.Vk_tab and then 
				flag_set (style, Wel_window_constants.Ws_tabstop)
			then
				tab_action (not key_down (Wel_input_constants.Vk_shift))
			end
		end

	process_tab_and_arrows_keys (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control need to process this kind of keys.
		do
			if virtual_key = Wel_input_constants.Vk_tab then
				tab_action (not key_down (Wel_input_constants.Vk_shift))
			elseif virtual_key = Wel_input_constants.Vk_down then
				arrow_action (True)
			elseif virtual_key = Wel_input_constants.Vk_up then
				arrow_action (False)
			end
		end

	tooltip_window: WEL_WINDOW is
			-- `Result' is WEL_WINDOW of `Current'.
		do
			Result := window_of_item (wel_item)
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		deferred
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearence of
			-- `Current'.
		do
			--| Redefine this for each primitive that changes its appearence
		end
		
	interface: EV_PRIMITIVE

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		do
			Result := (hwnd_control = wel_item)
		end

end -- class EV_PRIMITIVE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.32  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.31  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.20.4.11  2001/03/16 19:06:46  rogers
--| Implemented update_for_pick_and_drop.
--|
--| Revision 1.20.4.10  2001/02/04 19:22:30  pichery
--| Fixed bug
--|
--| Revision 1.20.4.9  2000/10/11 00:01:03  raphaels
--| `window_of_item' is now inherited from WEL_WINDOWS_ROUTINES
--|
--| Revision 1.20.4.8  2000/10/05 20:37:54  manus
--| Simplified `tab_action' call to avoid the use of an `if' statement.
--|
--| Revision 1.20.4.7  2000/08/11 18:47:40  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.20.4.6  2000/06/27 22:15:50  rogers
--| Added tooltip_window which is redefined from EV_TOOLTIPABLE_IMP.
--|
--| Revision 1.20.4.5  2000/05/23 16:48:48  rogers
--| Undid previous change as the code was definitely required.
--|
--| Revision 1.20.4.4  2000/05/23 15:56:37  rogers
--| Removed redundent check for a widget implementation with a void interface,
--| in set_parent, as Vision2 does not allow this anymore.
--|
--| Revision 1.20.4.3  2000/05/10 23:10:04  king
--| Integrated tooltipable changes
--|
--| Revision 1.20.4.2  2000/05/09 00:58:58  manus
--| Update with WEL recent changes:
--| - rename `windows.item (hwnd)' by `window_of_item (hwnd)'.
--| - added new deferred feature `window_of_item' which substitutes `windows'
--|   previously defined.
--|
--| Revision 1.20.4.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.29  2000/05/03 00:35:57  pichery
--| Changed constants retrieval
--|
--| Revision 1.28  2000/05/01 19:36:59  pichery
--| Added feature `is_control_in_window' used
--| to determine if a certain control is contained
--| inside the current window.
--|
--| Revision 1.27  2000/04/29 03:35:36  pichery
--| Remove Constants from Inheritance
--|
--| Revision 1.26  2000/04/26 22:11:49  rogers
--| Removed par_imp.add_child (Current) from set_parent as redundent now.
--|
--| Revision 1.25  2000/04/05 22:47:46  rogers
--| removed FIXME NOT_REVIEWED. Fixed description, made whole
--| class fit within 80 columns. Formatting.
--|
--| Revision 1.24  2000/03/14 20:09:08  brendel
--| Rearranged initialization
--|
--| Revision 1.23  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.22.2.2  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.22.2.1  2000/03/09 17:50:15  brendel
--| Added inheritance of EV_SIZEABLE_PRIMITIVE_IMP.
--|
--| Revision 1.22  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.21  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.6.7  2000/02/03 17:02:03  rogers
--|  Removed code in set_parent that was no longer necessary.
--|
--| Revision 1.20.6.6  2000/02/01 03:29:25  brendel
--| Commented back out call to remove_child.
--|
--| Revision 1.20.6.5  2000/01/31 19:31:32  brendel
--| Changed back implementation of set_parent.
--|
--| Revision 1.20.6.4  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.20.6.3  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.6.2  1999/12/17 00:33:38  rogers
--| Altered to fit in with the review branch. Basic alterations, redefinitaions
--| of name clashes etc.
--|
--| Revision 1.20.6.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
