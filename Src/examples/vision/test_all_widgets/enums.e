class ENUMS

-- identifiers 'b_*' correspond with buttons '*_b'
--             'm_*' correspond with messages invoked by '*_b'
--             'd_*' are used to give demos -that are included later-
--                   an index in 'windows.demo_window_array'

feature
	
	b_bulletin:                         INTEGER is 1
	b_form:                             INTEGER is 2
	b_radio_box:                        INTEGER is 3
	b_frame:                            INTEGER is 4
	b_scrolled_w:                       INTEGER is 5
	b_menu:                             INTEGER is 6
	b_option_pull:                      INTEGER is 7
	b_separator:                        INTEGER is 12
	b_scrollbar:                        INTEGER is 13
	b_scale:                            INTEGER is 14
	b_pict_color:                       INTEGER is 15
	b_push:                             INTEGER is 16
	b_label:                            INTEGER is 17
	b_draw:                             INTEGER is 18
	b_toggle:                           INTEGER is 19
	b_drawing_area:                     INTEGER is 20
	b_scroll_list:                      INTEGER is 21
	b_text_field:                       INTEGER is 22
	b_text:                             INTEGER is 23
	b_scrolled_t:                       INTEGER is 24
	d_bulletin_d:                       INTEGER is 25
	d_form_d:                           INTEGER is 26
	d_prompt_d:                         INTEGER is 27
	d_font_box_d:                       INTEGER is 28
	d_message_d:                        INTEGER is 29
	d_error_d:                          INTEGER is 30
	d_question_d:                       INTEGER is 31
	d_info_d:                           INTEGER is 32
	d_working_d:                        INTEGER is 33
	d_warning_d:                        INTEGER is 34
	d_file_sel_d:                       INTEGER is 35

	b_exit:                             INTEGER is 25

	b_button_press:                     INTEGER is 26
	b_pointer_motion:                   INTEGER is 27
	b_bg_color:                         INTEGER is 28
	b_bg_pixmap:                        INTEGER is 29
	b_button_motion:                    INTEGER is 30
	b_set_size:                         INTEGER is 31
	b_set_xy:                           INTEGER is 32
	b_destroy:                          INTEGER is 33
	b_hide:                             INTEGER is 34
	b_show:                             INTEGER is 35

	b_set_pixmap:                       INTEGER is 36

	b_set_font:                         INTEGER is 37
	b_set_fg:                           INTEGER is 38
	b_set_center:                       INTEGER is 39
	b_set_left:                         INTEGER is 40
	b_set_text:                         INTEGER is 41

	b_activate:                         INTEGER is 42

	b_output_only:                      INTEGER is 43
	b_input_output:                     INTEGER is 44
	b_show_value:                       INTEGER is 45
	b_hide_value:                       INTEGER is 46

	b_move_action:                      INTEGER is 47
	b_val_ch_act:                       INTEGER is 48
	b_set_granul:                       INTEGER is 49
	b_set_max:                          INTEGER is 50
	b_set_min:                          INTEGER is 51
	b_set_value:                        INTEGER is 52
	b_value:                            INTEGER is 53

	b_start:                            INTEGER is 54
	b_finish:                           INTEGER is 55
	b_forth:                            INTEGER is 56
	b_wipe_out:                         INTEGER is 57
	b_put_right:                        INTEGER is 58
	b_remove:                           INTEGER is 59
	b_item:                             INTEGER is 60
	b_select_item:                      INTEGER is 61
	b_selected_it:                      INTEGER is 62
	b_selected_pos:                     INTEGER is 63
	b_set_visible_item_count:           INTEGER is 64

	b_sel_active:                       INTEGER is 65
	b_is_read_only:                     INTEGER is 66
	b_set_read_only:                    INTEGER is 67
	b_set_editable:                     INTEGER is 68

	b_set_horiz:                        INTEGER is 69
	b_single_line:                      INTEGER is 70
	b_single_dashed:                    INTEGER is 71
	b_set_vert:                         INTEGER is 72
	b_double_line:                      INTEGER is 73
	b_double_dashed:                    INTEGER is 74

	b_set_max_size:                     INTEGER is 75
	b_get_text:                         INTEGER is 76
	b_append:                           INTEGER is 77
	b_insert:                           INTEGER IS 78
	b_replace:                          INTEGER is 79
	b_clear:                            INTEGER is 80

	b_modify:                           INTEGER is 81
	b_sel_begin:                        INTEGER is 82
	b_sel_end:                          INTEGER is 83
	b_cursor_pos:                       INTEGER is 84
	b_margin_hei:                       INTEGER is 85
	b_margin_wid:                       INTEGER is 86
	b_clear_sel:                        INTEGER is 87
	b_set_sel:                          INTEGER is 88

	b_arm:                              INTEGER is 89
	b_disarm:                           INTEGER is 90
	b_value_changed:                    INTEGER is 91
	b_state:                            INTEGER is 92

	b_ok:                               INTEGER is 93
	b_cancel:                           INTEGER is 94
	b_font_cancel:                      INTEGER is 95
   
	m_activate:                         INTEGER is 96
	m_move_action:                      INTEGER is 97
	m_val_ch_act:                       INTEGER is 98
   
	b_bulletin_d:                       INTEGER is 99
	b_form_d:                           INTEGER is 100
	b_prompt_d:                         INTEGER is 101
	b_font_box_d:                       INTEGER is 102
	b_message_d:                        INTEGER is 103
	b_error_d:                          INTEGER is 104
	b_question_d:                       INTEGER is 105
	b_info_d:                           INTEGER is 106
	b_working_d:                        INTEGER is 107
	b_warning_d:                        INTEGER is 108
	b_file_sel_d:                       INTEGER is 109

	b_popup:                            INTEGER is 110
	b_popdown:                          INTEGER is 111

	b_hide_cancel:                      INTEGER is 112
	b_show_cancel:                      INTEGER is 113
	b_hide_help:                        INTEGER is 114
	b_show_help:                        INTEGER is 115
	b_hide_ok:                          INTEGER is 116
	b_show_ok:                          INTEGER is 117
	b_set_cancel:                       INTEGER is 118
	b_set_help:                         INTEGER is 119
	b_set_ok:                           INTEGER is 120
	b_cancel_action:                    INTEGER is 121
	b_help_action:                      INTEGER is 122
	b_ok_action:                        INTEGER is 123
	b_set_start:                        INTEGER is 124
	b_set_end:                          INTEGER is 125
	b_set_message:                      INTEGER is 126
   
	m_cancel_action:                    INTEGER is 127
	m_help_action:                      INTEGER is 128
	m_ok_action:                        INTEGER is 129
	m_apply_action:                     INTEGER is 130

	b_hide_apply:                       INTEGER is 131
	b_show_apply:                       INTEGER is 132
	b_set_apply:                        INTEGER is 133
	b_set_selection_label:              INTEGER is 134
	b_set_selection_text:               INTEGER is 135
	b_selection_text:                   INTEGER is 136

	b_font:                             INTEGER is 137
	b_apply_action:                     INTEGER is 138

	b_hide_filter:                      INTEGER is 139
	b_show_filter:                      INTEGER is 140
	b_filter_action:                    INTEGER is 141
	m_filter_action:                    INTEGER is 142
	b_hide_file_selection_label:        INTEGER is 143
	b_show_file_selection_label:        INTEGER is 144
	b_hide_file_selection_list:         INTEGER is 145
	b_show_file_selection_list:         INTEGER is 146
	b_dir_count:                        INTEGER is 147
	b_directory:                        INTEGER is 148
	b_file_count:                       INTEGER is 149
	b_filter:                           INTEGER is 150
	b_is_dir_valid:                     INTEGER is 151
	b_is_list_updated:                  INTEGER is 152
	b_pattern:                          INTEGER is 153
	b_selected_file:                    INTEGER is 154
	b_set_dir_list_label:               INTEGER is 155
	b_set_directory:                    INTEGER is 156
	b_set_directory_selection:          INTEGER is 157
	b_set_file_list_label:              INTEGER is 158
	b_set_file_list_width:              INTEGER is 159
	b_set_file_selection:               INTEGER is 160
	b_set_filter:                       INTEGER is 161
	b_set_filter_label:                 INTEGER is 162
	b_set_pattern:                      INTEGER is 163
	b_set_all_selection:                INTEGER is 164

	b_allow_resize:                     INTEGER is 165
	b_forbid_resize:                    INTEGER is 166

	m_value_changed:                    INTEGER is 167
	m_modify:                           INTEGER is 168

	no_demo:                            INTEGER is 0

end -- class ENUMS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

