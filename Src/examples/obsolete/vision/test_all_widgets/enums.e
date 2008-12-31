note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class ENUMS

-- identifiers 'b_*' correspond with buttons '*_b'
--             'm_*' correspond with messages invoked by '*_b'
--             'd_*' are used to give demos -that are included later-
--                   an index in 'windows.demo_window_array'

feature
	
	b_bulletin:                         INTEGER = 1
	b_form:                             INTEGER = 2
	b_radio_box:                        INTEGER = 3
	b_frame:                            INTEGER = 4
	b_scrolled_w:                       INTEGER = 5
	b_menu:                             INTEGER = 6
	b_option_pull:                      INTEGER = 7
	b_separator:                        INTEGER = 12
	b_scrollbar:                        INTEGER = 13
	b_scale:                            INTEGER = 14
	b_pict_color:                       INTEGER = 15
	b_push:                             INTEGER = 16
	b_label:                            INTEGER = 17
	b_draw:                             INTEGER = 18
	b_toggle:                           INTEGER = 19
	b_drawing_area:                     INTEGER = 20
	b_scroll_list:                      INTEGER = 21
	b_text_field:                       INTEGER = 22
	b_text:                             INTEGER = 23
	b_scrolled_t:                       INTEGER = 24
	d_bulletin_d:                       INTEGER = 25
	d_form_d:                           INTEGER = 26
	d_prompt_d:                         INTEGER = 27
	d_font_box_d:                       INTEGER = 28
	d_message_d:                        INTEGER = 29
	d_error_d:                          INTEGER = 30
	d_question_d:                       INTEGER = 31
	d_info_d:                           INTEGER = 32
	d_working_d:                        INTEGER = 33
	d_warning_d:                        INTEGER = 34
	d_file_sel_d:                       INTEGER = 35

	b_exit:                             INTEGER = 25

	b_button_press:                     INTEGER = 26
	b_pointer_motion:                   INTEGER = 27
	b_bg_color:                         INTEGER = 28
	b_bg_pixmap:                        INTEGER = 29
	b_button_motion:                    INTEGER = 30
	b_set_size:                         INTEGER = 31
	b_set_xy:                           INTEGER = 32
	b_destroy:                          INTEGER = 33
	b_hide:                             INTEGER = 34
	b_show:                             INTEGER = 35

	b_set_pixmap:                       INTEGER = 36

	b_set_font:                         INTEGER = 37
	b_set_fg:                           INTEGER = 38
	b_set_center:                       INTEGER = 39
	b_set_left:                         INTEGER = 40
	b_set_text:                         INTEGER = 41

	b_activate:                         INTEGER = 42

	b_output_only:                      INTEGER = 43
	b_input_output:                     INTEGER = 44
	b_show_value:                       INTEGER = 45
	b_hide_value:                       INTEGER = 46

	b_move_action:                      INTEGER = 47
	b_val_ch_act:                       INTEGER = 48
	b_set_granul:                       INTEGER = 49
	b_set_max:                          INTEGER = 50
	b_set_min:                          INTEGER = 51
	b_set_value:                        INTEGER = 52
	b_value:                            INTEGER = 53

	b_start:                            INTEGER = 54
	b_finish:                           INTEGER = 55
	b_forth:                            INTEGER = 56
	b_wipe_out:                         INTEGER = 57
	b_put_right:                        INTEGER = 58
	b_remove:                           INTEGER = 59
	b_item:                             INTEGER = 60
	b_select_item:                      INTEGER = 61
	b_selected_it:                      INTEGER = 62
	b_selected_pos:                     INTEGER = 63
	b_set_visible_item_count:           INTEGER = 64

	b_sel_active:                       INTEGER = 65
	b_is_read_only:                     INTEGER = 66
	b_set_read_only:                    INTEGER = 67
	b_set_editable:                     INTEGER = 68

	b_set_horiz:                        INTEGER = 69
	b_single_line:                      INTEGER = 70
	b_single_dashed:                    INTEGER = 71
	b_set_vert:                         INTEGER = 72
	b_double_line:                      INTEGER = 73
	b_double_dashed:                    INTEGER = 74

	b_set_max_size:                     INTEGER = 75
	b_get_text:                         INTEGER = 76
	b_append:                           INTEGER = 77
	b_insert:                           INTEGER = 78
	b_replace:                          INTEGER = 79
	b_clear:                            INTEGER = 80

	b_modify:                           INTEGER = 81
	b_sel_begin:                        INTEGER = 82
	b_sel_end:                          INTEGER = 83
	b_cursor_pos:                       INTEGER = 84
	b_margin_hei:                       INTEGER = 85
	b_margin_wid:                       INTEGER = 86
	b_clear_sel:                        INTEGER = 87
	b_set_sel:                          INTEGER = 88

	b_arm:                              INTEGER = 89
	b_disarm:                           INTEGER = 90
	b_value_changed:                    INTEGER = 91
	b_state:                            INTEGER = 92

	b_ok:                               INTEGER = 93
	b_cancel:                           INTEGER = 94
	b_font_cancel:                      INTEGER = 95
   
	m_activate:                         INTEGER = 96
	m_move_action:                      INTEGER = 97
	m_val_ch_act:                       INTEGER = 98
   
	b_bulletin_d:                       INTEGER = 99
	b_form_d:                           INTEGER = 100
	b_prompt_d:                         INTEGER = 101
	b_font_box_d:                       INTEGER = 102
	b_message_d:                        INTEGER = 103
	b_error_d:                          INTEGER = 104
	b_question_d:                       INTEGER = 105
	b_info_d:                           INTEGER = 106
	b_working_d:                        INTEGER = 107
	b_warning_d:                        INTEGER = 108
	b_file_sel_d:                       INTEGER = 109

	b_popup:                            INTEGER = 110
	b_popdown:                          INTEGER = 111

	b_hide_cancel:                      INTEGER = 112
	b_show_cancel:                      INTEGER = 113
	b_hide_help:                        INTEGER = 114
	b_show_help:                        INTEGER = 115
	b_hide_ok:                          INTEGER = 116
	b_show_ok:                          INTEGER = 117
	b_set_cancel:                       INTEGER = 118
	b_set_help:                         INTEGER = 119
	b_set_ok:                           INTEGER = 120
	b_cancel_action:                    INTEGER = 121
	b_help_action:                      INTEGER = 122
	b_ok_action:                        INTEGER = 123
	b_set_start:                        INTEGER = 124
	b_set_end:                          INTEGER = 125
	b_set_message:                      INTEGER = 126
   
	m_cancel_action:                    INTEGER = 127
	m_help_action:                      INTEGER = 128
	m_ok_action:                        INTEGER = 129
	m_apply_action:                     INTEGER = 130

	b_hide_apply:                       INTEGER = 131
	b_show_apply:                       INTEGER = 132
	b_set_apply:                        INTEGER = 133
	b_set_selection_label:              INTEGER = 134
	b_set_selection_text:               INTEGER = 135
	b_selection_text:                   INTEGER = 136

	b_font:                             INTEGER = 137
	b_apply_action:                     INTEGER = 138

	b_hide_filter:                      INTEGER = 139
	b_show_filter:                      INTEGER = 140
	b_filter_action:                    INTEGER = 141
	m_filter_action:                    INTEGER = 142
	b_hide_file_selection_label:        INTEGER = 143
	b_show_file_selection_label:        INTEGER = 144
	b_hide_file_selection_list:         INTEGER = 145
	b_show_file_selection_list:         INTEGER = 146
	b_dir_count:                        INTEGER = 147
	b_directory:                        INTEGER = 148
	b_file_count:                       INTEGER = 149
	b_filter:                           INTEGER = 150
	b_is_dir_valid:                     INTEGER = 151
	b_is_list_updated:                  INTEGER = 152
	b_pattern:                          INTEGER = 153
	b_selected_file:                    INTEGER = 154
	b_set_dir_list_label:               INTEGER = 155
	b_set_directory:                    INTEGER = 156
	b_set_directory_selection:          INTEGER = 157
	b_set_file_list_label:              INTEGER = 158
	b_set_file_list_width:              INTEGER = 159
	b_set_file_selection:               INTEGER = 160
	b_set_filter:                       INTEGER = 161
	b_set_filter_label:                 INTEGER = 162
	b_set_pattern:                      INTEGER = 163
	b_set_all_selection:                INTEGER = 164

	b_allow_resize:                     INTEGER = 165
	b_forbid_resize:                    INTEGER = 166

	m_value_changed:                    INTEGER = 167
	m_modify:                           INTEGER = 168

	no_demo:                            INTEGER = 0;

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


end -- class ENUMS


