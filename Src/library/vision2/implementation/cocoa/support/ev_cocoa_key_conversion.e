note
	description: "Provides functions for converting keycodes between Cocoa and Vision."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COCOA_KEY_CONVERSION

inherit
	EV_KEY_CONSTANTS

feature -- Conversion

	key_code_to_cocoa (a_key_code: INTEGER): NATURAL_16
			-- Corresponding Cocoa code for `a_key_code'.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			Result := v2_to_cocoa_table @ a_key_code
		end

	key_code_from_cocoa (a_cocoa_code: NATURAL_16): INTEGER
			-- Corresponding key code for `a_cocoa_code'.
		require
			a_cocoa_code_valid: valid_cocoa_code (a_cocoa_code)
		do
			Result := cocoa_to_v2_table.item (a_cocoa_code)
		end

feature -- Contract support

	valid_cocoa_code (a_cocoa_code: NATURAL_16): BOOLEAN
			-- Is `a_cocoa_code' valid?
		do
			Result := cocoa_to_v2_table.has (a_cocoa_code)
		end

feature {NONE} -- Implementation

	v2_to_cocoa_table: ARRAY [NATURAL_16]
			-- Cocoa keycodes indexed by Vision2 key code.
		once
			create Result.make_filled (0, Key_0, Key_menu)
			Result.put (('0').code.to_natural_16, Key_0)
			Result.put (('1').code.to_natural_16, Key_1)
			Result.put (('2').code.to_natural_16, Key_2)
			Result.put (('3').code.to_natural_16, Key_3)
			Result.put (('4').code.to_natural_16, Key_4)
			Result.put (('5').code.to_natural_16, Key_5)
			Result.put (('6').code.to_natural_16, Key_6)
			Result.put (('7').code.to_natural_16, Key_7)
			Result.put (('8').code.to_natural_16, Key_8)
			Result.put (('9').code.to_natural_16, Key_9)
			Result.put (('0').code.to_natural_16, Key_numpad_0)
			Result.put (('1').code.to_natural_16, Key_numpad_1)
			Result.put (('2').code.to_natural_16, Key_numpad_2)
			Result.put (('3').code.to_natural_16, Key_numpad_3)
			Result.put (('4').code.to_natural_16, Key_numpad_4)
			Result.put (('5').code.to_natural_16, Key_numpad_5)
			Result.put (('6').code.to_natural_16, Key_numpad_6)
			Result.put (('7').code.to_natural_16, Key_numpad_7)
			Result.put (('8').code.to_natural_16, Key_numpad_8)
			Result.put (('9').code.to_natural_16, Key_numpad_9)
			Result.put (('+').code.to_natural_16, Key_numpad_add)
			Result.put (('/').code.to_natural_16, Key_numpad_divide)
			Result.put (('*').code.to_natural_16, Key_numpad_multiply)
			Result.put (0, Key_num_lock)
			Result.put (('-').code.to_natural_16, Key_numpad_subtract)
			Result.put (('.').code.to_natural_16, Key_numpad_decimal)
			Result.put (f1_key, Key_f1)
			Result.put (f2_key, Key_f2)
			Result.put (f3_key, Key_f3)
			Result.put (f4_key, Key_f4)
			Result.put (f5_key, Key_f5)
			Result.put (f6_key, Key_f6)
			Result.put (f7_key, Key_f7)
			Result.put (f8_key, Key_f8)
			Result.put (f9_key, Key_f9)
			Result.put (f10_key, Key_f10)
			Result.put (f11_key, Key_f11)
			Result.put (f12_key, Key_f12)
			Result.put ((' ').code.to_natural_16, Key_space)
			Result.put (delete_char_key, Key_back_space) -- Not sure if this is correct (127)
			Result.put (('%N').code.to_natural_16, Key_enter)
			Result.put (27, Key_escape) -- Cocoa doesn't have a constant
			Result.put (('%T').code.to_natural_16, Key_tab)
			Result.put (pause_key, Key_pause)
			Result.put (0, Key_caps_lock)
			Result.put (scroll_lock_key, Key_scroll_lock)
			Result.put ((',').code.to_natural_16, Key_comma)
			Result.put (('=').code.to_natural_16, Key_equal)
			Result.put (('.').code.to_natural_16, Key_period)
			Result.put ((';').code.to_natural_16, Key_semicolon)
			Result.put (('(').code.to_natural_16, Key_open_bracket)
			Result.put ((')').code.to_natural_16, Key_close_bracket)
			Result.put (('/').code.to_natural_16, Key_slash)
			Result.put (('\').code.to_natural_16, Key_backslash)
			Result.put (('%'').code.to_natural_16, Key_quote)
			Result.put (('`').code.to_natural_16, Key_backquote)
			Result.put (('-').code.to_natural_16, Key_dash)
			Result.put (up_arrow_key, Key_up)
			Result.put (down_arrow_key, Key_down)
			Result.put (left_arrow_key, Key_left)
			Result.put (right_arrow_key, Key_right)
			Result.put (page_up_key, Key_page_up)
			Result.put (page_down_key, Key_page_down)
			Result.put (help_key, Key_home)
			Result.put (end_key, Key_end)
			Result.put (insert_key, Key_insert)
			Result.put (delete_key, Key_delete)
			Result.put (('a').code.to_natural_16, Key_a)
			Result.put (('b').code.to_natural_16, Key_b)
			Result.put (('c').code.to_natural_16, Key_c)
			Result.put (('d').code.to_natural_16, Key_d)
			Result.put (('e').code.to_natural_16, Key_e)
			Result.put (('f').code.to_natural_16, Key_f)
			Result.put (('g').code.to_natural_16, Key_g)
			Result.put (('h').code.to_natural_16, Key_h)
			Result.put (('i').code.to_natural_16, Key_i)
			Result.put (('j').code.to_natural_16, Key_j)
			Result.put (('k').code.to_natural_16, Key_k)
			Result.put (('l').code.to_natural_16, Key_l)
			Result.put (('m').code.to_natural_16, Key_m)
			Result.put (('n').code.to_natural_16, Key_n)
			Result.put (('o').code.to_natural_16, Key_o)
			Result.put (('p').code.to_natural_16, Key_p)
			Result.put (('q').code.to_natural_16, Key_q)
			Result.put (('r').code.to_natural_16, Key_r)
			Result.put (('s').code.to_natural_16, Key_s)
			Result.put (('t').code.to_natural_16, Key_t)
			Result.put (('u').code.to_natural_16, Key_u)
			Result.put (('v').code.to_natural_16, Key_v)
			Result.put (('w').code.to_natural_16, Key_w)
			Result.put (('x').code.to_natural_16, Key_x)
			Result.put (('y').code.to_natural_16, Key_y)
			Result.put (('z').code.to_natural_16, Key_z)
			Result.put (0, Key_shift)
			Result.put (0, Key_ctrl)
			Result.put (0, key_alt)
			Result.put (0, key_alt)
			Result.put (0, Key_left_meta)
			Result.put (0, Key_right_meta)
			Result.put (menu_key, Key_menu)
		end

	cocoa_to_v2_table: HASH_TABLE [INTEGER, NATURAL_16]
			-- Vision2 keycodes indexed by Cocoa key code.
		once
			create Result.make (128)
			Result.put (Key_0, ('0').code.to_natural_16)
			Result.put (Key_1, ('1').code.to_natural_16)
			Result.put (Key_2, ('2').code.to_natural_16)
			Result.put (Key_3, ('3').code.to_natural_16)
			Result.put (Key_4, ('4').code.to_natural_16)
			Result.put (Key_5, ('5').code.to_natural_16)
			Result.put (Key_6, ('6').code.to_natural_16)
			Result.put (Key_7, ('7').code.to_natural_16)
			Result.put (Key_8, ('8').code.to_natural_16)
			Result.put (Key_9, ('9').code.to_natural_16)
			Result.put (Key_numpad_0, ('0').code.to_natural_16)
			Result.put (Key_numpad_1, ('1').code.to_natural_16)
			Result.put (Key_numpad_2, ('2').code.to_natural_16)
			Result.put (Key_numpad_3, ('3').code.to_natural_16)
			Result.put (Key_numpad_4, ('4').code.to_natural_16)
			Result.put (Key_numpad_5, ('5').code.to_natural_16)
			Result.put (Key_numpad_6, ('6').code.to_natural_16)
			Result.put (Key_numpad_7, ('7').code.to_natural_16)
			Result.put (Key_numpad_8, ('8').code.to_natural_16)
			Result.put (Key_numpad_9, ('9').code.to_natural_16)
			Result.put (Key_numpad_add, ('+').code.to_natural_16)
			Result.put (Key_numpad_divide, ('/').code.to_natural_16)
			Result.put (Key_numpad_multiply, ('*').code.to_natural_16)
			Result.put (Key_num_lock, 0)
			Result.put (Key_numpad_subtract, ('-').code.to_natural_16)
			Result.put (Key_numpad_decimal, ('.').code.to_natural_16)
			Result.put (Key_f1, f1_key)
			Result.put (Key_f2, f2_key)
			Result.put (Key_f3, f3_key)
			Result.put (Key_f4, f4_key)
			Result.put (Key_f5, f5_key)
			Result.put (Key_f6, f6_key)
			Result.put (Key_f7, f7_key)
			Result.put (Key_f8, f8_key)
			Result.put (Key_f9, f9_key)
			Result.put (Key_f10, f10_key)
			Result.put (Key_f11, f11_key)
			Result.put (Key_f12, f12_key)
			Result.put (Key_space, (' ').code.to_natural_16)
			Result.put (Key_back_space, 127)
			Result.put (Key_enter, ('%N').code.to_natural_16)
			Result.put (Key_escape, 27)
			Result.put (Key_tab, ('%T').code.to_natural_16)
			Result.put (Key_pause, pause_key)
			Result.put (Key_comma, (',').code.to_natural_16)
			Result.put (Key_semicolon, (';').code.to_natural_16)
			Result.put (Key_up, up_arrow_key)
			Result.put (Key_down, down_arrow_key)
			Result.put (Key_left, left_arrow_key)
			Result.put (Key_right, right_arrow_key)
			Result.put (Key_page_up, page_up_key)
			Result.put (Key_page_down, page_down_key)
			Result.put (Key_home, home_key)
			Result.put (Key_end, end_key)
			Result.put (Key_insert, insert_char_key)
			Result.put (Key_insert, insert_key)
			Result.put (Key_delete, delete_char_key)
			Result.put (Key_delete, delete_key)
			Result.put (Key_a, ('A').code.to_natural_16)
			Result.put (Key_b, ('B').code.to_natural_16)
			Result.put (Key_c, ('C').code.to_natural_16)
			Result.put (Key_d, ('D').code.to_natural_16)
			Result.put (Key_e, ('E').code.to_natural_16)
			Result.put (Key_f, ('F').code.to_natural_16)
			Result.put (Key_g, ('G').code.to_natural_16)
			Result.put (Key_h, ('H').code.to_natural_16)
			Result.put (Key_i, ('I').code.to_natural_16)
			Result.put (Key_j, ('J').code.to_natural_16)
			Result.put (Key_k, ('K').code.to_natural_16)
			Result.put (Key_l, ('L').code.to_natural_16)
			Result.put (Key_m, ('M').code.to_natural_16)
			Result.put (Key_n, ('N').code.to_natural_16)
			Result.put (Key_o, ('O').code.to_natural_16)
			Result.put (Key_p, ('P').code.to_natural_16)
			Result.put (Key_q, ('Q').code.to_natural_16)
			Result.put (Key_r, ('R').code.to_natural_16)
			Result.put (Key_s, ('S').code.to_natural_16)
			Result.put (Key_t, ('T').code.to_natural_16)
			Result.put (Key_u, ('U').code.to_natural_16)
			Result.put (Key_v, ('V').code.to_natural_16)
			Result.put (Key_w, ('W').code.to_natural_16)
			Result.put (Key_x, ('X').code.to_natural_16)
			Result.put (Key_y, ('Y').code.to_natural_16)
			Result.put (Key_z, ('Z').code.to_natural_16)
			Result.put (Key_a, ('a').code.to_natural_16)
			Result.put (Key_b, ('b').code.to_natural_16)
			Result.put (Key_c, ('c').code.to_natural_16)
			Result.put (Key_d, ('d').code.to_natural_16)
			Result.put (Key_e, ('e').code.to_natural_16)
			Result.put (Key_f, ('f').code.to_natural_16)
			Result.put (Key_g, ('g').code.to_natural_16)
			Result.put (Key_h, ('h').code.to_natural_16)
			Result.put (Key_i, ('i').code.to_natural_16)
			Result.put (Key_j, ('j').code.to_natural_16)
			Result.put (Key_k, ('k').code.to_natural_16)
			Result.put (Key_l, ('l').code.to_natural_16)
			Result.put (Key_m, ('m').code.to_natural_16)
			Result.put (Key_n, ('n').code.to_natural_16)
			Result.put (Key_o, ('o').code.to_natural_16)
			Result.put (Key_p, ('p').code.to_natural_16)
			Result.put (Key_q, ('q').code.to_natural_16)
			Result.put (Key_r, ('r').code.to_natural_16)
			Result.put (Key_s, ('s').code.to_natural_16)
			Result.put (Key_t, ('t').code.to_natural_16)
			Result.put (Key_u, ('u').code.to_natural_16)
			Result.put (Key_v, ('v').code.to_natural_16)
			Result.put (Key_w, ('w').code.to_natural_16)
			Result.put (Key_x, ('x').code.to_natural_16)
			Result.put (Key_y, ('y').code.to_natural_16)
			Result.put (Key_z, ('z').code.to_natural_16)
			Result.put (Key_backquote, ('`').code.to_natural_16)
			Result.put (Key_dash, ('-').code.to_natural_16)
			Result.put (Key_equal, ('=').code.to_natural_16)
			Result.put (Key_semicolon, (';').code.to_natural_16)
			Result.put (Key_quote, ('%'').code.to_natural_16)
			Result.put (Key_comma, (',').code.to_natural_16)
			Result.put (Key_period, ('.').code.to_natural_16)
			Result.put (Key_slash, ('/').code.to_natural_16)
			Result.put (Key_open_bracket, ('(').code.to_natural_16)
			Result.put (Key_close_bracket, (')').code.to_natural_16)
			Result.put (Key_backslash, ('\').code.to_natural_16)
			Result.put (Key_menu, menu_key)
		end

feature {EV_ANY_I} -- Externals

	up_arrow_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUpArrowFunctionKey"
		end

	down_arrow_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDownArrowFunctionKey"
		end

	left_arrow_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLeftArrowFunctionKey"
		end

	right_arrow_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRightArrowFunctionKey"
		end

	f1_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF1FunctionKey"
		end

	f2_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF2FunctionKey"
		end

	f3_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF3FunctionKey"
		end

	f4_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF4FunctionKey"
		end

	f5_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF5FunctionKey"
		end

	f6_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF6FunctionKey"
		end

	f7_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF7FunctionKey"
		end

	f8_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF8FunctionKey"
		end

	f9_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF9FunctionKey"
		end

	f10_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF10FunctionKey"
		end

	f11_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF11FunctionKey"
		end

	f12_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF12FunctionKey"
		end

	f13_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF13FunctionKey"
		end

	f14_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF14FunctionKey"
		end

	f15_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF15FunctionKey"
		end

	f16_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF16FunctionKey"
		end

	f17_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF17FunctionKey"
		end

	f18_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF18FunctionKey"
		end

	f19_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF19FunctionKey"
		end

	f20_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF20FunctionKey"
		end

	f21_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF21FunctionKey"
		end

	f22_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF22FunctionKey"
		end

	f23_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF23FunctionKey"
		end

	f24_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF24FunctionKey"
		end

	f25_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF25FunctionKey"
		end

	f26_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF26FunctionKey"
		end

	f27_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF27FunctionKey"
		end

	f28_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF28FunctionKey"
		end

	f29_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF29FunctionKey"
		end

	f30_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF30FunctionKey"
		end

	f31_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF31FunctionKey"
		end

	f32_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF32FunctionKey"
		end

	f33_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF33FunctionKey"
		end

	f34_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF34FunctionKey"
		end

	f35_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSF35FunctionKey"
		end

	insert_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSInsertFunctionKey"
		end

	delete_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDeleteFunctionKey"
		end

	home_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSHomeFunctionKey"
		end

	begin_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBeginFunctionKey"
		end

	end_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSEndFunctionKey"
		end

	page_up_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPageUpFunctionKey"
		end

	page_down_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPageDownFunctionKey"
		end

	print_screen_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPrintScreenFunctionKey"
		end

	scroll_lock_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSScrollLockFunctionKey"
		end

	pause_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPauseFunctionKey"
		end

	sys_req_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSysReqFunctionKey"
		end

	break_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBreakFunctionKey"
		end

	reset_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSResetFunctionKey"
		end

	stop_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSStopFunctionKey"
		end

	menu_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMenuFunctionKey"
		end

	user_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUserFunctionKey"
		end

	system_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSystemFunctionKey"
		end

	print_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPrintFunctionKey"
		end

	clear_line_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSClearLineFunctionKey"
		end

	clear_display_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSClearDisplayFunctionKey"
		end

	insert_line_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSInsertLineFunctionKey"
		end

	delete_line_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDeleteLineFunctionKey"
		end

	insert_char_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSInsertCharFunctionKey"
		end

	delete_char_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDeleteCharFunctionKey"
		end

	prev_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPrevFunctionKey"
		end

	next_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNextFunctionKey"
		end

	select_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSelectFunctionKey"
		end

	execute_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSExecuteFunctionKey"
		end

	undo_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUndoFunctionKey"
		end

	redo_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRedoFunctionKey"
		end

	find_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFindFunctionKey"
		end

	help_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSHelpFunctionKey"
		end

	mode_switch_key: NATURAL_16
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSModeSwitchFunctionKey"
		end

end
