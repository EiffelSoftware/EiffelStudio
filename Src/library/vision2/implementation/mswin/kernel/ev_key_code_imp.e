--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision key codes, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY_CODE_IMP

inherit
	EV_KEY_CODE_I

	WEL_VK_CONSTANTS

feature -- Numbers

	Key_0: INTEGER is
			-- A virtual key code for the ASCII "0" key. 
		do
			Result := 48
		end

	Key_1: INTEGER is 
			-- A virtual key code for the ASCII "1" key. 
		do
			Result := 49
		end

	Key_2: INTEGER is 
			-- A virtual key code for the ASCII "2" key. 
		do
			Result := 50
		end

	Key_3: INTEGER is 
			-- A virtual key code for the ASCII "3" key. 
		do
			Result := 51
		end

	Key_4: INTEGER is 
			-- A virtual key code for the ASCII "4" key. 
		do
			Result := 52
		end

	Key_5: INTEGER is 
			-- A virtual key code for the ASCII "5" key. 
		do
			Result := 53
		end

	Key_6: INTEGER is 
			-- A virtual key code for the ASCII "6" key. 
		do
			Result := 54
		end

	Key_7: INTEGER is 
			-- A virtual key code for the ASCII "7" key. 
		do
			Result := 55
		end

	Key_8: INTEGER is 
			-- A virtual key code for the ASCII "8" key. 
		do
			Result := 56
		end

	Key_9: INTEGER is 
			-- A virtual key code for the ASCII "9" key. 
		do
			Result := 57
		end

feature -- Numpad

	Key_numpad0: INTEGER is
			-- A virtual key code for the numeric keypad "0" key.
		do
			Result := Vk_numpad0
		end

	Key_numpad1: INTEGER is 
			-- A virtual key code for the numeric keypad "1" key. 
		do
			Result := Vk_numpad1
		end

	Key_numpad2: INTEGER is  
			-- A virtual key code for the numeric keypad "2" key. 
		do
			Result := Vk_numpad2
		end

	Key_numpad3: INTEGER is
			-- A virtual key code for the numeric keypad "3" key. 
		do
			Result := Vk_numpad3
		end

	Key_numpad4: INTEGER is
			-- A virtual key code for the numeric keypad "4" key. 
		do
			Result := Vk_numpad4
		end

	Key_numpad5: INTEGER is
			-- A virtual key code for the numeric keypad "5" key. 
		do
			Result := Vk_numpad5
		end

	Key_numpad6: INTEGER is
			-- A virtual key code for the numeric keypad "6" key. 
		do
			Result := Vk_numpad6
		end

	Key_numpad7: INTEGER is
			-- A virtual key code for the numeric keypad "7" key. 
		do
			Result := Vk_numpad7
		end

	Key_numpad8: INTEGER is
			-- A virtual key code for the numeric keypad "8" key. 
		do
			Result := Vk_numpad8
		end

	Key_numpad9: INTEGER is
			-- A virtual key code for the numeric keypad "9" key. 
		do
			Result := Vk_numpad9
		end

	Key_num_add: INTEGER is
			-- A virtual key code for the numeric keypad PLUS SIGN (+) key. 
		do
			Result := Vk_add
		end

	Key_num_divide: INTEGER is 
			-- A virtual key code for the numeric keypad DIVISION (/) key. 
		do
			Result := Vk_divide
		end

	Key_num_multiply: INTEGER is 
			-- A virtual key code for the numeric keypad MULTIPLICATION (*) key. 
		do
			Result := Vk_multiply
		end

	Key_num_lock: INTEGER is 
			-- A virtual key code for the NUM LOCK key. 
		do
			Result := Vk_numlock
		end

	Key_num_subtract: INTEGER is 
			-- A virtual key code for the numeric keypad MINUS SIGN (-) key. 
		do
			Result := Vk_subtract
		end

	Key_num_decimal: INTEGER is 
			-- A virtual key code for the numeric keypad DECIMAL POINT (.) key. 
		do
			Result := Vk_decimal
		end

feature -- F keys

	Key_F1: INTEGER is
			-- A virtual key code for the F1 key.
		do
			Result := Vk_f1
		end

	Key_F2: INTEGER is
			-- A virtual key code for the F2 key.
		do
			Result := Vk_f2
		end

	Key_F3: INTEGER is 
			-- A virtual key code for the F3 key.
		do
			Result := Vk_f3
		end

	Key_F4: INTEGER is
			-- A virtual key code for the F4 key.
		do
			Result := Vk_f4
		end

	Key_F5: INTEGER is
			-- A virtual key code for the F5 key.
		do
			Result := Vk_f5
		end

	Key_F6: INTEGER is
			-- A virtual key code for the F6 key.
		do
			Result := Vk_f6
		end

	Key_F7: INTEGER is
			-- A virtual key code for the F7 key.
		do
			Result := Vk_f7
		end

	Key_F8: INTEGER is
			-- A virtual key code for the F8 key.
		do
			Result := Vk_f8
		end

	Key_F9: INTEGER is
			-- A virtual key code for the F9 key.
		do
			Result := Vk_f9
		end

	Key_F10: INTEGER is
			-- A virtual key code for the F10 key.
		do
			Result := Vk_f10
		end

	Key_F11: INTEGER is
			-- A virtual key code for the F11 key.
		do
			Result := Vk_f11
		end

	Key_F12: INTEGER is
			-- A virtual key code for the F12 key.
		do
			Result := Vk_f12
		end

feature -- Special Keys

	Key_shift: INTEGER is 
			-- A virtual key code for the SHIFT keys.
		do
			Result := Vk_shift
		end

	Key_left_shift: INTEGER is 
			-- A virtual key code for the left SHIFT key. 
		do
			Result := Vk_lshift
		end

	Key_right_shift: INTEGER is 
			-- A virtual key code for the right SHIFT key. 
		do
			Result := Vk_rshift
		end

	Key_control: INTEGER is 
			-- A virtual key code for the CTRL key. 
		do
			Result := Vk_control
		end

	Key_left_control: INTEGER is 
			-- A virtual key code for the left CTRL key. 
		do
			Result := Vk_lcontrol
		end

	Key_right_control: INTEGER is 
			-- A virtual key code for the right CTRL key. 
		do
			Result := Vk_rcontrol
		end

	Key_meta: INTEGER is 
			-- A virtual key code for the Application key. 
		do
			Result := Vk_menu
		end

	Key_left_meta: INTEGER is 
			-- A virtual key code for the left Application key.
		do
			Result := Vk_lmenu
		end

	Key_right_meta: INTEGER is 
			-- A virtual key code for the right Application key.
		do
			Result := Vk_rmenu
		end

	Key_space: INTEGER is 
			-- A virtual key code for the SPACEBAR key. 
		do
			Result := Vk_space
		end

	Key_back_space: INTEGER is 
			-- A virtual key code for the BACKSPACE key. 
		do
			Result := Vk_back
		end

	Key_enter: INTEGER is 
			-- A virtual key code for the ENTER key. 
		do
			Result := Vk_return
		end

	Key_escape: INTEGER is 
			-- A virtual key code for the ESC key. 
		do
			Result := Vk_escape
		end

	Key_tab: INTEGER is
			-- A virtual key code for the TAB key.
		do
			Result := Vk_tab
		end

	Key_pause: INTEGER is 
			-- A virtual key code for the PAUSE (BREAK) key. 
		do
			Result := Vk_pause
		end

	Key_printscreen: INTEGER is 
			-- A virtual key code for the PRINT SCREEN key. 
		do
			Result := Vk_snapshot
		end

	Key_caps_lock: INTEGER is 
			-- A virtual key code for the CAPS LOCK key. 
		do
			Result := Vk_capital
		end

	Key_scroll_lock: INTEGER is 
			-- A virtual key code for the SCROLL LOCK key. 
		do
			Result := Vk_scroll
		end

feature -- Special characters

	Key_comma: INTEGER is 
			-- A virtual key code for the COMMA (,) key. 
		do
			Result := 188
		end

	Key_equals: INTEGER is 
			-- A virtual key code for the EQUAL SIGN (=) key. 
		do
			Result := 187
		end
	
	Key_period: INTEGER is 
			-- A virtual key code for the PERIOD (.) key.
		do
			Result := 190
		end

	Key_semicolon: INTEGER is 
			-- A virtual key code for the SEMICOLON (;) key. 
		do
			Result := 186
		end

	Key_open_bracket: INTEGER is 
			-- A virtual key code for the OPEN BRACKET ([) key. 
		do
			Result := 219
		end

	Key_close_bracket: INTEGER is 
			-- A virtual key code for the CLOSE BRACKET (]) key. 
		do
			Result := 221
		end

	Key_slash: INTEGER is 
			-- A virtual key code for the forward slash (/) key. 
		do
			Result := 191
		end

	Key_back_slash: INTEGER is 
			-- A virtual key code for the BACKSLASH (\) key. 
		do
			Result := 220
		end

	Key_quote: INTEGER is 
			-- A virtual key code for the QUOTATION MARK key. 
		do
			Result := 222
		end

	Key_back_quote: INTEGER is 
			-- A virtual key code for the apostrophe (`) key. 
		do
			Result := 192
		end

	Key_dash: INTEGER is
			-- A virtual key code for the dash (-) key.
		do
			Result := 189
		end

feature -- Position keys

	Key_up: INTEGER is 
			-- A virtual key code for the UP ARROW key. 
		do
			Result := Vk_up
		end

	Key_down: INTEGER is 
			-- A virtual key code for the DOWN ARROW key. 
		do
			Result := Vk_down
		end

	Key_left: INTEGER is 
			-- A virtual key code for the LEFT ARROW key. 
		do
			Result := Vk_left
		end

	Key_right: INTEGER is 
			-- A virtual key code for the RIGHT ARROW key. 
		do
			Result := Vk_right
		end

	Key_page_up: INTEGER is 
			-- A virtual key code for the PAGE UP key. 
		do
			Result := Vk_prior
		end

	Key_page_down: INTEGER is 
			-- A virtual key code for the PAGE DOWN key. 
		do
			Result := Vk_next
		end

	Key_home: INTEGER is 
			-- A virtual key code for the HOME key. 
		do
			Result := Vk_home
		end

	Key_end: INTEGER is 
			-- A virtual key code for the END key. 
		do
			Result := Vk_end
		end

	Key_insert: INTEGER is 
			-- A virtual key code for the INSERT key. 
		do
			Result := Vk_insert
		end

	Key_delete: INTEGER is 
			-- A virtual key code for the DELETE key. 
		do
			Result := Vk_delete
		end

feature -- Alpabetical keys

	Key_a: INTEGER is
			-- A virtual key code for the "a" key. 
		do
			Result := 65
		end

	Key_b: INTEGER is 
			-- A virtual key code for the "b" key. 
		do
			Result := 66
		end

	Key_c: INTEGER is 
			-- A virtual key code for the "c" key. 
		do
			Result := 67
		end

	Key_d: INTEGER is 
			-- A virtual key code for the "d" key. 
		do
			Result := 68
		end

	Key_e: INTEGER is 
			-- A virtual key code for the "e" key. 
		do
			Result := 69
		end

	Key_f: INTEGER is 
			-- A virtual key code for the "f" key. 
		do
			Result := 70
		end

	Key_g: INTEGER is 
			-- A virtual key code for the "g" key. 
		do
			Result := 71
		end

	Key_h: INTEGER is 
			-- A virtual key code for the "h" key. 
		do
			Result := 72
		end

	Key_i: INTEGER is 
			-- A virtual key code for the "i" key. 
		do
			Result := 73
		end

	Key_j: INTEGER is 
			-- A virtual key code for the "j" key. 
		do
			Result := 74
		end

	Key_k: INTEGER is 
			-- A virtual key code for the "k" key. 
		do
			Result := 75
		end

	Key_l: INTEGER is 
			-- A virtual key code for the "l" key. 
		do
			Result := 76
		end

	Key_m: INTEGER is 
			-- A virtual key code for the "m" key. 
		do
			Result := 77
		end

	Key_n: INTEGER is 
			-- A virtual key code for the "n" key. 
		do
			Result := 78
		end

	Key_o: INTEGER is 
			-- A virtual key code for the "o" key. 
		do
			Result := 79
		end

	Key_p: INTEGER is 
			-- A virtual key code for the "p" key. 
		dO
			Result := 80
		end
 
	Key_q: INTEGER is 
			-- A virtual key code for the "q" key. 
		do
			Result := 81
		end

	Key_r: INTEGER is 
			-- A virtual key code for the "r" key. 
		do
			Result := 82
		end

	Key_s: INTEGER is 
			-- A virtual key code for the "s" key. 
		do
			Result := 83
		end

	Key_t: INTEGER is 
			-- A virtual key code for the "t" key. 
		do
			Result := 84
		end

	Key_u: INTEGER is 
			-- A virtual key code for the "u" key. 
		do
			Result := 85
		end

	Key_v: INTEGER is 
			-- A virtual key code for the "v" key. 
		do
			Result := 86
		end

	Key_w: INTEGER is 
			-- A virtual key code for the "w" key. 
		do
			Result := 87
		end

	Key_x: INTEGER is 
			-- A virtual key code for the "x" key. 
		do
			Result := 88
		end

	Key_y: INTEGER is 
			-- A virtual key code for the "y" key. 
		do
			Result := 89
		end

	Key_z: INTEGER is 
			-- A virtual key code for the "z" key. 
		do
			Result := 90
		end

end -- class EV_KEY_CODE_IMP

--|----------------------------------------------------------------
--| EiffelVision Library: library of reusable components for ISE Eiffel.
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
--| Revision 1.6  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.8.1  2000/05/03 19:09:13  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/03/15 18:06:00  brendel
--| Unreleased.
--|
--| Revision 1.4  2000/03/07 02:16:57  oconnor
--| released
--|
--| Revision 1.3  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.2  2000/01/27 19:30:11  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:18  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
