indexing
	description: "Constants derived from GTK enums."
	status: "See notice at end of class"

class
	EV_GTK_ENUMS

feature -- C enums

	G_traverse_leafs_enum: INTEGER is 1

	G_traverse_non_leafs_enum: INTEGER is 2

	G_traverse_all_enum: INTEGER is 3

	G_traverse_mask_enum: INTEGER is 3

	G_in_order_enum: INTEGER is 0

	G_pre_order_enum: INTEGER is 1

	G_post_order_enum: INTEGER is 2

	G_level_order_enum: INTEGER is 3

	G_log_flag_recursion_enum: INTEGER is 1

	G_log_flag_fatal_enum: INTEGER is 2

	G_log_level_error_enum: INTEGER is 4

	G_log_level_critical_enum: INTEGER is 8

	G_log_level_warning_enum: INTEGER is 16

	G_log_level_message_enum: INTEGER is 32

	G_log_level_info_enum: INTEGER is 64

	G_log_level_debug_enum: INTEGER is 128

	G_log_level_mask_enum: INTEGER is -4

	G_hook_flag_active_enum: INTEGER is 1

	G_hook_flag_in_call_enum: INTEGER is 2

	G_hook_flag_mask_enum: INTEGER is 15

	G_err_unknown_enum: INTEGER is 0

	G_err_unexp_eof_enum: INTEGER is 1

	G_err_unexp_eof_in_string_enum: INTEGER is 2

	G_err_unexp_eof_in_comment_enum: INTEGER is 3

	G_err_non_digit_in_const_enum: INTEGER is 4

	G_err_digit_radix_enum: INTEGER is 5

	G_err_float_radix_enum: INTEGER is 6

	G_err_float_malformed_enum: INTEGER is 7

	G_token_eof_enum: INTEGER is 0

	G_token_left_paren_enum: INTEGER is 40

	G_token_right_paren_enum: INTEGER is 41

	G_token_left_curly_enum: INTEGER is 123

	G_token_right_curly_enum: INTEGER is 125

	G_date_day_enum: INTEGER is 0

	G_date_month_enum: INTEGER is 1

	G_date_year_enum: INTEGER is 2

	G_date_bad_weekday_enum: INTEGER is 0

	G_date_monday_enum: INTEGER is 1

	G_date_tuesday_enum: INTEGER is 2

	G_date_wednesday_enum: INTEGER is 3

	G_date_thursday_enum: INTEGER is 4

	G_date_friday_enum: INTEGER is 5

	G_date_saturday_enum: INTEGER is 6

	G_date_sunday_enum: INTEGER is 7

	G_date_bad_month_enum: INTEGER is 0

	G_date_january_enum: INTEGER is 1

	G_date_february_enum: INTEGER is 2

	G_date_march_enum: INTEGER is 3

	G_date_april_enum: INTEGER is 4

	G_date_may_enum: INTEGER is 5

	G_date_june_enum: INTEGER is 6

	G_date_july_enum: INTEGER is 7

	G_date_august_enum: INTEGER is 8

	G_date_september_enum: INTEGER is 9

	G_date_october_enum: INTEGER is 10

	G_date_november_enum: INTEGER is 11

	G_date_december_enum: INTEGER is 12

	G_io_error_none_enum: INTEGER is 0

	G_io_error_again_enum: INTEGER is 1

	G_io_error_inval_enum: INTEGER is 2

	G_io_error_unknown_enum: INTEGER is 3

	G_seek_cur_enum: INTEGER is 0

	G_seek_set_enum: INTEGER is 1

	G_seek_end_enum: INTEGER is 2

	G_io_in_enum: INTEGER is 1

	G_io_out_enum: INTEGER is 4

	G_io_pri_enum: INTEGER is 2

	G_io_err_enum: INTEGER is 8

	G_io_hup_enum: INTEGER is 16

	G_io_nval_enum: INTEGER is 32

	Gdk_window_root_enum: INTEGER is 0

	Gdk_window_toplevel_enum: INTEGER is 1

	Gdk_window_child_enum: INTEGER is 2

	Gdk_window_dialog_enum: INTEGER is 3

	Gdk_window_temp_enum: INTEGER is 4

	Gdk_window_pixmap_enum: INTEGER is 5

	Gdk_window_foreign_enum: INTEGER is 6

	Gdk_input_output_enum: INTEGER is 0

	Gdk_input_only_enum: INTEGER is 1

	Gdk_image_normal_enum: INTEGER is 0

	Gdk_image_shared_enum: INTEGER is 1

	Gdk_image_fastest_enum: INTEGER is 2

	Gdk_visual_static_gray_enum: INTEGER is 0

	Gdk_visual_grayscale_enum: INTEGER is 1

	Gdk_visual_static_color_enum: INTEGER is 2

	Gdk_visual_pseudo_color_enum: INTEGER is 3

	Gdk_visual_true_color_enum: INTEGER is 4

	Gdk_visual_direct_color_enum: INTEGER is 5

	Gdk_font_font_enum: INTEGER is 0

	Gdk_font_fontset_enum: INTEGER is 1

	Gdk_wa_title_enum: INTEGER is 2

	Gdk_wa_x_enum: INTEGER is 4

	Gdk_wa_y_enum: INTEGER is 8

	Gdk_wa_cursor_enum: INTEGER is 16

	Gdk_wa_colormap_enum: INTEGER is 32

	Gdk_wa_visual_enum: INTEGER is 64

	Gdk_wa_wmclass_enum: INTEGER is 128

	Gdk_wa_noredir_enum: INTEGER is 256

	Gdk_hint_pos_enum: INTEGER is 1

	Gdk_hint_min_size_enum: INTEGER is 2

	Gdk_hint_max_size_enum: INTEGER is 4

	Gdk_hint_base_size_enum: INTEGER is 8

	Gdk_hint_aspect_enum: INTEGER is 16

	Gdk_hint_resize_inc_enum: INTEGER is 32

	Gdk_copy_enum: INTEGER is 0

	Gdk_invert_enum: INTEGER is 1

	Gdk_xor_enum: INTEGER is 2

	Gdk_clear_enum: INTEGER is 3

	Gdk_and_enum: INTEGER is 4

	Gdk_and_reverse_enum: INTEGER is 5

	Gdk_and_invert_enum: INTEGER is 6

	Gdk_noop_enum: INTEGER is 7

	Gdk_or_enum: INTEGER is 8

	Gdk_equiv_enum: INTEGER is 9

	Gdk_or_reverse_enum: INTEGER is 10

	Gdk_copy_invert_enum: INTEGER is 11

	Gdk_or_invert_enum: INTEGER is 12

	Gdk_nand_enum: INTEGER is 13

	Gdk_set_enum: INTEGER is 14

	Gdk_solid_enum: INTEGER is 0

	Gdk_tiled_enum: INTEGER is 1

	Gdk_stippled_enum: INTEGER is 2

	Gdk_opaque_stippled_enum: INTEGER is 3

	Gdk_even_odd_rule_enum: INTEGER is 0

	Gdk_winding_rule_enum: INTEGER is 1

	Gdk_line_solid_enum: INTEGER is 0

	Gdk_line_on_off_dash_enum: INTEGER is 1

	Gdk_line_double_dash_enum: INTEGER is 2

	Gdk_cap_not_last_enum: INTEGER is 0

	Gdk_cap_butt_enum: INTEGER is 1

	Gdk_cap_round_enum: INTEGER is 2

	Gdk_cap_projecting_enum: INTEGER is 3

	Gdk_join_miter_enum: INTEGER is 0

	Gdk_join_round_enum: INTEGER is 1

	Gdk_join_bevel_enum: INTEGER is 2

	Gdk_filter_continue_enum: INTEGER is 0

	Gdk_filter_translate_enum: INTEGER is 1

	Gdk_filter_remove_enum: INTEGER is 2

	Gdk_visibility_unobscured_enum: INTEGER is 0

	Gdk_visibility_partial_enum: INTEGER is 1

	Gdk_visibility_fully_obscured_enum: INTEGER is 2

	Gdk_nothing_enum: INTEGER is -1

	Gdk_delete_enum: INTEGER is 0

	Gdk_destroy_enum: INTEGER is 1

	Gdk_expose_enum: INTEGER is 2

	Gdk_motion_notify_enum: INTEGER is 3

	Gdk_button_press_enum: INTEGER is 4

	Gdk_2button_press_enum: INTEGER is 5

	Gdk_3button_press_enum: INTEGER is 6

	Gdk_button_release_enum: INTEGER is 7

	Gdk_key_press_enum: INTEGER is 8

	Gdk_key_release_enum: INTEGER is 9

	Gdk_enter_notify_enum: INTEGER is 10

	Gdk_leave_notify_enum: INTEGER is 11

	Gdk_focus_change_enum: INTEGER is 12

	Gdk_configure_enum: INTEGER is 13

	Gdk_map_enum: INTEGER is 14

	Gdk_unmap_enum: INTEGER is 15

	Gdk_property_notify_enum: INTEGER is 16

	Gdk_selection_clear_enum: INTEGER is 17

	Gdk_selection_request_enum: INTEGER is 18

	Gdk_selection_notify_enum: INTEGER is 19

	Gdk_proximity_in_enum: INTEGER is 20

	Gdk_proximity_out_enum: INTEGER is 21

	Gdk_drag_enter_enum: INTEGER is 22

	Gdk_drag_leave_enum: INTEGER is 23

	Gdk_drag_motion_enum: INTEGER is 24

	Gdk_drag_status_enum: INTEGER is 25

	Gdk_drop_start_enum: INTEGER is 26

	Gdk_drop_finished_enum: INTEGER is 27

	Gdk_client_event_enum: INTEGER is 28

	Gdk_visibility_notify_enum: INTEGER is 29

	Gdk_no_expose_enum: INTEGER is 30

	Gdk_exposure_mask_enum: INTEGER is 2

	Gdk_pointer_motion_mask_enum: INTEGER is 4

	Gdk_pointer_motion_hint_mask_enum: INTEGER is 8

	Gdk_button_motion_mask_enum: INTEGER is 16

	Gdk_button1_motion_mask_enum: INTEGER is 32

	Gdk_button2_motion_mask_enum: INTEGER is 64

	Gdk_button3_motion_mask_enum: INTEGER is 128

	Gdk_button_press_mask_enum: INTEGER is 256

	Gdk_button_release_mask_enum: INTEGER is 512

	Gdk_key_press_mask_enum: INTEGER is 1024

	Gdk_key_release_mask_enum: INTEGER is 2048

	Gdk_enter_notify_mask_enum: INTEGER is 4096

	Gdk_leave_notify_mask_enum: INTEGER is 8192

	Gdk_focus_change_mask_enum: INTEGER is 16384

	Gdk_structure_mask_enum: INTEGER is 32768

	Gdk_property_change_mask_enum: INTEGER is 65536

	Gdk_visibility_notify_mask_enum: INTEGER is 131072

	Gdk_proximity_in_mask_enum: INTEGER is 262144

	Gdk_proximity_out_mask_enum: INTEGER is 524288

	Gdk_substructure_mask_enum: INTEGER is 1048576

	Gdk_all_events_mask_enum: INTEGER is 1048575

	Gdk_notify_ancestor_enum: INTEGER is 0

	Gdk_notify_virtual_enum: INTEGER is 1

	Gdk_notify_inferior_enum: INTEGER is 2

	Gdk_notify_nonlinear_enum: INTEGER is 3

	Gdk_notify_nonlinear_virtual_enum: INTEGER is 4

	Gdk_notify_unknown_enum: INTEGER is 5

	Gdk_crossing_normal_enum: INTEGER is 0

	Gdk_crossing_grab_enum: INTEGER is 1

	Gdk_crossing_ungrab_enum: INTEGER is 2

	Gdk_shift_mask_enum: INTEGER is 1

	Gdk_lock_mask_enum: INTEGER is 2

	Gdk_control_mask_enum: INTEGER is 4

	Gdk_mod1_mask_enum: INTEGER is 8

	Gdk_mod2_mask_enum: INTEGER is 16

	Gdk_mod3_mask_enum: INTEGER is 32

	Gdk_mod4_mask_enum: INTEGER is 64

	Gdk_mod5_mask_enum: INTEGER is 128

	Gdk_button1_mask_enum: INTEGER is 256

	Gdk_button2_mask_enum: INTEGER is 512

	Gdk_button3_mask_enum: INTEGER is 1024

	Gdk_button4_mask_enum: INTEGER is 2048

	Gdk_button5_mask_enum: INTEGER is 4096

	Gdk_release_mask_enum: INTEGER is 8192

	Gdk_modifier_mask_enum: INTEGER is 16383

	Gdk_clip_by_children_enum: INTEGER is 0

	Gdk_include_inferiors_enum: INTEGER is 1

	Gdk_input_read_enum: INTEGER is 1

	Gdk_input_write_enum: INTEGER is 2

	Gdk_input_exception_enum: INTEGER is 4

	Gdk_ok_enum: INTEGER is 0

	Gdk_error_enum: INTEGER is -1

	Gdk_error_param_enum: INTEGER is -2

	Gdk_error_file_enum: INTEGER is -3

	Gdk_error_mem_enum: INTEGER is -4

	Gdk_lsb_first_enum: INTEGER is 0

	Gdk_msb_first_enum: INTEGER is 1

	Gdk_gc_foreground_enum: INTEGER is 1

	Gdk_gc_background_enum: INTEGER is 2

	Gdk_gc_font_enum: INTEGER is 4

	Gdk_gc_function_enum: INTEGER is 8

	Gdk_gc_fill_enum: INTEGER is 16

	Gdk_gc_tile_enum: INTEGER is 32

	Gdk_gc_stipple_enum: INTEGER is 64

	Gdk_gc_clip_mask_enum: INTEGER is 128

	Gdk_gc_subwindow_enum: INTEGER is 256

	Gdk_gc_ts_x_origin_enum: INTEGER is 512

	Gdk_gc_ts_y_origin_enum: INTEGER is 1024

	Gdk_gc_clip_x_origin_enum: INTEGER is 2048

	Gdk_gc_clip_y_origin_enum: INTEGER is 4096

	Gdk_gc_exposures_enum: INTEGER is 8192

	Gdk_gc_line_width_enum: INTEGER is 16384

	Gdk_gc_line_style_enum: INTEGER is 32768

	Gdk_gc_cap_style_enum: INTEGER is 65536

	Gdk_gc_join_style_enum: INTEGER is 131072

	Gdk_selection_primary_enum: INTEGER is 1

	Gdk_selection_secondary_enum: INTEGER is 2

	Gdk_property_new_value_enum: INTEGER is 0

	Gdk_property_delete_enum: INTEGER is 1

	Gdk_prop_mode_replace_enum: INTEGER is 0

	Gdk_prop_mode_prepend_enum: INTEGER is 1

	Gdk_prop_mode_append_enum: INTEGER is 2

	Gdk_source_mouse_enum: INTEGER is 0

	Gdk_source_pen_enum: INTEGER is 1

	Gdk_source_eraser_enum: INTEGER is 2

	Gdk_source_cursor_enum: INTEGER is 3

	Gdk_mode_disabled_enum: INTEGER is 0

	Gdk_mode_screen_enum: INTEGER is 1

	Gdk_mode_window_enum: INTEGER is 2

	Gdk_axis_ignore_enum: INTEGER is 0

	Gdk_axis_x_enum: INTEGER is 1

	Gdk_axis_y_enum: INTEGER is 2

	Gdk_axis_pressure_enum: INTEGER is 3

	Gdk_axis_xtilt_enum: INTEGER is 4

	Gdk_axis_ytilt_enum: INTEGER is 5

	Gdk_axis_last_enum: INTEGER is 6

	Gdk_target_bitmap_enum: INTEGER is 5

	Gdk_target_colormap_enum: INTEGER is 7

	Gdk_target_drawable_enum: INTEGER is 17

	Gdk_target_pixmap_enum: INTEGER is 20

	Gdk_target_string_enum: INTEGER is 31

	Gdk_selection_type_atom_enum: INTEGER is 4

	Gdk_selection_type_bitmap_enum: INTEGER is 5

	Gdk_selection_type_colormap_enum: INTEGER is 7

	Gdk_selection_type_drawable_enum: INTEGER is 17

	Gdk_selection_type_integer_enum: INTEGER is 19

	Gdk_selection_type_pixmap_enum: INTEGER is 20

	Gdk_selection_type_window_enum: INTEGER is 33

	Gdk_selection_type_string_enum: INTEGER is 31

	Gdk_extension_events_none_enum: INTEGER is 0

	Gdk_extension_events_all_enum: INTEGER is 1

	Gdk_extension_events_cursor_enum: INTEGER is 2

	Gdk_im_preedit_area_enum: INTEGER is 1

	Gdk_im_preedit_callbacks_enum: INTEGER is 2

	Gdk_im_preedit_position_enum: INTEGER is 4

	Gdk_im_preedit_nothing_enum: INTEGER is 8

	Gdk_im_preedit_none_enum: INTEGER is 16

	Gdk_im_preedit_mask_enum: INTEGER is 31

	Gdk_im_status_area_enum: INTEGER is 256

	Gdk_im_status_callbacks_enum: INTEGER is 512

	Gdk_im_status_nothing_enum: INTEGER is 1024

	Gdk_im_status_none_enum: INTEGER is 2048

	Gdk_im_status_mask_enum: INTEGER is 3840

	Gdk_ic_style_enum: INTEGER is 1

	Gdk_ic_client_window_enum: INTEGER is 2

	Gdk_ic_focus_window_enum: INTEGER is 4

	Gdk_ic_filter_events_enum: INTEGER is 8

	Gdk_ic_spot_location_enum: INTEGER is 16

	Gdk_ic_line_spacing_enum: INTEGER is 32

	Gdk_ic_cursor_enum: INTEGER is 64

	Gdk_ic_preedit_fontset_enum: INTEGER is 1024

	Gdk_ic_preedit_area_enum: INTEGER is 2048

	Gdk_ic_preedit_area_needed_enum: INTEGER is 4096

	Gdk_ic_preedit_foreground_enum: INTEGER is 8192

	Gdk_ic_preedit_background_enum: INTEGER is 16384

	Gdk_ic_preedit_pixmap_enum: INTEGER is 32768

	Gdk_ic_preedit_colormap_enum: INTEGER is 65536

	Gdk_ic_status_fontset_enum: INTEGER is 2097152

	Gdk_ic_status_area_enum: INTEGER is 4194304

	Gdk_ic_status_area_needed_enum: INTEGER is 8388608

	Gdk_ic_status_foreground_enum: INTEGER is 16777216

	Gdk_ic_status_background_enum: INTEGER is 33554432

	Gdk_ic_status_pixmap_enum: INTEGER is 67108864

	Gdk_ic_status_colormap_enum: INTEGER is 134217728

	Gdk_ic_all_req_enum: INTEGER is 3

	Gdk_ic_preedit_area_req_enum: INTEGER is 3072

	Gdk_ic_preedit_position_req_enum: INTEGER is 3088

	Gdk_ic_status_area_req_enum: INTEGER is 6291456

	Gdk_decor_all_enum: INTEGER is 1

	Gdk_decor_border_enum: INTEGER is 2

	Gdk_decor_resizeh_enum: INTEGER is 4

	Gdk_decor_title_enum: INTEGER is 8

	Gdk_decor_menu_enum: INTEGER is 16

	Gdk_decor_minimize_enum: INTEGER is 32

	Gdk_decor_maximize_enum: INTEGER is 64

	Gdk_func_all_enum: INTEGER is 1

	Gdk_func_resize_enum: INTEGER is 2

	Gdk_func_move_enum: INTEGER is 4

	Gdk_func_minimize_enum: INTEGER is 8

	Gdk_func_maximize_enum: INTEGER is 16

	Gdk_func_close_enum: INTEGER is 32

	Gdk_cc_mode_undefined_enum: INTEGER is 0

	Gdk_cc_mode_bw_enum: INTEGER is 1

	Gdk_cc_mode_std_cmap_enum: INTEGER is 2

	Gdk_cc_mode_true_enum: INTEGER is 3

	Gdk_cc_mode_my_gray_enum: INTEGER is 4

	Gdk_cc_mode_palette_enum: INTEGER is 5

	Gdk_overlap_rectangle_in_enum: INTEGER is 0

	Gdk_overlap_rectangle_out_enum: INTEGER is 1

	Gdk_overlap_rectangle_part_enum: INTEGER is 2

	Gdk_action_default_enum: INTEGER is 1

	Gdk_action_copy_enum: INTEGER is 2

	Gdk_action_move_enum: INTEGER is 4

	Gdk_action_link_enum: INTEGER is 8

	Gdk_action_private_enum: INTEGER is 16

	Gdk_action_ask_enum: INTEGER is 32

	Gdk_drag_proto_motif_enum: INTEGER is 0

	Gdk_drag_proto_xdnd_enum: INTEGER is 1

	Gdk_drag_proto_rootwin_enum: INTEGER is 2

	Gdk_drag_proto_none_enum: INTEGER is 3

	Gdk_rgb_dither_none_enum: INTEGER is 0

	Gdk_rgb_dither_normal_enum: INTEGER is 1

	Gdk_rgb_dither_max_enum: INTEGER is 2

	Gtk_type_invalid_enum: INTEGER is 0

	Gtk_type_none_enum: INTEGER is 1

	Gtk_type_char_enum: INTEGER is 2

	Gtk_type_uchar_enum: INTEGER is 3

	Gtk_type_bool_enum: INTEGER is 4

	Gtk_type_int_enum: INTEGER is 5

	Gtk_type_uint_enum: INTEGER is 6

	Gtk_type_long_enum: INTEGER is 7

	Gtk_type_ulong_enum: INTEGER is 8

	Gtk_type_float_enum: INTEGER is 9

	Gtk_type_double_enum: INTEGER is 10

	Gtk_type_string_enum: INTEGER is 11

	Gtk_type_enum_enum: INTEGER is 12

	Gtk_type_flags_enum: INTEGER is 13

	Gtk_type_boxed_enum: INTEGER is 14

	Gtk_type_pointer_enum: INTEGER is 15

	Gtk_type_signal_enum: INTEGER is 16

	Gtk_type_args_enum: INTEGER is 17

	Gtk_type_callback_enum: INTEGER is 18

	Gtk_type_c_callback_enum: INTEGER is 19

	Gtk_type_foreign_enum: INTEGER is 20

	Gtk_type_object_enum: INTEGER is 21

	Gtk_arrow_up_enum: INTEGER is 0

	Gtk_arrow_down_enum: INTEGER is 1

	Gtk_arrow_left_enum: INTEGER is 2

	Gtk_arrow_right_enum: INTEGER is 3

	Gtk_expand_enum: INTEGER is 1

	Gtk_shrink_enum: INTEGER is 2

	Gtk_fill_enum: INTEGER is 4

	Gtk_buttonbox_default_style_enum: INTEGER is 0

	Gtk_buttonbox_spread_enum: INTEGER is 1

	Gtk_buttonbox_edge_enum: INTEGER is 2

	Gtk_buttonbox_start_enum: INTEGER is 3

	Gtk_buttonbox_end_enum: INTEGER is 4

	Gtk_curve_type_linear_enum: INTEGER is 0

	Gtk_curve_type_spline_enum: INTEGER is 1

	Gtk_curve_type_free_enum: INTEGER is 2

	Gtk_dir_tab_forward_enum: INTEGER is 0

	Gtk_dir_tab_backward_enum: INTEGER is 1

	Gtk_dir_up_enum: INTEGER is 2

	Gtk_dir_down_enum: INTEGER is 3

	Gtk_dir_left_enum: INTEGER is 4

	Gtk_dir_right_enum: INTEGER is 5

	Gtk_justify_left_enum: INTEGER is 0

	Gtk_justify_right_enum: INTEGER is 1

	Gtk_justify_center_enum: INTEGER is 2

	Gtk_justify_fill_enum: INTEGER is 3

	Gtk_match_all_enum: INTEGER is 0

	Gtk_match_all_tail_enum: INTEGER is 1

	Gtk_match_head_enum: INTEGER is 2

	Gtk_match_tail_enum: INTEGER is 3

	Gtk_match_exact_enum: INTEGER is 4

	Gtk_match_last_enum: INTEGER is 5

	Gtk_menu_dir_parent_enum: INTEGER is 0

	Gtk_menu_dir_child_enum: INTEGER is 1

	Gtk_menu_dir_next_enum: INTEGER is 2

	Gtk_menu_dir_prev_enum: INTEGER is 3

	Gtk_menu_factory_menu_enum: INTEGER is 0

	Gtk_menu_factory_menu_bar_enum: INTEGER is 1

	Gtk_menu_factory_option_menu_enum: INTEGER is 2

	Gtk_pixels_enum: INTEGER is 0

	Gtk_inches_enum: INTEGER is 1

	Gtk_centimeters_enum: INTEGER is 2

	Gtk_orientation_horizontal_enum: INTEGER is 0

	Gtk_orientation_vertical_enum: INTEGER is 1

	Gtk_corner_top_left_enum: INTEGER is 0

	Gtk_corner_bottom_left_enum: INTEGER is 1

	Gtk_corner_top_right_enum: INTEGER is 2

	Gtk_corner_bottom_right_enum: INTEGER is 3

	Gtk_pack_start_enum: INTEGER is 0

	Gtk_pack_end_enum: INTEGER is 1

	Gtk_path_prio_lowest_enum: INTEGER is 0

	Gtk_path_prio_gtk_enum: INTEGER is 4

	Gtk_path_prio_application_enum: INTEGER is 8

	Gtk_path_prio_rc_enum: INTEGER is 12

	Gtk_path_prio_highest_enum: INTEGER is 15

	Gtk_path_prio_mask_enum: INTEGER is 15

	Gtk_path_widget_enum: INTEGER is 0

	Gtk_path_widget_class_enum: INTEGER is 1

	Gtk_path_class_enum: INTEGER is 2

	Gtk_policy_always_enum: INTEGER is 0

	Gtk_policy_automatic_enum: INTEGER is 1

	Gtk_policy_never_enum: INTEGER is 2

	Gtk_pos_left_enum: INTEGER is 0

	Gtk_pos_right_enum: INTEGER is 1

	Gtk_pos_top_enum: INTEGER is 2

	Gtk_pos_bottom_enum: INTEGER is 3

	Gtk_preview_color_enum: INTEGER is 0

	Gtk_preview_grayscale_enum: INTEGER is 1

	Gtk_relief_normal_enum: INTEGER is 0

	Gtk_relief_half_enum: INTEGER is 1

	Gtk_relief_none_enum: INTEGER is 2

	Gtk_resize_parent_enum: INTEGER is 0

	Gtk_resize_queue_enum: INTEGER is 1

	Gtk_resize_immediate_enum: INTEGER is 2

	Gtk_run_first_enum: INTEGER is 1

	Gtk_run_last_enum: INTEGER is 2

	Gtk_run_both_enum: INTEGER is 3

	Gtk_run_no_recurse_enum: INTEGER is 4

	Gtk_run_action_enum: INTEGER is 8

	Gtk_run_no_hooks_enum: INTEGER is 16

	Gtk_scroll_none_enum: INTEGER is 0

	Gtk_scroll_step_backward_enum: INTEGER is 1

	Gtk_scroll_step_forward_enum: INTEGER is 2

	Gtk_scroll_page_backward_enum: INTEGER is 3

	Gtk_scroll_page_forward_enum: INTEGER is 4

	Gtk_scroll_jump_enum: INTEGER is 5

	Gtk_selection_single_enum: INTEGER is 0

	Gtk_selection_browse_enum: INTEGER is 1

	Gtk_selection_multiple_enum: INTEGER is 2

	Gtk_selection_extended_enum: INTEGER is 3

	Gtk_shadow_none_enum: INTEGER is 0

	Gtk_shadow_in_enum: INTEGER is 1

	Gtk_shadow_out_enum: INTEGER is 2

	Gtk_shadow_etched_in_enum: INTEGER is 3

	Gtk_shadow_etched_out_enum: INTEGER is 4

	Gtk_state_normal_enum: INTEGER is 0

	Gtk_state_active_enum: INTEGER is 1

	Gtk_state_prelight_enum: INTEGER is 2

	Gtk_state_selected_enum: INTEGER is 3

	Gtk_state_insensitive_enum: INTEGER is 4

	Gtk_direction_left_enum: INTEGER is 0

	Gtk_direction_right_enum: INTEGER is 1

	Gtk_top_bottom_enum: INTEGER is 0

	Gtk_left_right_enum: INTEGER is 1

	Gtk_toolbar_icons_enum: INTEGER is 0

	Gtk_toolbar_text_enum: INTEGER is 1

	Gtk_toolbar_both_enum: INTEGER is 2

	Gtk_trough_none_enum: INTEGER is 0

	Gtk_trough_start_enum: INTEGER is 1

	Gtk_trough_end_enum: INTEGER is 2

	Gtk_trough_jump_enum: INTEGER is 3

	Gtk_update_continuous_enum: INTEGER is 0

	Gtk_update_discontinuous_enum: INTEGER is 1

	Gtk_update_delayed_enum: INTEGER is 2

	Gtk_visibility_none_enum: INTEGER is 0

	Gtk_visibility_partial_enum: INTEGER is 1

	Gtk_visibility_full_enum: INTEGER is 2

	Gtk_win_pos_none_enum: INTEGER is 0

	Gtk_win_pos_center_enum: INTEGER is 1

	Gtk_win_pos_mouse_enum: INTEGER is 2

	Gtk_win_pos_center_always_enum: INTEGER is 3

	Gtk_window_toplevel_enum: INTEGER is 0

	Gtk_window_dialog_enum: INTEGER is 1

	Gtk_window_popup_enum: INTEGER is 2

	Gtk_sort_ascending_enum: INTEGER is 0

	Gtk_sort_descending_enum: INTEGER is 1

	Gtk_debug_objects_enum: INTEGER is 1

	Gtk_debug_misc_enum: INTEGER is 2

	Gtk_debug_signals_enum: INTEGER is 4

	Gtk_debug_dnd_enum: INTEGER is 8

	Gtk_debug_plugsocket_enum: INTEGER is 16

	Gtk_destroyed_enum: INTEGER is 1

	Gtk_floating_enum: INTEGER is 2

	Gtk_connected_enum: INTEGER is 4

	Gtk_constructed_enum: INTEGER is 8

	Gtk_arg_readable_enum: INTEGER is 1

	Gtk_arg_writable_enum: INTEGER is 2

	Gtk_arg_construct_enum: INTEGER is 4

	Gtk_arg_construct_only_enum: INTEGER is 8

	Gtk_arg_child_arg_enum: INTEGER is 16

	Gtk_arg_mask_enum: INTEGER is 31

	Gtk_arg_readwrite_enum: INTEGER is 3

	Gtk_accel_visible_enum: INTEGER is 1

	Gtk_accel_signal_visible_enum: INTEGER is 2

	Gtk_accel_locked_enum: INTEGER is 4

	Gtk_accel_mask_enum: INTEGER is 7

	Gtk_toplevel_enum: INTEGER is 16

	Gtk_no_window_enum: INTEGER is 32

	Gtk_realized_enum: INTEGER is 64

	Gtk_mapped_enum: INTEGER is 128

	Gtk_visible_enum: INTEGER is 256

	Gtk_sensitive_enum: INTEGER is 512

	Gtk_parent_sensitive_enum: INTEGER is 1024

	Gtk_can_focus_enum: INTEGER is 2048

	Gtk_has_focus_enum: INTEGER is 4096

	Gtk_can_default_enum: INTEGER is 8192

	Gtk_has_default_enum: INTEGER is 16384

	Gtk_has_grab_enum: INTEGER is 32768

	Gtk_rc_style_enum: INTEGER is 65536

	Gtk_composite_child_enum: INTEGER is 131072

	Gtk_no_reparent_enum: INTEGER is 262144

	Gtk_app_paintable_enum: INTEGER is 524288

	Gtk_receives_default_enum: INTEGER is 1048576

	Gtk_calendar_show_heading_enum: INTEGER is 1

	Gtk_calendar_show_day_names_enum: INTEGER is 2

	Gtk_calendar_no_month_change_enum: INTEGER is 4

	Gtk_calendar_show_week_numbers_enum: INTEGER is 8

	Gtk_calendar_week_start_monday_enum: INTEGER is 16

	Gtk_clist_in_drag_enum: INTEGER is 1

	Gtk_clist_row_height_set_enum: INTEGER is 2

	Gtk_clist_show_titles_enum: INTEGER is 4

	Gtk_clist_child_has_focus_enum: INTEGER is 8

	Gtk_clist_add_mode_enum: INTEGER is 16

	Gtk_clist_auto_sort_enum: INTEGER is 32

	Gtk_clist_auto_resize_blocked_enum: INTEGER is 64

	Gtk_clist_reorderable_enum: INTEGER is 128

	Gtk_clist_use_drag_icons_enum: INTEGER is 256

	Gtk_clist_draw_drag_line_enum: INTEGER is 512

	Gtk_clist_draw_drag_rect_enum: INTEGER is 1024

	Gtk_cell_empty_enum: INTEGER is 0

	Gtk_cell_text_enum: INTEGER is 1

	Gtk_cell_pixmap_enum: INTEGER is 2

	Gtk_cell_pixtext_enum: INTEGER is 3

	Gtk_cell_widget_enum: INTEGER is 4

	Gtk_clist_drag_none_enum: INTEGER is 0

	Gtk_clist_drag_before_enum: INTEGER is 1

	Gtk_clist_drag_into_enum: INTEGER is 2

	Gtk_clist_drag_after_enum: INTEGER is 3

	Gtk_button_ignored_enum: INTEGER is 0

	Gtk_button_selects_enum: INTEGER is 1

	Gtk_button_drags_enum: INTEGER is 2

	Gtk_button_expands_enum: INTEGER is 4

	Gtk_ctree_pos_before_enum: INTEGER is 0

	Gtk_ctree_pos_as_child_enum: INTEGER is 1

	Gtk_ctree_pos_after_enum: INTEGER is 2

	Gtk_ctree_lines_none_enum: INTEGER is 0

	Gtk_ctree_lines_solid_enum: INTEGER is 1

	Gtk_ctree_lines_dotted_enum: INTEGER is 2

	Gtk_ctree_lines_tabbed_enum: INTEGER is 3

	Gtk_ctree_expander_none_enum: INTEGER is 0

	Gtk_ctree_expander_square_enum: INTEGER is 1

	Gtk_ctree_expander_triangle_enum: INTEGER is 2

	Gtk_ctree_expander_circular_enum: INTEGER is 3

	Gtk_ctree_expansion_expand_enum: INTEGER is 0

	Gtk_ctree_expansion_expand_recursive_enum: INTEGER is 1

	Gtk_ctree_expansion_collapse_enum: INTEGER is 2

	Gtk_ctree_expansion_collapse_recursive_enum: INTEGER is 3

	Gtk_ctree_expansion_toggle_enum: INTEGER is 4

	Gtk_ctree_expansion_toggle_recursive_enum: INTEGER is 5

	Gtk_dest_default_motion_enum: INTEGER is 1

	Gtk_dest_default_highlight_enum: INTEGER is 2

	Gtk_dest_default_drop_enum: INTEGER is 4

	Gtk_dest_default_all_enum: INTEGER is 7

	Gtk_target_same_app_enum: INTEGER is 1

	Gtk_target_same_widget_enum: INTEGER is 2

	Gtk_font_metric_pixels_enum: INTEGER is 0

	Gtk_font_metric_points_enum: INTEGER is 1

	Gtk_font_bitmap_enum: INTEGER is 1

	Gtk_font_scalable_enum: INTEGER is 2

	Gtk_font_scalable_bitmap_enum: INTEGER is 4

	Gtk_font_all_enum: INTEGER is 7

	Gtk_font_filter_base_enum: INTEGER is 0

	Gtk_font_filter_user_enum: INTEGER is 1

	Gtk_pack_expand_enum: INTEGER is 1

	Gtk_fill_x_enum: INTEGER is 2

	Gtk_fill_y_enum: INTEGER is 4

	Gtk_side_top_enum: INTEGER is 0

	Gtk_side_bottom_enum: INTEGER is 1

	Gtk_side_left_enum: INTEGER is 2

	Gtk_side_right_enum: INTEGER is 3

	Gtk_anchor_center_enum: INTEGER is 0

	Gtk_anchor_north_enum: INTEGER is 1

	Gtk_anchor_north_west_enum: INTEGER is 2

	Gtk_anchor_north_east_enum: INTEGER is 3

	Gtk_anchor_south_enum: INTEGER is 4

	Gtk_anchor_south_west_enum: INTEGER is 5

	Gtk_anchor_south_east_enum: INTEGER is 6

	Gtk_anchor_west_enum: INTEGER is 7

	Gtk_anchor_east_enum: INTEGER is 8

	Gtk_anchor_n_enum: INTEGER is 1

	Gtk_anchor_nw_enum: INTEGER is 2

	Gtk_anchor_ne_enum: INTEGER is 3

	Gtk_anchor_s_enum: INTEGER is 4

	Gtk_anchor_sw_enum: INTEGER is 5

	Gtk_anchor_se_enum: INTEGER is 6

	Gtk_anchor_w_enum: INTEGER is 7

	Gtk_anchor_e_enum: INTEGER is 8

	Gtk_progress_continuous_enum: INTEGER is 0

	Gtk_progress_discrete_enum: INTEGER is 1

	Gtk_progress_left_to_right_enum: INTEGER is 0

	Gtk_progress_right_to_left_enum: INTEGER is 1

	Gtk_progress_bottom_to_top_enum: INTEGER is 2

	Gtk_progress_top_to_bottom_enum: INTEGER is 3

	Gtk_rc_fg_enum: INTEGER is 1

	Gtk_rc_bg_enum: INTEGER is 2

	Gtk_rc_text_enum: INTEGER is 4

	Gtk_rc_base_enum: INTEGER is 8

	Gtk_rc_token_invalid_enum: INTEGER is 270

	Gtk_rc_token_include_enum: INTEGER is 271

	Gtk_rc_token_normal_enum: INTEGER is 272

	Gtk_rc_token_active_enum: INTEGER is 273

	Gtk_rc_token_prelight_enum: INTEGER is 274

	Gtk_rc_token_selected_enum: INTEGER is 275

	Gtk_rc_token_insensitive_enum: INTEGER is 276

	Gtk_rc_token_fg_enum: INTEGER is 277

	Gtk_rc_token_bg_enum: INTEGER is 278

	Gtk_rc_token_base_enum: INTEGER is 279

	Gtk_rc_token_text_enum: INTEGER is 280

	Gtk_rc_token_font_enum: INTEGER is 281

	Gtk_rc_token_fontset_enum: INTEGER is 282

	Gtk_rc_token_bg_pixmap_enum: INTEGER is 283

	Gtk_rc_token_pixmap_path_enum: INTEGER is 284

	Gtk_rc_token_style_enum: INTEGER is 285

	Gtk_rc_token_binding_enum: INTEGER is 286

	Gtk_rc_token_bind_enum: INTEGER is 287

	Gtk_rc_token_widget_enum: INTEGER is 288

	Gtk_rc_token_widget_class_enum: INTEGER is 289

	Gtk_rc_token_class_enum: INTEGER is 290

	Gtk_rc_token_lowest_enum: INTEGER is 291

	Gtk_rc_token_gtk_enum: INTEGER is 292

	Gtk_rc_token_application_enum: INTEGER is 293

	Gtk_rc_token_rc_enum: INTEGER is 294

	Gtk_rc_token_highest_enum: INTEGER is 295

	Gtk_rc_token_engine_enum: INTEGER is 296

	Gtk_rc_token_module_path_enum: INTEGER is 297

	Gtk_rc_token_last_enum: INTEGER is 298

	Gtk_update_always_enum: INTEGER is 0

	Gtk_update_if_valid_enum: INTEGER is 1

	Gtk_spin_step_forward_enum: INTEGER is 0

	Gtk_spin_step_backward_enum: INTEGER is 1

	Gtk_spin_page_forward_enum: INTEGER is 2

	Gtk_spin_page_backward_enum: INTEGER is 3

	Gtk_spin_home_enum: INTEGER is 4

	Gtk_spin_end_enum: INTEGER is 5

	Gtk_spin_user_defined_enum: INTEGER is 6

	Gtk_toolbar_child_space_enum: INTEGER is 0

	Gtk_toolbar_child_button_enum: INTEGER is 1

	Gtk_toolbar_child_togglebutton_enum: INTEGER is 2

	Gtk_toolbar_child_radiobutton_enum: INTEGER is 3

	Gtk_toolbar_child_widget_enum: INTEGER is 4

	Gtk_toolbar_space_empty_enum: INTEGER is 0

	Gtk_toolbar_space_line_enum: INTEGER is 1

	Gtk_tree_view_line_enum: INTEGER is 0

	Gtk_tree_view_item_enum: INTEGER is 1

end -- class EV_GTK_ENUMS

--! This file was generated by the GOTE converter.
--! It is derived from the headers of GTK.
--! It is licensed under LGPL. (see www.gnu.org)
