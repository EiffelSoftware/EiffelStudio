indexing
	description	: "Objects to synthesize keystrokes, mouse motions %
				  %and button clicks."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_INPUT_EVENT

inherit
	WEL_INPUT_CONSTANTS
		export
			{NONE} all
		end

feature -- Keyboard events

	send_keyboard_key_down (virtual_key_code: INTEGER) is
			-- The keybd_event function synthesizes a keystroke. The system 
			-- can use such a synthesized keystroke to generate a  
			-- WM_KEYDOWN message.
			--
			-- An application can simulate a press of the PRINTSCRN key in 
			-- order to obtain a screen snapshot and save it to the 
			-- clipboard. 
			-- To do this, call `send_keyboard_key_down(Vk_snapshot)'.
			--
			-- Windows NT: The `send_keyboard_key_down' can toggle the 
			-- NUM LOCK, CAPS LOCK, and SCROLL LOCK keys. 
			--
			-- Windows 95: The `send_keyboard_key_down' function can toggle
			-- only the CAPS LOCK and SCROLL LOCK keys. It cannot toggle 
			-- the NUM LOCK key.
		do
			cwin_keybd_event (virtual_key_code, 0, 0, Default_pointer)
		end

	send_keyboard_key_up (virtual_key_code: INTEGER) is
			-- The keybd_event function synthesizes a keystroke. The system 
			-- can use such a synthesized keystroke to generate a  
			-- WM_KEYUP message.
			--
			-- Windows NT: The `send_keyboard_key_down' can toggle the 
			-- NUM LOCK, CAPS LOCK, and SCROLL LOCK keys. 
			--
			-- Windows 95: The `send_keyboard_key_down' function can toggle
			-- only the CAPS LOCK and SCROLL LOCK keys. It cannot toggle 
			-- the NUM LOCK key.
		do
			cwin_keybd_event (virtual_key_code, 0, Keyeventf_keyup, Default_pointer)
		end

feature -- Mouse events

	send_mouse_absolute_move (a_x, a_y: INTEGER) is
			-- Synthesize a fake mouse move to absolute
			-- screen position `a_x', `a_y'.
			--
			-- `a_x' and `a_y' contain normalized absolute coordinates 
			-- between 0 and 65,535. The event procedure maps these 
			-- coordinates onto the display surface. Coordinate (0,0) 
			-- maps onto the upper-left corner of the display surface, 
			-- (65535,65535) maps onto the lower-right corner. 
			--
			-- To determine the size of the screen use
			-- {WEL_SYSTEM_METRICS}.screen_width and 
			-- {WEL_SYSTEM_METRICS}.screen_height.
		do
			cwin_mouse_event (
				Mouseeventf_move + Mouseeventf_absolute,
				a_x,
				a_y,
				0,
				Default_pointer
				)
		end

	send_mouse_relative_move (a_x, a_y: INTEGER) is
			-- Synthesize a fake mouse move.
			-- `a_x' and `a_y' are the number of mickeys moved.
			--
			-- A mickey is the amount that a mouse has to move 
			-- for it to report that it has moved. 
		do
			cwin_mouse_event (
				Mouseeventf_move,
				a_x,
				a_y,
				0,
				Default_pointer
				)
		end

	send_mouse_left_button_down is
			-- Synthesize a fake press on the left button of the
			-- mouse.
		do
			cwin_mouse_event (Mouseeventf_leftdown, 0, 0, 0, Default_pointer);
		end

	send_mouse_left_button_up is
			-- Synthesize a fake press on the left button of the
			-- mouse.
		do
			cwin_mouse_event (Mouseeventf_leftup, 0, 0, 0, Default_pointer);
		end

	send_mouse_right_button_down is
			-- Synthesize a fake press on the right button of the
			-- mouse.
		do
			cwin_mouse_event (Mouseeventf_rightdown, 0, 0, 0, Default_pointer);
		end

	send_mouse_right_button_up is
			-- Synthesize a fake press on the right button of the
			-- mouse.
		do
			cwin_mouse_event (Mouseeventf_rightup, 0, 0, 0, Default_pointer);
		end

	send_mouse_middle_button_down is
			-- Synthesize a fake press on the middle button of the
			-- mouse.
		do
			cwin_mouse_event (Mouseeventf_middledown, 0, 0, 0, Default_pointer);
		end

	send_mouse_middle_button_up is
			-- Synthesize a fake press on the middle button of the
			-- mouse.
		do
			cwin_mouse_event (Mouseeventf_middleup, 0, 0, 0, Default_pointer);
		end

feature {NONE} -- External

	cwin_mouse_event (
		dwFlags	: INTEGER -- motion and click options
  		dx		: INTEGER -- horizontal position or change
  		dy		: INTEGER -- vertical position or change
  		dwData	: INTEGER -- wheel movement
  		dwExtraInfo: POINTER -- application-defined information
	) is
			-- The mouse_event function synthesizes mouse motion and button 
			-- clicks.
		external
			"C [macro %"wel.h%"] (DWORD, DWORD, DWORD, DWORD, DWORD)"
		alias
			"mouse_event"
		end

	cwin_keybd_event (
		bVk		: INTEGER -- virtual-key code
		bScan	: INTEGER -- hardware scan code
		dwFlags	: INTEGER -- function options
  		dwExtraInfo: POINTER -- application-defined information
	) is
			-- The keybd_event function synthesizes a keystroke. The system 
			-- can use such a synthesized keystroke to generate a WM_KEYUP or 
			-- WM_KEYDOWN message. The keyboard driver's interrupt handler 
			-- calls the keybd_event function. 
		external
			"C [macro %"wel.h%"] (BYTE, BYTE, DWORD, DWORD)"
		alias
			"keybd_event"
		end

end -- class WEL_INPUT_EVENT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

