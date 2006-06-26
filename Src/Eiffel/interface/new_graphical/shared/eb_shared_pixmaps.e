indexing
	description: "Pixmaps used in interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS

inherit
	EV_STOCK_PIXMAPS

	EB_SHARED_PIXMAP_FACTORY
		redefine
			pixmap_lookup_table
		end

feature -- Access

	mini_pixmaps: ES_PIXMAPS_10X10 is
			-- Shared icon pixmaps
		once
			create Result.make ("10x10.png")
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
			create Result.make_from_string ((create {EIFFEL_ENV}).bitmaps_path)
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

			icon_add_exported_feature_color_value,
			icon_attribute_symbol_value,
			icon_auto_slice_limits_color_value,
			icon_back_color_value,
			icon_bkpt_info_color_value,
			icon_center_diagram_color_value,
			icon_check_exports_color_value,
			icon_class_header_color_value,
			icon_class_symbol_color_value,
			icon_class_symbol_gray_value,
			icon_cluster_symbol_color_value,
			icon_cmd_history_color_value,
			icon_color_color_value,
			icon_compilation_error_value,
			icon_compiled_value,
			icon_compile_color_value,
			icon_compiling_1_value,
			icon_compiling_2_value,
			icon_compiling_3_value,
			icon_compiling_4_value,
			icon_context_tool_color_value,
			icon_copy_color_value,
			icon_crop_color_value,
			icon_cut_color_value,
			icon_deferred_class_symbol_color_value,
			icon_deferred_feature_value,
			icon_light_deferred_class_color_value,
			icon_delete_measure_color_value,
			icon_delete_small_color_value,
			icon_delete_view_color_value,
			icon_development_window_color_value,
			icon_dialog_window_value,
			icon_disable_bkpt_color_value,
			icon_display_labels_color_value,
			icon_dotnet_import_color_value,
			icon_dynamiclib_window_value,
			icon_edit_exported_feature_color_value,
			icon_editing_value,
			icon_enable_bkpt_color_value,
			icon_exec_quit_color_value,
			icon_exec_step_color_value,
			icon_exec_stop_color_value,
			icon_expanded_object_value,
			icon_export_to_png_color_value,
			icon_stopped_value,
			icon_external_feature_value,
			icon_external_symbol_value,
			icon_favorites_color_value,
			icon_favorites_folder_color_value,
			icon_feature_color_value,
			icon_feature_clause_any_value,
			icon_feature_clause_none_value,
			icon_feature_clause_some_value,
			icon_features_color_value,
			icon_fill_cluster_color_value,
			icon_finalize_color_value,
			icon_del_bkpt_color_value,
			icon_format_ancestors_color_value,
			icon_format_attributes_color_value,
			icon_format_clickable_color_value,
			icon_format_clients_color_value,
			icon_format_contract_color_value,
			icon_format_deferreds_color_value,
			icon_format_descendants_color_value,
			icon_format_exporteds_color_value,
			icon_format_externals_color_value,
			icon_format_feature_ancestors_color_value,
			icon_format_feature_callers_color_value,
			icon_format_feature_descendants_color_value,
			icon_format_feature_homonyms_color_value,
			icon_format_feature_implementers_color_value,
			icon_format_flat_color_value,
			icon_format_interface_color_value,
			icon_format_onces_color_value,
			icon_format_routines_color_value,
			icon_format_suppliers_color_value,
			icon_format_text_color_value,
			icon_forth_color_value,
			icon_freeze_color_value,
			icon_green_arrow_value,
			icon_green_tick_value,
			icon_help_tool_color_value,
			icon_immediate_value_value,
			icon_inherit_color_value,
			icon_straight_arrows_color_value,
			icon_minimize_all_color_value,
			icon_new_agg_supplier_color_value,
			icon_new_class_color_value,
			icon_new_cluster_color_value,
			icon_new_context_window_color_value,
			icon_new_development_tool_color_value,
			icon_new_dynamic_lib_color_value,
			icon_new_editor_color_value,
			icon_new_feature_color_value,
			icon_new_inherit_color_value,
			icon_new_measure_color_value,
			icon_new_metric_color_value,
			icon_new_supplier_color_value,
			icon_no_stop_color_value,
			icon_exe_up_to_date_value,
			icon_object_symbol_value,
			icon_once_symbol_value,
			icon_open_file_color_value,
			icon_paste_color_value,
			icon_preference_window_value,
			icon_open_exception_dialog_value,
			icon_print_color_value,
			icon_profiler_window_value,
			icon_progress_dialog_color_value,
			icon_quick_compile_color_value,
			icon_restore_all_color_value,
			icon_restore_all_unsaved_color_value,
			icon_light_class_color_value,
			icon_light_class_gray_value,
			icon_light_cluster_color_value,
			icon_recycle_bin_color_value,
			icon_red_cross_value,
			icon_redo_color_value,
			icon_remove_exported_feature_color_value,
			icon_reset_diagram_color_value,
			icon_restore_view_color_value,
			icon_run_color_value,
			icon_debug_run_color_value,
			icon_debugger_exception_value,
			icon_running_1_value,
			icon_running_2_value,
			icon_running_3_value,
			icon_save_color_value,
			icon_save_measure_color_value,
			icon_search_color_value,
			icon_select_depth_color_value,
			icon_select_metrics_color_value,
			icon_send_stone_down_color_value,
			icon_set_arguments_color_value,
			icon_shell_color_value,
			icon_sorter_color_value,
			icon_static_external_symbol_value,
			icon_static_object_symbol_value,
			icon_step_into_color_value,
			icon_step_out_color_value,
			icon_super_cluster_color_value,
			icon_supplier_color_value,
			icon_system_color_value,
			icon_system_info_color_value,
			icon_toggle_clusters_color_value,
			icon_toolbar_separator_value,
			icon_undo_color_value,
			icon_unify_stone_color_value,
			icon_view_measure_minus_color_value,
			icon_view_measure_plus_color_value,
			icon_void_pointer_value,
			icon_windows_color_value,
			icon_word_wrap_color_value,
			icon_zoom_in_color_value,
			icon_zoom_out_color_value,
			icon_anchor_color_value,
			icon_display_cluster_color_value,
			icon_display_legend_color_value,
			icon_fit_to_screen_color_value,
			icon_remove_anchor_color_value,
			icon_toggle_force_color_value,
			icon_toggle_quality_color_value,
			icon_uml_color_value,
			icon_pin_open_color_value,
			icon_pin_closed_color_value,
			icon_arrow_empty_value,
			icon_force_settings_color_value,
			icon_deferred_obsolete_feature_value,
			icon_attribute_obsolete_symbol_value,
			icon_attribute_frozen_symbol_value,
			icon_once_obsolete_symbol_value,
			icon_once_frozen_symbol_value,
			icon_external_obsolete_feature_value,
			icon_external_frozen_feature_value,
			icon_obsolete_feature_value,
			icon_frozen_feature_value,
			icon_format_assigners_color_value,
			icon_format_creator_callers_color_value,
			icon_preference_root_value,
			icon_preference_folder_value,
			icon_other_feature_value,
			icon_reset_view_color_value,
			icon_format_creators_color_value,
			icon_format_invariants_color_value,
			icon_input_to_process_color_value,
			icon_add_new_external_cmd_color_value,
			icon_save_all_color_value,
			icon_new_tab_color_value,
			icon_quick_search_next_color_value,
			icon_quick_search_previous_color_value,
			icon_quick_search_close_color_value,
			icon_trash_can_color_value,
			icon_read_only_assembly_symbol_color_value,
			icon_read_only_library_symbol_color_value,
			icon_read_only_override_symbol_color_value,
			icon_folder_symbol_color_value,
			icon_override_folder_symbol_color_value,
			icon_library_symbol_color_value,
			icon_override_symbol_color_value,
			icon_ascending_sort_color_value,
			icon_descending_sort_color_value,
			icon_expandable_right_arrow_color_value,
			icon_assembly_namespace_symbol_color_value,
			icon_overriden_class_color_value,
			icon_overriden_light_class_color_value,
			icon_overriden_grey_class_color_value,
			icon_overriden_light_grey_class_color_value,
			icon_overriden_deferred_class_color_value,
			icon_overriden_deferred_light_class_color_value,
			icon_clusters_symbol_color_value,
			icon_overrides_symbol_color_value,
			icon_libraries_symbol_color_value,
			icon_assemblies_symbol_color_value,
			icon_overrider_class_color_value,
			icon_overrider_light_class_color_value,
			icon_overrider_grey_class_color_value,
			icon_overrider_light_grey_class_color_value,
			icon_overrider_deferred_class_color_value,
			icon_overrider_deferred_light_class_color_value,
			Icon_output_view_icon_value,
			Icon_error_output_view_icon_value,
			Icon_warning_output_view_icon_value,
			Icon_diagram_tool_icon_value,
			Icon_bottom_reached_icon_value,
			Icon_first_result_reached_icon_value,
			Icon_expand_all_value,
			Icon_collapse_all_value,
			icon_assigner_value,
			icon_frozen_assigner_value,
			icon_obsolete_assigner_value,
			icon_deferred_assigner_value,
			icon_deferred_obsolete_assigner_value,
			icon_invisible_value,
			icon_external_command_icon_value,
			icon_normal_callee_icon_value,
			icon_creator_callee_icon_value,
			icon_assigner_callee_icon_value: INTEGER is unique;

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

