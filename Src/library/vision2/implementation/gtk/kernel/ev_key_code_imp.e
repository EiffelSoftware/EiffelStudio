--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Code that represent the keys of the keyboard."
	note: "Do not inherit from this class."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY_CODE_IMP

inherit
	EV_KEY_CODE_I
	EV_GDK_KEYSYMS_EXTERNALS

feature -- Numbers

	Key_0: INTEGER is
			-- A virtual key code for the ASCII "0" key. 
		do
			Result := gdk_0
		end

	Key_1: INTEGER is 
			-- A virtual key code for the ASCII "1" key. 
		do
			Result := gdk_1
		end

	Key_2: INTEGER is 
			-- A virtual key code for the ASCII "2" key. 
		do
			Result := gdk_2
		end

	Key_3: INTEGER is 
			-- A virtual key code for the ASCII "3" key. 
		do
			Result := gdk_3
		end

	Key_4: INTEGER is 
			-- A virtual key code for the ASCII "4" key. 
		do
			Result := gdk_4
		end

	Key_5: INTEGER is 
			-- A virtual key code for the ASCII "5" key. 
		do
			Result := gdk_5
		end

	Key_6: INTEGER is 
			-- A virtual key code for the ASCII "6" key. 
		do
			Result := gdk_6 
		end

	Key_7: INTEGER is 
			-- A virtual key code for the ASCII "7" key. 
		do
			Result := gdk_7
		end

	Key_8: INTEGER is 
			-- A virtual key code for the ASCII "8" key. 
		do
			Result := gdk_8 
		end

	Key_9: INTEGER is 
			-- A virtual key code for the ASCII "9" key. 
		do
			Result := gdk_9 
		end

feature -- Numpad

	Key_numpad0: INTEGER is
			-- A virtual key code for the numeric keypad "0" key.
		do
			Result := gdk_kp_0 
		end

	Key_numpad1: INTEGER is 
			-- A virtual key code for the numeric keypad "1" key. 
		do
			Result := gdk_kp_1 
		end

	Key_numpad2: INTEGER is  
			-- A virtual key code for the numeric keypad "2" key. 
		do
			Result := gdk_kp_2 
		end

	Key_numpad3: INTEGER is
			-- A virtual key code for the numeric keypad "3" key. 
		do
			Result := gdk_kp_3 
		end

	Key_numpad4: INTEGER is
			-- A virtual key code for the numeric keypad "4" key. 
		do
			Result := gdk_kp_4 
		end

	Key_numpad5: INTEGER is
			-- A virtual key code for the numeric keypad "5" key. 
		do
			Result := gdk_kp_5 
		end

	Key_numpad6: INTEGER is
			-- A virtual key code for the numeric keypad "6" key. 
		do
			Result := gdk_kp_6 
		end

	Key_numpad7: INTEGER is
			-- A virtual key code for the numeric keypad "7" key. 
		do
			Result := gdk_kp_7 
		end

	Key_numpad8: INTEGER is
			-- A virtual key code for the numeric keypad "8" key. 
		do
			Result := gdk_kp_8 
		end

	Key_numpad9: INTEGER is
			-- A virtual key code for the numeric keypad "9" key. 
		do
			Result := gdk_kp_9 
		end

	Key_num_add: INTEGER is
			-- A virtual key code for the numeric keypad PLUS SIGN (+) key. 
		do
			Result := 0 
		end

	Key_num_divide: INTEGER is 
			-- A virtual key code for the numeric keypad DIVISION (/) key. 
		do
			Result := 0 
		end

	Key_num_multiply: INTEGER is 
			-- A virtual key code for the numeric keypad MULTIPLICATION (*) key. 
		do
			Result := 0 
		end

	Key_num_lock: INTEGER is 
			-- A virtual key code for the NUM LOCK key. 
		do
			Result := 0 
		end

	Key_num_subtract: INTEGER is 
			-- A virtual key code for the numeric keypad MINUS SIGN (-) key. 
		do
			Result := 0 
		end

	Key_num_decimal: INTEGER is 
			-- A virtual key code for the numeric keypad DECIMAL POINT (.) key. 
		do
			Result := 0 
		end

feature -- F keys

	Key_F1: INTEGER is
			-- A virtual key code for the F1 key.
		do
			Result := gdk_F1 
		end

	Key_F2: INTEGER is
			-- A virtual key code for the F2 key.
		do
			Result := gdk_F2 
		end

	Key_F3: INTEGER is 
			-- A virtual key code for the F3 key.
		do
			Result := gdk_F3 
		end

	Key_F4: INTEGER is
			-- A virtual key code for the F4 key.
		do
			Result := gdk_F4 
		end

	Key_F5: INTEGER is
			-- A virtual key code for the F5 key.
		do
			Result := gdk_F5 
		end

	Key_F6: INTEGER is
			-- A virtual key code for the F6 key.
		do
			Result := gdk_F6 
		end

	Key_F7: INTEGER is
			-- A virtual key code for the F7 key.
		do
			Result := gdk_F7 
		end

	Key_F8: INTEGER is
			-- A virtual key code for the F8 key.
		do
			Result := gdk_F8 
		end

	Key_F9: INTEGER is
			-- A virtual key code for the F9 key.
		do
			Result := gdk_F9 
		end

	Key_F10: INTEGER is
			-- A virtual key code for the F10 key.
		do
			Result := gdk_F10 
		end

	Key_F11: INTEGER is
			-- A virtual key code for the F11 key.
		do
			Result := gdk_F11 
		end

	Key_F12: INTEGER is
			-- A virtual key code for the F12 key.
		do
			Result := gdk_F12 
		end

feature -- Special Keys

	Key_shift: INTEGER is 
			-- A virtual key code for the SHIFT key.
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_left_shift: INTEGER is 
			-- A virtual key code for the left SHIFT key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_right_shift: INTEGER is 
			-- A virtual key code for the right SHIFT key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_control: INTEGER is 
			-- A virtual key code for the CTRL key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_left_control: INTEGER is 
			-- A virtual key code for the left CTRL key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_right_control: INTEGER is 
			-- A virtual key code for the right CTRL key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_meta: INTEGER is 
			-- A virtual key code for the Application key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_left_meta: INTEGER is 
			-- A virtual key code for the left Application key.
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_right_meta: INTEGER is 
			-- A virtual key code for the right Application key.
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_space: INTEGER is 
			-- A virtual key code for the SPACEBAR key. 
		do
			Result := 0 
		end

	Key_back_space: INTEGER is 
			-- A virtual key code for the BACKSPACE key. 
		do
			Result := 0 
		end

	Key_enter: INTEGER is 
			-- A virtual key code for the ENTER key. 
		do
			Result := 0 
		end

	Key_escape: INTEGER is 
			-- A virtual key code for the ESC key. 
		do
			Result := 0 
		end

	Key_tab: INTEGER is
			-- A virtual key code for the TAB key.
		do
			Result := 0 
		end

	Key_pause: INTEGER is 
			-- A virtual key code for the PAUSE (BREAK) key. 
		do
			Result := 0 
		end

	Key_printscreen: INTEGER is 
			-- A virtual key code for the PRINT SCREEN key. 
			-- Do not work for accelerators.
		do
			Result := 0 
		end

	Key_caps_lock: INTEGER is 
			-- A virtual key code for the CAPS LOCK key. 
		do
			Result := 0 
		end

	Key_scroll_lock: INTEGER is 
			-- A virtual key code for the SCROLL LOCK key. 
		do
			Result := 0 
		end

feature -- Special characters

	Key_comma: INTEGER is 
			-- A virtual key code for the COMMA (,) key. 
		do
			Result := gdk_comma 
		end

	Key_equals: INTEGER is 
			-- A virtual key code for the EQUAL SIGN (=) key. 
		do
			Result := gdk_equal 
		end
	
	Key_period: INTEGER is 
			-- A virtual key code for the PERIOD (.) key.
		do
			Result := gdk_period
		end

	Key_semicolon: INTEGER is 
			-- A virtual key code for the SEMICOLON (;) key. 
		do
			Result := gdk_semicolon
		end

	Key_open_bracket: INTEGER is 
			-- A virtual key code for the OPEN BRACKET ([) key. 
		do
			Result := gdk_braceleft
		end

	Key_close_bracket: INTEGER is 
			-- A virtual key code for the CLOSE BRACKET (]) key. 
		do
			Result := gdk_braceright
		end

	Key_slash: INTEGER is 
			-- A virtual key code for the forward slash (/) key. 
		do
			Result := gdk_slash
		end

	Key_back_slash: INTEGER is 
			-- A virtual key code for the BACKSLASH (\) key. 
		do
			Result := gdk_backslash
		end

	Key_quote: INTEGER is 
			-- A virtual key code for the QUOTATION MARK key. 
		do
			Result := gdk_quoteleft
		end

	Key_back_quote: INTEGER is 
			-- A virtual key code for the apostrophe (`) key. 
		do
			Result := gdk_quoteright
		end

	Key_dash: INTEGER is
			-- A virtual key code for the dash (-) key.
		do
			check
					To_be_implemented: False
			end
			Result := 0
		end

feature -- Position keys

	Key_up: INTEGER is 
			-- A virtual key code for the UP ARROW key. 
		do
			Result := gdk_uparrow
		end

	Key_down: INTEGER is 
			-- A virtual key code for the DOWN ARROW key. 
		do
			Result := gdk_downarrow 
		end

	Key_left: INTEGER is 
			-- A virtual key code for the LEFT ARROW key. 
		do
			Result := gdk_leftarrow
		end

	Key_right: INTEGER is 
			-- A virtual key code for the RIGHT ARROW key. 
		do
			Result := gdk_rightarrow
		end

	Key_page_up: INTEGER is 
			-- A virtual key code for the PAGE UP key. 
		do
			Result := gdk_kp_page_up 
		end

	Key_page_down: INTEGER is 
			-- A virtual key code for the PAGE DOWN key. 
		do
			Result := gdk_kp_page_down 
		end

	Key_home: INTEGER is 
			-- A virtual key code for the HOME key. 
		do
			Result := gdk_kp_home 
		end

	Key_end: INTEGER is 
			-- A virtual key code for the END key. 
		do
			Result := gdk_kp_end 
		end

	Key_insert: INTEGER is 
			-- A virtual key code for the INSERT key. 
		do
			Result := gdk_kp_insert 
		end

	Key_delete: INTEGER is 
			-- A virtual key code for the DELETE key. 
		do
			Result := gdk_kp_delete 
		end

feature -- Alpabetical keys

	Key_a: INTEGER is
			-- A virtual key code for the "a" key. 
		do
			Result := gdk_a 
		end

	Key_b: INTEGER is 
			-- A virtual key code for the "b" key. 
		do
			Result := gdk_b 
		end

	Key_c: INTEGER is 
			-- A virtual key code for the "c" key. 
		do
			Result := gdk_c 
		end

	Key_d: INTEGER is 
			-- A virtual key code for the "d" key. 
		do
			Result := gdk_d 
		end

	Key_e: INTEGER is 
			-- A virtual key code for the "e" key. 
		do
			Result := gdk_e 
		end

	Key_f: INTEGER is 
			-- A virtual key code for the "f" key. 
		do
			Result := gdk_f 
		end

	Key_g: INTEGER is 
			-- A virtual key code for the "g" key. 
		do
			Result := gdk_g 
		end

	Key_h: INTEGER is 
			-- A virtual key code for the "h" key. 
		do
			Result := gdk_h 
		end

	Key_i: INTEGER is 
			-- A virtual key code for the "i" key. 
		do
			Result := gdk_i 
		end

	Key_j: INTEGER is 
			-- A virtual key code for the "j" key. 
		do
			Result := gdk_j 
		end

	Key_k: INTEGER is 
			-- A virtual key code for the "k" key. 
		do
			Result := gdk_k 
		end

	Key_l: INTEGER is 
			-- A virtual key code for the "l" key. 
		do
			Result := gdk_l 
		end

	Key_m: INTEGER is 
			-- A virtual key code for the "m" key. 
		do
			Result := gdk_m 
		end

	Key_n: INTEGER is 
			-- A virtual key code for the "n" key. 
		do
			Result := gdk_n 
		end

	Key_o: INTEGER is 
			-- A virtual key code for the "o" key. 
		do
			Result := gdk_o 
		end

	Key_p: INTEGER is 
			-- A virtual key code for the "p" key. 
		dO
			Result := gdk_p 
		end
 
	Key_q: INTEGER is 
			-- A virtual key code for the "q" key. 
		do
			Result := gdk_q 
		end

	Key_r: INTEGER is 
			-- A virtual key code for the "r" key. 
		do
			Result := gdk_r 
		end

	Key_s: INTEGER is 
			-- A virtual key code for the "s" key. 
		do
			Result := gdk_s 
		end

	Key_t: INTEGER is 
			-- A virtual key code for the "t" key. 
		do
			Result := gdk_t 
		end

	Key_u: INTEGER is 
			-- A virtual key code for the "u" key. 
		do
			Result := gdk_u 
		end

	Key_v: INTEGER is 
			-- A virtual key code for the "v" key. 
		do
			Result := gdk_v 
		end

	Key_w: INTEGER is 
			-- A virtual key code for the "w" key. 
		do
			Result := gdk_w 
		end

	Key_x: INTEGER is 
			-- A virtual key code for the "x" key. 
		do
			Result := gdk_x 
		end

	Key_y: INTEGER is 
			-- A virtual key code for the "y" key. 
		do
			Result := gdk_y 
		end

	Key_z: INTEGER is 
			-- A virtual key code for the "z" key. 
		do
			Result := gdk_z 
		end

end -- class EV_KEY_CODE_IMP

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
--| Revision 1.7  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.1  2000/05/03 19:08:38  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/03/15 18:53:32  brendel
--| Unreleased.
--|
--| Revision 1.5  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.3  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.3.6.2  2000/01/27 19:29:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:29:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
