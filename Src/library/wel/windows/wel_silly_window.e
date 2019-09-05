note
	description: "Special window we can use to send resizing messages when Windows does not propagate them properly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SILLY_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			process_message
		end

create
	make_top

feature {WEL_ABSTRACT_DISPATCHER, WEL_WINDOW} -- Implementation

	 process_message (hwnd: POINTER;
			msg: INTEGER; wparam, lparam: POINTER): POINTER
		do
			if msg = {WEL_RESIZING_SUPPORT}.wm_set_window_pos_msg then
				on_delayed_move_and_resize (wparam)
			end
		end

feature {NONE} -- Implementation

	on_delayed_move_and_resize (a_ptr: POINTER)
		local
			l_pos: WEL_WINDOW_POS
			l_window: detachable WEL_WINDOW
			l_is_refresh_required: BOOLEAN
		do
			if a_ptr /= default_pointer then
				create l_pos.make_by_pointer (a_ptr)
				l_pos.set_unshared
				if l_pos.hwnd /= default_pointer and is_window (l_pos.hwnd) then
					l_window := window_of_item (l_pos.hwnd)
					if l_window /= Void and then l_window.exists then
						if attached {WEL_COMBO_BOX} l_window  or attached {WEL_EDIT} l_window then
								-- Combo boxes and edit controls are special because they are made of several widgets/abstractions
								-- and trying to resize it again with the same size doesn't do much, so we shrink the window by one pixel.
								-- The side effect is that if you are refreshing the content of a window while resizing
								-- you will see those windows shrink and grow by one pixel width during the resizing.
							if l_pos.width > 0 then
								l_window.move_and_resize (l_pos.x, l_pos.y, l_pos.width - 1, l_pos.height, False )
							elseif l_pos.height > 0 then
								l_window.move_and_resize (l_pos.x, l_pos.y, l_pos.width, l_pos.height - 1, False )
							else
									-- do not try to workaround, if width and height are not positive.
							end
							l_window.move_and_resize (l_pos.x, l_pos.y, l_pos.width, l_pos.height, (l_pos.flags & swp_noredraw) = 0)
							l_is_refresh_required := True
						else
								-- If the window size is different from the originally requested size
								-- it means that some other resizing have been done on the window
								-- and that we should ignore the current message.
							if l_window.width = l_pos.width then
								l_window.on_size (0, l_pos.width, l_pos.height)
								if (l_pos.flags & swp_nomove) = 0 then
									l_window.on_move (l_pos.x, l_pos.y)
								end
								l_is_refresh_required := True
							end
						end
						if l_is_refresh_required then
								-- Refresh is required as otherwise some parts of the screen are usually
								-- not refresh.
							if attached l_window.parent as l_parent then
								l_parent.invalidate
							end
							l_window.invalidate
						end
					end
				end
				l_pos.dispose
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
