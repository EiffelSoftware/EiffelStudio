indexing
	description:
		" A silly window that doesn't do anything. Used%
		% as default parent."
	note: " This window is actually used as a default parent%
		% to avoid a Microsoft Windows Bug. Because, when%
		% we change the parent of a tack-bar on windows NT%
		% the parent for the events stays the first parent,%
		% here, the default_parent. It needs then to handle%
		% the events for its children. Once the bug is fixed%
		% in windows, we can simply use a WEL_FRAME_WINDOW."
	status: "See notice at end of class."
	revision: "$Revision$"

class
	EV_INTERNAL_SILLY_WINDOW_IMP

inherit 
	WEL_FRAME_WINDOW
		redefine
			on_wm_vscroll,
			on_wm_hscroll,
			default_style,
			on_wm_notify
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

create
	make_top,
	make_child

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Windows default style used in creation of `Current'.
		do
			Result := Ws_overlappedwindow
		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
 			-- Wm_vscroll message.
 			-- Should be implementated in EV_CONTAINER_IMP,
			-- But as we can't implement a deferred feature
 			-- with an external, it is not possible.
 		local
			range: EV_RANGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
		 				-- The message comes from a gauge
						-- If it is a range then we need to call the change actions.
 					range ?= window_of_item (p)
					if range /= Void then
 						check
 							range_exists: range.exists
						end
						if range.change_actions_internal /= Void then
							range.change_actions_internal.call
								([range.interface.value])
						end
					end
 				else
 						-- The message comes from a window scroll bar
 					on_vertical_scroll (cwin_get_wm_vscroll_code
						(wparam, lparam), cwin_get_wm_vscroll_pos
						(wparam, lparam))
 				end
			end
 		end
 
 	on_wm_hscroll (wparam, lparam: INTEGER) is
 			-- Wm_hscroll message.
 		local
 			range: EV_RANGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := cwin_get_wm_hscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 					-- The message comes from a gauge
						-- If it is a range then we need to call the change actions.
	 				range ?= window_of_item (p)
	 				if range /= Void then
	 					check
	 						range_exists: range.exists
	 					end
	 					if range.change_actions_internal /= Void then
							range.change_actions_internal.call
								([range.interface.value])
						end
	 				end
				else
 						-- The message comes from a window scroll bar
 					on_horizontal_scroll (cwin_get_wm_hscroll_code
						(wparam, lparam), cwin_get_wm_hscroll_pos
						(wparam, lparam))
 				end
			end
 		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		local
			info: WEL_NMHDR
			ww: WEL_WINDOW
		do
			create info.make_by_pointer (cwel_integer_to_pointer (lparam))
			if
				has_child (info.window_from)
			then
				Precursor {WEL_FRAME_WINDOW} (wparam, lparam)
			else
				-- message has been sent to the wrong window (the old parent)
				-- this is a win32 bug
				-- see: MSDN Article Article ID: Q104069
				-- http://support.microsoft.com/support/kb/articles/Q104/0/69.asp
				-- we simply forward the message to the new parent

				-- Also we need to force a new level on the return message stack
				-- because WEL_DISPATCHER does not do it in this case.

				if info.window_from /= Void then
					ww := info.window_from.parent
					if ww /= Void and then ww /= Current then
						ww.increment_level
						ww.on_wm_notify (wparam, lparam)
						if
							ww.has_return_value
						then
							set_message_return_value (ww.message_return_value)
						end
						ww.decrement_level
					end
				end
			end
		end

feature {NONE} -- Implemetation

	has_child (w: WEL_WINDOW): BOOLEAN is
			-- Is `w' a child of Current?
		require
			exists: exists
			w_exists: w /= Void implies w.exists
		local
			hwnd, win: POINTER
		do
			if w /= Void then
				from
					hwnd := cwin_get_window (item, Gw_child)
					win := w.item
				until
					hwnd = default_pointer or Result
				loop
					Result := win = hwnd
					hwnd := cwin_get_window (hwnd, Gw_hwndnext)
				end
			end
		end

end -- class EV_INTERNAL_SILLY_WINDOW_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.12  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.11  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.2.10  2001/05/16 02:32:37  manus
--| Implemented `has_child': fast way of finding if a given window is a direct
--| child of Current.
--|
--| Revision 1.6.2.9  2001/02/19 16:35:38  manus
--| Speed optimization by avoiding too many calls to `parent_imp' use a local
--| variable instead.
--|
--| Revision 1.6.2.8  2000/11/10 19:44:56  rogers
--| Replaced !! with create.
--|
--| Revision 1.6.2.7  2000/09/13 22:13:46  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.6.2.6  2000/08/22 00:23:08  rogers
--| Fixed on_wm_vscroll and on_wm_hscroll, so they call the change actions
--| for a range. Previously the change_actions for EV_RANGE were never fired.
--|
--| Revision 1.6.2.5  2000/08/11 19:52:14  rogers
--| Removed fixme NOT_REVIEWED. Removed redefinition of on_draw_item as it
--| did nothing. Formatting. Fixed copyright notice.
--|
--| Revision 1.6.2.4  2000/07/24 21:56:56  manus
--| Fixed a possible infinite recursion with the following code:
--|
--| 	first_window := create {EV_TITLED_WINDOW}
--| 	first_window.extend (create {EV_MULTI_COLUMN_LIST})
--| 	first_window.show
--| 	first_window.wipe_out
--|
--| because the message `on_wm_notify' was sent to the one who called it.
--|
--| Revision 1.6.2.3  2000/05/30 16:29:10  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.6.2.2  2000/05/09 00:49:41  manus
--| Update with recent WEL changes:
--| - replace `register_window (Current)' by `register_current_window'
--| - replace `windows.item (p)' by `window_of_item (p)'
--|
--| Revision 1.6.2.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/28 21:52:43  brendel
--| Removed reference to EV_STATUS_BAR_IMP.
--|
--| Revision 1.8  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.7  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.4.5  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.4.4  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.6.4.3  1999/12/17 17:11:04  rogers
--| Altered to fit in with the review branch.
--|
--| Revision 1.6.4.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP.
--| ev_item_holder_imp.e
--|
--| Revision 1.6.4.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
