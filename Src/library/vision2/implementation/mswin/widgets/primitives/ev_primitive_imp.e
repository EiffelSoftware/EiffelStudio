--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision primitive, mswin implementation."
	note: "This class would be the equivalent of a wel_control in%
			% the wel hierarchy."
	status: "See notice at end of class"
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
			interface
		end

feature -- Access

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

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
				--if parent_imp /= Void then
				--	parent_imp.remove_child (Current)
				--end
				par_imp ?= par.implementation
				par_imp.add_child (Current)
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
			-- of the widget.
		do
			top_level_window_imp := a_window
		end

feature -- Basic operations

	tab_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through to the tab key.
			-- If `direction' it goes to the next widget otherwise, it goes to the 
			-- previous one.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := next_dlgtabitem (top_level_window_imp.wel_item, wel_item, direction)
			window := windows.item (hwnd)
			window.set_focus
		end

	arrow_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through the arrow keys.
			-- If `direction' it goes to the next widget otherwise, it goes to the 
			-- previous one.
		local
			hwnd: POINTER
			window: EV_WIDGET_IMP
		do
			hwnd := next_dlggroupitem (top_level_window_imp.wel_item, wel_item, direction)
			window ?= windows.item (hwnd)
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
			-- Process a tab or arrow key press to give the focus to the next widget
			-- Need to be called in the feature on_key_down when the control need to
			-- process this kind of keys.
		do
			if virtual_key = Vk_tab and then flag_set (style, Ws_tabstop) then
				if key_down (Vk_shift) then
					tab_action (False)
				else
					tab_action (True)
				end
			end
		end

	process_tab_and_arrows_keys (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next widget
			-- Need to be called in the feature on_key_down when the control need to
			-- process this kind of keys.
		do
			if virtual_key = Vk_tab then
				if key_down (Vk_shift) then
					tab_action (False)
				else
					tab_action (True)
				end
			elseif virtual_key = Vk_down then
				arrow_action (True)
			elseif virtual_key = Vk_up then
				arrow_action (False)
			end
		end

feature {NONE} -- Deferred features

	--item: POINTER is
	--	deferred
	--	end

	windows: HASH_TABLE [WEL_WINDOW, POINTER] is
		deferred
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

	interface: EV_PRIMITIVE

end -- class EV_PRIMITIVE_IMP

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
--| Altered to fit in with the review branch. Basic alterations, redefinitaions of name clashes etc.
--|
--| Revision 1.20.6.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
