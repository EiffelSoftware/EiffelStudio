--| FIXME NOT_REVIEWED this file has not been reviewed
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
			on_draw_item,
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
			-- Default style of the window.
		do
			Result := Ws_overlappedwindow
		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
 			-- Wm_vscroll message.
 			-- Should be implementated in EV_CONTAINER_IMP,
			-- But as we can't implement a deferred feature
 			-- with an external, it is not possible.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge,
 					gauge ?= window_of_item (p)
						if gauge /= Void then
	 						check
 							gauge_exists: gauge.exists
 						end
 						--| FIXME gauge.execute_command (gauge.Cmd_gauge, Void)
 					end
 				else
 					-- The message comes from a window scroll bar
 					on_vertical_scroll (cwin_get_wm_vscroll_code (wparam, lparam),
 						cwin_get_wm_vscroll_pos (wparam, lparam))
 				end
			end
 		end
 
 	on_wm_hscroll (wparam, lparam: INTEGER) is
 			-- Wm_hscroll message.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := cwin_get_wm_hscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge
	 				gauge ?= window_of_item (p)
	 				if gauge /= Void then
	 					check
	 						gauge_exists: gauge.exists
	 					end
	 					--| FIXME gauge.execute_command (gauge.Cmd_gauge, Void)
	 				end
				else
 					-- The message comes from a window scroll bar
 					on_horizontal_scroll (cwin_get_wm_hscroll_code (wparam, lparam),
						cwin_get_wm_hscroll_pos (wparam, lparam))
 				end
			end
 		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		local
			info: WEL_NMHDR
			ww: WEL_WINDOW
		do
			!! info.make_by_pointer (cwel_integer_to_pointer (lparam))
			if
				children.has (info.window_from)
			then
				{WEL_FRAME_WINDOW} Precursor (wparam, lparam)
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
					if ww /= Void then
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

	on_draw_item (id: INTEGER; struct: WEL_DRAW_ITEM_STRUCT) is
			-- If wm_draw is recieved for a status bar then
			-- Re-draw `bar'.
		do
	--		bar ?= struct.window_item
	--		if bar /= Void then
	--			bar.draw_item (id, struct)		
	--		end
		end
		 		
end -- class EV_INTERNAL_SILLY_WINDOW_IMP

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
--| Revision 1.10  2000/06/07 17:27:57  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP. ev_item_holder_imp.e
--|
--| Revision 1.6.4.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
