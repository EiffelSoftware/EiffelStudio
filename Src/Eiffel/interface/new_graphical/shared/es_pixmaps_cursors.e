note
	description: "[
		Automatically generated class for EiffelStudio 32x32 icons.
	]"
	generator: "Eiffel Matrix Generator"
	command_line: "emcgen.exe \work\64dev\Delivery\studio\bitmaps\png\cursors.ini -f \work\64dev\tools\eiffel_matrix_code_generator\frames\studio.e.frame"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PIXMAPS_CURSORS

inherit
	ES_PIXMAPS
		redefine
			matrix_pixel_border
		end

create
	make

feature -- Access

	icon_width: NATURAL_8 = 32
			-- <Precursor>

	icon_height: NATURAL_8 = 32
			-- <Precursor>

	width: NATURAL_8 = 17
			-- <Precursor>

	height: NATURAL_8 = 4
			-- <Precursor>

feature {NONE} -- Access

	matrix_pixel_border: NATURAL_8 = 1
			-- <Precursor>

feature -- Icons
	
	frozen context_cluster_cursor: EV_PIXMAP
			-- Access to 'cluster' pixmap.
		require
			has_named_icon: has_named_icon (context_cluster_name)
		once
			Result := named_icon (context_cluster_name)
		ensure
			context_cluster_cursor_attached: Result /= Void
		end

	frozen context_cluster_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'cluster' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_cluster_name)
		once
			Result := named_icon_buffer (context_cluster_name)
		ensure
			context_cluster_cursor_buffer_attached: Result /= Void
		end

	frozen context_favorite_cursor: EV_PIXMAP
			-- Access to 'favorite' pixmap.
		require
			has_named_icon: has_named_icon (context_favorite_name)
		once
			Result := named_icon (context_favorite_name)
		ensure
			context_favorite_cursor_attached: Result /= Void
		end

	frozen context_favorite_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'favorite' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_favorite_name)
		once
			Result := named_icon_buffer (context_favorite_name)
		ensure
			context_favorite_cursor_buffer_attached: Result /= Void
		end

	frozen context_class_cursor: EV_PIXMAP
			-- Access to 'class' pixmap.
		require
			has_named_icon: has_named_icon (context_class_name)
		once
			Result := named_icon (context_class_name)
		ensure
			context_class_cursor_attached: Result /= Void
		end

	frozen context_class_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'class' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_class_name)
		once
			Result := named_icon_buffer (context_class_name)
		ensure
			context_class_cursor_buffer_attached: Result /= Void
		end

	frozen context_feature_cursor: EV_PIXMAP
			-- Access to 'feature' pixmap.
		require
			has_named_icon: has_named_icon (context_feature_name)
		once
			Result := named_icon (context_feature_name)
		ensure
			context_feature_cursor_attached: Result /= Void
		end

	frozen context_feature_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'feature' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_feature_name)
		once
			Result := named_icon_buffer (context_feature_name)
		ensure
			context_feature_cursor_buffer_attached: Result /= Void
		end

	frozen context_client_link_cursor: EV_PIXMAP
			-- Access to 'client link' pixmap.
		require
			has_named_icon: has_named_icon (context_client_link_name)
		once
			Result := named_icon (context_client_link_name)
		ensure
			context_client_link_cursor_attached: Result /= Void
		end

	frozen context_client_link_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'client link' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_client_link_name)
		once
			Result := named_icon_buffer (context_client_link_name)
		ensure
			context_client_link_cursor_buffer_attached: Result /= Void
		end

	frozen context_inherit_link_cursor: EV_PIXMAP
			-- Access to 'inherit link' pixmap.
		require
			has_named_icon: has_named_icon (context_inherit_link_name)
		once
			Result := named_icon (context_inherit_link_name)
		ensure
			context_inherit_link_cursor_attached: Result /= Void
		end

	frozen context_inherit_link_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'inherit link' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_inherit_link_name)
		once
			Result := named_icon_buffer (context_inherit_link_name)
		ensure
			context_inherit_link_cursor_buffer_attached: Result /= Void
		end

	frozen context_debug_object_cursor: EV_PIXMAP
			-- Access to 'debug object' pixmap.
		require
			has_named_icon: has_named_icon (context_debug_object_name)
		once
			Result := named_icon (context_debug_object_name)
		ensure
			context_debug_object_cursor_attached: Result /= Void
		end

	frozen context_debug_object_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'debug object' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_debug_object_name)
		once
			Result := named_icon_buffer (context_debug_object_name)
		ensure
			context_debug_object_cursor_buffer_attached: Result /= Void
		end

	frozen context_metric_cursor: EV_PIXMAP
			-- Access to 'metric' pixmap.
		require
			has_named_icon: has_named_icon (context_metric_name)
		once
			Result := named_icon (context_metric_name)
		ensure
			context_metric_cursor_attached: Result /= Void
		end

	frozen context_metric_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'metric' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_metric_name)
		once
			Result := named_icon_buffer (context_metric_name)
		ensure
			context_metric_cursor_buffer_attached: Result /= Void
		end

	frozen context_criteria_cursor: EV_PIXMAP
			-- Access to 'criteria' pixmap.
		require
			has_named_icon: has_named_icon (context_criteria_name)
		once
			Result := named_icon (context_criteria_name)
		ensure
			context_criteria_cursor_attached: Result /= Void
		end

	frozen context_criteria_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'criteria' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_criteria_name)
		once
			Result := named_icon_buffer (context_criteria_name)
		ensure
			context_criteria_cursor_buffer_attached: Result /= Void
		end

	frozen context_classes_cursor: EV_PIXMAP
			-- Access to 'classes' pixmap.
		require
			has_named_icon: has_named_icon (context_classes_name)
		once
			Result := named_icon (context_classes_name)
		ensure
			context_classes_cursor_attached: Result /= Void
		end

	frozen context_classes_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'classes' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_classes_name)
		once
			Result := named_icon_buffer (context_classes_name)
		ensure
			context_classes_cursor_buffer_attached: Result /= Void
		end

	frozen context_help_cursor: EV_PIXMAP
			-- Access to 'help' pixmap.
		require
			has_named_icon: has_named_icon (context_help_name)
		once
			Result := named_icon (context_help_name)
		ensure
			context_help_cursor_attached: Result /= Void
		end

	frozen context_help_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'help' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_help_name)
		once
			Result := named_icon_buffer (context_help_name)
		ensure
			context_help_cursor_buffer_attached: Result /= Void
		end

	frozen context_debugger_step_cursor: EV_PIXMAP
			-- Access to 'debugger step' pixmap.
		require
			has_named_icon: has_named_icon (context_debugger_step_name)
		once
			Result := named_icon (context_debugger_step_name)
		ensure
			context_debugger_step_cursor_attached: Result /= Void
		end

	frozen context_debugger_step_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'debugger step' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_debugger_step_name)
		once
			Result := named_icon_buffer (context_debugger_step_name)
		ensure
			context_debugger_step_cursor_buffer_attached: Result /= Void
		end

	frozen context_library_cursor: EV_PIXMAP
			-- Access to 'library' pixmap.
		require
			has_named_icon: has_named_icon (context_library_name)
		once
			Result := named_icon (context_library_name)
		ensure
			context_library_cursor_attached: Result /= Void
		end

	frozen context_library_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'library' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_library_name)
		once
			Result := named_icon_buffer (context_library_name)
		ensure
			context_library_cursor_buffer_attached: Result /= Void
		end

	frozen context_precompile_cursor: EV_PIXMAP
			-- Access to 'precompile' pixmap.
		require
			has_named_icon: has_named_icon (context_precompile_name)
		once
			Result := named_icon (context_precompile_name)
		ensure
			context_precompile_cursor_attached: Result /= Void
		end

	frozen context_precompile_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'precompile' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_precompile_name)
		once
			Result := named_icon_buffer (context_precompile_name)
		ensure
			context_precompile_cursor_buffer_attached: Result /= Void
		end

	frozen context_assembly_cursor: EV_PIXMAP
			-- Access to 'assembly' pixmap.
		require
			has_named_icon: has_named_icon (context_assembly_name)
		once
			Result := named_icon (context_assembly_name)
		ensure
			context_assembly_cursor_attached: Result /= Void
		end

	frozen context_assembly_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'assembly' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_assembly_name)
		once
			Result := named_icon_buffer (context_assembly_name)
		ensure
			context_assembly_cursor_buffer_attached: Result /= Void
		end

	frozen context_namespace_cursor: EV_PIXMAP
			-- Access to 'namespace' pixmap.
		require
			has_named_icon: has_named_icon (context_namespace_name)
		once
			Result := named_icon (context_namespace_name)
		ensure
			context_namespace_cursor_attached: Result /= Void
		end

	frozen context_namespace_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'namespace' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_namespace_name)
		once
			Result := named_icon_buffer (context_namespace_name)
		ensure
			context_namespace_cursor_buffer_attached: Result /= Void
		end

	frozen context_target_cursor: EV_PIXMAP
			-- Access to 'target' pixmap.
		require
			has_named_icon: has_named_icon (context_target_name)
		once
			Result := named_icon (context_target_name)
		ensure
			context_target_cursor_attached: Result /= Void
		end

	frozen context_target_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'target' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_target_name)
		once
			Result := named_icon_buffer (context_target_name)
		ensure
			context_target_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_cluster_cursor: EV_PIXMAP
			-- Access to 'cluster' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_cluster_name)
		once
			Result := named_icon (context_disabled_cluster_name)
		ensure
			context_disabled_cluster_cursor_attached: Result /= Void
		end

	frozen context_disabled_cluster_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'cluster' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_cluster_name)
		once
			Result := named_icon_buffer (context_disabled_cluster_name)
		ensure
			context_disabled_cluster_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_favorite_cursor: EV_PIXMAP
			-- Access to 'favorite' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_favorite_name)
		once
			Result := named_icon (context_disabled_favorite_name)
		ensure
			context_disabled_favorite_cursor_attached: Result /= Void
		end

	frozen context_disabled_favorite_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'favorite' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_favorite_name)
		once
			Result := named_icon_buffer (context_disabled_favorite_name)
		ensure
			context_disabled_favorite_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_class_cursor: EV_PIXMAP
			-- Access to 'class' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_class_name)
		once
			Result := named_icon (context_disabled_class_name)
		ensure
			context_disabled_class_cursor_attached: Result /= Void
		end

	frozen context_disabled_class_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'class' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_class_name)
		once
			Result := named_icon_buffer (context_disabled_class_name)
		ensure
			context_disabled_class_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_feature_cursor: EV_PIXMAP
			-- Access to 'feature' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_feature_name)
		once
			Result := named_icon (context_disabled_feature_name)
		ensure
			context_disabled_feature_cursor_attached: Result /= Void
		end

	frozen context_disabled_feature_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'feature' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_feature_name)
		once
			Result := named_icon_buffer (context_disabled_feature_name)
		ensure
			context_disabled_feature_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_client_link_cursor: EV_PIXMAP
			-- Access to 'client link' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_client_link_name)
		once
			Result := named_icon (context_disabled_client_link_name)
		ensure
			context_disabled_client_link_cursor_attached: Result /= Void
		end

	frozen context_disabled_client_link_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'client link' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_client_link_name)
		once
			Result := named_icon_buffer (context_disabled_client_link_name)
		ensure
			context_disabled_client_link_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_inherit_link_cursor: EV_PIXMAP
			-- Access to 'inherit link' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_inherit_link_name)
		once
			Result := named_icon (context_disabled_inherit_link_name)
		ensure
			context_disabled_inherit_link_cursor_attached: Result /= Void
		end

	frozen context_disabled_inherit_link_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'inherit link' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_inherit_link_name)
		once
			Result := named_icon_buffer (context_disabled_inherit_link_name)
		ensure
			context_disabled_inherit_link_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_debug_object_cursor: EV_PIXMAP
			-- Access to 'debug object' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_debug_object_name)
		once
			Result := named_icon (context_disabled_debug_object_name)
		ensure
			context_disabled_debug_object_cursor_attached: Result /= Void
		end

	frozen context_disabled_debug_object_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'debug object' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_debug_object_name)
		once
			Result := named_icon_buffer (context_disabled_debug_object_name)
		ensure
			context_disabled_debug_object_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_metric_cursor: EV_PIXMAP
			-- Access to 'metric' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_metric_name)
		once
			Result := named_icon (context_disabled_metric_name)
		ensure
			context_disabled_metric_cursor_attached: Result /= Void
		end

	frozen context_disabled_metric_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'metric' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_metric_name)
		once
			Result := named_icon_buffer (context_disabled_metric_name)
		ensure
			context_disabled_metric_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_criteria_cursor: EV_PIXMAP
			-- Access to 'criteria' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_criteria_name)
		once
			Result := named_icon (context_disabled_criteria_name)
		ensure
			context_disabled_criteria_cursor_attached: Result /= Void
		end

	frozen context_disabled_criteria_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'criteria' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_criteria_name)
		once
			Result := named_icon_buffer (context_disabled_criteria_name)
		ensure
			context_disabled_criteria_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_classes_cursor: EV_PIXMAP
			-- Access to 'classes' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_classes_name)
		once
			Result := named_icon (context_disabled_classes_name)
		ensure
			context_disabled_classes_cursor_attached: Result /= Void
		end

	frozen context_disabled_classes_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'classes' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_classes_name)
		once
			Result := named_icon_buffer (context_disabled_classes_name)
		ensure
			context_disabled_classes_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_help_cursor: EV_PIXMAP
			-- Access to 'help' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_help_name)
		once
			Result := named_icon (context_disabled_help_name)
		ensure
			context_disabled_help_cursor_attached: Result /= Void
		end

	frozen context_disabled_help_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'help' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_help_name)
		once
			Result := named_icon_buffer (context_disabled_help_name)
		ensure
			context_disabled_help_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_debugger_step_cursor: EV_PIXMAP
			-- Access to 'debugger step' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_debugger_step_name)
		once
			Result := named_icon (context_disabled_debugger_step_name)
		ensure
			context_disabled_debugger_step_cursor_attached: Result /= Void
		end

	frozen context_disabled_debugger_step_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'debugger step' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_debugger_step_name)
		once
			Result := named_icon_buffer (context_disabled_debugger_step_name)
		ensure
			context_disabled_debugger_step_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_library_cursor: EV_PIXMAP
			-- Access to 'library' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_library_name)
		once
			Result := named_icon (context_disabled_library_name)
		ensure
			context_disabled_library_cursor_attached: Result /= Void
		end

	frozen context_disabled_library_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'library' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_library_name)
		once
			Result := named_icon_buffer (context_disabled_library_name)
		ensure
			context_disabled_library_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_precompile_cursor: EV_PIXMAP
			-- Access to 'precompile' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_precompile_name)
		once
			Result := named_icon (context_disabled_precompile_name)
		ensure
			context_disabled_precompile_cursor_attached: Result /= Void
		end

	frozen context_disabled_precompile_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'precompile' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_precompile_name)
		once
			Result := named_icon_buffer (context_disabled_precompile_name)
		ensure
			context_disabled_precompile_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_assembly_cursor: EV_PIXMAP
			-- Access to 'assembly' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_assembly_name)
		once
			Result := named_icon (context_disabled_assembly_name)
		ensure
			context_disabled_assembly_cursor_attached: Result /= Void
		end

	frozen context_disabled_assembly_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'assembly' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_assembly_name)
		once
			Result := named_icon_buffer (context_disabled_assembly_name)
		ensure
			context_disabled_assembly_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_namespace_cursor: EV_PIXMAP
			-- Access to 'namespace' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_namespace_name)
		once
			Result := named_icon (context_disabled_namespace_name)
		ensure
			context_disabled_namespace_cursor_attached: Result /= Void
		end

	frozen context_disabled_namespace_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'namespace' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_namespace_name)
		once
			Result := named_icon_buffer (context_disabled_namespace_name)
		ensure
			context_disabled_namespace_cursor_buffer_attached: Result /= Void
		end

	frozen context_disabled_target_cursor: EV_PIXMAP
			-- Access to 'target' pixmap.
		require
			has_named_icon: has_named_icon (context_disabled_target_name)
		once
			Result := named_icon (context_disabled_target_name)
		ensure
			context_disabled_target_cursor_attached: Result /= Void
		end

	frozen context_disabled_target_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'target' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (context_disabled_target_name)
		once
			Result := named_icon_buffer (context_disabled_target_name)
		ensure
			context_disabled_target_cursor_buffer_attached: Result /= Void
		end

	frozen cursor_hand_open_cursor: EV_PIXMAP
			-- Access to 'hand open' pixmap.
		require
			has_named_icon: has_named_icon (cursor_hand_open_name)
		once
			Result := named_icon (cursor_hand_open_name)
		ensure
			cursor_hand_open_cursor_attached: Result /= Void
		end

	frozen cursor_hand_open_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'hand open' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (cursor_hand_open_name)
		once
			Result := named_icon_buffer (cursor_hand_open_name)
		ensure
			cursor_hand_open_cursor_buffer_attached: Result /= Void
		end

	frozen cursor_hand_clasped_cursor: EV_PIXMAP
			-- Access to 'hand clasped' pixmap.
		require
			has_named_icon: has_named_icon (cursor_hand_clasped_name)
		once
			Result := named_icon (cursor_hand_clasped_name)
		ensure
			cursor_hand_clasped_cursor_attached: Result /= Void
		end

	frozen cursor_hand_clasped_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'hand clasped' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (cursor_hand_clasped_name)
		once
			Result := named_icon_buffer (cursor_hand_clasped_name)
		ensure
			cursor_hand_clasped_cursor_buffer_attached: Result /= Void
		end

	frozen cursor_move_cursor: EV_PIXMAP
			-- Access to 'move' pixmap.
		require
			has_named_icon: has_named_icon (cursor_move_name)
		once
			Result := named_icon (cursor_move_name)
		ensure
			cursor_move_cursor_attached: Result /= Void
		end

	frozen cursor_move_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'move' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (cursor_move_name)
		once
			Result := named_icon_buffer (cursor_move_name)
		ensure
			cursor_move_cursor_buffer_attached: Result /= Void
		end

	frozen cursor_copy_cursor: EV_PIXMAP
			-- Access to 'copy' pixmap.
		require
			has_named_icon: has_named_icon (cursor_copy_name)
		once
			Result := named_icon (cursor_copy_name)
		ensure
			cursor_copy_cursor_attached: Result /= Void
		end

	frozen cursor_copy_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'copy' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (cursor_copy_name)
		once
			Result := named_icon_buffer (cursor_copy_name)
		ensure
			cursor_copy_cursor_buffer_attached: Result /= Void
		end

	frozen docking_up_cursor: EV_PIXMAP
			-- Access to 'up' pixmap.
		require
			has_named_icon: has_named_icon (docking_up_name)
		once
			Result := named_icon (docking_up_name)
		ensure
			docking_up_cursor_attached: Result /= Void
		end

	frozen docking_up_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'up' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (docking_up_name)
		once
			Result := named_icon_buffer (docking_up_name)
		ensure
			docking_up_cursor_buffer_attached: Result /= Void
		end

	frozen docking_down_cursor: EV_PIXMAP
			-- Access to 'down' pixmap.
		require
			has_named_icon: has_named_icon (docking_down_name)
		once
			Result := named_icon (docking_down_name)
		ensure
			docking_down_cursor_attached: Result /= Void
		end

	frozen docking_down_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'down' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (docking_down_name)
		once
			Result := named_icon_buffer (docking_down_name)
		ensure
			docking_down_cursor_buffer_attached: Result /= Void
		end

	frozen docking_left_cursor: EV_PIXMAP
			-- Access to 'left' pixmap.
		require
			has_named_icon: has_named_icon (docking_left_name)
		once
			Result := named_icon (docking_left_name)
		ensure
			docking_left_cursor_attached: Result /= Void
		end

	frozen docking_left_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'left' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (docking_left_name)
		once
			Result := named_icon_buffer (docking_left_name)
		ensure
			docking_left_cursor_buffer_attached: Result /= Void
		end

	frozen docking_right_cursor: EV_PIXMAP
			-- Access to 'right' pixmap.
		require
			has_named_icon: has_named_icon (docking_right_name)
		once
			Result := named_icon (docking_right_name)
		ensure
			docking_right_cursor_attached: Result /= Void
		end

	frozen docking_right_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'right' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (docking_right_name)
		once
			Result := named_icon_buffer (docking_right_name)
		ensure
			docking_right_cursor_buffer_attached: Result /= Void
		end

	frozen docking_float_cursor: EV_PIXMAP
			-- Access to 'float' pixmap.
		require
			has_named_icon: has_named_icon (docking_float_name)
		once
			Result := named_icon (docking_float_name)
		ensure
			docking_float_cursor_attached: Result /= Void
		end

	frozen docking_float_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'float' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (docking_float_name)
		once
			Result := named_icon_buffer (docking_float_name)
		ensure
			docking_float_cursor_buffer_attached: Result /= Void
		end

	frozen docking_tabify_cursor: EV_PIXMAP
			-- Access to 'tabify' pixmap.
		require
			has_named_icon: has_named_icon (docking_tabify_name)
		once
			Result := named_icon (docking_tabify_name)
		ensure
			docking_tabify_cursor_attached: Result /= Void
		end

	frozen docking_tabify_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'tabify' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (docking_tabify_name)
		once
			Result := named_icon_buffer (docking_tabify_name)
		ensure
			docking_tabify_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_generic_cursor: EV_PIXMAP
			-- Access to 'generic' pixmap.
		require
			has_named_icon: has_named_icon (metrics_generic_name)
		once
			Result := named_icon (metrics_generic_name)
		ensure
			metrics_generic_cursor_attached: Result /= Void
		end

	frozen metrics_generic_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'generic' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_generic_name)
		once
			Result := named_icon_buffer (metrics_generic_name)
		ensure
			metrics_generic_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_feature_cursor: EV_PIXMAP
			-- Access to 'feature' pixmap.
		require
			has_named_icon: has_named_icon (metrics_feature_name)
		once
			Result := named_icon (metrics_feature_name)
		ensure
			metrics_feature_cursor_attached: Result /= Void
		end

	frozen metrics_feature_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'feature' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_feature_name)
		once
			Result := named_icon_buffer (metrics_feature_name)
		ensure
			metrics_feature_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_local_cursor: EV_PIXMAP
			-- Access to 'local' pixmap.
		require
			has_named_icon: has_named_icon (metrics_local_name)
		once
			Result := named_icon (metrics_local_name)
		ensure
			metrics_local_cursor_attached: Result /= Void
		end

	frozen metrics_local_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'local' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_local_name)
		once
			Result := named_icon_buffer (metrics_local_name)
		ensure
			metrics_local_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_assertion_cursor: EV_PIXMAP
			-- Access to 'assertion' pixmap.
		require
			has_named_icon: has_named_icon (metrics_assertion_name)
		once
			Result := named_icon (metrics_assertion_name)
		ensure
			metrics_assertion_cursor_attached: Result /= Void
		end

	frozen metrics_assertion_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'assertion' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_assertion_name)
		once
			Result := named_icon_buffer (metrics_assertion_name)
		ensure
			metrics_assertion_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_line_cursor: EV_PIXMAP
			-- Access to 'line' pixmap.
		require
			has_named_icon: has_named_icon (metrics_line_name)
		once
			Result := named_icon (metrics_line_name)
		ensure
			metrics_line_cursor_attached: Result /= Void
		end

	frozen metrics_line_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'line' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_line_name)
		once
			Result := named_icon_buffer (metrics_line_name)
		ensure
			metrics_line_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_disabled_generic_cursor: EV_PIXMAP
			-- Access to 'generic' pixmap.
		require
			has_named_icon: has_named_icon (metrics_disabled_generic_name)
		once
			Result := named_icon (metrics_disabled_generic_name)
		ensure
			metrics_disabled_generic_cursor_attached: Result /= Void
		end

	frozen metrics_disabled_generic_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'generic' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_disabled_generic_name)
		once
			Result := named_icon_buffer (metrics_disabled_generic_name)
		ensure
			metrics_disabled_generic_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_disabled_feature_cursor: EV_PIXMAP
			-- Access to 'feature' pixmap.
		require
			has_named_icon: has_named_icon (metrics_disabled_feature_name)
		once
			Result := named_icon (metrics_disabled_feature_name)
		ensure
			metrics_disabled_feature_cursor_attached: Result /= Void
		end

	frozen metrics_disabled_feature_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'feature' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_disabled_feature_name)
		once
			Result := named_icon_buffer (metrics_disabled_feature_name)
		ensure
			metrics_disabled_feature_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_disabled_local_cursor: EV_PIXMAP
			-- Access to 'local' pixmap.
		require
			has_named_icon: has_named_icon (metrics_disabled_local_name)
		once
			Result := named_icon (metrics_disabled_local_name)
		ensure
			metrics_disabled_local_cursor_attached: Result /= Void
		end

	frozen metrics_disabled_local_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'local' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_disabled_local_name)
		once
			Result := named_icon_buffer (metrics_disabled_local_name)
		ensure
			metrics_disabled_local_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_disabled_assertion_cursor: EV_PIXMAP
			-- Access to 'assertion' pixmap.
		require
			has_named_icon: has_named_icon (metrics_disabled_assertion_name)
		once
			Result := named_icon (metrics_disabled_assertion_name)
		ensure
			metrics_disabled_assertion_cursor_attached: Result /= Void
		end

	frozen metrics_disabled_assertion_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'assertion' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_disabled_assertion_name)
		once
			Result := named_icon_buffer (metrics_disabled_assertion_name)
		ensure
			metrics_disabled_assertion_cursor_buffer_attached: Result /= Void
		end

	frozen metrics_disabled_line_cursor: EV_PIXMAP
			-- Access to 'line' pixmap.
		require
			has_named_icon: has_named_icon (metrics_disabled_line_name)
		once
			Result := named_icon (metrics_disabled_line_name)
		ensure
			metrics_disabled_line_cursor_attached: Result /= Void
		end

	frozen metrics_disabled_line_cursor_buffer: EV_PIXEL_BUFFER
			-- Access to 'line' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (metrics_disabled_line_name)
		once
			Result := named_icon_buffer (metrics_disabled_line_name)
		ensure
			metrics_disabled_line_cursor_buffer_attached: Result /= Void
		end

feature -- Icons: Animations
	
	-- No animation frames detected.

feature -- Constants: Icon names

	context_cluster_name: STRING = "context cluster"
	context_favorite_name: STRING = "context favorite"
	context_class_name: STRING = "context class"
	context_feature_name: STRING = "context feature"
	context_client_link_name: STRING = "context client link"
	context_inherit_link_name: STRING = "context inherit link"
	context_debug_object_name: STRING = "context debug object"
	context_metric_name: STRING = "context metric"
	context_criteria_name: STRING = "context criteria"
	context_classes_name: STRING = "context classes"
	context_help_name: STRING = "context help"
	context_debugger_step_name: STRING = "context debugger step"
	context_library_name: STRING = "context library"
	context_precompile_name: STRING = "context precompile"
	context_assembly_name: STRING = "context assembly"
	context_namespace_name: STRING = "context namespace"
	context_target_name: STRING = "context target"
	context_disabled_cluster_name: STRING = "context disabled cluster"
	context_disabled_favorite_name: STRING = "context disabled favorite"
	context_disabled_class_name: STRING = "context disabled class"
	context_disabled_feature_name: STRING = "context disabled feature"
	context_disabled_client_link_name: STRING = "context disabled client link"
	context_disabled_inherit_link_name: STRING = "context disabled inherit link"
	context_disabled_debug_object_name: STRING = "context disabled debug object"
	context_disabled_metric_name: STRING = "context disabled metric"
	context_disabled_criteria_name: STRING = "context disabled criteria"
	context_disabled_classes_name: STRING = "context disabled classes"
	context_disabled_help_name: STRING = "context disabled help"
	context_disabled_debugger_step_name: STRING = "context disabled debugger step"
	context_disabled_library_name: STRING = "context disabled library"
	context_disabled_precompile_name: STRING = "context disabled precompile"
	context_disabled_assembly_name: STRING = "context disabled assembly"
	context_disabled_namespace_name: STRING = "context disabled namespace"
	context_disabled_target_name: STRING = "context disabled target"
	cursor_hand_open_name: STRING = "cursor hand open"
	cursor_hand_clasped_name: STRING = "cursor hand clasped"
	cursor_move_name: STRING = "cursor move"
	cursor_copy_name: STRING = "cursor copy"
	docking_up_name: STRING = "docking up"
	docking_down_name: STRING = "docking down"
	docking_left_name: STRING = "docking left"
	docking_right_name: STRING = "docking right"
	docking_float_name: STRING = "docking float"
	docking_tabify_name: STRING = "docking tabify"
	metrics_generic_name: STRING = "metrics generic"
	metrics_feature_name: STRING = "metrics feature"
	metrics_local_name: STRING = "metrics local"
	metrics_assertion_name: STRING = "metrics assertion"
	metrics_line_name: STRING = "metrics line"
	metrics_disabled_generic_name: STRING = "metrics disabled generic"
	metrics_disabled_feature_name: STRING = "metrics disabled feature"
	metrics_disabled_local_name: STRING = "metrics disabled local"
	metrics_disabled_assertion_name: STRING = "metrics disabled assertion"
	metrics_disabled_line_name: STRING = "metrics disabled line"

feature {NONE} -- Basic operations

	populate_coordinates_table (a_table: HASH_TABLE [TUPLE [x: NATURAL_8; y: NATURAL_8], STRING])
			-- <Precursor>
		do
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 1], context_cluster_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 1], context_favorite_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 1], context_class_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 1], context_feature_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 1], context_client_link_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 1], context_inherit_link_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 1], context_debug_object_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 1], context_metric_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 1], context_criteria_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 1], context_classes_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 1], context_help_name)
			a_table.put ([{NATURAL_8} 12, {NATURAL_8} 1], context_debugger_step_name)
			a_table.put ([{NATURAL_8} 13, {NATURAL_8} 1], context_library_name)
			a_table.put ([{NATURAL_8} 14, {NATURAL_8} 1], context_precompile_name)
			a_table.put ([{NATURAL_8} 15, {NATURAL_8} 1], context_assembly_name)
			a_table.put ([{NATURAL_8} 16, {NATURAL_8} 1], context_namespace_name)
			a_table.put ([{NATURAL_8} 17, {NATURAL_8} 1], context_target_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 2], context_disabled_cluster_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 2], context_disabled_favorite_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 2], context_disabled_class_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 2], context_disabled_feature_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 2], context_disabled_client_link_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 2], context_disabled_inherit_link_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 2], context_disabled_debug_object_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 2], context_disabled_metric_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 2], context_disabled_criteria_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 2], context_disabled_classes_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 2], context_disabled_help_name)
			a_table.put ([{NATURAL_8} 12, {NATURAL_8} 2], context_disabled_debugger_step_name)
			a_table.put ([{NATURAL_8} 13, {NATURAL_8} 2], context_disabled_library_name)
			a_table.put ([{NATURAL_8} 14, {NATURAL_8} 2], context_disabled_precompile_name)
			a_table.put ([{NATURAL_8} 15, {NATURAL_8} 2], context_disabled_assembly_name)
			a_table.put ([{NATURAL_8} 16, {NATURAL_8} 2], context_disabled_namespace_name)
			a_table.put ([{NATURAL_8} 17, {NATURAL_8} 2], context_disabled_target_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 3], cursor_hand_open_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 3], cursor_hand_clasped_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 3], cursor_move_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 3], cursor_copy_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 3], docking_up_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 3], docking_down_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 3], docking_left_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 3], docking_right_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 3], docking_float_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 3], docking_tabify_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 3], metrics_generic_name)
			a_table.put ([{NATURAL_8} 12, {NATURAL_8} 3], metrics_feature_name)
			a_table.put ([{NATURAL_8} 13, {NATURAL_8} 3], metrics_local_name)
			a_table.put ([{NATURAL_8} 14, {NATURAL_8} 3], metrics_assertion_name)
			a_table.put ([{NATURAL_8} 15, {NATURAL_8} 3], metrics_line_name)
			a_table.put ([{NATURAL_8} 16, {NATURAL_8} 3], metrics_disabled_generic_name)
			a_table.put ([{NATURAL_8} 17, {NATURAL_8} 3], metrics_disabled_feature_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 4], metrics_disabled_local_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 4], metrics_disabled_assertion_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 4], metrics_disabled_line_name)
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
