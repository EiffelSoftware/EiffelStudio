--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision key codes, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_KEY_CODE_I

feature -- Numbers

	Key_0: INTEGER is
			-- A virtual key code for the ASCII "0" key. 
		deferred
		end

	Key_1: INTEGER is 
			-- A virtual key code for the ASCII "1" key. 
		deferred
		end

	Key_2: INTEGER is 
			-- A virtual key code for the ASCII "2" key. 
		deferred
		end

	Key_3: INTEGER is 
			-- A virtual key code for the ASCII "3" key. 
		deferred
		end

	Key_4: INTEGER is 
			-- A virtual key code for the ASCII "4" key. 
		deferred
		end

	Key_5: INTEGER is 
			-- A virtual key code for the ASCII "5" key. 
		deferred
		end

	Key_6: INTEGER is 
			-- A virtual key code for the ASCII "6" key. 
		deferred
		end

	Key_7: INTEGER is 
			-- A virtual key code for the ASCII "7" key. 
		deferred
		end

	Key_8: INTEGER is 
			-- A virtual key code for the ASCII "8" key. 
		deferred
		end

	Key_9: INTEGER is 
			-- A virtual key code for the ASCII "9" key. 
		deferred
		end

feature -- Numpad

	Key_numpad0: INTEGER is
			-- A virtual key code for the numeric keypad "0" key.
		deferred
		end

	Key_numpad1: INTEGER is 
			-- A virtual key code for the numeric keypad "1" key. 
		deferred
		end

	Key_numpad2: INTEGER is  
			-- A virtual key code for the numeric keypad "2" key. 
		deferred
		end

	Key_numpad3: INTEGER is
			-- A virtual key code for the numeric keypad "3" key. 
		deferred
		end

	Key_numpad4: INTEGER is
			-- A virtual key code for the numeric keypad "4" key. 
		deferred
		end

	Key_numpad5: INTEGER is
			-- A virtual key code for the numeric keypad "5" key. 
		deferred
		end

	Key_numpad6: INTEGER is
			-- A virtual key code for the numeric keypad "6" key. 
		deferred
		end

	Key_numpad7: INTEGER is
			-- A virtual key code for the numeric keypad "7" key. 
		deferred
		end

	Key_numpad8: INTEGER is
			-- A virtual key code for the numeric keypad "8" key. 
		deferred
		end

	Key_numpad9: INTEGER is
			-- A virtual key code for the numeric keypad "9" key. 
		deferred
		end

	Key_num_add: INTEGER is
			-- A virtual key code for the numeric keypad PLUS SIGN (+) key. 
		deferred
		end

	Key_num_divide: INTEGER is 
			-- A virtual key code for the numeric keypad DIVISION (/) key. 
		deferred
		end

	Key_num_multiply: INTEGER is 
			-- A virtual key code for the numeric keypad MULTIPLICATION (*) key. 
		deferred
		end

	Key_num_lock: INTEGER is 
			-- A virtual key code for the NUM LOCK key. 
		deferred
		end

	Key_num_subtract: INTEGER is 
			-- A virtual key code for the numeric keypad MINUS SIGN (-) key. 
		deferred
		end

	Key_num_decimal: INTEGER is 
			-- A virtual key code for the numeric keypad DECIMAL POINT (.) key. 
		deferred
		end

feature -- F keys

	Key_F1: INTEGER is
			-- A virtual key code for the F1 key.
		deferred
		end

	Key_F2: INTEGER is
			-- A virtual key code for the F2 key.
		deferred
		end

	Key_F3: INTEGER is 
			-- A virtual key code for the F3 key.
		deferred
		end

	Key_F4: INTEGER is
			-- A virtual key code for the F4 key.
		deferred
		end

	Key_F5: INTEGER is
			-- A virtual key code for the F5 key.
		deferred
		end

	Key_F6: INTEGER is
			-- A virtual key code for the F6 key.
		deferred
		end

	Key_F7: INTEGER is
			-- A virtual key code for the F7 key.
		deferred
		end

	Key_F8: INTEGER is
			-- A virtual key code for the F8 key.
		deferred
		end

	Key_F9: INTEGER is
			-- A virtual key code for the F9 key.
		deferred
		end

	Key_F10: INTEGER is
			-- A virtual key code for the F10 key.
		deferred
		end

	Key_F11: INTEGER is
			-- A virtual key code for the F11 key.
		deferred
		end

	Key_F12: INTEGER is
			-- A virtual key code for the F12 key.
		deferred
		end

feature -- Special Keys

	Key_shift: INTEGER is 
			-- A virtual key code for the SHIFT key. 
		deferred
		end

	Key_left_shift: INTEGER is 
			-- A virtual key code for the left SHIFT key. 
		deferred
		end

	Key_right_shift: INTEGER is 
			-- A virtual key code for the right SHIFT key. 
		deferred
		end

	Key_control: INTEGER is 
			-- A virtual key code for the CTRL key. 
		deferred
		end

	Key_left_control: INTEGER is 
			-- A virtual key code for the left CTRL key. 
		deferred
		end

	Key_right_control: INTEGER is 
			-- A virtual key code for the right CTRL key. 
		deferred
		end

	Key_meta: INTEGER is 
			-- A virtual key code for the Application key. 
		deferred
		end

	Key_left_meta: INTEGER is 
			-- A virtual key code for the left Application key.
		deferred
		end

	Key_right_meta: INTEGER is 
			-- A virtual key code for the right Application key.
		deferred
		end

	Key_space: INTEGER is 
			-- A virtual key code for the SPACEBAR key. 
		deferred
		end

	Key_back_space: INTEGER is 
			-- A virtual key code for the BACKSPACE key. 
		deferred
		end

	Key_enter: INTEGER is 
			-- A virtual key code for the ENTER key. 
		deferred
		end

	Key_escape: INTEGER is 
			-- A virtual key code for the ESC key. 
		deferred
		end

	Key_tab: INTEGER is
			-- A virtual key code for the TAB key.
		deferred
		end

	Key_pause: INTEGER is 
			-- A virtual key code for the PAUSE (BREAK) key. 
		deferred
		end

	Key_printscreen: INTEGER is 
			-- A virtual key code for the PRINT SCREEN key. 
		deferred
		end

	Key_caps_lock: INTEGER is 
			-- A virtual key code for the CAPS LOCK key. 
		deferred
		end

	Key_scroll_lock: INTEGER is 
			-- A virtual key code for the SCROLL LOCK key. 
		deferred
		end

feature -- Special characters

	Key_comma: INTEGER is 
			-- A virtual key code for the COMMA (,) key. 
		deferred
		end

	Key_equals: INTEGER is 
			-- A virtual key code for the EQUAL SIGN (=) key. 
		deferred
		end
	
	Key_period: INTEGER is 
			-- A virtual key code for the PERIOD (.) key.
		deferred
		end

	Key_semicolon: INTEGER is 
			-- A virtual key code for the SEMICOLON (;) key. 
		deferred
		end

	Key_open_bracket: INTEGER is 
			-- A virtual key code for the OPEN BRACKET ([) key. 
		deferred
		end

	Key_close_bracket: INTEGER is 
			-- A virtual key code for the CLOSE BRACKET (]) key. 
		deferred
		end

	Key_slash: INTEGER is 
			-- A virtual key code for the forward slash (/) key. 
		deferred
		end

	Key_back_slash: INTEGER is 
			-- A virtual key code for the BACKSLASH (\) key. 
		deferred
		end

	Key_quote: INTEGER is 
			-- A virtual key code for the QUOTATION MARK key. 
		deferred
		end

	Key_back_quote: INTEGER is 
			-- A virtual key code for the apostrophe (`) key. 
		deferred
		end

	Key_dash: INTEGER is
			-- A virtual key code for the dash (-) key.
		deferred
		end

feature -- Position keys

	Key_up: INTEGER is 
			-- A virtual key code for the UP ARROW key. 
		deferred
		end

	key_down: INTEGER is 
			-- A virtual key code for the DOWN ARROW key. 
		deferred
		end

	Key_left: INTEGER is 
			-- A virtual key code for the LEFT ARROW key. 
		deferred
		end

	Key_right: INTEGER is 
			-- A virtual key code for the RIGHT ARROW key. 
		deferred
		end

	Key_page_up: INTEGER is 
			-- A virtual key code for the PAGE UP key. 
		deferred
		end

	Key_page_down: INTEGER is 
			-- A virtual key code for the PAGE DOWN key. 
		deferred
		end

	Key_home: INTEGER is 
			-- A virtual key code for the HOME key. 
		deferred
		end

	Key_end: INTEGER is 
			-- A virtual key code for the END key. 
		deferred
		end

	Key_insert: INTEGER is 
			-- A virtual key code for the INSERT key. 
		deferred
		end

	Key_delete: INTEGER is 
			-- A virtual key code for the DELETE key. 
		deferred
		end

feature -- Alpabetical keys

	Key_a: INTEGER is
			-- A virtual key code for the "a" key. 
		deferred
		end

	Key_b: INTEGER is 
			-- A virtual key code for the "b" key. 
		deferred
		end

	Key_c: INTEGER is 
			-- A virtual key code for the "c" key. 
		deferred
		end

	Key_d: INTEGER is 
			-- A virtual key code for the "d" key. 
		deferred
		end

	Key_e: INTEGER is 
			-- A virtual key code for the "e" key. 
		deferred
		end

	Key_f: INTEGER is 
			-- A virtual key code for the "f" key. 
		deferred
		end

	Key_g: INTEGER is 
			-- A virtual key code for the "g" key. 
		deferred
		end

	Key_h: INTEGER is 
			-- A virtual key code for the "h" key. 
		deferred
		end

	Key_i: INTEGER is 
			-- A virtual key code for the "i" key. 
		deferred
		end

	Key_j: INTEGER is 
			-- A virtual key code for the "j" key. 
		deferred
		end

	Key_k: INTEGER is 
			-- A virtual key code for the "k" key. 
		deferred
		end

	Key_l: INTEGER is 
			-- A virtual key code for the "l" key. 
		deferred
		end

	Key_m: INTEGER is 
			-- A virtual key code for the "m" key. 
		deferred
		end

	Key_n: INTEGER is 
			-- A virtual key code for the "n" key. 
		deferred
		end

	Key_o: INTEGER is 
			-- A virtual key code for the "o" key. 
		deferred
		end

	Key_p: INTEGER is 
			-- A virtual key code for the "p" key. 
		deferred
		end
 
	Key_q: INTEGER is 
			-- A virtual key code for the "q" key. 
		deferred
		end

	Key_r: INTEGER is 
			-- A virtual key code for the "r" key. 
		deferred
		end

	Key_s: INTEGER is 
			-- A virtual key code for the "s" key. 
		deferred
		end

	Key_t: INTEGER is 
			-- A virtual key code for the "t" key. 
		deferred
		end

	Key_u: INTEGER is 
			-- A virtual key code for the "u" key. 
		deferred
		end

	Key_v: INTEGER is 
			-- A virtual key code for the "v" key. 
		deferred
		end

	Key_w: INTEGER is 
			-- A virtual key code for the "w" key. 
		deferred
		end

	Key_x: INTEGER is 
			-- A virtual key code for the "x" key. 
		deferred
		end

	Key_y: INTEGER is 
			-- A virtual key code for the "y" key. 
		deferred
		end

	Key_z: INTEGER is 
			-- A virtual key code for the "z" key. 
		deferred
		end

end -- class EV_KEY_CODE_I

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/03/15 18:06:01  brendel
--| Unreleased.
--|
--| Revision 1.4  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.3  2000/02/04 04:15:56  oconnor
--| release
--|
--| Revision 1.2.6.2  2000/01/27 19:29:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:30:05  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
