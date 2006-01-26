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

	small_pixmaps: EB_SHARED_PIXMAPS_8 is
			-- Shared small pixmaps
		once
			create Result
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

	Icon_dialog_window: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_dialog_window_value)
		end

	Icon_preference_root: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_preference_root_value)
		end

	Icon_preference_folder: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_preference_folder_value)
		end

	Icon_preference_window: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_preference_window_value)
		end

	Icon_open_exception_dialog: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_open_exception_dialog_value)
		end

	Icon_format_feature_homonyms: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_feature_homonyms_color_value)
		end

	Icon_format_feature_implementers: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_feature_implementers_color_value)
		end

	Icon_format_feature_ancestors: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_feature_ancestors_color_value)
		end

	Icon_format_feature_descendants: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_feature_descendants_color_value)
		end

	Icon_format_feature_callers: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_feature_callers_color_value)
		end

	icon_format_assigners: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_assigners_color_value)
		end

	icon_format_creators: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_creators_color_value)
		end

	icon_format_creator_callers: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_creator_callers_color_value)
		end

	Icon_format_invariants: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_invariants_color_value)
		end

	Icon_format_ancestors: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_ancestors_color_value)
		end

	Icon_format_descendants: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_descendants_color_value)
		end

	Icon_format_clients: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_clients_color_value)
		end

	Icon_format_suppliers: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_suppliers_color_value)
		end

	Icon_format_externals: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_externals_color_value)
		end

	Icon_format_exporteds: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_exporteds_color_value)
		end

	Icon_format_deferreds: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_deferreds_color_value)
		end

	Icon_format_onces: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_onces_color_value)
		end

	Icon_format_attributes: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_attributes_color_value)
		end

	Icon_format_routines: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_routines_color_value)
		end

	Icon_format_text: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_text_color_value)
		end

	Icon_format_clickable: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_clickable_color_value)
		end

	Icon_format_flat: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_flat_color_value)
		end

	Icon_format_contract: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_contract_color_value)
		end

	Icon_format_interface: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_format_interface_color_value)
		end

	Icon_frozen_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_frozen_feature_value)
		end

	Icon_obsolete_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_obsolete_feature_value)
		end

	Icon_object_symbol: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_object_symbol_value)
		end

	Icon_static_object_symbol: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_static_object_symbol_value)
		end

	Icon_external_symbol: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_external_symbol_value)
		end

	Icon_static_external_symbol: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_static_external_symbol_value)
		end

	Icon_once_objects: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_once_symbol_value)
		end

	Icon_once_obsolete_objects: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_once_obsolete_symbol_value)
		end

	Icon_once_frozen_objects: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_once_frozen_symbol_value)
		end

	Icon_attributes: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_attribute_symbol_value)
		end

	Icon_obsolete_attribute: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_attribute_obsolete_symbol_value)
		end

	Icon_frozen_attribute: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_attribute_frozen_symbol_value)
		end

	Icon_deferred_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_deferred_feature_value)
		end

	Icon_deferred_obsolete_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_deferred_obsolete_feature_value)
		end

	Icon_external_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_external_feature_value)
		end

	Icon_external_frozen_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_external_frozen_feature_value)
		end

	Icon_external_obsolete_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_external_obsolete_feature_value)
		end

	Icon_other_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_other_feature_value)
		end

	Icon_void_object: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_void_pointer_value)
		end

	Icon_dotnet_import: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_dotnet_import_color_value)
		end

	Icon_expanded_object: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_expanded_object_value)
		end

	Icon_immediate_value: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_immediate_value_value)
		end

	Icon_feature_clause_any: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_feature_clause_any_value)
		end

	Icon_feature_clause_some: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_feature_clause_some_value)
		end

	Icon_feature_clause_none: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_feature_clause_none_value)
		end

	Icon_nothing: EV_PIXMAP is
		once
			Result := small_pixmaps.icon_nothing
		end

	Icon_compilation_succeeded: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_compiled_value)
		end

	Icon_compilation_failed: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_compilation_error_value)
		end

	Icon_application_paused: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_stopped_value)
		end

	Icon_expression_disabled: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_stopped_value)
		end

	Icon_edited: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_editing_value)
		end

	Icon_not_edited: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_exe_up_to_date_value)
		end

	Icon_running: ARRAY [EV_PIXMAP] is
		once
			create Result.make (1, 3)
			Result.put (pixmap_from_constant (icon_running_1_value), 1)
			Result.put (pixmap_from_constant (icon_running_2_value), 2)
			Result.put (pixmap_from_constant (icon_running_3_value), 3)
		end

	Icon_compiling: ARRAY [EV_PIXMAP] is
		once
			create Result.make (1, 4)
			Result.put (pixmap_from_constant (icon_compiling_1_value), 1)
			Result.put (pixmap_from_constant (icon_compiling_2_value), 2)
			Result.put (pixmap_from_constant (icon_compiling_3_value), 3)
			Result.put (pixmap_from_constant (icon_compiling_4_value), 4)
		end

	Icon_is_compiling: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_compiling_4_value)
		end

	Icon_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_feature_color_value)
		end

	Icon_toolbar_separator: EV_PIXMAP is
			-- Icon for toolbar separator.
		once
			Result := pixmap_from_constant (icon_toolbar_separator_value)
		end

	Icon_compile: EV_PIXMAP is
			-- Icon for "Melt project" command.
		once
			Result := pixmap_from_constant (icon_compile_color_value)
		end

	Icon_quick_compile: EV_PIXMAP is
			-- Icon for "Quick melt project" command.
		once
			Result := pixmap_from_constant (icon_quick_compile_color_value)
		end

	Icon_finalize: EV_PIXMAP is
			-- Icon for "Finalize project" command
		once
			Result := pixmap_from_constant (icon_finalize_color_value)
		end

	Icon_freeze: EV_PIXMAP is
			-- Icon for "Freeze project" command
		once
			Result := pixmap_from_constant (icon_freeze_color_value)
		end

	Icon_system_info: EV_PIXMAP is
			-- Icon for "System Info" command
		once
			Result := pixmap_from_constant (icon_system_info_color_value)
		end

	Icon_unify_stone: EV_PIXMAP is
			-- Icon for "Unify Stone" command
		once
			Result := pixmap_from_constant (icon_unify_stone_color_value)
		end

	Icon_send_stone_down: EV_PIXMAP is
			-- Icon for "Send Stone" command
		once
			Result := pixmap_from_constant (icon_send_stone_down_color_value)
		end

	Icon_open_file: EV_PIXMAP is
			-- Icon for "Open File" command
		once
			Result := pixmap_from_constant (icon_open_file_color_value)
		end

	Icon_run: EV_PIXMAP is
			-- Icon for "Run" command
		once
			Result := pixmap_from_constant (icon_run_color_value)
		end

	Icon_run_debug: EV_PIXMAP is
			-- Icon for "Run Debug" command
		once
			Result := pixmap_from_constant (icon_debug_run_color_value)
		end

	Icon_debugger_exception: EV_PIXMAP is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := pixmap_from_constant (icon_debugger_exception_value)
		end

	Icon_cluster_tool: EV_PIXMAP is
			-- Icon for cluster tool
		once
			Result := pixmap_from_constant (icon_cluster_tool_color_value)
		end

	Icon_context_tool: EV_PIXMAP is
			-- Icon for context tool
		once
			Result := pixmap_from_constant (icon_context_tool_color_value)
		end

	Icon_cut: EV_PIXMAP is
			-- Icon for cut.
		once
			Result := pixmap_from_constant (icon_cut_color_value)
		end

	Icon_copy: EV_PIXMAP is
			-- Icon for copy.
		once
			Result := pixmap_from_constant (icon_copy_color_value)
		end

	Icon_paste: EV_PIXMAP is
			-- Icon for paste
		once
			Result := pixmap_from_constant (icon_paste_color_value)
		end

	Icon_search: EV_PIXMAP is
			-- Icon for search
		once
			Result := pixmap_from_constant (icon_search_color_value)
		end

	Icon_editor: EV_PIXMAP is
			-- Icon for editor
		once
			Result := pixmap_from_constant (icon_format_text_color_value)
		end

	Icon_windows: EV_PIXMAP is
			-- Icon for windows
		once
			Result := pixmap_from_constant (icon_windows_color_value)
		end

	Icon_favorites: EV_PIXMAP is
			-- Icon for favorites
		once
			Result := pixmap_from_constant (icon_favorites_color_value)
		end

	Icon_features: EV_PIXMAP is
			-- Icon for features
		once
			Result := pixmap_from_constant (icon_features_color_value)
		end

	Icon_help_tool: EV_PIXMAP is
			-- Icon for help tool.
		once
			Result := pixmap_from_constant (icon_help_tool_color_value)
		end

	Icon_save: EV_PIXMAP is
			-- Icon for save.
		once
			Result := pixmap_from_constant (icon_save_color_value)
		end

	Icon_save_all: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_save_all_color_value)
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

	Icon_undo: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_undo_color_value)
		end

	Icon_cmd_history: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_cmd_history_color_value)
		end

	Icon_redo: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_redo_color_value)
		end

	Icon_shell: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_shell_color_value)
		end

	Icon_new_development_tool: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_development_tool_color_value)
		end

	Icon_new_tab: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_tab_color_value)
		end

	Icon_new_editor: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_editor_color_value)
		end

	Icon_new_context_tool: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_context_window_color_value)
		end

	Icon_new_dynamic_lib: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_dynamic_lib_color_value)
		end

	Icon_new_cluster: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_cluster_color_value)
		end

	Icon_new_class: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_class_color_value)
		end

	Icon_minimize_all: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_minimize_all_color_value)
		end

	Icon_new_measure: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_measure_color_value)
		end

	Icon_raise_all: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_restore_all_color_value)
		end

	Icon_raise_all_unsaved: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_restore_all_unsaved_color_value)
		end

	Icon_add_exported_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_add_exported_feature_color_value)
		end

	Icon_edit_exported_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_edit_exported_feature_color_value)
		end

	Icon_check_exports: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_check_exports_color_value)
		end

	Icon_exec_step: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_exec_step_color_value)
		end

	Icon_step_into: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_step_into_color_value)
		end

	Icon_step_out: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_step_out_color_value)
		end

	Icon_exec_quit: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_exec_quit_color_value)
		end

	Icon_exec_stop: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_exec_stop_color_value)
		end

	Icon_no_stop: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_no_stop_color_value)
		end

	Icon_back: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_back_color_value)
		end

	Icon_forth: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_forth_color_value)
		end

	Icon_class_symbol: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_class_symbol_color_value)
		end

	Icon_class_symbol_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_class_symbol_color_value)
		end

	Icon_deferred_class_symbol_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_deferred_class_symbol_color_value)
		end

	Icon_class_symbol_gray: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_class_symbol_gray_value)
		end

	Icon_read_only_class_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_light_class_color_value)
		end

	Icon_deferred_read_only_class_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_light_deferred_class_color_value)
		end

	Icon_read_only_class_gray: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_light_class_gray_value)
		end

	Icon_read_only_cluster: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_light_cluster_color_value)
		end

	Icon_favorites_folder: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_favorites_folder_color_value)
		end

	Icon_cluster_symbol: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_cluster_symbol_color_value)
		end

	Icon_development_window: EV_PIXMAP is
			-- Pixmap representing a development window
		once
			Result := pixmap_from_constant (icon_development_window_color_value)
		end

	Icon_profiler_window: EV_PIXMAP is
			-- Pixmap representing a profiler window
		once
			Result := pixmap_from_constant (icon_profiler_window_value)
		end

	Icon_dynamiclib_window: EV_PIXMAP is
			-- Pixmap representing a dynamic library builder window
		once
			Result := pixmap_from_constant (icon_dynamiclib_window_value)
		end

	Icon_progress_dialog: EV_PIXMAP is
			-- Pixmap representing a dynamic library builder window
		once
			Result := pixmap_from_constant (icon_progress_dialog_color_value)
		end

	Icon_enable_bkpt: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_enable_bkpt_color_value)
		end

	Icon_disable_bkpt: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_disable_bkpt_color_value)
		end

	Icon_forget_bkpt: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_del_bkpt_color_value)
		end

	Icon_bkpt_info: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bkpt_info_color_value)
		end

	Icon_new_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_feature_color_value)
		end

	Icon_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_color_color_value)
		end

	Icon_new_supplier: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_supplier_color_value)
		end

	Icon_new_aggregate_supplier: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_agg_supplier_color_value)
		end

	Icon_new_inherit: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_inherit_color_value)
		end

	Icon_supplier: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_supplier_color_value)
		end

	Icon_inherit: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_inherit_color_value)
		end

	Icon_display_labels: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_display_labels_color_value)
		end

	Icon_display_uml: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_uml_color_value)
		end

	Icon_display_clusters: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_display_cluster_color_value)
		end

	Icon_remove_anchor: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_remove_anchor_color_value)
		end

	Icon_toggle_force_directed: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_toggle_force_color_value)
		end

	Icon_force_settings: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_force_settings_color_value)
		end

	Icon_toggle_clusters: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_toggle_clusters_color_value)
		end

	Icon_class_header: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_class_header_color_value)
		end

	Icon_toggle_quality: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_toggle_quality_color_value)
		end

	Icon_super_cluster: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_super_cluster_color_value)
		end

	Icon_center_diagram: EV_PIXMAP is
		once
			Result :=  pixmap_from_constant (icon_center_diagram_color_value)
		end

	Icon_delete_view: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_delete_view_color_value)
		end
	Icon_reset_view: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_reset_view_color_value)
		end

	Icon_export_to_png: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_export_to_png_color_value)
		end

	Icon_delete_small: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_delete_small_color_value)
		end

	Icon_delete_measure: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_delete_measure_color_value)
		end

	Icon_remove_exported_feature: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_remove_exported_feature_color_value)
		end

	Icon_set_arguments: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_set_arguments_color_value)
		end

	Icon_crop: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_crop_color_value)
		end

	Icon_restore_view: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_restore_view_color_value)
		end

	Icon_fill_cluster: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_fill_cluster_color_value)
		end

	Icon_link_tool: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_straight_arrows_color_value)
		end

	Icon_reset_diagram: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_reset_diagram_color_value)
		end

	Icon_zoom_in: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_zoom_in_color_value)
		end

	Icon_zoom_out: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_zoom_out_color_value)
		end

	Icon_fit_to_screen: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_fit_to_screen_color_value)
		end

	Icon_select_depth: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_select_depth_color_value)
		end

	Icon_display_legend: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_display_legend_color_value)
		end

	Icon_pin_legend_open: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_pin_open_color_value)
		end

	Icon_pin_legend_closed: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_pin_closed_color_value)
		end

	Icon_recycle_bin: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_recycle_bin_color_value)
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

	Icon_bon_anchor: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_anchor_color_value)
		end

	Icon_system: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_system_color_value)
		end

	Icon_system_window: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_system_color_value)
		end

	Icon_green_arrow: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_green_arrow_value)
		end

	Icon_arrow_empty: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_arrow_empty_value)
		end

	Icon_green_tick: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_green_tick_value)
		end

	Icon_red_cross: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_red_cross_value)
		end

	Icon_print: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_print_color_value)
		end

	Icon_word_wrap_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_word_wrap_color_value)
		end

	Icon_auto_slice_limits_color: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_auto_slice_limits_color_value)
		end

	Icon_input_to_process: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_input_to_process_color_value)
		end

	Icon_add_new_external_cmd: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_add_new_external_cmd_color_value)
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
			create Result.make_with_values (16, 13)
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
			Result.add_pixmap (10, 1, icon_class_symbol_color_value)
			Result.add_pixmap (11, 1, icon_class_symbol_color_value)
			Result.add_pixmap (12, 1, icon_class_symbol_gray_value)
			Result.add_pixmap (13, 1, icon_cluster_symbol_color_value)
			Result.add_pixmap (14, 1, icon_cluster_tool_color_value)
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
			Result.add_pixmap (12, 2, icon_deferred_class_symbol_color_value)
			Result.add_pixmap (13, 2, icon_deferred_feature_value)
			Result.add_pixmap (14, 2, icon_light_deferred_class_color_value)
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
			Result.add_pixmap (5, 8, icon_light_class_color_value)
			Result.add_pixmap (6, 8, icon_light_class_gray_value)
			Result.add_pixmap (7, 8, icon_light_cluster_color_value)
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
			Result.add_pixmap (14, 12, icon_input_to_process_color_value)
			Result.add_pixmap (15, 12, icon_add_new_external_cmd_color_value)
			Result.add_pixmap (16, 12, icon_save_all_color_value)
			Result.add_pixmap (1, 13, icon_new_tab_color_value)
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
			icon_cluster_tool_color_value,
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
			icon_new_tab_color_value: INTEGER is unique;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

