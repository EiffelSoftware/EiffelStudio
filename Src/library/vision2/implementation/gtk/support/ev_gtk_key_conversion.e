indexing
	description: "Eiffel Vision GTK key conversion. Provides a function%N%
		%for GTK to vision2 conversion and for vision2 to GTK conversion."
	status: "See notice at end of class"
	date: "generated"
	revision: "generated"

class
	EV_GTK_KEY_CONVERSION

inherit
	EV_KEY_CONSTANTS

feature -- Conversion

	key_code_to_gtk (a_key_code: INTEGER): INTEGER is
			-- Corresponding WEL code for ``a_key_code''.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			Result := v2_to_gtk_table @ a_key_code
		end

	key_code_from_gtk (a_gtk_code: INTEGER): INTEGER is
			-- Corresponding key code for ``a_gtk_code''.
		require
			a_gtk_code_valid: valid_gtk_code (a_gtk_code)
		do
			Result := gtk_to_v2_table.item (a_gtk_code)
		end

feature -- Contract support

	valid_gtk_code (a_gtk_code: INTEGER): BOOLEAN is
			-- Is ``a_gtk_code'' valid?
		do
			Result := gtk_to_v2_table.has (a_gtk_code)
		end

feature {NONE} -- Implementation

	v2_to_gtk_table: ARRAY [INTEGER] is
			-- GTK keycodes indexed by Vision2 key code.
		once
			create Result.make (Key_0, Key_right_meta)
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
			Result.put (Key_left_meta_keysym, Key_left_meta)
			Result.put (Key_right_meta_keysym, Key_right_meta)
		end

	gtk_to_v2_table: HASH_TABLE [INTEGER, INTEGER] is
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
			Result.put (Key_left_meta, Key_left_meta_keysym)
			Result.put (Key_right_meta, Key_right_meta_keysym)
		end

feature {NONE} -- Externals

	Key_0_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_0"
		end

	Key_1_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_1"
		end

	Key_2_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_2"
		end

	Key_3_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_3"
		end

	Key_4_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_4"
		end

	Key_5_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_5"
		end

	Key_6_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_6"
		end

	Key_7_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_7"
		end

	Key_8_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_8"
		end

	Key_9_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_9"
		end

	Key_numpad_0_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_0"
		end

	Key_numpad_1_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_1"
		end

	Key_numpad_2_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_2"
		end

	Key_numpad_3_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_3"
		end

	Key_numpad_4_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_4"
		end

	Key_numpad_5_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_5"
		end

	Key_numpad_6_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_6"
		end

	Key_numpad_7_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_7"
		end

	Key_numpad_8_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_8"
		end

	Key_numpad_9_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_9"
		end

	Key_numpad_add_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Add"
		end

	Key_numpad_divide_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Divide"
		end

	Key_numpad_multiply_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Multiply"
		end

	Key_num_lock_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Num_Lock"
		end

	Key_numpad_subtract_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Subtract"
		end

	Key_numpad_decimal_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Decimal"
		end

	Key_f1_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F1"
		end

	Key_f2_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F2"
		end

	Key_f3_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F3"
		end

	Key_f4_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F4"
		end

	Key_f5_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F5"
		end

	Key_f6_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F6"
		end

	Key_f7_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F7"
		end

	Key_f8_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F8"
		end

	Key_f9_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F9"
		end

	Key_f10_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F10"
		end

	Key_f11_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F11"
		end

	Key_f12_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F12"
		end

	Key_space_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_space"
		end

	Key_back_space_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_BackSpace"
		end

	Key_enter_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Return"
		end

	Key_kp_enter_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Enter"
		end

	Key_escape_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Escape"
		end

	Key_tab_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Tab"
		end

	Key_shift_tab_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_ISO_Left_Tab"
		end

	Key_pause_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Pause"
		end

	Key_caps_lock_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Caps_Lock"
		end

	Key_scroll_lock_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F23"
		end

	Key_comma_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_comma"
		end

	Key_equal_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_equal"
		end

	Key_period_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_period"
		end

	Key_semicolon_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_semicolon"
		end

	Key_open_bracket_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_bracketleft"
		end

	Key_close_bracket_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_bracketright"
		end

	Key_slash_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_slash"
		end

	Key_backslash_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_backslash"
		end

	Key_quote_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_quoteleft"
		end

	Key_backquote_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_quoteright"
		end

	Key_dash_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_minus"
		end

	Key_up_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Up"
		end

	Key_kp_up_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Up"
		end

	Key_down_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Down"
		end

	Key_kp_down_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Down"
		end

	Key_left_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Left"
		end

	Key_kp_left_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Left"
		end

	Key_right_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Right"
		end

	Key_kp_right_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Right"
		end

	Key_page_up_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Page_Up"
		end

	Key_kp_page_up_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Page_Up"
		end

	Key_page_down_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Page_Down"
		end

	Key_kp_page_down_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Page_Down"
		end

	Key_home_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Home"
		end

	Key_kp_home_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Home"
		end

	Key_end_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_End"
		end

	Key_kp_end_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_End"
		end

	Key_insert_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Insert"
		end

	Key_kp_insert_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Insert"
		end

	Key_delete_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Delete"
		end

	Key_kp_delete_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_KP_Delete"
		end

	Key_a_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_A"
		end

	Key_b_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_B"
		end

	Key_c_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_C"
		end

	Key_d_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_D"
		end

	Key_e_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_E"
		end

	Key_f_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_F"
		end

	Key_g_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_G"
		end

	Key_h_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_H"
		end

	Key_i_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_I"
		end

	Key_j_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_J"
		end

	Key_k_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_K"
		end

	Key_l_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_L"
		end

	Key_m_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_M"
		end

	Key_n_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_N"
		end

	Key_o_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_O"
		end

	Key_p_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_P"
		end

	Key_q_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Q"
		end

	Key_r_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_R"
		end

	Key_s_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_S"
		end

	Key_t_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_T"
		end

	Key_u_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_U"
		end

	Key_v_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_V"
		end

	Key_w_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_W"
		end

	Key_x_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_X"
		end

	Key_y_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Y"
		end

	Key_z_upper_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Z"
		end

	Key_a_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_a"
		end

	Key_b_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_b"
		end

	Key_c_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_c"
		end

	Key_d_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_d"
		end

	Key_e_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_e"
		end

	Key_f_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_f"
		end

	Key_g_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_g"
		end

	Key_h_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_h"
		end

	Key_i_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_i"
		end

	Key_j_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_j"
		end

	Key_k_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_k"
		end

	Key_l_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_l"
		end

	Key_m_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_m"
		end

	Key_n_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_n"
		end

	Key_o_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_o"
		end

	Key_p_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_p"
		end

	Key_q_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_q"
		end

	Key_r_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_r"
		end

	Key_s_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_s"
		end

	Key_t_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_t"
		end

	Key_u_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_u"
		end

	Key_v_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_v"
		end

	Key_w_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_w"
		end

	Key_x_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_x"
		end

	Key_y_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_y"
		end

	Key_z_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_z"
		end

	Key_shift_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Shift_L"
		end

	Key_right_shift_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Shift_R"
		end

	Key_ctrl_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Control_L"
		end

	Key_right_ctrl_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Control_R"
		end

	Key_left_meta_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Meta_L"
		end

	Key_right_meta_keysym: INTEGER is
		external
			"C [macro <gdk/gdkkeysyms.h>]"
		alias
			"GDK_Meta_R"
		end

end -- class EV_GTK_KEY_CONVERSION

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
