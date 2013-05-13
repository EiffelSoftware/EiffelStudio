note
	description: "[
		Automatically generated class for EiffelStudio 10x10 icons.
	]"
	generator: "Eiffel Matrix Generator"
	command_line: "emcgen.exe \work\73dev\Delivery\studio\bitmaps\png\10x10.ini -f \work\73dev\tools\eiffel_matrix_code_generator\frames\studio.e.frame"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PIXMAPS_10X10

inherit
	ES_PIXMAPS
		redefine
			matrix_pixel_border
		end

create
	make

feature -- Access

	icon_width: NATURAL_8 = 10
			-- <Precursor>

	icon_height: NATURAL_8 = 10
			-- <Precursor>

	width: NATURAL_8 = 12
			-- <Precursor>

	height: NATURAL_8 = 7
			-- <Precursor>

feature {NONE} -- Access

	matrix_pixel_border: NATURAL_8 = 1
			-- <Precursor>

feature -- Icons

	frozen toolbar_close_icon: EV_PIXMAP
			-- Access to 'close' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_close_name)
		once
			Result := named_icon (toolbar_close_name)
		ensure
			toolbar_close_icon_attached: Result /= Void
		end

	frozen toolbar_close_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'close' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_close_name)
		once
			Result := named_icon_buffer (toolbar_close_name)
		ensure
			toolbar_close_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_minimize_icon: EV_PIXMAP
			-- Access to 'minimize' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_minimize_name)
		once
			Result := named_icon (toolbar_minimize_name)
		ensure
			toolbar_minimize_icon_attached: Result /= Void
		end

	frozen toolbar_minimize_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'minimize' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_minimize_name)
		once
			Result := named_icon_buffer (toolbar_minimize_name)
		ensure
			toolbar_minimize_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_maximize_icon: EV_PIXMAP
			-- Access to 'maximize' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_maximize_name)
		once
			Result := named_icon (toolbar_maximize_name)
		ensure
			toolbar_maximize_icon_attached: Result /= Void
		end

	frozen toolbar_maximize_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'maximize' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_maximize_name)
		once
			Result := named_icon_buffer (toolbar_maximize_name)
		ensure
			toolbar_maximize_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_restore_icon: EV_PIXMAP
			-- Access to 'restore' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_restore_name)
		once
			Result := named_icon (toolbar_restore_name)
		ensure
			toolbar_restore_icon_attached: Result /= Void
		end

	frozen toolbar_restore_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'restore' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_restore_name)
		once
			Result := named_icon_buffer (toolbar_restore_name)
		ensure
			toolbar_restore_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_pinned_icon: EV_PIXMAP
			-- Access to 'pinned' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_pinned_name)
		once
			Result := named_icon (toolbar_pinned_name)
		ensure
			toolbar_pinned_icon_attached: Result /= Void
		end

	frozen toolbar_pinned_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'pinned' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_pinned_name)
		once
			Result := named_icon_buffer (toolbar_pinned_name)
		ensure
			toolbar_pinned_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_unpinned_icon: EV_PIXMAP
			-- Access to 'unpinned' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_unpinned_name)
		once
			Result := named_icon (toolbar_unpinned_name)
		ensure
			toolbar_unpinned_icon_attached: Result /= Void
		end

	frozen toolbar_unpinned_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'unpinned' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_unpinned_name)
		once
			Result := named_icon_buffer (toolbar_unpinned_name)
		ensure
			toolbar_unpinned_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_expand_icon: EV_PIXMAP
			-- Access to 'expand' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_expand_name)
		once
			Result := named_icon (toolbar_expand_name)
		ensure
			toolbar_expand_icon_attached: Result /= Void
		end

	frozen toolbar_expand_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'expand' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_expand_name)
		once
			Result := named_icon_buffer (toolbar_expand_name)
		ensure
			toolbar_expand_icon_buffer_attached: Result /= Void
		end

	frozen toolbar_dropdown_icon: EV_PIXMAP
			-- Access to 'dropdown' pixmap.
		require
			has_named_icon: has_named_icon (toolbar_dropdown_name)
		once
			Result := named_icon (toolbar_dropdown_name)
		ensure
			toolbar_dropdown_icon_attached: Result /= Void
		end

	frozen toolbar_dropdown_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'dropdown' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (toolbar_dropdown_name)
		once
			Result := named_icon_buffer (toolbar_dropdown_name)
		ensure
			toolbar_dropdown_icon_buffer_attached: Result /= Void
		end

	frozen sort_accending_icon: EV_PIXMAP
			-- Access to 'accending' pixmap.
		require
			has_named_icon: has_named_icon (sort_accending_name)
		once
			Result := named_icon (sort_accending_name)
		ensure
			sort_accending_icon_attached: Result /= Void
		end

	frozen sort_accending_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'accending' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (sort_accending_name)
		once
			Result := named_icon_buffer (sort_accending_name)
		ensure
			sort_accending_icon_buffer_attached: Result /= Void
		end

	frozen sort_descending_icon: EV_PIXMAP
			-- Access to 'descending' pixmap.
		require
			has_named_icon: has_named_icon (sort_descending_name)
		once
			Result := named_icon (sort_descending_name)
		ensure
			sort_descending_icon_attached: Result /= Void
		end

	frozen sort_descending_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'descending' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (sort_descending_name)
		once
			Result := named_icon_buffer (sort_descending_name)
		ensure
			sort_descending_icon_buffer_attached: Result /= Void
		end

	frozen sort_group_icon: EV_PIXMAP
			-- Access to 'group' pixmap.
		require
			has_named_icon: has_named_icon (sort_group_name)
		once
			Result := named_icon (sort_group_name)
		ensure
			sort_group_icon_attached: Result /= Void
		end

	frozen sort_group_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'group' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (sort_group_name)
		once
			Result := named_icon_buffer (sort_group_name)
		ensure
			sort_group_icon_buffer_attached: Result /= Void
		end

	frozen general_blank_icon: EV_PIXMAP
			-- Access to 'blank' pixmap.
		require
			has_named_icon: has_named_icon (general_blank_name)
		once
			Result := named_icon (general_blank_name)
		ensure
			general_blank_icon_attached: Result /= Void
		end

	frozen general_blank_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'blank' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_blank_name)
		once
			Result := named_icon_buffer (general_blank_name)
		ensure
			general_blank_icon_buffer_attached: Result /= Void
		end

	frozen general_save_icon: EV_PIXMAP
			-- Access to 'save' pixmap.
		require
			has_named_icon: has_named_icon (general_save_name)
		once
			Result := named_icon (general_save_name)
		ensure
			general_save_icon_attached: Result /= Void
		end

	frozen general_save_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'save' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_save_name)
		once
			Result := named_icon_buffer (general_save_name)
		ensure
			general_save_icon_buffer_attached: Result /= Void
		end

	frozen general_add_icon: EV_PIXMAP
			-- Access to 'add' pixmap.
		require
			has_named_icon: has_named_icon (general_add_name)
		once
			Result := named_icon (general_add_name)
		ensure
			general_add_icon_attached: Result /= Void
		end

	frozen general_add_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'add' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_add_name)
		once
			Result := named_icon_buffer (general_add_name)
		ensure
			general_add_icon_buffer_attached: Result /= Void
		end

	frozen general_edit_icon: EV_PIXMAP
			-- Access to 'edit' pixmap.
		require
			has_named_icon: has_named_icon (general_edit_name)
		once
			Result := named_icon (general_edit_name)
		ensure
			general_edit_icon_attached: Result /= Void
		end

	frozen general_edit_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'edit' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_edit_name)
		once
			Result := named_icon_buffer (general_edit_name)
		ensure
			general_edit_icon_buffer_attached: Result /= Void
		end

	frozen general_delete_icon: EV_PIXMAP
			-- Access to 'delete' pixmap.
		require
			has_named_icon: has_named_icon (general_delete_name)
		once
			Result := named_icon (general_delete_name)
		ensure
			general_delete_icon_attached: Result /= Void
		end

	frozen general_delete_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'delete' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_delete_name)
		once
			Result := named_icon_buffer (general_delete_name)
		ensure
			general_delete_icon_buffer_attached: Result /= Void
		end

	frozen general_copy_icon: EV_PIXMAP
			-- Access to 'copy' pixmap.
		require
			has_named_icon: has_named_icon (general_copy_name)
		once
			Result := named_icon (general_copy_name)
		ensure
			general_copy_icon_attached: Result /= Void
		end

	frozen general_copy_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'copy' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_copy_name)
		once
			Result := named_icon_buffer (general_copy_name)
		ensure
			general_copy_icon_buffer_attached: Result /= Void
		end

	frozen general_search_icon: EV_PIXMAP
			-- Access to 'search' pixmap.
		require
			has_named_icon: has_named_icon (general_search_name)
		once
			Result := named_icon (general_search_name)
		ensure
			general_search_icon_attached: Result /= Void
		end

	frozen general_search_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'search' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_search_name)
		once
			Result := named_icon_buffer (general_search_name)
		ensure
			general_search_icon_buffer_attached: Result /= Void
		end

	frozen general_previous_icon: EV_PIXMAP
			-- Access to 'previous' pixmap.
		require
			has_named_icon: has_named_icon (general_previous_name)
		once
			Result := named_icon (general_previous_name)
		ensure
			general_previous_icon_attached: Result /= Void
		end

	frozen general_previous_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'previous' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_previous_name)
		once
			Result := named_icon_buffer (general_previous_name)
		ensure
			general_previous_icon_buffer_attached: Result /= Void
		end

	frozen general_next_icon: EV_PIXMAP
			-- Access to 'next' pixmap.
		require
			has_named_icon: has_named_icon (general_next_name)
		once
			Result := named_icon (general_next_name)
		ensure
			general_next_icon_attached: Result /= Void
		end

	frozen general_next_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'next' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_next_name)
		once
			Result := named_icon_buffer (general_next_name)
		ensure
			general_next_icon_buffer_attached: Result /= Void
		end

	frozen general_up_icon: EV_PIXMAP
			-- Access to 'up' pixmap.
		require
			has_named_icon: has_named_icon (general_up_name)
		once
			Result := named_icon (general_up_name)
		ensure
			general_up_icon_attached: Result /= Void
		end

	frozen general_up_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'up' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_up_name)
		once
			Result := named_icon_buffer (general_up_name)
		ensure
			general_up_icon_buffer_attached: Result /= Void
		end

	frozen general_down_icon: EV_PIXMAP
			-- Access to 'down' pixmap.
		require
			has_named_icon: has_named_icon (general_down_name)
		once
			Result := named_icon (general_down_name)
		ensure
			general_down_icon_attached: Result /= Void
		end

	frozen general_down_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'down' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_down_name)
		once
			Result := named_icon_buffer (general_down_name)
		ensure
			general_down_icon_buffer_attached: Result /= Void
		end

	frozen general_toogle_icon: EV_PIXMAP
			-- Access to 'toogle' pixmap.
		require
			has_named_icon: has_named_icon (general_toogle_name)
		once
			Result := named_icon (general_toogle_name)
		ensure
			general_toogle_icon_attached: Result /= Void
		end

	frozen general_toogle_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'toogle' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_toogle_name)
		once
			Result := named_icon_buffer (general_toogle_name)
		ensure
			general_toogle_icon_buffer_attached: Result /= Void
		end

	frozen debugger_callstack_depth_icon: EV_PIXMAP
			-- Access to 'callstack depth' pixmap.
		require
			has_named_icon: has_named_icon (debugger_callstack_depth_name)
		once
			Result := named_icon (debugger_callstack_depth_name)
		ensure
			debugger_callstack_depth_icon_attached: Result /= Void
		end

	frozen debugger_callstack_depth_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'callstack depth' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (debugger_callstack_depth_name)
		once
			Result := named_icon_buffer (debugger_callstack_depth_name)
		ensure
			debugger_callstack_depth_icon_buffer_attached: Result /= Void
		end

	frozen debugger_error_icon: EV_PIXMAP
			-- Access to 'error' pixmap.
		require
			has_named_icon: has_named_icon (debugger_error_name)
		once
			Result := named_icon (debugger_error_name)
		ensure
			debugger_error_icon_attached: Result /= Void
		end

	frozen debugger_error_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'error' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (debugger_error_name)
		once
			Result := named_icon_buffer (debugger_error_name)
		ensure
			debugger_error_icon_buffer_attached: Result /= Void
		end

	frozen debugger_expand_info_icon: EV_PIXMAP
			-- Access to 'expand info' pixmap.
		require
			has_named_icon: has_named_icon (debugger_expand_info_name)
		once
			Result := named_icon (debugger_expand_info_name)
		ensure
			debugger_expand_info_icon_attached: Result /= Void
		end

	frozen debugger_expand_info_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'expand info' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (debugger_expand_info_name)
		once
			Result := named_icon_buffer (debugger_expand_info_name)
		ensure
			debugger_expand_info_icon_buffer_attached: Result /= Void
		end

	frozen debugger_set_sizes_icon: EV_PIXMAP
			-- Access to 'set sizes' pixmap.
		require
			has_named_icon: has_named_icon (debugger_set_sizes_name)
		once
			Result := named_icon (debugger_set_sizes_name)
		ensure
			debugger_set_sizes_icon_attached: Result /= Void
		end

	frozen debugger_set_sizes_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'set sizes' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (debugger_set_sizes_name)
		once
			Result := named_icon_buffer (debugger_set_sizes_name)
		ensure
			debugger_set_sizes_icon_buffer_attached: Result /= Void
		end

	frozen debugger_show_hex_value_icon: EV_PIXMAP
			-- Access to 'show hex value' pixmap.
		require
			has_named_icon: has_named_icon (debugger_show_hex_value_name)
		once
			Result := named_icon (debugger_show_hex_value_name)
		ensure
			debugger_show_hex_value_icon_attached: Result /= Void
		end

	frozen debugger_show_hex_value_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show hex value' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (debugger_show_hex_value_name)
		once
			Result := named_icon_buffer (debugger_show_hex_value_name)
		ensure
			debugger_show_hex_value_icon_buffer_attached: Result /= Void
		end

	frozen breakpoints_enable_icon: EV_PIXMAP
			-- Access to 'enable' pixmap.
		require
			has_named_icon: has_named_icon (breakpoints_enable_name)
		once
			Result := named_icon (breakpoints_enable_name)
		ensure
			breakpoints_enable_icon_attached: Result /= Void
		end

	frozen breakpoints_enable_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'enable' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (breakpoints_enable_name)
		once
			Result := named_icon_buffer (breakpoints_enable_name)
		ensure
			breakpoints_enable_icon_buffer_attached: Result /= Void
		end

	frozen breakpoints_disable_icon: EV_PIXMAP
			-- Access to 'disable' pixmap.
		require
			has_named_icon: has_named_icon (breakpoints_disable_name)
		once
			Result := named_icon (breakpoints_disable_name)
		ensure
			breakpoints_disable_icon_attached: Result /= Void
		end

	frozen breakpoints_disable_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'disable' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (breakpoints_disable_name)
		once
			Result := named_icon_buffer (breakpoints_disable_name)
		ensure
			breakpoints_disable_icon_buffer_attached: Result /= Void
		end

	frozen viewer_wrap_icon: EV_PIXMAP
			-- Access to 'wrap' pixmap.
		require
			has_named_icon: has_named_icon (viewer_wrap_name)
		once
			Result := named_icon (viewer_wrap_name)
		ensure
			viewer_wrap_icon_attached: Result /= Void
		end

	frozen viewer_wrap_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'wrap' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (viewer_wrap_name)
		once
			Result := named_icon_buffer (viewer_wrap_name)
		ensure
			viewer_wrap_icon_buffer_attached: Result /= Void
		end

	frozen viewer_expand_icon: EV_PIXMAP
			-- Access to 'expand' pixmap.
		require
			has_named_icon: has_named_icon (viewer_expand_name)
		once
			Result := named_icon (viewer_expand_name)
		ensure
			viewer_expand_icon_attached: Result /= Void
		end

	frozen viewer_expand_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'expand' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (viewer_expand_name)
		once
			Result := named_icon_buffer (viewer_expand_name)
		ensure
			viewer_expand_icon_buffer_attached: Result /= Void
		end

	frozen viewer_lock_icon: EV_PIXMAP
			-- Access to 'lock' pixmap.
		require
			has_named_icon: has_named_icon (viewer_lock_name)
		once
			Result := named_icon (viewer_lock_name)
		ensure
			viewer_lock_icon_attached: Result /= Void
		end

	frozen viewer_lock_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'lock' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (viewer_lock_name)
		once
			Result := named_icon_buffer (viewer_lock_name)
		ensure
			viewer_lock_icon_buffer_attached: Result /= Void
		end

	frozen viewer_formatting_icon: EV_PIXMAP
			-- Access to 'formatting' pixmap.
		require
			has_named_icon: has_named_icon (viewer_formatting_name)
		once
			Result := named_icon (viewer_formatting_name)
		ensure
			viewer_formatting_icon_attached: Result /= Void
		end

	frozen viewer_formatting_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'formatting' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (viewer_formatting_name)
		once
			Result := named_icon_buffer (viewer_formatting_name)
		ensure
			viewer_formatting_icon_buffer_attached: Result /= Void
		end

	frozen watch_auto_icon: EV_PIXMAP
			-- Access to 'auto' pixmap.
		require
			has_named_icon: has_named_icon (watch_auto_name)
		once
			Result := named_icon (watch_auto_name)
		ensure
			watch_auto_icon_attached: Result /= Void
		end

	frozen watch_auto_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'auto' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (watch_auto_name)
		once
			Result := named_icon_buffer (watch_auto_name)
		ensure
			watch_auto_icon_buffer_attached: Result /= Void
		end

	frozen callstack_send_to_external_editor_icon: EV_PIXMAP
			-- Access to 'send to external editor' pixmap.
		require
			has_named_icon: has_named_icon (callstack_send_to_external_editor_name)
		once
			Result := named_icon (callstack_send_to_external_editor_name)
		ensure
			callstack_send_to_external_editor_icon_attached: Result /= Void
		end

	frozen callstack_send_to_external_editor_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'send to external editor' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (callstack_send_to_external_editor_name)
		once
			Result := named_icon_buffer (callstack_send_to_external_editor_name)
		ensure
			callstack_send_to_external_editor_icon_buffer_attached: Result /= Void
		end

	frozen callstack_is_melted_icon: EV_PIXMAP
			-- Access to 'is melted' pixmap.
		require
			has_named_icon: has_named_icon (callstack_is_melted_name)
		once
			Result := named_icon (callstack_is_melted_name)
		ensure
			callstack_is_melted_icon_attached: Result /= Void
		end

	frozen callstack_is_melted_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'is melted' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (callstack_is_melted_name)
		once
			Result := named_icon_buffer (callstack_is_melted_name)
		ensure
			callstack_is_melted_icon_buffer_attached: Result /= Void
		end

	frozen callstack_has_rescue_icon: EV_PIXMAP
			-- Access to 'has rescue' pixmap.
		require
			has_named_icon: has_named_icon (callstack_has_rescue_name)
		once
			Result := named_icon (callstack_has_rescue_name)
		ensure
			callstack_has_rescue_icon_attached: Result /= Void
		end

	frozen callstack_has_rescue_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'has rescue' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (callstack_has_rescue_name)
		once
			Result := named_icon_buffer (callstack_has_rescue_name)
		ensure
			callstack_has_rescue_icon_buffer_attached: Result /= Void
		end

	frozen execution_record_icon: EV_PIXMAP
			-- Access to 'record' pixmap.
		require
			has_named_icon: has_named_icon (execution_record_name)
		once
			Result := named_icon (execution_record_name)
		ensure
			execution_record_icon_attached: Result /= Void
		end

	frozen execution_record_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'record' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (execution_record_name)
		once
			Result := named_icon_buffer (execution_record_name)
		ensure
			execution_record_icon_buffer_attached: Result /= Void
		end

	frozen execution_replay_icon: EV_PIXMAP
			-- Access to 'replay' pixmap.
		require
			has_named_icon: has_named_icon (execution_replay_name)
		once
			Result := named_icon (execution_replay_name)
		ensure
			execution_replay_icon_attached: Result /= Void
		end

	frozen execution_replay_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'replay' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (execution_replay_name)
		once
			Result := named_icon_buffer (execution_replay_name)
		ensure
			execution_replay_icon_buffer_attached: Result /= Void
		end

	frozen execution_object_storage_icon: EV_PIXMAP
			-- Access to 'object storage' pixmap.
		require
			has_named_icon: has_named_icon (execution_object_storage_name)
		once
			Result := named_icon (execution_object_storage_name)
		ensure
			execution_object_storage_icon_attached: Result /= Void
		end

	frozen execution_object_storage_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'object storage' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (execution_object_storage_name)
		once
			Result := named_icon_buffer (execution_object_storage_name)
		ensure
			execution_object_storage_icon_buffer_attached: Result /= Void
		end

	frozen hidden_show_in_callstack_icon: EV_PIXMAP
			-- Access to 'show in callstack' pixmap.
		require
			has_named_icon: has_named_icon (hidden_show_in_callstack_name)
		once
			Result := named_icon (hidden_show_in_callstack_name)
		ensure
			hidden_show_in_callstack_icon_attached: Result /= Void
		end

	frozen hidden_show_in_callstack_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show in callstack' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (hidden_show_in_callstack_name)
		once
			Result := named_icon_buffer (hidden_show_in_callstack_name)
		ensure
			hidden_show_in_callstack_icon_buffer_attached: Result /= Void
		end

	frozen hidden_hide_in_callstack_icon: EV_PIXMAP
			-- Access to 'hide in callstack' pixmap.
		require
			has_named_icon: has_named_icon (hidden_hide_in_callstack_name)
		once
			Result := named_icon (hidden_hide_in_callstack_name)
		ensure
			hidden_hide_in_callstack_icon_attached: Result /= Void
		end

	frozen hidden_hide_in_callstack_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'hide in callstack' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (hidden_hide_in_callstack_name)
		once
			Result := named_icon_buffer (hidden_hide_in_callstack_name)
		ensure
			hidden_hide_in_callstack_icon_buffer_attached: Result /= Void
		end

	frozen reserved_reserved_1_icon: EV_PIXMAP
			-- Access to 'reserved 1' pixmap.
		require
			has_named_icon: has_named_icon (reserved_reserved_1_name)
		once
			Result := named_icon (reserved_reserved_1_name)
		ensure
			reserved_reserved_1_icon_attached: Result /= Void
		end

	frozen reserved_reserved_1_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'reserved 1' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (reserved_reserved_1_name)
		once
			Result := named_icon_buffer (reserved_reserved_1_name)
		ensure
			reserved_reserved_1_icon_buffer_attached: Result /= Void
		end

	frozen reserved_reserved_2_icon: EV_PIXMAP
			-- Access to 'reserved 2' pixmap.
		require
			has_named_icon: has_named_icon (reserved_reserved_2_name)
		once
			Result := named_icon (reserved_reserved_2_name)
		ensure
			reserved_reserved_2_icon_attached: Result /= Void
		end

	frozen reserved_reserved_2_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'reserved 2' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (reserved_reserved_2_name)
		once
			Result := named_icon_buffer (reserved_reserved_2_name)
		ensure
			reserved_reserved_2_icon_buffer_attached: Result /= Void
		end

	frozen evaluation_refresh_icon: EV_PIXMAP
			-- Access to 'refresh' pixmap.
		require
			has_named_icon: has_named_icon (evaluation_refresh_name)
		once
			Result := named_icon (evaluation_refresh_name)
		ensure
			evaluation_refresh_icon_attached: Result /= Void
		end

	frozen evaluation_refresh_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'refresh' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (evaluation_refresh_name)
		once
			Result := named_icon_buffer (evaluation_refresh_name)
		ensure
			evaluation_refresh_icon_buffer_attached: Result /= Void
		end

	frozen new_feature_icon: EV_PIXMAP
			-- Access to 'feature' pixmap.
		require
			has_named_icon: has_named_icon (new_feature_name)
		once
			Result := named_icon (new_feature_name)
		ensure
			new_feature_icon_attached: Result /= Void
		end

	frozen new_feature_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'feature' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_feature_name)
		once
			Result := named_icon_buffer (new_feature_name)
		ensure
			new_feature_icon_buffer_attached: Result /= Void
		end

	frozen new_class_icon: EV_PIXMAP
			-- Access to 'class' pixmap.
		require
			has_named_icon: has_named_icon (new_class_name)
		once
			Result := named_icon (new_class_name)
		ensure
			new_class_icon_attached: Result /= Void
		end

	frozen new_class_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'class' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_class_name)
		once
			Result := named_icon_buffer (new_class_name)
		ensure
			new_class_icon_buffer_attached: Result /= Void
		end

	frozen new_cluster_icon: EV_PIXMAP
			-- Access to 'cluster' pixmap.
		require
			has_named_icon: has_named_icon (new_cluster_name)
		once
			Result := named_icon (new_cluster_name)
		ensure
			new_cluster_icon_attached: Result /= Void
		end

	frozen new_cluster_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'cluster' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_cluster_name)
		once
			Result := named_icon_buffer (new_cluster_name)
		ensure
			new_cluster_icon_buffer_attached: Result /= Void
		end

	frozen new_expression_icon: EV_PIXMAP
			-- Access to 'expression' pixmap.
		require
			has_named_icon: has_named_icon (new_expression_name)
		once
			Result := named_icon (new_expression_name)
		ensure
			new_expression_icon_attached: Result /= Void
		end

	frozen new_expression_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'expression' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_expression_name)
		once
			Result := named_icon_buffer (new_expression_name)
		ensure
			new_expression_icon_buffer_attached: Result /= Void
		end

	frozen new_library_icon: EV_PIXMAP
			-- Access to 'library' pixmap.
		require
			has_named_icon: has_named_icon (new_library_name)
		once
			Result := named_icon (new_library_name)
		ensure
			new_library_icon_attached: Result /= Void
		end

	frozen new_library_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'library' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_library_name)
		once
			Result := named_icon_buffer (new_library_name)
		ensure
			new_library_icon_buffer_attached: Result /= Void
		end

	frozen new_assembly_icon: EV_PIXMAP
			-- Access to 'assembly' pixmap.
		require
			has_named_icon: has_named_icon (new_assembly_name)
		once
			Result := named_icon (new_assembly_name)
		ensure
			new_assembly_icon_attached: Result /= Void
		end

	frozen new_assembly_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'assembly' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_assembly_name)
		once
			Result := named_icon_buffer (new_assembly_name)
		ensure
			new_assembly_icon_buffer_attached: Result /= Void
		end

	frozen new_watch_tool_icon: EV_PIXMAP
			-- Access to 'watch tool' pixmap.
		require
			has_named_icon: has_named_icon (new_watch_tool_name)
		once
			Result := named_icon (new_watch_tool_name)
		ensure
			new_watch_tool_icon_attached: Result /= Void
		end

	frozen new_watch_tool_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'watch tool' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_watch_tool_name)
		once
			Result := named_icon_buffer (new_watch_tool_name)
		ensure
			new_watch_tool_icon_buffer_attached: Result /= Void
		end

	frozen new_window_icon: EV_PIXMAP
			-- Access to 'window' pixmap.
		require
			has_named_icon: has_named_icon (new_window_name)
		once
			Result := named_icon (new_window_name)
		ensure
			new_window_icon_attached: Result /= Void
		end

	frozen new_window_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'window' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_window_name)
		once
			Result := named_icon_buffer (new_window_name)
		ensure
			new_window_icon_buffer_attached: Result /= Void
		end

	frozen new_tool_edition_icon: EV_PIXMAP
			-- Access to 'tool edition' pixmap.
		require
			has_named_icon: has_named_icon (new_tool_edition_name)
		once
			Result := named_icon (new_tool_edition_name)
		ensure
			new_tool_edition_icon_attached: Result /= Void
		end

	frozen new_tool_edition_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'tool edition' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (new_tool_edition_name)
		once
			Result := named_icon_buffer (new_tool_edition_name)
		ensure
			new_tool_edition_icon_buffer_attached: Result /= Void
		end

	frozen completion_remember_size_icon: EV_PIXMAP
			-- Access to 'remember size' pixmap.
		require
			has_named_icon: has_named_icon (completion_remember_size_name)
		once
			Result := named_icon (completion_remember_size_name)
		ensure
			completion_remember_size_icon_attached: Result /= Void
		end

	frozen completion_remember_size_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'remember size' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_remember_size_name)
		once
			Result := named_icon_buffer (completion_remember_size_name)
		ensure
			completion_remember_size_icon_buffer_attached: Result /= Void
		end

	frozen completion_filter_icon: EV_PIXMAP
			-- Access to 'filter' pixmap.
		require
			has_named_icon: has_named_icon (completion_filter_name)
		once
			Result := named_icon (completion_filter_name)
		ensure
			completion_filter_icon_attached: Result /= Void
		end

	frozen completion_filter_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'filter' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_filter_name)
		once
			Result := named_icon_buffer (completion_filter_name)
		ensure
			completion_filter_icon_buffer_attached: Result /= Void
		end

	frozen completion_show_disambiguants_icon: EV_PIXMAP
			-- Access to 'show disambiguants' pixmap.
		require
			has_named_icon: has_named_icon (completion_show_disambiguants_name)
		once
			Result := named_icon (completion_show_disambiguants_name)
		ensure
			completion_show_disambiguants_icon_attached: Result /= Void
		end

	frozen completion_show_disambiguants_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show disambiguants' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_show_disambiguants_name)
		once
			Result := named_icon_buffer (completion_show_disambiguants_name)
		ensure
			completion_show_disambiguants_icon_buffer_attached: Result /= Void
		end

	frozen completion_show_signature_icon: EV_PIXMAP
			-- Access to 'show signature' pixmap.
		require
			has_named_icon: has_named_icon (completion_show_signature_name)
		once
			Result := named_icon (completion_show_signature_name)
		ensure
			completion_show_signature_icon_attached: Result /= Void
		end

	frozen completion_show_signature_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show signature' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_show_signature_name)
		once
			Result := named_icon_buffer (completion_show_signature_name)
		ensure
			completion_show_signature_icon_buffer_attached: Result /= Void
		end

	frozen completion_show_alias_icon: EV_PIXMAP
			-- Access to 'show alias' pixmap.
		require
			has_named_icon: has_named_icon (completion_show_alias_name)
		once
			Result := named_icon (completion_show_alias_name)
		ensure
			completion_show_alias_icon_attached: Result /= Void
		end

	frozen completion_show_alias_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show alias' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_show_alias_name)
		once
			Result := named_icon_buffer (completion_show_alias_name)
		ensure
			completion_show_alias_icon_buffer_attached: Result /= Void
		end

	frozen completion_show_return_type_icon: EV_PIXMAP
			-- Access to 'show return type' pixmap.
		require
			has_named_icon: has_named_icon (completion_show_return_type_name)
		once
			Result := named_icon (completion_show_return_type_name)
		ensure
			completion_show_return_type_icon_attached: Result /= Void
		end

	frozen completion_show_return_type_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show return type' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_show_return_type_name)
		once
			Result := named_icon_buffer (completion_show_return_type_name)
		ensure
			completion_show_return_type_icon_buffer_attached: Result /= Void
		end

	frozen completion_show_assigner_icon: EV_PIXMAP
			-- Access to 'show assigner' pixmap.
		require
			has_named_icon: has_named_icon (completion_show_assigner_name)
		once
			Result := named_icon (completion_show_assigner_name)
		ensure
			completion_show_assigner_icon_attached: Result /= Void
		end

	frozen completion_show_assigner_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show assigner' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_show_assigner_name)
		once
			Result := named_icon_buffer (completion_show_assigner_name)
		ensure
			completion_show_assigner_icon_buffer_attached: Result /= Void
		end

	frozen completion_show_obsolete_icon: EV_PIXMAP
			-- Access to 'show obsolete' pixmap.
		require
			has_named_icon: has_named_icon (completion_show_obsolete_name)
		once
			Result := named_icon (completion_show_obsolete_name)
		ensure
			completion_show_obsolete_icon_attached: Result /= Void
		end

	frozen completion_show_obsolete_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'show obsolete' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (completion_show_obsolete_name)
		once
			Result := named_icon_buffer (completion_show_obsolete_name)
		ensure
			completion_show_obsolete_icon_buffer_attached: Result /= Void
		end

	frozen bon_persistent_icon: EV_PIXMAP
			-- Access to 'persistent' pixmap.
		require
			has_named_icon: has_named_icon (bon_persistent_name)
		once
			Result := named_icon (bon_persistent_name)
		ensure
			bon_persistent_icon_attached: Result /= Void
		end

	frozen bon_persistent_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'persistent' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (bon_persistent_name)
		once
			Result := named_icon_buffer (bon_persistent_name)
		ensure
			bon_persistent_icon_buffer_attached: Result /= Void
		end

	frozen bon_interfaces_icon: EV_PIXMAP
			-- Access to 'interfaces' pixmap.
		require
			has_named_icon: has_named_icon (bon_interfaces_name)
		once
			Result := named_icon (bon_interfaces_name)
		ensure
			bon_interfaces_icon_attached: Result /= Void
		end

	frozen bon_interfaces_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'interfaces' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (bon_interfaces_name)
		once
			Result := named_icon_buffer (bon_interfaces_name)
		ensure
			bon_interfaces_icon_buffer_attached: Result /= Void
		end

	frozen bon_effective_icon: EV_PIXMAP
			-- Access to 'effective' pixmap.
		require
			has_named_icon: has_named_icon (bon_effective_name)
		once
			Result := named_icon (bon_effective_name)
		ensure
			bon_effective_icon_attached: Result /= Void
		end

	frozen bon_effective_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'effective' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (bon_effective_name)
		once
			Result := named_icon_buffer (bon_effective_name)
		ensure
			bon_effective_icon_buffer_attached: Result /= Void
		end

	frozen bon_deferred_icon: EV_PIXMAP
			-- Access to 'deferred' pixmap.
		require
			has_named_icon: has_named_icon (bon_deferred_name)
		once
			Result := named_icon (bon_deferred_name)
		ensure
			bon_deferred_icon_attached: Result /= Void
		end

	frozen bon_deferred_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'deferred' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (bon_deferred_name)
		once
			Result := named_icon_buffer (bon_deferred_name)
		ensure
			bon_deferred_icon_buffer_attached: Result /= Void
		end

feature -- Icons: Animations

	frozen reserved_reserved_anim: ARRAY [EV_PIXMAP]
			-- Access to 'reserved_reserved' pixmap animation items.
		once
			create Result.make (1, 2)
				Result.put (named_icon (reserved_reserved_1_name), 1)
			Result.put (named_icon (reserved_reserved_2_name), 2)
		ensure
			reserved_reserved_anim_attached: Result /= Void
		end

	frozen reserved_reserved_buffer_anim: ARRAY [EV_PIXEL_BUFFER]
			-- Access to 'reserved_reserved' pixel buffer animation items.
		once
			create Result.make (1, 2)
				Result.put (named_icon_buffer (reserved_reserved_1_name), 1)
			Result.put (named_icon_buffer (reserved_reserved_2_name), 2)
		ensure
			reserved_reserved_buffer_anim_attached: Result /= Void
		end

feature -- Constants: Icon names

	toolbar_close_name: STRING = "toolbar close"
	toolbar_minimize_name: STRING = "toolbar minimize"
	toolbar_maximize_name: STRING = "toolbar maximize"
	toolbar_restore_name: STRING = "toolbar restore"
	toolbar_pinned_name: STRING = "toolbar pinned"
	toolbar_unpinned_name: STRING = "toolbar unpinned"
	toolbar_expand_name: STRING = "toolbar expand"
	toolbar_dropdown_name: STRING = "toolbar dropdown"
	sort_accending_name: STRING = "sort accending"
	sort_descending_name: STRING = "sort descending"
	sort_group_name: STRING = "sort group"
	general_blank_name: STRING = "general blank"
	general_save_name: STRING = "general save"
	general_add_name: STRING = "general add"
	general_edit_name: STRING = "general edit"
	general_delete_name: STRING = "general delete"
	general_copy_name: STRING = "general copy"
	general_search_name: STRING = "general search"
	general_previous_name: STRING = "general previous"
	general_next_name: STRING = "general next"
	general_up_name: STRING = "general up"
	general_down_name: STRING = "general down"
	general_toogle_name: STRING = "general toogle"
	debugger_callstack_depth_name: STRING = "debugger callstack depth"
	debugger_error_name: STRING = "debugger error"
	debugger_expand_info_name: STRING = "debugger expand info"
	debugger_set_sizes_name: STRING = "debugger set sizes"
	debugger_show_hex_value_name: STRING = "debugger show hex value"
	breakpoints_enable_name: STRING = "breakpoints enable"
	breakpoints_disable_name: STRING = "breakpoints disable"
	viewer_wrap_name: STRING = "viewer wrap"
	viewer_expand_name: STRING = "viewer expand"
	viewer_lock_name: STRING = "viewer lock"
	viewer_formatting_name: STRING = "viewer formatting"
	watch_auto_name: STRING = "watch auto"
	callstack_send_to_external_editor_name: STRING = "callstack send to external editor"
	callstack_is_melted_name: STRING = "callstack is melted"
	callstack_has_rescue_name: STRING = "callstack has rescue"
	execution_record_name: STRING = "execution record"
	execution_replay_name: STRING = "execution replay"
	execution_object_storage_name: STRING = "execution object storage"
	hidden_show_in_callstack_name: STRING = "hidden show in callstack"
	hidden_hide_in_callstack_name: STRING = "hidden hide in callstack"
	reserved_reserved_1_name: STRING = "reserved reserved 1"
	reserved_reserved_2_name: STRING = "reserved reserved 2"
	evaluation_refresh_name: STRING = "evaluation refresh"
	new_feature_name: STRING = "new feature"
	new_class_name: STRING = "new class"
	new_cluster_name: STRING = "new cluster"
	new_expression_name: STRING = "new expression"
	new_library_name: STRING = "new library"
	new_assembly_name: STRING = "new assembly"
	new_watch_tool_name: STRING = "new watch tool"
	new_window_name: STRING = "new window"
	new_tool_edition_name: STRING = "new tool edition"
	completion_remember_size_name: STRING = "completion remember size"
	completion_filter_name: STRING = "completion filter"
	completion_show_disambiguants_name: STRING = "completion show disambiguants"
	completion_show_signature_name: STRING = "completion show signature"
	completion_show_alias_name: STRING = "completion show alias"
	completion_show_return_type_name: STRING = "completion show return type"
	completion_show_assigner_name: STRING = "completion show assigner"
	completion_show_obsolete_name: STRING = "completion show obsolete"
	bon_persistent_name: STRING = "bon persistent"
	bon_interfaces_name: STRING = "bon interfaces"
	bon_effective_name: STRING = "bon effective"
	bon_deferred_name: STRING = "bon deferred"

feature {NONE} -- Basic operations

	populate_coordinates_table (a_table: HASH_TABLE [TUPLE [x: NATURAL_8; y: NATURAL_8], STRING])
			-- <Precursor>
		do
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 1], toolbar_close_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 1], toolbar_minimize_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 1], toolbar_maximize_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 1], toolbar_restore_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 1], toolbar_pinned_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 1], toolbar_unpinned_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 1], toolbar_expand_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 1], toolbar_dropdown_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 1], sort_accending_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 1], sort_descending_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 1], sort_group_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 2], general_blank_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 2], general_save_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 2], general_add_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 2], general_edit_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 2], general_delete_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 2], general_copy_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 2], general_search_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 2], general_previous_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 2], general_next_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 2], general_up_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 2], general_down_name)
			a_table.put ([{NATURAL_8} 12, {NATURAL_8} 2], general_toogle_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 3], debugger_callstack_depth_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 3], debugger_error_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 3], debugger_expand_info_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 3], debugger_set_sizes_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 3], debugger_show_hex_value_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 3], breakpoints_enable_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 3], breakpoints_disable_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 3], viewer_wrap_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 3], viewer_expand_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 3], viewer_lock_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 3], viewer_formatting_name)
			a_table.put ([{NATURAL_8} 12, {NATURAL_8} 3], watch_auto_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 4], callstack_send_to_external_editor_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 4], callstack_is_melted_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 4], callstack_has_rescue_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 4], execution_record_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 4], execution_replay_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 4], execution_object_storage_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 4], hidden_show_in_callstack_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 4], hidden_hide_in_callstack_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 4], reserved_reserved_1_name)
			a_table.put ([{NATURAL_8} 10, {NATURAL_8} 4], reserved_reserved_2_name)
			a_table.put ([{NATURAL_8} 11, {NATURAL_8} 4], evaluation_refresh_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 5], new_feature_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 5], new_class_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 5], new_cluster_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 5], new_expression_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 5], new_library_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 5], new_assembly_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 5], new_watch_tool_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 5], new_window_name)
			a_table.put ([{NATURAL_8} 9, {NATURAL_8} 5], new_tool_edition_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 6], completion_remember_size_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 6], completion_filter_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 6], completion_show_disambiguants_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 6], completion_show_signature_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 6], completion_show_alias_name)
			a_table.put ([{NATURAL_8} 6, {NATURAL_8} 6], completion_show_return_type_name)
			a_table.put ([{NATURAL_8} 7, {NATURAL_8} 6], completion_show_assigner_name)
			a_table.put ([{NATURAL_8} 8, {NATURAL_8} 6], completion_show_obsolete_name)
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 7], bon_persistent_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 7], bon_interfaces_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 7], bon_effective_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 7], bon_deferred_name)
		end

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
