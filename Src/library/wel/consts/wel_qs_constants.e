note
	description: "Constants used for MsgWaitForMultipleObjects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_QS_CONSTANTS

feature -- Access

	qs_allevents: INTEGER = 0x04BF
			-- An input, WM_TIMER, WM_PAINT, WM_HOTKEY, or posted message is in the queue.
			-- This value is a combination of QS_INPUT, QS_POSTMESSAGE, QS_TIMER, QS_PAINT, and QS_HOTKEY.

	qs_allinput: INTEGER = 0x04FF
			-- Any message is in the queue.
			-- This value is a combination of QS_INPUT, QS_POSTMESSAGE, QS_TIMER, QS_PAINT, QS_HOTKEY, and QS_SENDMESSAGE.

	qs_allpostmessage: INTEGER = 0x0100
			-- A posted message is in the queue.
			-- This value is cleared when you call GetMessage or PeekMessage without filtering messages.

	qs_hotkey: INTEGER = 0x0080
			-- A WM_HOTKEY message is in the queue.

	qs_input: INTEGER = 0x407
			-- An input message is in the queue.
			-- This value is a combination of QS_MOUSE and QS_KEY.
			-- Windows Server 2003 and Windows XP:  This value also includes QS_RAWINPUT.

	qs_key: INTEGER = 0x0001
			-- A WM_KEYUP, WM_KEYDOWN, WM_SYSKEYUP, or WM_SYSKEYDOWN message is in the queue.

	qs_mouse: INTEGER = 0x0006
			-- A WM_MOUSEMOVE message or mouse-button message (WM_LBUTTONUP, WM_RBUTTONDOWN, and so on).
			-- This value is a combination of QS_MOUSEMOVE and QS_MOUSEBUTTON.

	qs_mousebutton: INTEGER = 0x0004
			-- A mouse-button message (WM_LBUTTONUP, WM_RBUTTONDOWN, and so on).

	qs_mousemove: INTEGER = 0x0002
			-- A WM_MOUSEMOVE message is in the queue.

	qs_paint: INTEGER = 0x0020
			-- A WM_PAINT message is in the queue.

	qs_postmessage: INTEGER = 0x0008
			-- A posted message is in the queue.
			-- This value is cleared when you call GetMessage or PeekMessage, whether or not you are filtering messages.

	qs_rawinput: INTEGER = 0x0400
			-- A raw input message is in the queue. For more information, see Raw Input.
			-- Windows 2000/NT and Windows Me/98/95:  This value is not supported.

	qs_sendmessage: INTEGER = 0x0040
			-- A message sent by another thread or application is in the queue.

	qs_timer: INTEGER = 0x0010;
			-- A WM_TIMER message is in the queue.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
