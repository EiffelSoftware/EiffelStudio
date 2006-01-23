indexing
	description: "[
		A silly window that doesn't do anything. Used as default parent.
		
		Note: This window is actually used as a default parent
		to avoid a Microsoft Windows Bug. Because, when
		we change the parent of a tack-bar on windows NT
		the parent for the events stays the first parent,
		here, the default_parent. It needs then to handle
		the events for its children. Once the bug is fixed
		in windows, we can simply use a WEL_FRAME_WINDOW.
		]"
	legal: "See notice at end of class."
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
			on_wm_notify,
			class_requires_icon
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
			Result := ws_popup
		end

	on_wm_vscroll (wparam, lparam: POINTER) is
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
 
 	on_wm_hscroll (wparam, lparam: POINTER) is
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

	on_wm_notify (wparam, lparam: POINTER) is
			-- Wm_notify message
		local
			info: WEL_NMHDR
			ww: WEL_WINDOW
		do
			create info.make_by_pointer (lparam)
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
		
	class_requires_icon: BOOLEAN is
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_INTERNAL_SILLY_WINDOW_IMP

