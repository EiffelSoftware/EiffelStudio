indexing
	description: "Code that represent the keys of the keyboard."
	note: "Do not inherit from this class."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY_CODE

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the object.
		do
			!EV_KEY_CODE_IMP! implementation
		end

feature -- Numbers

	Key_0: INTEGER is
			-- A virtual key code for the ASCII "0" key. 
		do
			Result := implementation.Key_0
		end

	Key_1: INTEGER is 
			-- A virtual key code for the ASCII "1" key. 
		do
			Result := implementation.Key_1
		end

	Key_2: INTEGER is 
			-- A virtual key code for the ASCII "2" key. 
		do
			Result := implementation.Key_2
		end

	Key_3: INTEGER is 
			-- A virtual key code for the ASCII "3" key. 
		do
			Result := implementation.Key_3
		end

	Key_4: INTEGER is 
			-- A virtual key code for the ASCII "4" key. 
		do
			Result := implementation.Key_4
		end

	Key_5: INTEGER is 
			-- A virtual key code for the ASCII "5" key. 
		do
			Result := implementation.Key_5
		end

	Key_6: INTEGER is 
			-- A virtual key code for the ASCII "6" key. 
		do
			Result := implementation.Key_6
		end

	Key_7: INTEGER is 
			-- A virtual key code for the ASCII "7" key. 
		do
			Result := implementation.Key_7
		end

	Key_8: INTEGER is 
			-- A virtual key code for the ASCII "8" key. 
		do
			Result := implementation.Key_8
		end

	Key_9: INTEGER is 
			-- A virtual key code for the ASCII "9" key. 
		do
			Result := implementation.Key_9
		end

feature -- Numpad

	Key_numpad0: INTEGER is
			-- A virtual key code for the numeric keypad "0" key.
		do
			Result := implementation.Key_numpad0
		end

	Key_numpad1: INTEGER is 
			-- A virtual key code for the numeric keypad "1" key. 
		do
			Result := implementation.Key_numpad1
		end

	Key_numpad2: INTEGER is  
			-- A virtual key code for the numeric keypad "2" key. 
		do
			Result := implementation.Key_numpad2
		end

	Key_numpad3: INTEGER is
			-- A virtual key code for the numeric keypad "3" key. 
		do
			Result := implementation.Key_numpad3
		end

	Key_numpad4: INTEGER is
			-- A virtual key code for the numeric keypad "4" key. 
		do
			Result := implementation.Key_numpad4
		end

	Key_numpad5: INTEGER is
			-- A virtual key code for the numeric keypad "5" key. 
		do
			Result := implementation.Key_numpad5
		end

	Key_numpad6: INTEGER is
			-- A virtual key code for the numeric keypad "6" key. 
		do
			Result := implementation.Key_numpad6
		end

	Key_numpad7: INTEGER is
			-- A virtual key code for the numeric keypad "7" key. 
		do
			Result := implementation.Key_numpad7
		end

	Key_numpad8: INTEGER is
			-- A virtual key code for the numeric keypad "8" key. 
		do
			Result := implementation.Key_numpad8
		end

	Key_numpad9: INTEGER is
			-- A virtual key code for the numeric keypad "9" key. 
		do
			Result := implementation.Key_numpad9
		end

	Key_num_add: INTEGER is
			-- A virtual key code for the numeric keypad PLUS SIGN (+) key. 
		do
			Result := implementation.Key_num_add
		end

	Key_num_divide: INTEGER is 
			-- A virtual key code for the numeric keypad DIVISION (/) key. 
		do
			Result := implementation.Key_num_divide
		end

	Key_num_multiply: INTEGER is 
			-- A virtual key code for the numeric keypad MULTIPLICATION (*) key. 
		do
			Result := implementation.Key_num_multiply
		end

	Key_num_lock: INTEGER is 
			-- A virtual key code for the NUM LOCK key. 
		do
			Result := implementation.Key_num_lock
		end

	Key_num_subtract: INTEGER is 
			-- A virtual key code for the numeric keypad MINUS SIGN (-) key. 
		do
			Result := implementation.Key_num_subtract
		end

	Key_num_decimal: INTEGER is 
			-- A virtual key code for the numeric keypad DECIMAL POINT (.) key. 
		do
			Result := implementation.Key_num_decimal
		end

feature -- F keys

	Key_F1: INTEGER is
			-- A virtual key code for the F1 key.
		do
			Result := implementation.Key_F1
		end

	Key_F2: INTEGER is
			-- A virtual key code for the F2 key.
		do
			Result := implementation.Key_F2
		end

	Key_F3: INTEGER is 
			-- A virtual key code for the F3 key.
		do
			Result := implementation.Key_F3
		end

	Key_F4: INTEGER is
			-- A virtual key code for the F4 key.
		do
			Result := implementation.Key_F4
		end

	Key_F5: INTEGER is
			-- A virtual key code for the F5 key.
		do
			Result := implementation.Key_F5
		end

	Key_F6: INTEGER is
			-- A virtual key code for the F6 key.
		do
			Result := implementation.Key_F6
		end

	Key_F7: INTEGER is
			-- A virtual key code for the F7 key.
		do
			Result := implementation.Key_F7
		end

	Key_F8: INTEGER is
			-- A virtual key code for the F8 key.
		do
			Result := implementation.Key_F8
		end

	Key_F9: INTEGER is
			-- A virtual key code for the F9 key.
		do
			Result := implementation.Key_F9
		end

	Key_F10: INTEGER is
			-- A virtual key code for the F10 key.
		do
			Result := implementation.Key_F10
		end

	Key_F11: INTEGER is
			-- A virtual key code for the F11 key.
		do
			Result := implementation.Key_F11
		end

	Key_F12: INTEGER is
			-- A virtual key code for the F12 key.
		do
			Result := implementation.Key_F12
		end

feature -- Special Keys

	Key_shift: INTEGER is 
			-- A virtual key code for the SHIFT key.
			-- Do not work for accelerators.
		do
			Result := implementation.Key_shift
		end

	Key_left_shift: INTEGER is 
			-- A virtual key code for the left SHIFT key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_left_shift
		end

	Key_right_shift: INTEGER is 
			-- A virtual key code for the right SHIFT key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_right_shift
		end

	Key_control: INTEGER is 
			-- A virtual key code for the CTRL key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_control
		end

	Key_left_control: INTEGER is 
			-- A virtual key code for the left CTRL key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_left_control
		end

	Key_right_control: INTEGER is 
			-- A virtual key code for the right CTRL key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_right_control
		end

	Key_meta: INTEGER is 
			-- A virtual key code for the Application key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_meta
		end

	Key_left_meta: INTEGER is 
			-- A virtual key code for the left Application key.
			-- Do not work for accelerators.
		do
			Result := implementation.Key_left_meta
		end

	Key_right_meta: INTEGER is 
			-- A virtual key code for the right Application key.
			-- Do not work for accelerators.
		do
			Result := implementation.Key_right_meta
		end

	Key_space: INTEGER is 
			-- A virtual key code for the SPACEBAR key. 
		do
			Result := implementation.Key_space
		end

	Key_back_space: INTEGER is 
			-- A virtual key code for the BACKSPACE key. 
		do
			Result := implementation.Key_back_space
		end

	Key_enter: INTEGER is 
			-- A virtual key code for the ENTER key. 
		do
			Result := implementation.Key_enter
		end

	Key_escape: INTEGER is 
			-- A virtual key code for the ESC key. 
		do
			Result := implementation.Key_escape
		end

	Key_tab: INTEGER is
			-- A virtual key code for the TAB key.
		do
			Result := implementation.Key_tab
		end

	Key_pause: INTEGER is 
			-- A virtual key code for the PAUSE (BREAK) key. 
		do
			Result := implementation.Key_pause
		end

	Key_printscreen: INTEGER is 
			-- A virtual key code for the PRINT SCREEN key. 
			-- Do not work for accelerators.
		do
			Result := implementation.Key_printscreen
		end

	Key_caps_lock: INTEGER is 
			-- A virtual key code for the CAPS LOCK key. 
		do
			Result := implementation.Key_caps_lock
		end

	Key_scroll_lock: INTEGER is 
			-- A virtual key code for the SCROLL LOCK key. 
		do
			Result := implementation.Key_scroll_lock
		end

feature -- Special characters

	Key_comma: INTEGER is 
			-- A virtual key code for the COMMA (,) key. 
		do
			Result := implementation.Key_comma
		end

	Key_equals: INTEGER is 
			-- A virtual key code for the EQUAL SIGN (=) key. 
		do
			Result := implementation.Key_equals
		end
	
	Key_period: INTEGER is 
			-- A virtual key code for the PERIOD (.) key.
		do
			Result := implementation.Key_period
		end

	Key_semicolon: INTEGER is 
			-- A virtual key code for the SEMICOLON (;) key. 
		do
			Result := implementation.Key_semicolon
		end

	Key_open_bracket: INTEGER is 
			-- A virtual key code for the OPEN BRACKET ([) key. 
		do
			Result := implementation.Key_open_bracket
		end

	Key_close_bracket: INTEGER is 
			-- A virtual key code for the CLOSE BRACKET (]) key. 
		do
			Result := implementation.Key_close_bracket
		end

	Key_slash: INTEGER is 
			-- A virtual key code for the forward slash (/) key. 
		do
			Result := implementation.Key_slash
		end

	Key_back_slash: INTEGER is 
			-- A virtual key code for the BACKSLASH (\) key. 
		do
			Result := implementation.Key_back_slash
		end

	Key_quote: INTEGER is 
			-- A virtual key code for the QUOTATION MARK key. 
		do
			Result := implementation.Key_quote
		end

	Key_back_quote: INTEGER is 
			-- A virtual key code for the apostrophe (`) key. 
		do
			Result := implementation.Key_back_quote
		end

	Key_dash: INTEGER is
			-- A virtual key code for the dash (-) key.
		do
			Result := implementation.Key_dash
		end

feature -- Position keys

	Key_up: INTEGER is 
			-- A virtual key code for the UP ARROW key. 
		do
			Result := implementation.Key_up
		end

	Key_down: INTEGER is 
			-- A virtual key code for the DOWN ARROW key. 
		do
			Result := implementation.Key_down
		end

	Key_left: INTEGER is 
			-- A virtual key code for the LEFT ARROW key. 
		do
			Result := implementation.Key_left
		end

	Key_right: INTEGER is 
			-- A virtual key code for the RIGHT ARROW key. 
		do
			Result := implementation.Key_right
		end

	Key_page_up: INTEGER is 
			-- A virtual key code for the PAGE UP key. 
		do
			Result := implementation.Key_page_up
		end

	Key_page_down: INTEGER is 
			-- A virtual key code for the PAGE DOWN key. 
		do
			Result := implementation.Key_page_down
		end

	Key_home: INTEGER is 
			-- A virtual key code for the HOME key. 
		do
			Result := implementation.Key_home
		end

	Key_end: INTEGER is 
			-- A virtual key code for the END key. 
		do
			Result := implementation.Key_end
		end

	Key_insert: INTEGER is 
			-- A virtual key code for the INSERT key. 
		do
			Result := implementation.Key_insert
		end

	Key_delete: INTEGER is 
			-- A virtual key code for the DELETE key. 
		do
			Result := implementation.Key_delete
		end

feature -- Alpabetical keys

	Key_a: INTEGER is
			-- A virtual key code for the "a" key. 
		do
			Result := implementation.Key_a
		end

	Key_b: INTEGER is 
			-- A virtual key code for the "b" key. 
		do
			Result := implementation.Key_b
		end

	Key_c: INTEGER is 
			-- A virtual key code for the "c" key. 
		do
			Result := implementation.Key_c
		end

	Key_d: INTEGER is 
			-- A virtual key code for the "d" key. 
		do
			Result := implementation.Key_d
		end

	Key_e: INTEGER is 
			-- A virtual key code for the "e" key. 
		do
			Result := implementation.Key_e
		end

	Key_f: INTEGER is 
			-- A virtual key code for the "f" key. 
		do
			Result := implementation.Key_f
		end

	Key_g: INTEGER is 
			-- A virtual key code for the "g" key. 
		do
			Result := implementation.Key_g
		end

	Key_h: INTEGER is 
			-- A virtual key code for the "h" key. 
		do
			Result := implementation.Key_h
		end

	Key_i: INTEGER is 
			-- A virtual key code for the "i" key. 
		do
			Result := implementation.Key_i
		end

	Key_j: INTEGER is 
			-- A virtual key code for the "j" key. 
		do
			Result := implementation.Key_j
		end

	Key_k: INTEGER is 
			-- A virtual key code for the "k" key. 
		do
			Result := implementation.Key_k
		end

	Key_l: INTEGER is 
			-- A virtual key code for the "l" key. 
		do
			Result := implementation.Key_l
		end

	Key_m: INTEGER is 
			-- A virtual key code for the "m" key. 
		do
			Result := implementation.Key_m
		end

	Key_n: INTEGER is 
			-- A virtual key code for the "n" key. 
		do
			Result := implementation.Key_n
		end

	Key_o: INTEGER is 
			-- A virtual key code for the "o" key. 
		do
			Result := implementation.Key_o
		end

	Key_p: INTEGER is 
			-- A virtual key code for the "p" key. 
		dO
			Result := implementation.Key_p
		end
 
	Key_q: INTEGER is 
			-- A virtual key code for the "q" key. 
		do
			Result := implementation.Key_q
		end

	Key_r: INTEGER is 
			-- A virtual key code for the "r" key. 
		do
			Result := implementation.Key_r
		end

	Key_s: INTEGER is 
			-- A virtual key code for the "s" key. 
		do
			Result := implementation.Key_s
		end

	Key_t: INTEGER is 
			-- A virtual key code for the "t" key. 
		do
			Result := implementation.Key_t
		end

	Key_u: INTEGER is 
			-- A virtual key code for the "u" key. 
		do
			Result := implementation.Key_u
		end

	Key_v: INTEGER is 
			-- A virtual key code for the "v" key. 
		do
			Result := implementation.Key_v
		end

	Key_w: INTEGER is 
			-- A virtual key code for the "w" key. 
		do
			Result := implementation.Key_w
		end

	Key_x: INTEGER is 
			-- A virtual key code for the "x" key. 
		do
			Result := implementation.Key_x
		end

	Key_y: INTEGER is 
			-- A virtual key code for the "y" key. 
		do
			Result := implementation.Key_y
		end

	Key_z: INTEGER is 
			-- A virtual key code for the "z" key. 
		do
			Result := implementation.Key_z
		end

feature -- Implementation

	implementation: EV_KEY_CODE_I
			-- Implementation access

end -- class EV_KEY_CODE

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
