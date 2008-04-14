indexing
	description: "Pixmaps used in interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS

inherit
	CONF_PIXMAPS

	EV_STOCK_PIXMAPS

	EB_SHARED_PIXMAP_FACTORY
		redefine
			pixmap_lookup_table
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Utility

	icon_buffer_with_overlay (a_icon: EV_PIXEL_BUFFER; a_overlay: EV_PIXEL_BUFFER; a_x_offset: NATURAL_8; a_y_offset: NATURAL_8): !EV_PIXEL_BUFFER
			-- Creates a new icon with a supplied overlay.
			--
			-- `a_icon': The original icon to draw an overlay on top of.
			-- `a_overlay': An overlay icon.
			-- `a_x_offset': X positional offset on the icon to start drawing the overlay at.
			-- `a_y_offset': Y positional offset on the icon to start drawing the overlay at.
			-- `Result': A buffer result of the overlay.
		require
			a_icon_attached: a_icon /= Void
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			a_overlay_attached: a_overlay /= Void
			not_a_overlay_is_destoryed: not a_overlay.is_destroyed
			a_icon_big_enough: a_icon.width > 0 and a_icon.height > 0
			a_overlay_big_enough: a_overlay.width > 0 and a_overlay.height > 0
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := a_icon.width.max (a_overlay.width + a_x_offset)
			l_height := a_icon.height.max (a_overlay.height + a_y_offset)
			create Result.make_with_size (l_width, l_height)
			Result.draw_pixel_buffer_with_x_y (0, 0, a_icon)
			Result.draw_pixel_buffer_with_x_y (a_x_offset, a_y_offset, a_overlay)
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_with_overlay (a_icon: EV_PIXMAP; a_overlay: EV_PIXEL_BUFFER; a_x_offset: NATURAL_8; a_y_offset: NATURAL_8): !EV_PIXMAP
			-- Creates a new icon with a supplied overlay.
			--
			-- `a_icon': The original icon to draw an overlay on top of.
			-- `a_overlay': An overlay icon.
			-- `a_x_offset': X positional offset on the icon to start drawing the overlay at.
			-- `a_y_offset': Y positional offset on the icon to start drawing the overlay at.
			-- `Result': A buffer result of the overlay.
		require
			a_icon_attached: a_icon /= Void
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			a_overlay_attached: a_overlay /= Void
			not_a_overlay_is_destoryed: not a_overlay.is_destroyed
			a_icon_big_enough: a_icon.width > 0 and a_icon.height > 0
			a_overlay_big_enough: a_overlay.width > 0 and a_overlay.height > 0
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := a_icon.width.max (a_overlay.width + a_x_offset)
			l_height := a_icon.height.max (a_overlay.height + a_y_offset)
			create Result.make_with_size (l_width, l_height)
			Result.draw_sub_pixmap (0, 0, a_icon, create {EV_RECTANGLE}.make (0, 0, a_icon.width, a_icon.height))
			Result.draw_sub_pixel_buffer (a_x_offset, a_y_offset, a_overlay, create {EV_RECTANGLE}.make (0, 0, a_overlay.width, a_overlay.height))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

feature -- Access

	mini_pixmaps: ES_PIXMAPS_10X10 is
			-- Shared icon pixmaps
		once
			create Result.make ("10x10.png")
		ensure
			result_not_void: Result /= Void
		end

	small_pixmaps: ES_PIXMAPS_12X12 is
			-- Shared icon pixmaps
		once
			create Result.make ("12x12.png")
		ensure
			result_not_void: Result /= Void
		end

	icon_pixmaps: ES_PIXMAPS_16X16 is
			-- Shared icon pixmaps
		once
			create Result.make ("16x16.png")
		ensure
			result_not_void: Result /= Void
		end

	large_pixmaps: EB_SHARED_PIXMAPS_32 is
			-- Shared large pixmaps
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature -- Pngs

	bm_About: EV_PIXMAP is
			-- Bitmap for the "About Dialog"
		once
			Result := load_pixmap_from_repository ("bm_About")
		end

	bm_Wizard_blue: EV_PIXMAP is
			-- Bitmap for the wizards
		once
			Result := load_pixmap_from_repository ("bm_wizard_blue")
		end

	bm_Wizard_profiler_icon: EV_PIXMAP is
			-- Icon Bitmap for the wizards
		once
			Result := load_pixmap_from_repository ("bm_wizard_profiler_icon")
		end

	bm_Borland: EV_PIXMAP is
			-- Bitmap for "About dialog" when Borland C++ is installed.
		once
			Result := load_pixmap_from_repository ("borland_logo")
		end

feature -- Icons

	Icon_dotnet_import: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_dotnet_import_color_value)
		end

	icon_running: ARRAY [EV_PIXMAP] is
		once
			create Result.make (1, 5)
			Result.put (icon_pixmaps.run_animation_1_icon, 1)
			Result.put (icon_pixmaps.run_animation_2_icon, 2)
			Result.put (icon_pixmaps.run_animation_3_icon, 3)
			Result.put (icon_pixmaps.run_animation_4_icon, 4)
			Result.put (icon_pixmaps.run_animation_5_icon, 5)
		end

	icon_compiling: ARRAY [EV_PIXMAP] is
		once
			create Result.make (1, 10)
			Result.put (icon_pixmaps.compile_animation_1_icon, 1)
			Result.put (icon_pixmaps.compile_animation_1_icon, 2)
			Result.put (icon_pixmaps.compile_animation_2_icon, 3)
			Result.put (icon_pixmaps.compile_animation_3_icon, 4)
			Result.put (icon_pixmaps.compile_animation_4_icon, 5)
			Result.put (icon_pixmaps.compile_animation_5_icon, 6)
			Result.put (icon_pixmaps.compile_animation_6_icon, 7)
			Result.put (icon_pixmaps.compile_animation_7_icon, 8)
			Result.put (icon_pixmaps.compile_animation_8_icon, 9)
			Result.put (icon_pixmaps.compile_animation_8_icon, 10)
		end

	Icon_context_tool: EV_PIXMAP is
			-- Icon for context tool
		once
			Result := pixmap_from_constant (icon_context_tool_color_value)
		end

	Icon_save_measure: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_save_measure_color_value)
		end

	Icon_view_measure_minus: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_view_measure_minus_color_value)
		end

	Icon_view_measure_plus: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_view_measure_plus_color_value)
		end

	Icon_new_context_tool: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_context_window_color_value)
		end

	Icon_new_measure: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_measure_color_value)
		end

	Icon_profiler_window: EV_PIXMAP is
			-- Pixmap representing a profiler window
		once
			Result := pixmap_from_constant (icon_profiler_window_value)
		end

	Icon_delete_measure: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_delete_measure_color_value)
		end

	Icon_remove_exported_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_remove_exported_feature_color_value)
		end

	Icon_new_metric: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_metric_color_value)
		end

	Icon_select_metrics: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_select_metrics_color_value)
		end

	Icon_sorter: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_sorter_color_value)
		end

	Icon_red_cross: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_red_cross_value)
		end

	Icon_expand_all: EV_PIXMAP is
		once
			Result := pixmap_from_constant (Icon_expand_all_value)
		end

	Icon_collapse_all: EV_PIXMAP is
		once
			Result := pixmap_from_constant (Icon_collapse_all_value)
		end

feature -- Reading

	pixmap_path: DIRECTORY_NAME is
			-- (export status {NONE})
		once
			create Result.make_from_string (eiffel_layout.bitmaps_path)
			Result.extend (pixmap_suffix)
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER is 16
		-- Width in pixels of generated factory image

	pixmap_height: INTEGER is 16
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the screen cursors
		once
			Result := load_pixmap_from_repository ("icon_matrix_16")
		end

	pixmap_lookup_table: ES_PIXMAP_LOOKUP_TABLE is
			-- Lookup hash table for Studio pixmaps
		once
			create Result.make_with_values (16, 16)
				-- Icons
			Result.add_pixmap (1, 1, icon_add_exported_feature_color_value)
			Result.add_pixmap (2, 1, icon_stopped_value)
			Result.add_pixmap (3, 1, icon_attribute_symbol_value)
			Result.add_pixmap (4, 1, icon_auto_slice_limits_color_value)
			Result.add_pixmap (5, 1, icon_back_color_value)
			Result.add_pixmap (6, 1, icon_bkpt_info_color_value)
			Result.add_pixmap (7, 1, icon_center_diagram_color_value)
			Result.add_pixmap (8, 1, icon_check_exports_color_value)
			Result.add_pixmap (9, 1, icon_class_header_color_value)
			Result.add_pixmap (10, 1, icon_expand_all_value)
			Result.add_pixmap (11, 1, icon_collapse_all_value)
			Result.add_pixmap (12, 1, icon_invisible_value)
			Result.add_pixmap (15, 1, icon_cmd_history_color_value)
			Result.add_pixmap (16, 1, icon_color_color_value)
			Result.add_pixmap (1, 2, icon_compilation_error_value)
			Result.add_pixmap (2, 2, icon_compiled_value)
			Result.add_pixmap (3, 2, icon_compile_color_value)
			Result.add_pixmap (4, 2, icon_compiling_1_value)
			Result.add_pixmap (5, 2, icon_compiling_2_value)
			Result.add_pixmap (6, 2, icon_compiling_3_value)
			Result.add_pixmap (7, 2, icon_compiling_4_value)
			Result.add_pixmap (8, 2, icon_context_tool_color_value)
			Result.add_pixmap (9, 2, icon_copy_color_value)
			Result.add_pixmap (10, 2, icon_crop_color_value)
			Result.add_pixmap (11, 2, icon_cut_color_value)
			Result.add_pixmap (13, 2, icon_deferred_feature_value)
			Result.add_pixmap (15, 2, icon_delete_measure_color_value)
			Result.add_pixmap (16, 2, icon_delete_small_color_value)
			Result.add_pixmap (1, 3, icon_delete_view_color_value)
			Result.add_pixmap (2, 3, icon_development_window_color_value)
			Result.add_pixmap (3, 3, icon_dialog_window_value)
			Result.add_pixmap (4, 3, icon_disable_bkpt_color_value)
			Result.add_pixmap (5, 3, icon_display_labels_color_value)
			Result.add_pixmap (6, 3, icon_dotnet_import_color_value)
			Result.add_pixmap (7, 3, icon_dynamiclib_window_value)
			Result.add_pixmap (8, 3, icon_edit_exported_feature_color_value)
			Result.add_pixmap (9, 3, icon_editing_value)
			Result.add_pixmap (10, 3, icon_enable_bkpt_color_value)
			Result.add_pixmap (11, 3, icon_exec_quit_color_value)
			Result.add_pixmap (12, 3, icon_exec_quit_color_value)
			Result.add_pixmap (13, 3, icon_exec_step_color_value)
			Result.add_pixmap (14, 3, icon_exec_stop_color_value)
			Result.add_pixmap (15, 3, icon_expanded_object_value)
			Result.add_pixmap (16, 3, icon_export_to_png_color_value)
			Result.add_pixmap (1, 4, icon_stopped_value)
			Result.add_pixmap (2, 4, icon_external_feature_value)
			Result.add_pixmap (3, 4, icon_external_symbol_value)
			Result.add_pixmap (4, 4, icon_favorites_color_value)
			Result.add_pixmap (5, 4, icon_favorites_folder_color_value)
			Result.add_pixmap (6, 4, icon_feature_color_value)
			Result.add_pixmap (7, 4, icon_feature_clause_any_value)
			Result.add_pixmap (8, 4, icon_feature_clause_none_value)
			Result.add_pixmap (9, 4, icon_feature_clause_some_value)
			Result.add_pixmap (10, 4, icon_features_color_value)
			Result.add_pixmap (11, 4, icon_fill_cluster_color_value)
			Result.add_pixmap (12, 4, icon_finalize_color_value)
			Result.add_pixmap (13, 4, icon_del_bkpt_color_value)
			Result.add_pixmap (14, 4, icon_format_ancestors_color_value)
			Result.add_pixmap (15, 4, icon_format_attributes_color_value)
			Result.add_pixmap (16, 4, icon_format_clickable_color_value)
			Result.add_pixmap (1, 5, icon_format_clients_color_value)
			Result.add_pixmap (2, 5, icon_format_contract_color_value)
			Result.add_pixmap (3, 5, icon_format_deferreds_color_value)
			Result.add_pixmap (4, 5, icon_format_descendants_color_value)
			Result.add_pixmap (5, 5, icon_format_exporteds_color_value)
			Result.add_pixmap (6, 5, icon_format_externals_color_value)
			Result.add_pixmap (7, 5, icon_format_feature_ancestors_color_value)
			Result.add_pixmap (8, 5, icon_format_feature_callers_color_value)
			Result.add_pixmap (9, 5, icon_format_feature_descendants_color_value)
			Result.add_pixmap (10, 5, icon_format_feature_homonyms_color_value)
			Result.add_pixmap (11, 5, icon_format_feature_implementers_color_value)
			Result.add_pixmap (12, 5, icon_format_flat_color_value)
			Result.add_pixmap (13, 5, icon_format_interface_color_value)
			Result.add_pixmap (14, 5, icon_format_onces_color_value)
			Result.add_pixmap (15, 5, icon_format_routines_color_value)
			Result.add_pixmap (16, 5, icon_format_suppliers_color_value)
			Result.add_pixmap (1, 6, icon_format_text_color_value)
			Result.add_pixmap (2, 6, icon_forth_color_value)
			Result.add_pixmap (3, 6, icon_freeze_color_value)
			Result.add_pixmap (4, 6, icon_green_arrow_value)
			Result.add_pixmap (5, 6, icon_green_tick_value)
			Result.add_pixmap (6, 6, icon_help_tool_color_value)
			Result.add_pixmap (7, 6, icon_immediate_value_value)
			Result.add_pixmap (8, 6, icon_inherit_color_value)
			Result.add_pixmap (9, 6, icon_straight_arrows_color_value)
			Result.add_pixmap (10, 6, icon_minimize_all_color_value)
			Result.add_pixmap (11, 6, icon_new_agg_supplier_color_value)
			Result.add_pixmap (12, 6, icon_new_class_color_value)
			Result.add_pixmap (13, 6, icon_new_cluster_color_value)
			Result.add_pixmap (14, 6, icon_new_context_window_color_value)
			Result.add_pixmap (15, 6, icon_new_development_tool_color_value)
			Result.add_pixmap (16, 6, icon_new_dynamic_lib_color_value)
			Result.add_pixmap (1, 7, icon_new_editor_color_value)
			Result.add_pixmap (2, 7, icon_new_feature_color_value)
			Result.add_pixmap (3, 7, icon_new_inherit_color_value)
			Result.add_pixmap (4, 7, icon_new_measure_color_value)
			Result.add_pixmap (5, 7, icon_new_metric_color_value)
			Result.add_pixmap (6, 7, icon_new_supplier_color_value)
			Result.add_pixmap (7, 7, icon_no_stop_color_value)
			Result.add_pixmap (8, 7, icon_exe_up_to_date_value)
			Result.add_pixmap (9, 7, icon_object_symbol_value)
			Result.add_pixmap (10, 7, icon_once_symbol_value)
			Result.add_pixmap (11, 7, icon_open_file_color_value)
			Result.add_pixmap (12, 7, icon_paste_color_value)
			Result.add_pixmap (13, 7, icon_preference_window_value)
			Result.add_pixmap (14, 7, icon_open_exception_dialog_value)
			Result.add_pixmap (15, 7, icon_print_color_value)
			Result.add_pixmap (16, 7, icon_profiler_window_value)
			Result.add_pixmap (1, 8, icon_progress_dialog_color_value)
			Result.add_pixmap (2, 8, icon_quick_compile_color_value)
			Result.add_pixmap (3, 8, icon_restore_all_color_value)
			Result.add_pixmap (4, 8, icon_restore_all_unsaved_color_value)
			Result.add_pixmap (8, 8, icon_recycle_bin_color_value)
			Result.add_pixmap (9, 8, icon_red_cross_value)
			Result.add_pixmap (10, 8, icon_redo_color_value)
			Result.add_pixmap (11, 8, icon_remove_exported_feature_color_value)
			Result.add_pixmap (12, 8, icon_reset_diagram_color_value)
			Result.add_pixmap (13, 8, icon_restore_view_color_value)
			Result.add_pixmap (14, 8, icon_run_color_value)
			Result.add_pixmap (15, 8, icon_debug_run_color_value)
			Result.add_pixmap (16, 8, icon_debugger_exception_value)
			Result.add_pixmap (1, 9, icon_running_1_value)
			Result.add_pixmap (2, 9, icon_running_2_value)
			Result.add_pixmap (3, 9, icon_running_3_value)
			Result.add_pixmap (4, 9, icon_save_color_value)
			Result.add_pixmap (5, 9, icon_save_measure_color_value)
			Result.add_pixmap (6, 9, icon_search_color_value)
			Result.add_pixmap (7, 9, icon_select_depth_color_value)
			Result.add_pixmap (8, 9, icon_select_metrics_color_value)
			Result.add_pixmap (9, 9, icon_send_stone_down_color_value)
			Result.add_pixmap (10, 9, icon_set_arguments_color_value)
			Result.add_pixmap (11, 9, icon_shell_color_value)
			Result.add_pixmap (12, 9, icon_sorter_color_value)
			Result.add_pixmap (13, 9, icon_static_external_symbol_value)
			Result.add_pixmap (14, 9, icon_static_object_symbol_value)
			Result.add_pixmap (15, 9, icon_step_into_color_value)
			Result.add_pixmap (16, 9, icon_step_out_color_value)
			Result.add_pixmap (1, 10, icon_super_cluster_color_value)
			Result.add_pixmap (2, 10, icon_supplier_color_value)
			Result.add_pixmap (3, 10, icon_system_color_value)
			Result.add_pixmap (4, 10, icon_system_info_color_value)
			Result.add_pixmap (5, 10, icon_system_color_value)
			Result.add_pixmap (6, 10, icon_toggle_clusters_color_value)
			Result.add_pixmap (7, 10, icon_toolbar_separator_value)
			Result.add_pixmap (8, 10, icon_undo_color_value)
			Result.add_pixmap (9, 10, icon_unify_stone_color_value)
			Result.add_pixmap (10, 10, icon_view_measure_minus_color_value)
			Result.add_pixmap (11, 10, icon_view_measure_plus_color_value)
			Result.add_pixmap (12, 10, icon_void_pointer_value)
			Result.add_pixmap (13, 10, icon_windows_color_value)
			Result.add_pixmap (14, 10, icon_word_wrap_color_value)
			Result.add_pixmap (15, 10, icon_zoom_in_color_value)
			Result.add_pixmap (16, 10, icon_zoom_out_color_value)
			Result.add_pixmap (1, 11, icon_anchor_color_value)
			Result.add_pixmap (2, 11, icon_display_cluster_color_value)
			Result.add_pixmap (3, 11, icon_display_legend_color_value)
			Result.add_pixmap (4, 11, icon_fit_to_screen_color_value)
			Result.add_pixmap (5, 11, icon_remove_anchor_color_value)
			Result.add_pixmap (6, 11, icon_toggle_force_color_value)
			Result.add_pixmap (7, 11, icon_toggle_quality_color_value)
			Result.add_pixmap (8, 11, icon_uml_color_value)
			Result.add_pixmap (9, 11, icon_pin_open_color_value)
			Result.add_pixmap (10, 11, icon_pin_closed_color_value)
			Result.add_pixmap (11, 11, icon_arrow_empty_value)
			Result.add_pixmap (12, 11, icon_force_settings_color_value)
			Result.add_pixmap (13, 11, icon_deferred_obsolete_feature_value)
			Result.add_pixmap (14, 11, icon_attribute_obsolete_symbol_value)
			Result.add_pixmap (15, 11, icon_attribute_frozen_symbol_value)
			Result.add_pixmap (16, 11, icon_once_obsolete_symbol_value)
			Result.add_pixmap (1, 12, icon_once_frozen_symbol_value)
			Result.add_pixmap (2, 12, icon_external_obsolete_feature_value)
			Result.add_pixmap (3, 12, icon_external_frozen_feature_value)
			Result.add_pixmap (4, 12, icon_obsolete_feature_value)
			Result.add_pixmap (5, 12, icon_frozen_feature_value)
			Result.add_pixmap (6, 12, icon_format_assigners_color_value)
			Result.add_pixmap (7, 12, icon_format_creator_callers_color_value)
			Result.add_pixmap (8, 12, icon_preference_root_value)
			Result.add_pixmap (9, 12, icon_preference_folder_value)
			Result.add_pixmap (10, 12, icon_other_feature_value)
			Result.add_pixmap (11, 12, icon_reset_view_color_value)
			Result.add_pixmap (12, 12, icon_format_creators_color_value)
			Result.add_pixmap (13, 12, icon_format_invariants_color_value)
			Result.add_pixmap (14, 12, icon_add_new_external_cmd_color_value)
			Result.add_pixmap (15, 12, icon_input_to_process_color_value)
			Result.add_pixmap (16, 12, icon_save_all_color_value)
			Result.add_pixmap (1, 13, icon_new_tab_color_value)
			Result.add_pixmap (2, 13, icon_quick_search_close_color_value)
			Result.add_pixmap (3, 13, icon_quick_search_next_color_value)
			Result.add_pixmap (4, 13, icon_quick_search_previous_color_value)
			Result.add_pixmap (6, 13, icon_trash_can_color_value)
			Result.add_pixmap (7, 13, icon_assigner_value)
			Result.add_pixmap (8, 13, icon_frozen_assigner_value)
			Result.add_pixmap (9, 13, icon_obsolete_assigner_value)
			Result.add_pixmap (10, 13, icon_deferred_assigner_value)
			Result.add_pixmap (11, 13, icon_deferred_obsolete_assigner_value)
			Result.add_pixmap (12, 13, icon_ascending_sort_color_value)
			Result.add_pixmap (13, 13, icon_descending_sort_color_value)
			Result.add_pixmap (14, 13, icon_expandable_right_arrow_color_value)
			Result.add_pixmap (1, 14, icon_folder_symbol_color_value)
			Result.add_pixmap (2, 14, icon_clusters_symbol_color_value)
			Result.add_pixmap (3, 14, icon_overrides_symbol_color_value)
			Result.add_pixmap (4, 14, icon_cluster_symbol_color_value)
			Result.add_pixmap (5, 14, icon_light_cluster_color_value)
			Result.add_pixmap (6, 14, icon_override_symbol_color_value)
			Result.add_pixmap (7, 14, icon_read_only_override_symbol_color_value)
			Result.add_pixmap (8, 14, icon_override_folder_symbol_color_value)
			Result.add_pixmap (9, 14, icon_class_symbol_color_value)
			Result.add_pixmap (10, 14, icon_light_class_color_value)
			Result.add_pixmap (11, 14, icon_class_symbol_gray_value)
			Result.add_pixmap (12, 14, icon_light_class_gray_value)
			Result.add_pixmap (13, 14, icon_deferred_class_symbol_color_value)
			Result.add_pixmap (14, 14, icon_light_deferred_class_color_value)
			Result.add_pixmap (15, 14, icon_overriden_class_color_value)
			Result.add_pixmap (16, 14, icon_overriden_light_class_color_value)
			Result.add_pixmap (1, 15, icon_overriden_grey_class_color_value)
			Result.add_pixmap (2, 15, icon_overriden_light_grey_class_color_value)
			Result.add_pixmap (3, 15, icon_overriden_deferred_class_color_value)
			Result.add_pixmap (4, 15, icon_overriden_deferred_light_class_color_value)
			Result.add_pixmap (5, 15, icon_assemblies_symbol_color_value)
			Result.add_pixmap (6, 15, icon_read_only_assembly_symbol_color_value)
			Result.add_pixmap (7, 15, icon_assembly_namespace_symbol_color_value)
			Result.add_pixmap (8, 15, icon_overrider_class_color_value)
			Result.add_pixmap (9, 15, icon_overrider_light_class_color_value)
			Result.add_pixmap (10, 15, icon_overrider_grey_class_color_value)
			Result.add_pixmap (11, 15, icon_overrider_light_grey_class_color_value)
			Result.add_pixmap (12, 15, icon_overrider_deferred_class_color_value)
			Result.add_pixmap (13, 15, icon_overrider_deferred_light_class_color_value)
			Result.add_pixmap (14, 15, icon_libraries_symbol_color_value)
			Result.add_pixmap (15, 15, icon_library_symbol_color_value)
			Result.add_pixmap (16, 15, icon_read_only_library_symbol_color_value)
			Result.add_pixmap (1, 16, Icon_warning_output_view_icon_value)
			Result.add_pixmap (2, 16, Icon_error_output_view_icon_value)
			Result.add_pixmap (3, 16, Icon_diagram_tool_icon_value)
			Result.add_pixmap (4, 16, Icon_output_view_icon_value)
			Result.add_pixmap (5, 16, Icon_bottom_reached_icon_value)
			Result.add_pixmap (6, 16, Icon_first_result_reached_icon_value)
			Result.add_pixmap (7, 16, Icon_external_command_icon_value)
			Result.add_pixmap (8, 16, Icon_normal_callee_icon_value)
			Result.add_pixmap (9, 16, Icon_creator_callee_icon_value)
			Result.add_pixmap (10, 16, Icon_assigner_callee_icon_value)
		end

feature {NONE} -- Constants

			icon_add_exported_feature_color_value: INTEGER is 1
			icon_attribute_symbol_value: INTEGER is 2
			icon_auto_slice_limits_color_value: INTEGER is 3
			icon_back_color_value: INTEGER is 4
			icon_bkpt_info_color_value: INTEGER is 5
			icon_center_diagram_color_value: INTEGER is 6
			icon_check_exports_color_value: INTEGER is 7
			icon_class_header_color_value: INTEGER is 8
			icon_class_symbol_color_value: INTEGER is 9
			icon_class_symbol_gray_value: INTEGER is 10
			icon_cluster_symbol_color_value: INTEGER is 11
			icon_cmd_history_color_value: INTEGER is 12
			icon_color_color_value: INTEGER is 13
			icon_compilation_error_value: INTEGER is 14
			icon_compiled_value: INTEGER is 15
			icon_compile_color_value: INTEGER is 16
			icon_compiling_1_value: INTEGER is 17
			icon_compiling_2_value: INTEGER is 18
			icon_compiling_3_value: INTEGER is 19
			icon_compiling_4_value: INTEGER is 20
			icon_context_tool_color_value: INTEGER is 21
			icon_copy_color_value: INTEGER is 22
			icon_crop_color_value: INTEGER is 23
			icon_cut_color_value: INTEGER is 24
			icon_deferred_class_symbol_color_value: INTEGER is 25
			icon_deferred_feature_value: INTEGER is 26
			icon_light_deferred_class_color_value: INTEGER is 27
			icon_delete_measure_color_value: INTEGER is 28
			icon_delete_small_color_value: INTEGER is 29
			icon_delete_view_color_value: INTEGER is 30
			icon_development_window_color_value: INTEGER is 31
			icon_dialog_window_value: INTEGER is 32
			icon_disable_bkpt_color_value: INTEGER is 33
			icon_display_labels_color_value: INTEGER is 34
			icon_dotnet_import_color_value: INTEGER is 35
			icon_dynamiclib_window_value: INTEGER is 36
			icon_edit_exported_feature_color_value: INTEGER is 37
			icon_editing_value: INTEGER is 38
			icon_enable_bkpt_color_value: INTEGER is 39
			icon_exec_quit_color_value: INTEGER is 40
			icon_exec_step_color_value: INTEGER is 41
			icon_exec_stop_color_value: INTEGER is 42
			icon_expanded_object_value: INTEGER is 43
			icon_export_to_png_color_value: INTEGER is 44
			icon_stopped_value: INTEGER is 45
			icon_external_feature_value: INTEGER is 46
			icon_external_symbol_value: INTEGER is 47
			icon_favorites_color_value: INTEGER is 48
			icon_favorites_folder_color_value: INTEGER is 49
			icon_feature_color_value: INTEGER is 50
			icon_feature_clause_any_value: INTEGER is 51
			icon_feature_clause_none_value: INTEGER is 52
			icon_feature_clause_some_value: INTEGER is 53
			icon_features_color_value: INTEGER is 54
			icon_fill_cluster_color_value: INTEGER is 55
			icon_finalize_color_value: INTEGER is 56
			icon_del_bkpt_color_value: INTEGER is 57
			icon_format_ancestors_color_value: INTEGER is 58
			icon_format_attributes_color_value: INTEGER is 59
			icon_format_clickable_color_value: INTEGER is 60
			icon_format_clients_color_value: INTEGER is 61
			icon_format_contract_color_value: INTEGER is 62
			icon_format_deferreds_color_value: INTEGER is 63
			icon_format_descendants_color_value: INTEGER is 64
			icon_format_exporteds_color_value: INTEGER is 65
			icon_format_externals_color_value: INTEGER is 66
			icon_format_feature_ancestors_color_value: INTEGER is 67
			icon_format_feature_callers_color_value: INTEGER is 68
			icon_format_feature_descendants_color_value: INTEGER is 69
			icon_format_feature_homonyms_color_value: INTEGER is 70
			icon_format_feature_implementers_color_value: INTEGER is 71
			icon_format_flat_color_value: INTEGER is 72
			icon_format_interface_color_value: INTEGER is 73
			icon_format_onces_color_value: INTEGER is 74
			icon_format_routines_color_value: INTEGER is 75
			icon_format_suppliers_color_value: INTEGER is 76
			icon_format_text_color_value: INTEGER is 77
			icon_forth_color_value: INTEGER is 78
			icon_freeze_color_value: INTEGER is 79
			icon_green_arrow_value: INTEGER is 80
			icon_green_tick_value: INTEGER is 81
			icon_help_tool_color_value: INTEGER is 82
			icon_immediate_value_value: INTEGER is 83
			icon_inherit_color_value: INTEGER is 84
			icon_straight_arrows_color_value: INTEGER is 85
			icon_minimize_all_color_value: INTEGER is 86
			icon_new_agg_supplier_color_value: INTEGER is 87
			icon_new_class_color_value: INTEGER is 88
			icon_new_cluster_color_value: INTEGER is 89
			icon_new_context_window_color_value: INTEGER is 90
			icon_new_development_tool_color_value: INTEGER is 91
			icon_new_dynamic_lib_color_value: INTEGER is 92
			icon_new_editor_color_value: INTEGER is 93
			icon_new_feature_color_value: INTEGER is 94
			icon_new_inherit_color_value: INTEGER is 95
			icon_new_measure_color_value: INTEGER is 96
			icon_new_metric_color_value: INTEGER is 97
			icon_new_supplier_color_value: INTEGER is 98
			icon_no_stop_color_value: INTEGER is 99
			icon_exe_up_to_date_value: INTEGER is 100
			icon_object_symbol_value: INTEGER is 101
			icon_once_symbol_value: INTEGER is 102
			icon_open_file_color_value: INTEGER is 103
			icon_paste_color_value: INTEGER is 104
			icon_preference_window_value: INTEGER is 105
			icon_open_exception_dialog_value: INTEGER is 106
			icon_print_color_value: INTEGER is 107
			icon_profiler_window_value: INTEGER is 108
			icon_progress_dialog_color_value: INTEGER is 109
			icon_quick_compile_color_value: INTEGER is 110
			icon_restore_all_color_value: INTEGER is 111
			icon_restore_all_unsaved_color_value: INTEGER is 112
			icon_light_class_color_value: INTEGER is 113
			icon_light_class_gray_value: INTEGER is 114
			icon_light_cluster_color_value: INTEGER is 115
			icon_recycle_bin_color_value: INTEGER is 116
			icon_red_cross_value: INTEGER is 117
			icon_redo_color_value: INTEGER is 118
			icon_remove_exported_feature_color_value: INTEGER is 119
			icon_reset_diagram_color_value: INTEGER is 120
			icon_restore_view_color_value: INTEGER is 121
			icon_run_color_value: INTEGER is 122
			icon_debug_run_color_value: INTEGER is 123
			icon_debugger_exception_value: INTEGER is 124
			icon_running_1_value: INTEGER is 125
			icon_running_2_value: INTEGER is 126
			icon_running_3_value: INTEGER is 127
			icon_save_color_value: INTEGER is 128
			icon_save_measure_color_value: INTEGER is 129
			icon_search_color_value: INTEGER is 130
			icon_select_depth_color_value: INTEGER is 131
			icon_select_metrics_color_value: INTEGER is 132
			icon_send_stone_down_color_value: INTEGER is 133
			icon_set_arguments_color_value: INTEGER is 134
			icon_shell_color_value: INTEGER is 135
			icon_sorter_color_value: INTEGER is 136
			icon_static_external_symbol_value: INTEGER is 137
			icon_static_object_symbol_value: INTEGER is 138
			icon_step_into_color_value: INTEGER is 139
			icon_step_out_color_value: INTEGER is 140
			icon_super_cluster_color_value: INTEGER is 141
			icon_supplier_color_value: INTEGER is 142
			icon_system_color_value: INTEGER is 143
			icon_system_info_color_value: INTEGER is 144
			icon_toggle_clusters_color_value: INTEGER is 145
			icon_toolbar_separator_value: INTEGER is 146
			icon_undo_color_value: INTEGER is 147
			icon_unify_stone_color_value: INTEGER is 148
			icon_view_measure_minus_color_value: INTEGER is 149
			icon_view_measure_plus_color_value: INTEGER is 150
			icon_void_pointer_value: INTEGER is 151
			icon_windows_color_value: INTEGER is 152
			icon_word_wrap_color_value: INTEGER is 153
			icon_zoom_in_color_value: INTEGER is 154
			icon_zoom_out_color_value: INTEGER is 155
			icon_anchor_color_value: INTEGER is 156
			icon_display_cluster_color_value: INTEGER is 157
			icon_display_legend_color_value: INTEGER is 158
			icon_fit_to_screen_color_value: INTEGER is 159
			icon_remove_anchor_color_value: INTEGER is 160
			icon_toggle_force_color_value: INTEGER is 161
			icon_toggle_quality_color_value: INTEGER is 162
			icon_uml_color_value: INTEGER is 163
			icon_pin_open_color_value: INTEGER is 164
			icon_pin_closed_color_value: INTEGER is 165
			icon_arrow_empty_value: INTEGER is 166
			icon_force_settings_color_value: INTEGER is 167
			icon_deferred_obsolete_feature_value: INTEGER is 168
			icon_attribute_obsolete_symbol_value: INTEGER is 169
			icon_attribute_frozen_symbol_value: INTEGER is 170
			icon_once_obsolete_symbol_value: INTEGER is 171
			icon_once_frozen_symbol_value: INTEGER is 172
			icon_external_obsolete_feature_value: INTEGER is 173
			icon_external_frozen_feature_value: INTEGER is 174
			icon_obsolete_feature_value: INTEGER is 175
			icon_frozen_feature_value: INTEGER is 176
			icon_format_assigners_color_value: INTEGER is 177
			icon_format_creator_callers_color_value: INTEGER is 178
			icon_preference_root_value: INTEGER is 179
			icon_preference_folder_value: INTEGER is 180
			icon_other_feature_value: INTEGER is 181
			icon_reset_view_color_value: INTEGER is 182
			icon_format_creators_color_value: INTEGER is 183
			icon_format_invariants_color_value: INTEGER is 184
			icon_input_to_process_color_value: INTEGER is 185
			icon_add_new_external_cmd_color_value: INTEGER is 186
			icon_save_all_color_value: INTEGER is 187
			icon_new_tab_color_value: INTEGER is 188
			icon_quick_search_next_color_value: INTEGER is 189
			icon_quick_search_previous_color_value: INTEGER is 190
			icon_quick_search_close_color_value: INTEGER is 191
			icon_trash_can_color_value: INTEGER is 192
			icon_read_only_assembly_symbol_color_value: INTEGER is 193
			icon_read_only_library_symbol_color_value: INTEGER is 194
			icon_read_only_override_symbol_color_value: INTEGER is 195
			icon_folder_symbol_color_value: INTEGER is 196
			icon_override_folder_symbol_color_value: INTEGER is 197
			icon_library_symbol_color_value: INTEGER is 198
			icon_override_symbol_color_value: INTEGER is 199
			icon_ascending_sort_color_value: INTEGER is 200
			icon_descending_sort_color_value: INTEGER is 201
			icon_expandable_right_arrow_color_value: INTEGER is 202
			icon_assembly_namespace_symbol_color_value: INTEGER is 203
			icon_overriden_class_color_value: INTEGER is 204
			icon_overriden_light_class_color_value: INTEGER is 205
			icon_overriden_grey_class_color_value: INTEGER is 206
			icon_overriden_light_grey_class_color_value: INTEGER is 207
			icon_overriden_deferred_class_color_value: INTEGER is 208
			icon_overriden_deferred_light_class_color_value: INTEGER is 209
			icon_clusters_symbol_color_value: INTEGER is 210
			icon_overrides_symbol_color_value: INTEGER is 211
			icon_libraries_symbol_color_value: INTEGER is 212
			icon_assemblies_symbol_color_value: INTEGER is 213
			icon_overrider_class_color_value: INTEGER is 214
			icon_overrider_light_class_color_value: INTEGER is 215
			icon_overrider_grey_class_color_value: INTEGER is 216
			icon_overrider_light_grey_class_color_value: INTEGER is 217
			icon_overrider_deferred_class_color_value: INTEGER is 218
			icon_overrider_deferred_light_class_color_value: INTEGER is 219
			Icon_output_view_icon_value: INTEGER is 220
			Icon_error_output_view_icon_value: INTEGER is 221
			Icon_warning_output_view_icon_value: INTEGER is 222
			Icon_diagram_tool_icon_value: INTEGER is 223
			Icon_bottom_reached_icon_value: INTEGER is 224
			Icon_first_result_reached_icon_value: INTEGER is 225
			Icon_expand_all_value: INTEGER is 226
			Icon_collapse_all_value: INTEGER is 227
			icon_assigner_value: INTEGER is 228
			icon_frozen_assigner_value: INTEGER is 229
			icon_obsolete_assigner_value: INTEGER is 230
			icon_deferred_assigner_value: INTEGER is 231
			icon_deferred_obsolete_assigner_value: INTEGER is 232
			icon_invisible_value: INTEGER is 233
			icon_external_command_icon_value: INTEGER is 234
			icon_normal_callee_icon_value: INTEGER is 235
			icon_creator_callee_icon_value: INTEGER is 236
			icon_assigner_callee_icon_value: INTEGER is 237

feature {NONE} -- Configuration pixmaps

	folder_blank_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_blank_readonly_icon
		end

	folder_blank_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_blank_icon
		end

	folder_namespace_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_namespace_icon
		end

	folder_override_cluster_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_override_cluster_readonly_icon
		end

	folder_override_cluster_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_override_cluster_icon
		end

	folder_override_blank_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_override_blank_readonly_icon
		end

	folder_override_blank_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_override_blank_icon
		end

	folder_hidden_cluster_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_hidden_cluster_readonly_icon
		end

	folder_hidden_cluster_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_hidden_cluster_icon
		end

	folder_hidden_blank_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_hidden_blank_readonly_icon
		end

	folder_hidden_blank_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_hidden_blank_icon
		end

	folder_cluster_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_cluster_readonly_icon
		end

	folder_precompiled_library_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_precompiled_library_icon
		end

	folder_precompiled_library_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_precompiled_library_readonly_icon
		end

	folder_cluster_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_cluster_icon
		end

	folder_library_readonly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_library_readonly_icon
		end

	folder_library_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_library_icon
		end

	folder_assembly_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.folder_assembly_icon
		end

	new_reference_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_reference_icon
		end

	new_reference_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_reference_icon_buffer
		end

	new_target_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_target_icon
		end

	new_target_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_target_icon_buffer
		end

	new_cluster_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_cluster_icon
		end

	new_cluster_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_cluster_icon_buffer
		end

	new_override_cluster_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_override_cluster_icon
		end

	new_override_cluster_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_override_cluster_icon_buffer
		end

	new_library_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_library_icon
		end

	new_library_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_library_icon_buffer
		end

	general_open_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.general_open_icon
		end

	general_add_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.general_add_icon
		end

	general_remove_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.general_remove_icon
		end

	general_edit_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.general_edit_icon
		end

	general_edit_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.general_edit_icon_buffer
		end

	general_delete_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.general_delete_icon
		end

	general_delete_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.general_delete_icon_buffer
		end

	new_precompiled_library_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_precompiled_library_icon
		end

	new_precompiled_library_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_precompiled_library_icon_buffer
		end

	new_include_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_include_icon
		end

	new_include_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_include_icon_buffer
		end

	new_object_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_object_icon
		end

	new_object_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_object_icon_buffer
		end

	new_makefile_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_makefile_icon
		end

	new_makefile_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_makefile_icon_buffer
		end

	new_resource_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_resource_icon
		end

	new_resource_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_resource_icon_buffer
		end

	new_pre_compilation_task_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_pre_compilation_task_icon
		end

	new_pre_compilation_task_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_pre_compilation_task_icon_buffer
		end

	new_post_compilation_task_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.new_post_compilation_task_icon
		end

	new_post_compilation_task_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.new_post_compilation_task_icon_buffer
		end

	project_settings_edit_library_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_edit_library_icon
		end

	project_settings_edit_library_icon_buffer: EV_PIXEL_BUFFER
		once
			Result := icon_pixmaps.project_settings_edit_library_icon_buffer
		end

	project_settings_system_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_system_icon
		end

	project_settings_tasks_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_tasks_icon
		end

	project_settings_task_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_task_icon
		end

	project_settings_variables_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_variables_icon
		end

	project_settings_groups_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_groups_icon
		end

	project_settings_assertions_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_assertions_icon
		end

	project_settings_warnings_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_warnings_icon
		end

	project_settings_externals_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_externals_icon
		end

	project_settings_debug_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_debug_icon
		end

	project_settings_type_mappings_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_type_mappings_icon
		end

	project_settings_advanced_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_advanced_icon
		end

	project_settings_include_file_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_include_file_icon
		end

	project_settings_resource_file_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_resource_file_icon
		end

	project_settings_make_file_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_make_file_icon
		end

	project_settings_object_file_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.project_settings_object_file_icon
		end

	tool_properties_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.tool_properties_icon
		end

	tool_config_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.tool_config_icon
		end

	top_level_folder_targets_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.top_level_folder_targets_icon
		end

	top_level_folder_references_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.top_level_folder_references_icon
		end

	top_level_folder_clusters_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.top_level_folder_clusters_icon
		end

	top_level_folder_overrides_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.top_level_folder_overrides_icon
		end

	top_level_folder_library_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.top_level_folder_library_icon
		end

	top_level_folder_precompiles_icon: EV_PIXMAP
		once
			Result := icon_pixmaps.top_level_folder_precompiles_icon
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- EB_SHARED_PIXMAPS

