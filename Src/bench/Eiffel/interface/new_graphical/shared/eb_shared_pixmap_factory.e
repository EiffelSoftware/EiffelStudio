indexing
	description: "Factory for all of the pixmapped graphics"
	author: "king"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SHARED_PIXMAP_FACTORY

feature

	pixmap_file_content (fn: STRING): EV_PIXMAP is
			-- Load a pixmap with name `fn'
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
			a_coord: TUPLE [INTEGER, INTEGER]
			a_row, a_column, a_x_offset, a_y_offset: INTEGER
			a_icon_matrix: EV_PIXMAP_I
		do
			if not retried then
				a_coord := pixmap_lookup @ fn
				if a_coord /= Void then
						-- We are looking up a 16 by 16 icon
					a_column := a_coord.integer_32_item (2)
					a_row := a_coord.integer_32_item (1)
					a_icon_matrix ?= studio_icon_matrix.implementation
					a_x_offset := (a_column - 1) * (1 + 16) + 1
					a_y_offset := (a_row - 1) * (1 + 16) + 1
					Result := a_icon_matrix.sub_pixmap (create {EV_RECTANGLE}.make (a_x_offset, a_y_offset, 16, 16))
				else
						-- Initialize the pathname & load the file
					create Result
					create full_path.make_from_string (pixmap_path)
					full_path.set_file_name (fn)
					full_path.add_extension (Pixmap_suffix)
					Result.set_with_named_file (full_path)
				end
			else
				create warning_dialog.make_with_text (
					"Cannot read pixmap file:%N" + full_path + ".%N%
					%Please make sure the installation is not corrupted.")
				warning_dialog.show
				create Result.make_with_size (16, 16) -- Default pixmap size
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Update

	Pixmap_suffix: STRING is "png"
			-- Suffix for pixmaps.

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the Studio pixmaps
		deferred
		end

	studio_icon_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the present icons
		once
			Result := pixmap_file_content ("studio_icon_matrix")
		end

	cursor_offset: INTEGER is 14
		-- Row Offset of cursors in icon matrix pixmap

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for Studio pixmaps
		once
			create Result.make (256)
				-- Icons
			Result.put ([1, 1], "icon_add_exported_feature_color")
			Result.put ([1, 2], "icon_stopped")
			Result.put ([1, 3], "icon_attribute_symbol")
			Result.put ([1, 4], "icon_auto_slice_limits_color")
			Result.put ([1, 5], "icon_back_color")
			Result.put ([1, 6], "icon_bkpt_info_color")
			Result.put ([1, 7], "icon_center_diagram_color")
			Result.put ([1, 8], "icon_check_exports_color")
			Result.put ([1, 9], "icon_class_header_color")
			Result.put ([1, 10], "icon_class_symbol_color")
			Result.put ([1, 11], "icon_class_symbol_color")
			Result.put ([1, 12], "icon_class_symbol_gray")
			Result.put ([1, 13], "icon_cluster_symbol_color")
			Result.put ([1, 14], "icon_cluster_tool_color")
			Result.put ([1, 15], "icon_cmd_history_color")
			Result.put ([1, 16], "icon_color_color")
			Result.put ([2, 1], "icon_compilation_error")
			Result.put ([2, 2], "icon_compiled")
			Result.put ([2, 3], "icon_compile_color")
			Result.put ([2, 4], "icon_compiling_1")
			Result.put ([2, 5], "icon_compiling_2")
			Result.put ([2, 6], "icon_compiling_3")
			Result.put ([2, 7], "icon_compiling_4")
			Result.put ([2, 8], "icon_context_tool_color")
			Result.put ([2, 9], "icon_copy_color")
			Result.put ([2, 10], "icon_crop_color")
			Result.put ([2, 11], "icon_cut_color")
			Result.put ([2, 12], "icon_deferred_class_symbol_color")
			Result.put ([2, 13], "icon_deferred_feature")
			Result.put ([2, 14], "icon_light_deferred_class_color")
			Result.put ([2, 15], "icon_delete_measure_color")
			Result.put ([2, 16], "icon_delete_small_color")
			Result.put ([3, 1], "icon_delete_view_color")
			Result.put ([3, 2], "icon_development_window")
			Result.put ([3, 3], "icon_dialog_window")
			Result.put ([3, 4], "icon_disable_bkpt_color")
			Result.put ([3, 5], "icon_display_labels_color")
			Result.put ([3, 6], "icon_dotnet_import_color")
			Result.put ([3, 7], "icon_dynamiclib_window")
			Result.put ([3, 8], "icon_edit_exported_feature_color")
			Result.put ([3, 9], "icon_editing")
			Result.put ([3, 10], "icon_enable_bkpt_color")
			Result.put ([3, 11], "icon_exec_quit_color")
			Result.put ([3, 12], "icon_exec_quit_color")
			Result.put ([3, 13], "icon_exec_step_color")
			Result.put ([3, 14], "icon_exec_stop_color")
			Result.put ([3, 15], "icon_expanded_object")
			Result.put ([3, 16], "icon_export_to_png_color")
			Result.put ([4, 1], "icon_stopped")
			Result.put ([4, 2], "icon_external_feature")
			Result.put ([4, 3], "icon_external_symbol")
			Result.put ([4, 4], "icon_favorites_color")
			Result.put ([4, 5], "icon_favorites_folder_color")
			Result.put ([4, 6], "icon_feature_color")
			Result.put ([4, 7], "icon_feature_clause_any")
			Result.put ([4, 8], "icon_feature_clause_none")
			Result.put ([4, 9], "icon_feature_clause_some")
			Result.put ([4, 10], "icon_features_color")
			Result.put ([4, 11], "icon_fill_cluster_color")
			Result.put ([4, 12], "icon_finalize_color")
			Result.put ([4, 13], "icon_del_bkpt_color")
			Result.put ([4, 14], "icon_format_ancestors_color")
			Result.put ([4, 15], "icon_format_attributes_color")
			Result.put ([4, 16], "icon_format_clickable_color")
			Result.put ([5, 1], "icon_format_clients_color")
			Result.put ([5, 2], "icon_format_contract_color")
			Result.put ([5, 3], "icon_format_deferreds_color")
			Result.put ([5, 4], "icon_format_descendants_color")
			Result.put ([5, 5], "icon_format_exporteds_color")
			Result.put ([5, 6], "icon_format_externals_color")
			Result.put ([5, 7], "icon_format_feature_ancestors_color")
			Result.put ([5, 8], "icon_format_feature_callers_color")
			Result.put ([5, 9], "icon_format_feature_descendants_color")
			Result.put ([5, 10], "icon_format_feature_homonyms_color")
			Result.put ([5, 11], "icon_format_feature_implementers_color")
			Result.put ([5, 12], "icon_format_flat_color")
			Result.put ([5, 13], "icon_format_interface_color")
			Result.put ([5, 14], "icon_format_onces_color")
			Result.put ([5, 15], "icon_format_routines_color")
			Result.put ([5, 16], "icon_format_suppliers_color")
			Result.put ([6, 1], "icon_format_text_color")
			Result.put ([6, 2], "icon_forth_color")
			Result.put ([6, 3], "icon_freeze_color")
			Result.put ([6, 4], "icon_green_arrow")
			Result.put ([6, 5], "icon_green_tick")
			Result.put ([6, 6], "icon_help_tool_color")
			Result.put ([6, 7], "icon_immediate_value")
			Result.put ([6, 8], "icon_inherit_color")
			Result.put ([6, 9], "icon_straight_arrows_color")
			Result.put ([6, 10], "icon_minimize_all_color")
			Result.put ([6, 11], "icon_new_agg_supplier_color")
			Result.put ([6, 12], "icon_new_class_color")
			Result.put ([6, 13], "icon_new_cluster_color")
			Result.put ([6, 14], "icon_new_context_window_color")
			Result.put ([6, 15], "icon_new_development_tool_color")
			Result.put ([6, 16], "icon_new_dynamic_lib_color")
			Result.put ([7, 1], "icon_new_editor_color")
			Result.put ([7, 2], "icon_new_feature_color")
			Result.put ([7, 3], "icon_new_inherit_color")
			Result.put ([7, 4], "icon_new_measure_color")
			Result.put ([7, 5], "icon_new_metric_color")
			Result.put ([7, 6], "icon_new_supplier_color")
			Result.put ([7, 7], "icon_no_stop_color")
			Result.put ([7, 8], "icon_exe_up_to_date")
			Result.put ([7, 9], "icon_object_symbol")
			Result.put ([7, 10], "icon_once_symbol")
			Result.put ([7, 11], "icon_open_file_color")
			Result.put ([7, 12], "icon_past_color")
			Result.put ([7, 13], "icon_preference_window")
			Result.put ([7, 14], "icon_pretty_print_16")
			Result.put ([7, 15], "icon_print_color")
			Result.put ([7, 16], "icon_profiler_window")
			Result.put ([8, 1], "icon_progress_dialog")
			Result.put ([8, 2], "icon_quick_compile_color")
			Result.put ([8, 3], "icon_restore_all_color")
			Result.put ([8, 4], "icon_restore_all_color")
			Result.put ([8, 5], "icon_light_class_color")
			Result.put ([8, 6], "icon_light_class_gray")
			Result.put ([8, 7], "icon_light_cluster_color")
			Result.put ([8, 8], "icon_recycle_bin_color")
			Result.put ([8, 9], "icon_red_cross")
			Result.put ([8, 10], "icon_redo_color")
			Result.put ([8, 11], "icon_remove_exported_feature_color")
			Result.put ([8, 12], "icon_reset_diagram_color")
			Result.put ([8, 13], "icon_restore_view_color")
			Result.put ([8, 14], "icon_run_color")
			Result.put ([8, 15], "icon_debug_run_color")
			Result.put ([8, 16], "icon_debug_run_continue_color")
			Result.put ([9, 1], "icon_running_1")
			Result.put ([9, 2], "icon_running_2")
			Result.put ([9, 3], "icon_running_3")
			Result.put ([9, 4], "icon_save_color")
			Result.put ([9, 5], "icon_save_measure_color")
			Result.put ([9, 6], "icon_search_color")
			Result.put ([9, 7], "icon_select_depth_color")
			Result.put ([9, 8], "icon_select_metrics_color")
			Result.put ([9, 9], "icon_send_stone_down_color")
			Result.put ([9, 10], "icon_set_arguments_color")
			Result.put ([9, 11], "icon_shell_color")
			Result.put ([9, 12], "icon_sorter_color")
			Result.put ([9, 13], "icon_static_external_symbol")
			Result.put ([9, 14], "icon_static_object_symbol")
			Result.put ([9, 15], "icon_step_into_color")
			Result.put ([9, 16], "icon_step_out_color")
			Result.put ([10, 1], "icon_super_cluster_color")
			Result.put ([10, 2], "icon_supplier_color")
			Result.put ([10, 3], "icon_system_color")
			Result.put ([10, 4], "icon_system_info_color")
			Result.put ([10, 5], "icon_system_color")
			Result.put ([10, 6], "icon_toggle_clusters_color")
			Result.put ([10, 7], "icon_toolbar_separator")
			Result.put ([10, 8], "icon_undo_color")
			Result.put ([10, 9], "icon_unify_stone_color")
			Result.put ([10, 10], "icon_view_measure_minus_color")
			Result.put ([10, 11], "icon_view_measure_plus_color")
			Result.put ([10, 12], "icon_void_pointer")
			Result.put ([10, 13], "icon_windows_color")
			Result.put ([10, 14], "icon_word_wrap_color")
			Result.put ([10, 15], "icon_zoom_in_color")
			Result.put ([10, 16], "icon_zoom_out_color")

				-- Cursors
			Result.put ([1 + cursor_offset, 1], "class")
			Result.put ([1 + cursor_offset, 2], "clientlnk")
			Result.put ([1 + cursor_offset, 3], "cluster")
			Result.put ([1 + cursor_offset, 4], "favorites_folder")
			Result.put ([1 + cursor_offset, 5], "feature")
			Result.put ([1 + cursor_offset, 6], "inheritlnk")
			Result.put ([1 + cursor_offset, 7], "interro")
			Result.put ([1 + cursor_offset, 8], "object")
			Result.put ([1 + cursor_offset, 9], "stopexec")
			Result.put ([1 + cursor_offset, 10], "Xclass")
			Result.put ([1 + cursor_offset, 11], "Xcluster")
			Result.put ([1 + cursor_offset, 12], "Xobject")
			Result.put ([1 + cursor_offset, 13], "Xfavorites_folder")
			Result.put ([1 + cursor_offset, 14], "Xfeature")
			Result.put ([1 + cursor_offset, 15], "Xinterro")
			Result.put ([1 + cursor_offset, 16], "Xobject")
			Result.put ([2 + cursor_offset, 1], "Xstopexec")			

			Result.compare_objects
		end

end -- class EB_SHARED_PIXMAP_FACTORY
