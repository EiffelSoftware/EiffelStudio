indexing
	description: "Pixmaps used in interface."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PIXMAPS

inherit
	EV_STOCK_PIXMAPS

	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Pngs

	Help_about_pixmap: EV_PIXMAP is
			-- Full path name and file title of PNG used in the help about window.
		local
			file_name: FILE_NAME
		once
			create file_name.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
			file_name.extend ("build")
			file_name.extend ("bitmaps")
			file_name.extend ("png")
			file_name.extend ("bm_about.png")
			create Result
			Result.set_with_named_file (file_name)
		end

--	bm_About: EV_PIXMAP is
--			-- Bitmap for the "About Dialog"
--		once
--			Result := pixmap_file_content ("bm_About")
--		end
--
--	bm_Wizard_blue: EV_PIXMAP is
--			-- Bitmap for the wizards
--		once
--			Result := pixmap_file_content ("bm_wizard_blue")
--		end
--
--	bm_Wizard_profiler_icon: EV_PIXMAP is
--			-- Icon Bitmap for the wizards
--		once
--			Result := pixmap_file_content ("bm_wizard_profiler_icon")
--		end
--
--	bm_Borland: EV_PIXMAP is
--			-- Bitmap for "About dialog" when Borland C++ is installed.
--		once
--			Result := pixmap_file_content ("borland_logo")
--		end
--
--feature -- Icons
--
--	Icon_dialog_window: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_dialog_window")
--		end
--
--	Icon_preference_window: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_preference_window")
--		end
--
--	Icon_format_feature_homonyms: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_feature_homonyms_color")
--		end
--
--	Icon_format_feature_implementers: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_feature_implementers_color")
--		end
--
--	Icon_format_feature_ancestors: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_feature_ancestors_color")
--		end
--
--	Icon_format_feature_descendants: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_feature_descendants_color")
--		end
--
--	Icon_format_feature_callers: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_feature_callers_color")
--		end
--
--	Icon_format_ancestors: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_ancestors_color")
--		end
--
--	Icon_format_descendants: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_descendants_color")
--		end
--
--	Icon_format_clients: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_clients_color")
--		end
--		
--	Icon_format_suppliers: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_suppliers_color")
--		end
--
--	Icon_format_externals: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_externals_color")
--		end
--
--	Icon_format_exporteds: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_exporteds_color")
--		end
--
--	Icon_format_deferreds: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_deferreds_color")
--		end
--
--	Icon_format_onces: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_onces_color")
--		end
--
--	Icon_format_attributes: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_attributes_color")
--		end
--
--	Icon_format_routines: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_routines_color")
--		end
--
--	Icon_format_text: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_text_color")
--		end
--
--	Icon_format_clickable: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_clickable_color")
--		end
--
--	Icon_format_flat: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_flat_color")
--		end
--
--	Icon_format_contract: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_contract_color")
--		end
--
--	Icon_format_interface: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_format_interface_color")
--		end
--
	Icon_object_symbol: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_object_symbol")
		end

--	Icon_once_objects: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_once_symbol")
--		end
--
--	Icon_attributes: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_attribute_symbol")
--		end
--
--	Icon_void_object: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_void_pointer")
--		end
--
--	Icon_dotnet_import: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("dotnet_import")
--		end
--
--	Icon_expanded_object: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_expanded_object")
--		end
--
--	Icon_immediate_value: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_immediate_value")
--		end
--
--	Icon_feature_clause_any: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_feature_clause_any")
--		end
--
--	Icon_feature_clause_some: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_feature_clause_some")
--		end
--
--	Icon_feature_clause_none: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_feature_clause_none")
--		end
--
--	Icon_nothing: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_nothing")
--		end
--		
--	Icon_down_triangle: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_down_triangle")
--		end
--
--	Icon_feature: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("feature")
--		end
--
--	Icon_toolbar_separator: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			create Result.make (1, 1)
--			Result.put (pixmap_file_content ("icon_toolbar_separator"), 1)
--		end
--
--	Icon_compile: ARRAY [EV_PIXMAP] is
--			-- Icon for "Melt project" command.
--		once
--			Result := build_text_pixmap ("compile")
--		end
--
--	Icon_finalize: ARRAY [EV_PIXMAP] is
--			-- Icon for "Finalize project" command
--		once
--			Result := build_classic_pixmap ("finalize")
--		end
--
--	Icon_freeze: ARRAY [EV_PIXMAP] is
--			-- Icon for "Freeze project" command
--		once
--			Result := build_classic_pixmap ("freeze")
--		end
--
--	Icon_system_info: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("system_info")
--		end
--
--	Icon_unify_stone: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("unify_stone")
--		end
--
--	Icon_send_stone_down: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("send_stone_down")
--		end
--
--	Icon_open_file: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("open_file")
--		end
--
--	Icon_wizard_precompile: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("wizard_precompile")
--		end
--
--	Icon_run: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("run")
--		end
--
--	Icon_run_debug: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_text_pixmap ("debug_run")
--		end
--		
--	Icon_save_call_stack: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_classic_pixmap ("save_call_stack")
--		end
--
--	Icon_cluster_tool: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_text_pixmap ("cluster_tool")
--		end
--
--	Icon_context_tool: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_text_pixmap ("context_tool")
--		end
--
--	Icon_cut: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("cut")
--		end
--
--	Icon_copy: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("copy")
--		end
--
--	Icon_paste: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("past")
--		end
--
--	Icon_search: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_text_pixmap ("search")
--		end
--
--	Icon_view_small: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("view_small")
--		end
--
--	Icon_windows: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_text_pixmap ("windows")
--		end
--
--	Icon_favorites: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_text_pixmap ("favorites")
--		end
--
--	Icon_features: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_text_pixmap ("features")
--		end
--
--	Icon_help_tool: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--			-- Color with explaining text is at index 3, gray with explaining text at index 4
--		once
--			Result := build_classic_pixmap ("help_tool")
--		end
--
--
	Icon_save: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("save")
		end

--	Icon_save_measure: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("save_measure")
--		end
--
--	Icon_view_measure_minus: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("view_measure_minus")
--		end
--
--	Icon_view_measure_plus: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("view_measure_plus")
--		end
--
--	Icon_view_measure: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("view_measure")
--		end
--
	Icon_undo: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("undo")
		end

	Icon_cmd_history: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("cmd_history")
		end

	Icon_redo: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("redo")
		end

--	Icon_shell: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("shell")
--		end
--
--	Icon_new_development_tool: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_development_tool")
--		end
--
	Icon_new_editor: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("new_editor")
		end

--	Icon_new_context_tool: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_context_window")
--		end
--
--	Icon_new_dynamic_lib: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_dynamic_lib")
--		end
--
--	Icon_new_small: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_small")
--		end
--
--	Icon_new_cluster_small: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_cluster_small")
--		end
--
--	Icon_new_class_small: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_class_small")
--		end
--
--	Icon_new_cluster: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_cluster")
--		end
--
	Icon_new_class: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("new_class")
		end

--	Icon_new_feature_small: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_feature_small")
--		end
--
--	Icon_close: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("close")
--		end
--
--	Icon_minimize_all: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("minimize_all")
--		end
--
--	Icon_new_measure: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("new_measure")
--		end
--
--
--	Icon_raise_all: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("restore_all")
--		end
--
--	Icon_raise_all_unsaved: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("restore_all")
--		end
--
--	Icon_add_exported_feature: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("add_exported_feature")
--		end
--
--	Icon_edit_exported_feature: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("edit_exported_feature")
--		end
--
--	Icon_check_exports: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("check_exports")
--		end
--
--	Icon_exec_step: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("exec_step")
--		end
--
--	Icon_step_into: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("step_into")
--		end
--
--	Icon_step_out: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("step_out")
--		end
--
--	Icon_exec_quit: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("exec_quit")
--		end
--
--	Icon_exec_stop: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("exec_stop")
--		end
--
--	Icon_no_stop: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("no_stop")
--		end
--
--	Icon_minimize: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("minimize")
--		end
--
--	Icon_maximize: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("maximize")
--		end
--
--	Icon_restore: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("restore")
--		end
--
--	Icon_back: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("back")
--		end
--
--	Icon_forth: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("forth")
--		end
--
--	Icon_mini_back: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("mini_back")
--		end
--
--	Icon_mini_forth: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("mini_forth")
--		end
--
--	Icon_class_symbol: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("class_symbol")
--		end
--
--	Icon_class_symbol_color: EV_PIXMAP is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := pixmap_file_content ("icon_class_symbol_color")
--		end
--
--	Icon_class_symbol_gray: EV_PIXMAP is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := pixmap_file_content ("icon_class_symbol_gray")
--		end
--
--	Icon_read_only_class_color: EV_PIXMAP is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := pixmap_file_content ("icon_light_class_color")
--		end
--
--	Icon_read_only_class_gray: EV_PIXMAP is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := pixmap_file_content ("icon_light_class_gray")
--		end
--
--	Icon_read_only_cluster: EV_PIXMAP is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := pixmap_file_content ("icon_light_cluster_color")
--		end
--
--	Icon_favorites_folder: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("favorites_folder")
--		end
--
--	Icon_cluster_symbol: ARRAY [EV_PIXMAP] is
--			-- Array containing both the color & the gray pixmap
--			-- Color is at index 1, gray at index 2
--		once
--			Result := build_classic_pixmap ("cluster_symbol")
--		end
--
--	Icon_development_window: EV_PIXMAP is
--			-- Pixmap representing a development window
--		once
--			Result := pixmap_file_content ("icon_development_window")
--		end
--
--	Icon_profiler_window: EV_PIXMAP is
--			-- Pixmap representing a profiler window
--		once
--			Result := pixmap_file_content ("icon_profiler_window")
--		end
--
--	Icon_dynamiclib_window: EV_PIXMAP is
--			-- Pixmap representing a dynamic library builder window
--		once
--			Result := pixmap_file_content ("icon_dynamiclib_window")
--		end
--
--	Icon_progress_dialog: EV_PIXMAP is
--			-- Pixmap representing a dynamic library builder window
--		once
--			Result := pixmap_file_content ("icon_progress_dialog")
--		end
--
--	Icon_bpslot: ARRAY [EV_PIXMAP] is
--		once
--				-- Read the pixmaps 
--			create Result.make (1,3)
--			Result.put (pixmap_file_content ("icon_bpslot"), 1)
--			Result.put (pixmap_file_content ("icon_bpslot_stopped"), 2)
--			Result.put (pixmap_file_content ("icon_bpslot_top"), 3)
--		end
--
--	Icon_bpenabled: ARRAY [EV_PIXMAP] is
--		once
--				-- Read the pixmaps 
--			create Result.make (1,3)
--			Result.put (pixmap_file_content ("icon_bpenabled"), 1)
--			Result.put (pixmap_file_content ("icon_bpenabled_stopped"), 2)
--			Result.put (pixmap_file_content ("icon_bpenabled_top"), 3)
--		end
--
--	Icon_bpdisabled: ARRAY [EV_PIXMAP] is
--		once
--				-- Read the pixmaps 
--			create Result.make (1,3)
--			Result.put (pixmap_file_content ("icon_bpdisabled"), 1)
--			Result.put (pixmap_file_content ("icon_bpdisabled_stopped"), 2)
--			Result.put (pixmap_file_content ("icon_bpdisabled_top"), 3)
--		end
--
--	Icon_enable_bkpt: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("enable_bkpt")
--		end
--
--	Icon_disable_bkpt: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("disable_bkpt")
--		end
--
--	Icon_forget_bkpt: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("del_bkpt")
--		end
--
--	Icon_bkpt_info: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("bkpt_info")
--		end
--
--	Icon_new_feature: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("new_feature")
--		end
--
--	Icon_color: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("color")
--		end
--
--	Icon_new_supplier: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("new_supplier")
--		end
--
--	Icon_new_aggregate_supplier: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("new_agg_supplier")
--		end
--
--	Icon_new_inherit: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("new_inherit")
--		end
--
--	Icon_supplier: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("supplier")
--		end
--
--	Icon_inherit: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("inherit")
--		end
--
--	Icon_display_labels: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("display_labels")
--		end
--
--	Icon_toggle_clusters: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("toggle_clusters")
--		end
--
--	Icon_class_header: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("class_header")
--		end
--
--	Icon_super_cluster: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("super_cluster")
--		end
--
--	Icon_center_diagram: ARRAY [EV_PIXMAP] is
--		once
--			Result :=  build_classic_pixmap ("center_diagram")
--		end
--
--	Icon_delete_view: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("delete_view")
--		end
--
--	Icon_export_to_png: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("export_to_png")
--		end
--
	Icon_delete_small: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("delete_small")
		end

--	Icon_delete_very_small: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("delete_very_small")
--		end
--
--	Icon_delete_measure: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("delete_measure")
--		end
--
--	Icon_remove_exported_feature: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("remove_exported_feature")
--		end
--
--	Icon_set_arguments: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("set_arguments")
--		end
--
--	Icon_slice_limits_vsmall: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("slice_limits_vsmall")
--		end
--
--	Icon_pretty_print: EV_PIXMAP is
--			-- Icon for the dialog that display expanded value of objects.
--		once
--			Result := pixmap_file_content ("icon_pretty_print_16")
--		end
--
--	Icon_pretty_print_vsmall: ARRAY [EV_PIXMAP] is
--			-- Icon for the dialog that display expanded value of objects.
--		once
--			create Result.make (1, 2)
--			Result.put (pixmap_file_content ("icon_pretty_print_8"), 1)
--			Result.put (pixmap_file_content ("icon_pretty_print_8"), 2)
--		end
--
--	Icon_crop: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("crop")
--		end
--
--	Icon_restore_view: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("restore_view")
--		end
--
--	Icon_fill_cluster: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("fill_cluster")
--		end
--
--	Icon_link_tool: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("straight_arrows")
--		end
--
--	Icon_reset_diagram: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("reset_diagram")
--		end
--
--	Icon_zoom_in: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("zoom_in")
--		end
--
--	Icon_zoom_out: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("zoom_out")
--		end
--
--	Icon_select_depth: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("select_depth")
--		end
--
--	Icon_recycle_bin: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("recycle_bin")
--		end
--
--	Icon_new_metric: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("new_metric")
--		end
--
--	Icon_select_metrics: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("select_metrics")
--		end
--
--	Icon_sorter: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("sorter")
--		end
--
--	Icon_bon_deferred: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_bon_deferred")
--		end
--
--	Icon_bon_effective: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_bon_effective")
--		end
--
--	Icon_bon_interfaced: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_bon_interfaced")
--		end
--
--	Icon_bon_persistent: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_bon_persistent")
--		end
--
--	Icon_system: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("system")
--		end
--
	Icon_system_window: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_system_color")
		end

--	Icon_green_arrow: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_green_arrow")
--		end
--
--	Icon_green_tick: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_green_tick")
--		end
--
--	Icon_red_cross: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_red_cross")
--		end
--
--	Icons_progress_degree: ARRAY [EV_PIXMAP] is
--			-- Icons representing a thermometer a different temperatures.
--		local
--			i: INTEGER
--		once
--			create Result.make (-3, 6)
--			from
--				i := -3
--			until
--				i > 6
--			loop
--				Result.put (pixmap_file_content ("icon_degree"+i.out), i)
--				i := i + 1
--			end
--		end
--
--	Icon_wizard_blank_project: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_wizard_blank_project")
--		end
--
--	Icon_wizard_project: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_wizard_project")
--		end
--
--	Icon_wizard_ace_project: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_wizard_ace_project")
--		end
--
--	Icon_open_project: EV_PIXMAP is
--		once
--			Result := pixmap_file_content ("icon_open_project")
--		end
--
--	Icon_print: ARRAY [EV_PIXMAP] is
--		once
--			Result := build_classic_pixmap ("print")
--		end

feature -- Reading

	pixmap_file_content (fn: STRING): EV_PIXMAP is
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
		do
				-- Create the pixmap
			create Result

			if not retried then
					-- Initialize the pathname & load the file
				if
					-- |FIXME
					True --Platform_constants.is_windows and then
					--fn.substring_index ("icon_", 1) = 1
				then
					create full_path.make_from_string (Icon_path)
					full_path.set_file_name (fn)
					full_path.add_extension ("ico")
				else
					create full_path.make_from_string (Bitmap_path)
					full_path.set_file_name (fn)
					full_path.add_extension (Pixmap_suffix)
				end
				Result.set_with_named_file (full_path)
			else
				create warning_dialog.make_with_text (
					"Cannot read pixmap file:%N" + full_path + ".%N%
					%Please make sure the installation is not corrupted.")
				warning_dialog.show
				Result.set_size (16, 16) -- Default pixmap size
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Update

	Pixmap_suffix: STRING is "png"
			-- Suffix for pixmaps.

	Bitmap_path: DIRECTORY_NAME is
			-- Path for Bmp/Xpm for Windows/Unix.
		once
			create Result.make_from_string ((create {EIFFEL_ENV}).Bitmaps_path)
			Result.extend (Pixmap_suffix)
		end

	Icon_path: DIRECTORY_NAME is
			-- Path for Icons for Windows.
		once
			create Result.make_from_string ((create {EIFFEL_ENV}).Bitmaps_path)
			Result.extend ("ico")
		end

	build_classic_pixmap (pixmap_name: STRING): ARRAY [EV_PIXMAP] is
			-- Build an array of 2 pixmaps. The first pixmap is the
			-- colored pixmap, the second is the corresponding gray pixmap.
			--
			-- `pixmap_name' is the core name of the pixmap.
		do
				-- Read the pixmaps 
			create Result.make (1,1)
			Result.put (pixmap_file_content ("icon_" + pixmap_name + "_color"), 1)
		ensure
			result_valid: Result /= Void and then Result.count = 1
		end

	build_text_pixmap (pixmap_name: STRING): ARRAY [EV_PIXMAP] is
			-- Build an array of 4 pixmaps. The first pixmap is the
			-- colored pixmap, the second is the corresponding gray pixmap.
			-- The third is a colored pixmap with some explaining text and
			-- the forth is the grayed version of the third.
			--
			-- `pixmap_name' is the core name of the pixmap.
		do
				-- Read the pixmaps 
			create Result.make (1,2)
			Result.put (pixmap_file_content ("icon_" + pixmap_name + "_color"), 1)
			Result.put (pixmap_file_content ("icon_" + pixmap_name + "_text_color"), 2)
		ensure
			result_valid: Result /= Void and then Result.count = 2
		end

end -- Class GB_SHARED_PIXMAPS
