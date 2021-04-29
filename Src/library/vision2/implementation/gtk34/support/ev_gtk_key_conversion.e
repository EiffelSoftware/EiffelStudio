note
	description: "Eiffel Vision GTK key conversion. Provides a function%N%
		%for GTK to vision2 conversion and for vision2 to GTK conversion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "generated"
	revision: "generated"

class
	EV_GTK_KEY_CONVERSION

inherit
	EV_KEY_CONSTANTS

feature -- Conversion

	key_code_to_gtk (a_key_code: INTEGER): NATURAL_32
			-- Corresponding GTK code for `a_key_code'.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			Result := v2_to_gtk_table @ a_key_code
		end

	key_code_from_gtk (a_gtk_code: NATURAL_32): INTEGER
			-- Corresponding key code for `a_gtk_code'.
		require
			a_gtk_code_valid: valid_gtk_code (a_gtk_code)
		do
			Result := gtk_to_v2_table.item (a_gtk_code)
		end

feature -- Contract support

	valid_gtk_code (a_gtk_code: NATURAL_32): BOOLEAN
			-- Is `a_gtk_code' valid?
		do
			Result := gtk_to_v2_table.has (a_gtk_code)
		end

feature {NONE} -- Implementation

	v2_to_gtk_table: ARRAY [NATURAL_32]
			-- GTK keycodes indexed by Vision2 key code.
		once
			create Result.make_filled ({NATURAL_32} 0, Key_0, Key_menu)
			Result.put (Key_0_keysym, Key_0)
			Result.put (Key_1_keysym, Key_1)
			Result.put (Key_2_keysym, Key_2)
			Result.put (Key_3_keysym, Key_3)
			Result.put (Key_4_keysym, Key_4)
			Result.put (Key_5_keysym, Key_5)
			Result.put (Key_6_keysym, Key_6)
			Result.put (Key_7_keysym, Key_7)
			Result.put (Key_8_keysym, Key_8)
			Result.put (Key_9_keysym, Key_9)
			Result.put (Key_numpad_0_keysym, Key_numpad_0)
			Result.put (Key_numpad_1_keysym, Key_numpad_1)
			Result.put (Key_numpad_2_keysym, Key_numpad_2)
			Result.put (Key_numpad_3_keysym, Key_numpad_3)
			Result.put (Key_numpad_4_keysym, Key_numpad_4)
			Result.put (Key_numpad_5_keysym, Key_numpad_5)
			Result.put (Key_numpad_6_keysym, Key_numpad_6)
			Result.put (Key_numpad_7_keysym, Key_numpad_7)
			Result.put (Key_numpad_8_keysym, Key_numpad_8)
			Result.put (Key_numpad_9_keysym, Key_numpad_9)
			Result.put (Key_numpad_add_keysym, Key_numpad_add)
			Result.put (Key_numpad_divide_keysym, Key_numpad_divide)
			Result.put (Key_numpad_multiply_keysym, Key_numpad_multiply)
			Result.put (Key_num_lock_keysym, Key_num_lock)
			Result.put (Key_numpad_subtract_keysym, Key_numpad_subtract)
			Result.put (Key_numpad_decimal_keysym, Key_numpad_decimal)
			Result.put (Key_f1_keysym, Key_f1)
			Result.put (Key_f2_keysym, Key_f2)
			Result.put (Key_f3_keysym, Key_f3)
			Result.put (Key_f4_keysym, Key_f4)
			Result.put (Key_f5_keysym, Key_f5)
			Result.put (Key_f6_keysym, Key_f6)
			Result.put (Key_f7_keysym, Key_f7)
			Result.put (Key_f8_keysym, Key_f8)
			Result.put (Key_f9_keysym, Key_f9)
			Result.put (Key_f10_keysym, Key_f10)
			Result.put (Key_f11_keysym, Key_f11)
			Result.put (Key_f12_keysym, Key_f12)
			Result.put (Key_space_keysym, Key_space)
			Result.put (Key_back_space_keysym, Key_back_space)
			Result.put (Key_enter_keysym, Key_enter)
			Result.put (Key_escape_keysym, Key_escape)
			Result.put (Key_tab_keysym, Key_tab)
			Result.put (Key_pause_keysym, Key_pause)
			Result.put (Key_caps_lock_keysym, Key_caps_lock)
			Result.put (Key_scroll_lock_keysym, Key_scroll_lock)
			Result.put (Key_comma_keysym, Key_comma)
			Result.put (Key_equal_keysym, Key_equal)
			Result.put (Key_period_keysym, Key_period)
			Result.put (Key_semicolon_keysym, Key_semicolon)
			Result.put (Key_open_bracket_keysym, Key_open_bracket)
			Result.put (Key_close_bracket_keysym, Key_close_bracket)
			Result.put (Key_slash_keysym, Key_slash)
			Result.put (Key_backslash_keysym, Key_backslash)
			Result.put (Key_quote_keysym, Key_quote)
			Result.put (Key_backquote_keysym, Key_backquote)
			Result.put (Key_dash_keysym, Key_dash)
			Result.put (Key_up_keysym, Key_up)
			Result.put (Key_down_keysym, Key_down)
			Result.put (Key_left_keysym, Key_left)
			Result.put (Key_right_keysym, Key_right)
			Result.put (Key_page_up_keysym, Key_page_up)
			Result.put (Key_page_down_keysym, Key_page_down)
			Result.put (Key_home_keysym, Key_home)
			Result.put (Key_end_keysym, Key_end)
			Result.put (Key_insert_keysym, Key_insert)
			Result.put (Key_delete_keysym, Key_delete)
			Result.put (Key_a_keysym, Key_a)
			Result.put (Key_b_keysym, Key_b)
			Result.put (Key_c_keysym, Key_c)
			Result.put (Key_d_keysym, Key_d)
			Result.put (Key_e_keysym, Key_e)
			Result.put (Key_f_keysym, Key_f)
			Result.put (Key_g_keysym, Key_g)
			Result.put (Key_h_keysym, Key_h)
			Result.put (Key_i_keysym, Key_i)
			Result.put (Key_j_keysym, Key_j)
			Result.put (Key_k_keysym, Key_k)
			Result.put (Key_l_keysym, Key_l)
			Result.put (Key_m_keysym, Key_m)
			Result.put (Key_n_keysym, Key_n)
			Result.put (Key_o_keysym, Key_o)
			Result.put (Key_p_keysym, Key_p)
			Result.put (Key_q_keysym, Key_q)
			Result.put (Key_r_keysym, Key_r)
			Result.put (Key_s_keysym, Key_s)
			Result.put (Key_t_keysym, Key_t)
			Result.put (Key_u_keysym, Key_u)
			Result.put (Key_v_keysym, Key_v)
			Result.put (Key_w_keysym, Key_w)
			Result.put (Key_x_keysym, Key_x)
			Result.put (Key_y_keysym, Key_y)
			Result.put (Key_z_keysym, Key_z)
			Result.put (Key_shift_keysym, Key_shift)
			Result.put (Key_ctrl_keysym, Key_ctrl)
			Result.put (key_left_alt_keysym, key_alt)
			Result.put (key_right_alt_keysym, key_alt)
			Result.put (Key_left_meta_keysym, Key_left_meta)
			Result.put (Key_right_meta_keysym, Key_right_meta)
			Result.put (Key_menu_keysym, Key_menu)
		end

	gtk_to_v2_table: HASH_TABLE [INTEGER, NATURAL_32]
			-- Vision2 keycodes indexed by GTK key code.
		once
			create Result.make (128)
			Result.put (Key_0, Key_0_keysym)
			Result.put (Key_1, Key_1_keysym)
			Result.put (Key_2, Key_2_keysym)
			Result.put (Key_3, Key_3_keysym)
			Result.put (Key_4, Key_4_keysym)
			Result.put (Key_5, Key_5_keysym)
			Result.put (Key_6, Key_6_keysym)
			Result.put (Key_7, Key_7_keysym)
			Result.put (Key_8, Key_8_keysym)
			Result.put (Key_9, Key_9_keysym)
			Result.put (Key_numpad_0, Key_numpad_0_keysym)
			Result.put (Key_numpad_1, Key_numpad_1_keysym)
			Result.put (Key_numpad_2, Key_numpad_2_keysym)
			Result.put (Key_numpad_3, Key_numpad_3_keysym)
			Result.put (Key_numpad_4, Key_numpad_4_keysym)
			Result.put (Key_numpad_5, Key_numpad_5_keysym)
			Result.put (Key_numpad_6, Key_numpad_6_keysym)
			Result.put (Key_numpad_7, Key_numpad_7_keysym)
			Result.put (Key_numpad_8, Key_numpad_8_keysym)
			Result.put (Key_numpad_9, Key_numpad_9_keysym)
			Result.put (Key_numpad_add, Key_numpad_add_keysym)
			Result.put (Key_numpad_divide, Key_numpad_divide_keysym)
			Result.put (Key_numpad_multiply, Key_numpad_multiply_keysym)
			Result.put (Key_num_lock, Key_num_lock_keysym)
			Result.put (Key_numpad_subtract, Key_numpad_subtract_keysym)
			Result.put (Key_numpad_decimal, Key_numpad_decimal_keysym)
			Result.put (Key_f1, Key_f1_keysym)
			Result.put (Key_f2, Key_f2_keysym)
			Result.put (Key_f3, Key_f3_keysym)
			Result.put (Key_f4, Key_f4_keysym)
			Result.put (Key_f5, Key_f5_keysym)
			Result.put (Key_f6, Key_f6_keysym)
			Result.put (Key_f7, Key_f7_keysym)
			Result.put (Key_f8, Key_f8_keysym)
			Result.put (Key_f9, Key_f9_keysym)
			Result.put (Key_f10, Key_f10_keysym)
			Result.put (Key_f11, Key_f11_keysym)
			Result.put (Key_f12, Key_f12_keysym)
			Result.put (Key_space, Key_space_keysym)
			Result.put (Key_back_space, Key_back_space_keysym)
			Result.put (Key_enter, Key_enter_keysym)
			Result.put (Key_enter, Key_kp_enter_keysym)
			Result.put (Key_escape, Key_escape_keysym)
			Result.put (Key_tab, Key_tab_keysym)
			Result.put (Key_tab, Key_shift_tab_keysym)
			Result.put (Key_pause, Key_pause_keysym)
			Result.put (Key_caps_lock, Key_caps_lock_keysym)
			Result.put (Key_scroll_lock, Key_scroll_lock_keysym)
			Result.put (Key_comma, Key_comma_keysym)
			Result.put (Key_equal, Key_equal_keysym)
			Result.put (Key_period, Key_period_keysym)
			Result.put (Key_semicolon, Key_semicolon_keysym)
			Result.put (Key_open_bracket, Key_open_bracket_keysym)
			Result.put (Key_close_bracket, Key_close_bracket_keysym)
			Result.put (Key_slash, Key_slash_keysym)
			Result.put (Key_backslash, Key_backslash_keysym)
			Result.put (Key_quote, Key_quote_keysym)
			Result.put (Key_backquote, Key_backquote_keysym)
			Result.put (Key_dash, Key_dash_keysym)
			Result.put (Key_up, Key_up_keysym)
			Result.put (Key_up, Key_kp_up_keysym)
			Result.put (Key_down, Key_down_keysym)
			Result.put (Key_down, Key_kp_down_keysym)
			Result.put (Key_left, Key_left_keysym)
			Result.put (Key_left, Key_kp_left_keysym)
			Result.put (Key_right, Key_right_keysym)
			Result.put (Key_right, Key_kp_right_keysym)
			Result.put (Key_page_up, Key_page_up_keysym)
			Result.put (Key_page_up, Key_kp_page_up_keysym)
			Result.put (Key_page_down, Key_page_down_keysym)
			Result.put (Key_page_down, Key_kp_page_down_keysym)
			Result.put (Key_home, Key_home_keysym)
			Result.put (Key_home, Key_kp_home_keysym)
			Result.put (Key_end, Key_end_keysym)
			Result.put (Key_end, Key_kp_end_keysym)
			Result.put (Key_insert, Key_insert_keysym)
			Result.put (Key_insert, Key_kp_insert_keysym)
			Result.put (Key_delete, Key_delete_keysym)
			Result.put (Key_delete, Key_kp_delete_keysym)
			Result.put (Key_a, Key_a_upper_keysym)
			Result.put (Key_b, Key_b_upper_keysym)
			Result.put (Key_c, Key_c_upper_keysym)
			Result.put (Key_d, Key_d_upper_keysym)
			Result.put (Key_e, Key_e_upper_keysym)
			Result.put (Key_f, Key_f_upper_keysym)
			Result.put (Key_g, Key_g_upper_keysym)
			Result.put (Key_h, Key_h_upper_keysym)
			Result.put (Key_i, Key_i_upper_keysym)
			Result.put (Key_j, Key_j_upper_keysym)
			Result.put (Key_k, Key_k_upper_keysym)
			Result.put (Key_l, Key_l_upper_keysym)
			Result.put (Key_m, Key_m_upper_keysym)
			Result.put (Key_n, Key_n_upper_keysym)
			Result.put (Key_o, Key_o_upper_keysym)
			Result.put (Key_p, Key_p_upper_keysym)
			Result.put (Key_q, Key_q_upper_keysym)
			Result.put (Key_r, Key_r_upper_keysym)
			Result.put (Key_s, Key_s_upper_keysym)
			Result.put (Key_t, Key_t_upper_keysym)
			Result.put (Key_u, Key_u_upper_keysym)
			Result.put (Key_v, Key_v_upper_keysym)
			Result.put (Key_w, Key_w_upper_keysym)
			Result.put (Key_x, Key_x_upper_keysym)
			Result.put (Key_y, Key_y_upper_keysym)
			Result.put (Key_z, Key_z_upper_keysym)
			Result.put (Key_a, Key_a_keysym)
			Result.put (Key_b, Key_b_keysym)
			Result.put (Key_c, Key_c_keysym)
			Result.put (Key_d, Key_d_keysym)
			Result.put (Key_e, Key_e_keysym)
			Result.put (Key_f, Key_f_keysym)
			Result.put (Key_g, Key_g_keysym)
			Result.put (Key_h, Key_h_keysym)
			Result.put (Key_i, Key_i_keysym)
			Result.put (Key_j, Key_j_keysym)
			Result.put (Key_k, Key_k_keysym)
			Result.put (Key_l, Key_l_keysym)
			Result.put (Key_m, Key_m_keysym)
			Result.put (Key_n, Key_n_keysym)
			Result.put (Key_o, Key_o_keysym)
			Result.put (Key_p, Key_p_keysym)
			Result.put (Key_q, Key_q_keysym)
			Result.put (Key_r, Key_r_keysym)
			Result.put (Key_s, Key_s_keysym)
			Result.put (Key_t, Key_t_keysym)
			Result.put (Key_u, Key_u_keysym)
			Result.put (Key_v, Key_v_keysym)
			Result.put (Key_w, Key_w_keysym)
			Result.put (Key_x, Key_x_keysym)
			Result.put (Key_y, Key_y_keysym)
			Result.put (Key_z, Key_z_keysym)
			Result.put (Key_shift, Key_shift_keysym)
			Result.put (Key_shift, Key_right_shift_keysym)
			Result.put (Key_ctrl, Key_ctrl_keysym)
			Result.put (Key_ctrl, Key_right_ctrl_keysym)
			Result.put (key_alt, key_left_alt_keysym)
			Result.put (key_alt, key_right_alt_keysym)
			Result.put (Key_left_meta, Key_left_meta_keysym)
			Result.put (Key_right_meta, Key_right_meta_keysym)
			Result.put (Key_backquote, Key_tilde_keysym)
			Result.put (Key_1, Key_exclamation_keysym)
			Result.put (Key_2, Key_at_keysym)
			Result.put (Key_3, Key_numbersign_keysym)
			Result.put (Key_4, Key_dollar_keysym)
			Result.put (Key_5, Key_percent_keysym)
			Result.put (Key_6, Key_asciicircum_keysym)
			Result.put (Key_7, Key_ampersand_keysym)
			Result.put (Key_8, Key_asterisk_keysym)
			Result.put (Key_9, Key_parenleft_keysym)
			Result.put (Key_0, Key_parenright_keysym)
			Result.put (Key_dash, Key_underscore_keysym)
			Result.put (Key_equal, Key_plus_keysym)
			Result.put (Key_semicolon, Key_colon_keysym)
			Result.put (Key_quote, Key_quotedbl_keysym)
			Result.put (Key_comma, Key_less_keysym)
			Result.put (Key_period, Key_greater_keysym)
			Result.put (Key_slash, Key_question_keysym)
			Result.put (Key_open_bracket, Key_braceleft_keysym)
			Result.put (Key_close_bracket, Key_braceright_keysym)
			Result.put (Key_backslash, Key_bar_keysym)
			Result.put (Key_menu, Key_menu_keysym)
		end

feature {EV_ANY_I} -- Externals

	Key_tilde_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_asciitilde"
		ensure
			is_class: class
		end

	Key_exclamation_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_exclam"
		ensure
			is_class: class
		end

	Key_at_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_at"
		ensure
			is_class: class
		end

	Key_numbersign_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_numbersign"
		ensure
			is_class: class
		end

	Key_dollar_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_dollar"
		ensure
			is_class: class
		end

	Key_percent_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_percent"
		ensure
			is_class: class
		end

	Key_asciicircum_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_asciicircum"
		ensure
			is_class: class
		end

	Key_ampersand_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_ampersand"
		ensure
			is_class: class
		end

	Key_asterisk_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_asterisk"
		ensure
			is_class: class
		end

	Key_parenleft_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_parenleft"
		ensure
			is_class: class
		end

	Key_parenright_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_parenright"
		ensure
			is_class: class
		end

	Key_underscore_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_underscore"
		ensure
			is_class: class
		end

	Key_plus_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_plus"
		ensure
			is_class: class
		end

	Key_colon_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_colon"
		ensure
			is_class: class
		end

	Key_quotedbl_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_quotedbl"
		ensure
			is_class: class
		end

	Key_less_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_less"
		ensure
			is_class: class
		end

	Key_greater_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_greater"
		ensure
			is_class: class
		end

	Key_question_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_question"
		ensure
			is_class: class
		end

	Key_braceleft_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_braceleft"
		ensure
			is_class: class
		end

	Key_braceright_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_braceright"
		ensure
			is_class: class
		end

	Key_bar_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_bar"
		ensure
			is_class: class
		end

	Key_0_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_0"
		ensure
			is_class: class
		end

	frozen Key_1_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_1"
		ensure
			is_class: class
		end

	Key_2_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_2"
		ensure
			is_class: class
		end

	Key_3_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_3"
		ensure
			is_class: class
		end

	Key_4_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_4"
		ensure
			is_class: class
		end

	Key_5_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_5"
		ensure
			is_class: class
		end

	Key_6_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_6"
		ensure
			is_class: class
		end

	Key_7_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_7"
		ensure
			is_class: class
		end

	Key_8_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_8"
		ensure
			is_class: class
		end

	Key_9_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_9"
		ensure
			is_class: class
		end

	Key_numpad_0_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_0"
		ensure
			is_class: class
		end

	Key_numpad_1_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_1"
		ensure
			is_class: class
		end

	Key_numpad_2_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_2"
		ensure
			is_class: class
		end

	Key_numpad_3_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_3"
		ensure
			is_class: class
		end

	Key_numpad_4_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_4"
		ensure
			is_class: class
		end

	Key_numpad_5_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_5"
		ensure
			is_class: class
		end

	Key_numpad_6_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_6"
		ensure
			is_class: class
		end

	Key_numpad_7_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_7"
		ensure
			is_class: class
		end

	Key_numpad_8_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_8"
		ensure
			is_class: class
		end

	Key_numpad_9_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_9"
		ensure
			is_class: class
		end

	Key_numpad_add_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Add"
		ensure
			is_class: class
		end

	Key_numpad_divide_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Divide"
		ensure
			is_class: class
		end

	Key_numpad_multiply_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Multiply"
		ensure
			is_class: class
		end

	Key_num_lock_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Num_Lock"
		ensure
			is_class: class
		end

	Key_numpad_subtract_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Subtract"
		ensure
			is_class: class
		end

	Key_numpad_decimal_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Decimal"
		ensure
			is_class: class
		end

	Key_f1_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F1"
		ensure
			is_class: class
		end

	Key_f2_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F2"
		ensure
			is_class: class
		end

	Key_f3_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F3"
		ensure
			is_class: class
		end

	Key_f4_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F4"
		ensure
			is_class: class
		end

	Key_f5_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F5"
		ensure
			is_class: class
		end

	Key_f6_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F6"
		ensure
			is_class: class
		end

	Key_f7_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F7"
		ensure
			is_class: class
		end

	Key_f8_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F8"
		ensure
			is_class: class
		end

	Key_f9_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F9"
		ensure
			is_class: class
		end

	Key_f10_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F10"
		ensure
			is_class: class
		end

	Key_f11_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F11"
		ensure
			is_class: class
		end

	Key_f12_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F12"
		ensure
			is_class: class
		end

	Key_space_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_space"
		ensure
			is_class: class
		end

	Key_back_space_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_BackSpace"
		ensure
			is_class: class
		end

	Key_enter_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Return"
		ensure
			is_class: class
		end

	Key_kp_enter_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Enter"
		ensure
			is_class: class
		end

	Key_escape_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Escape"
		ensure
			is_class: class
		end

	Key_tab_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Tab"
		ensure
			is_class: class
		end

	Key_shift_tab_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_ISO_Left_Tab"
		ensure
			is_class: class
		end

	Key_pause_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Pause"
		ensure
			is_class: class
		end

	Key_caps_lock_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Caps_Lock"
		ensure
			is_class: class
		end

	Key_scroll_lock_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F23"
		ensure
			is_class: class
		end

	Key_comma_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_comma"
		ensure
			is_class: class
		end

	Key_equal_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_equal"
		ensure
			is_class: class
		end

	Key_period_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_period"
		ensure
			is_class: class
		end

	Key_semicolon_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_semicolon"
		ensure
			is_class: class
		end

	Key_open_bracket_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_bracketleft"
		ensure
			is_class: class
		end

	Key_close_bracket_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_bracketright"
		ensure
			is_class: class
		end

	Key_slash_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_slash"
		ensure
			is_class: class
		end

	Key_backslash_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_backslash"
		ensure
			is_class: class
		end

	Key_quote_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_quoteright"
		ensure
			is_class: class
		end

	Key_backquote_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_quoteleft"
		ensure
			is_class: class
		end

	Key_dash_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_minus"
		ensure
			is_class: class
		end

	Key_up_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Up"
		ensure
			is_class: class
		end

	Key_kp_up_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Up"
		ensure
			is_class: class
		end

	Key_down_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Down"
		ensure
			is_class: class
		end

	Key_kp_down_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Down"
		ensure
			is_class: class
		end

	Key_left_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Left"
		ensure
			is_class: class
		end

	Key_kp_left_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Left"
		ensure
			is_class: class
		end

	Key_right_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Right"
		ensure
			is_class: class
		end

	Key_kp_right_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Right"
		ensure
			is_class: class
		end

	Key_page_up_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Page_Up"
		ensure
			is_class: class
		end

	Key_kp_page_up_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Page_Up"
		ensure
			is_class: class
		end

	Key_page_down_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Page_Down"
		ensure
			is_class: class
		end

	Key_kp_page_down_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Page_Down"
		ensure
			is_class: class
		end

	Key_home_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Home"
		ensure
			is_class: class
		end

	Key_kp_home_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Home"
		ensure
			is_class: class
		end

	Key_end_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_End"
		ensure
			is_class: class
		end

	Key_kp_end_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_End"
		ensure
			is_class: class
		end

	Key_insert_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Insert"
		ensure
			is_class: class
		end

	Key_kp_insert_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Insert"
		ensure
			is_class: class
		end

	Key_delete_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Delete"
		ensure
			is_class: class
		end

	Key_kp_delete_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_KP_Delete"
		ensure
			is_class: class
		end

	Key_a_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_A"
		ensure
			is_class: class
		end

	Key_b_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_B"
		ensure
			is_class: class
		end

	Key_c_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_C"
		ensure
			is_class: class
		end

	Key_d_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_D"
		ensure
			is_class: class
		end

	Key_e_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_E"
		ensure
			is_class: class
		end

	Key_f_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_F"
		ensure
			is_class: class
		end

	Key_g_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_G"
		ensure
			is_class: class
		end

	Key_h_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_H"
		ensure
			is_class: class
		end

	Key_i_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_I"
		ensure
			is_class: class
		end

	Key_j_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_J"
		ensure
			is_class: class
		end

	Key_k_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_K"
		ensure
			is_class: class
		end

	Key_l_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_L"
		ensure
			is_class: class
		end

	Key_m_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_M"
		ensure
			is_class: class
		end

	Key_n_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_N"
		ensure
			is_class: class
		end

	Key_o_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_O"
		ensure
			is_class: class
		end

	Key_p_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_P"
		ensure
			is_class: class
		end

	Key_q_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Q"
		ensure
			is_class: class
		end

	Key_r_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_R"
		ensure
			is_class: class
		end

	Key_s_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_S"
		ensure
			is_class: class
		end

	Key_t_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_T"
		ensure
			is_class: class
		end

	Key_u_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_U"
		ensure
			is_class: class
		end

	Key_v_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_V"
		ensure
			is_class: class
		end

	Key_w_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_W"
		ensure
			is_class: class
		end

	Key_x_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_X"
		ensure
			is_class: class
		end

	Key_y_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Y"
		ensure
			is_class: class
		end

	Key_z_upper_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Z"
		ensure
			is_class: class
		end

	frozen Key_a_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_a"
		ensure
			is_class: class
		end

	Key_b_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_b"
		ensure
			is_class: class
		end

	Key_c_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_c"
		ensure
			is_class: class
		end

	Key_d_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_d"
		ensure
			is_class: class
		end

	Key_e_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_e"
		ensure
			is_class: class
		end

	Key_f_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_f"
		ensure
			is_class: class
		end

	Key_g_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_g"
		ensure
			is_class: class
		end

	Key_h_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_h"
		ensure
			is_class: class
		end

	Key_i_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_i"
		ensure
			is_class: class
		end

	Key_j_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_j"
		ensure
			is_class: class
		end

	Key_k_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_k"
		ensure
			is_class: class
		end

	Key_l_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_l"
		ensure
			is_class: class
		end

	Key_m_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_m"
		ensure
			is_class: class
		end

	Key_n_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_n"
		ensure
			is_class: class
		end

	Key_o_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_o"
		ensure
			is_class: class
		end

	Key_p_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_p"
		ensure
			is_class: class
		end

	Key_q_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_q"
		ensure
			is_class: class
		end

	Key_r_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_r"
		ensure
			is_class: class
		end

	Key_s_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_s"
		ensure
			is_class: class
		end

	Key_t_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_t"
		ensure
			is_class: class
		end

	Key_u_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_u"
		ensure
			is_class: class
		end

	Key_v_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_v"
		ensure
			is_class: class
		end

	Key_w_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_w"
		ensure
			is_class: class
		end

	Key_x_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_x"
		ensure
			is_class: class
		end

	Key_y_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_y"
		ensure
			is_class: class
		end

	Key_z_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_z"
		ensure
			is_class: class
		end

	Key_shift_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Shift_L"
		ensure
			is_class: class
		end

	Key_right_shift_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Shift_R"
		ensure
			is_class: class
		end

	Key_ctrl_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Control_L"
		ensure
			is_class: class
		end

	Key_right_ctrl_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Control_R"
		ensure
			is_class: class
		end

	Key_left_meta_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Meta_L"
		ensure
			is_class: class
		end

	Key_right_meta_keysym: NATURAL_32
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KEY_Meta_R"
		ensure
			is_class: class
		end

	Key_left_alt_keysym: NATURAL_32
		external
			"C macro use <gdk/gdkkeysyms.h>"
		alias
			"GDK_KEY_Alt_L"
		ensure
			is_class: class
		end

	Key_right_alt_keysym: NATURAL_32
		external
			"C macro use <gdk/gdkkeysyms.h>"
		alias
			"GDK_KEY_Alt_R"
		ensure
			is_class: class
		end

	Key_menu_keysym: NATURAL_32
		external
			"C macro use <gdk/gdkkeysyms.h>"
		alias
			"GDK_KEY_Menu"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_KEY_CONVERSION

