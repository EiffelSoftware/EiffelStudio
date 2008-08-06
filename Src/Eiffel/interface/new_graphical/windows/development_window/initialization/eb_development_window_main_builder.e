indexing
	description: "[
					Main Builder for EB_DEVELOPMENT_WINDOW.
					Build all tools and formatters.
																		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_MAIN_BUILDER

inherit
	EB_DEVELOPMENT_WINDOW_BUILDER
		redefine
			internal_recycle,
			internal_detach_entities
		end

create
	make

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the button has became useless.
		do
			if develop_window.docking_manager /= Void then
				develop_window.docking_manager.set_restoration_callback (Void)
			end
			Precursor {EB_DEVELOPMENT_WINDOW_BUILDER}
		end

	internal_detach_entities is
			-- Detaches objects from their container
		do

			Precursor {EB_DEVELOPMENT_WINDOW_BUILDER}
		end

feature -- Command

	init_size_and_position is
			-- Initialize window size.
		local
			l_screen: EB_STUDIO_SCREEN
			l_x, l_y: INTEGER
			l_data: EB_DEVELOPMENT_WINDOW_DATA
			l_border_width: INTEGER
		do
			-- There are two development window data (EB_DEVELOPMENT_WINDOW_DATA) saved.
			-- One is saved in preferences
			-- The other is saved in session manager
			-- Maybe we should divide the class EB_DEVELOPMENT_WINDOW_DATA into two classes?
			if(create {SHARED_WORKBENCH}).workbench.system_defined then
				l_data ?= develop_window.project_session_data.value (develop_window.development_window_data.development_window_data_id)
			end

			if l_data = Void then
				l_data := develop_window.development_window_data
			end
			create l_screen
				-- Take into account `border_width'
			l_border_width := (develop_window.window.width - develop_window.window.client_width) // 2

				-- When window is maximized, then the border might be slightly off screen.
			develop_window.window.set_size (
				l_data.width.min (l_screen.width + l_border_width * 2),
				l_data.height.min (l_screen.height + l_border_width * 2))

			l_x := l_data.x_position
			if (l_x + l_border_width) < l_screen.virtual_left or (l_x + l_border_width) > l_screen.virtual_right then
					-- Somehow screens have changed, reset it to 0
				l_x := 0
			end
			l_y := l_data.y_position
			if (l_y + l_border_width) < l_screen.virtual_top or (l_y + l_border_width) > l_screen.virtual_bottom then
					-- Somehow screens have changed, reset it to 0
				l_y := 0
			end
			develop_window.window.set_position (l_x, l_y)
		end

	safe_restore is
			-- Ensure that when restoring a window it appears on screen.
		local
			l_screen: EB_STUDIO_SCREEN
			l_x, l_y: INTEGER
			l_modified: BOOLEAN
		do
			create l_screen
			l_x := develop_window.development_window_data.x_position
			if l_x < l_screen.virtual_left or l_x > l_screen.virtual_right then
					-- Somehow screens have changed, reset it to 0
				l_x := 0
				l_modified := True
			end
			l_y := develop_window.development_window_data.y_position
			if l_y < l_screen.virtual_top or l_y > l_screen.virtual_bottom then
					-- Somehow screens have changed, reset it to 0
				l_y := 0
				l_modified := True
			end
			if l_modified then
				develop_window.window.set_position (l_x, l_y)
			end
		end

	init_commands is
			-- Initialize commands.
		local
			l_accel: EV_ACCELERATOR
			l_toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			l_new_tab_cmd: EB_NEW_TAB_EDITOR_COMMAND
			l_save_cmd: EB_SAVE_FILE_COMMAND
			l_save_as_cmd: EB_SAVE_FILE_AS_COMMAND
			l_save_all_cmd: EB_SAVE_ALL_FILE_COMMAND

			l_shell_cmd: EB_OPEN_SHELL_COMMAND
			l_print_cmd: EB_PRINT_COMMAND
			l_c_workbench_compilation_cmd: EB_C_COMPILATION_COMMAND
			l_c_finalized_compilation_cmd: EB_C_COMPILATION_COMMAND

			l_show_dynamic_lib_tool: EB_STANDARD_CMD
			l_show_profiler: EB_SHOW_PROFILE_TOOL

			l_undo_cmd: EB_UNDO_COMMAND
			l_redo_cmd: EB_REDO_COMMAND
			l_editor_cut_cmd: EB_EDITOR_CUT_COMMAND
			l_editor_copy_cmd: EB_EDITOR_COPY_COMMAND
			l_editor_paste_cmd: EB_EDITOR_PASTE_COMMAND
			l_new_cluster_cmd: EB_NEW_CLUSTER_COMMAND
			l_new_library_cmd: EB_NEW_LIBRARY_COMMAND
			l_new_assembly_cmd: EB_NEW_ASSEMBLY_COMMAND
			l_new_class_cmd: EB_NEW_CLASS_COMMAND
			l_delete_class_cluster_cmd: EB_DELETE_CLASS_CLUSTER_COMMAND
			l_new_feature_cmd: EB_NEW_FEATURE_COMMAND
			l_toggle_stone_cmd: EB_UNIFY_STONE_CMD
			l_send_stone_to_context_cmd: EB_STANDARD_CMD

			l_show_tool_commands: HASH_TABLE [EB_SHOW_TOOL_COMMAND, EB_TOOL]
			l_show_toolbar_commands: HASH_TABLE [EB_SHOW_TOOLBAR_COMMAND, SD_TOOL_BAR_CONTENT]
			l_editor_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
			l_simple_shortcut_commands: ARRAYED_LIST [EB_SIMPLE_SHORTCUT_COMMAND]

			l_reset_command: EB_RESET_LAYOUT_COMMAND
			l_save_layout_as_command: EB_SAVE_LAYOUT_AS_COMMAND
			l_open_layout_command: EB_OPEN_LAYOUT_COMMAND
			l_shortcut: SHORTCUT_PREFERENCE
			l_lock_tool_bar_command: EB_LOCK_TOOL_BAR_COMMAND
			l_lock_docking_command: EB_LOCK_DOCKING_COMMAND
			l_lock_editor_docking_command: EB_LOCK_EDITOR_DOCKING_COMMAND
			l_minimize_editors_command: EB_MINIMIZE_EDITORS_COMMAND
			l_restore_editors_command: EB_RESTORE_EDITORS_COMMAND

			l_editor_font_zoom_in_command: EB_EDITOR_FONT_ZOOM_IN_COMMAND
			l_editor_font_zoom_out_command: EB_EDITOR_FONT_ZOOM_OUT_COMMAND
			l_editor_font_zoom_reset_command: EB_EDITOR_FONT_ZOOM_RESET_COMMAND

			l_edit_contracts_command: ES_EDIT_CONTRACTS_COMMAND
		do
				-- Directly call a un-redefine init_commands in EB_DEVELOPMENT_WINDOW
				-- Non-docking Eiffel Studio was call Precursor
			develop_window.init_commands

			create l_toolbarable_commands.make (15)
			develop_window.commands.set_toolbarable_commands (l_toolbarable_commands)

			create l_simple_shortcut_commands.make (10)
			develop_window.commands.set_simple_shortcut_commands (l_simple_shortcut_commands)

				-- Open, save, ...
			create l_new_tab_cmd.make (develop_window)
			auto_recycle (l_new_tab_cmd)
			develop_window.commands.set_new_tab_cmd (l_new_tab_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.commands.new_tab_cmd)

			create l_save_cmd.make (develop_window)
			auto_recycle (l_save_cmd)
			develop_window.set_save_cmd (l_save_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.save_cmd)

			create l_save_as_cmd.make (develop_window)
			auto_recycle (l_save_as_cmd)
			develop_window.commands.set_save_as_cmd (l_save_as_cmd)
			if develop_window.editors_manager = Void or else
				develop_window.editors_manager.current_editor = Void or else
				develop_window.editors_manager.current_editor.is_empty
			then
				develop_window.commands.save_as_cmd.disable_sensitive
			else
				develop_window.commands.save_as_cmd.enable_sensitive
			end

			create l_save_all_cmd.make (develop_window)
			auto_recycle (l_save_all_cmd)
			develop_window.set_save_all_cmd (l_save_all_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.save_all_cmd)

			create l_shell_cmd.make (develop_window)
			auto_recycle (l_shell_cmd)
			develop_window.commands.set_shell_cmd (l_shell_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.commands.shell_cmd)

			create l_print_cmd.make (develop_window)
			auto_recycle (l_print_cmd)
			develop_window.commands.set_print_cmd (l_print_cmd)
			if develop_window.is_empty then
				develop_window.commands.print_cmd.disable_sensitive
			else
				develop_window.commands.print_cmd.enable_sensitive
			end
			develop_window.commands.toolbarable_commands.extend (develop_window.commands.print_cmd)

				-- Compilation
			create l_c_workbench_compilation_cmd.make_workbench (develop_window)
			auto_recycle (l_c_workbench_compilation_cmd)
			develop_window.commands.set_c_workbench_compilation_cmd (l_c_workbench_compilation_cmd)
			create l_c_finalized_compilation_cmd.make_finalized (develop_window)
			auto_recycle (l_c_finalized_compilation_cmd)
			develop_window.commands.set_c_finalized_compilation_cmd (l_c_finalized_compilation_cmd)
			if eiffel_layout.has_dll_generation then
				create l_show_dynamic_lib_tool.make
				auto_recycle (l_show_dynamic_lib_tool)
				develop_window.set_show_dynamic_lib_tool (l_show_dynamic_lib_tool)
				develop_window.show_dynamic_lib_tool.set_menu_name (develop_window.Interface_names.m_new_dynamic_lib)
				develop_window.show_dynamic_lib_tool.add_agent (agent develop_window.show_dynamic_library_dialog)
			end
			if eiffel_layout.has_profiler then
				create l_show_profiler
				auto_recycle (l_show_profiler)
				develop_window.commands.set_show_profiler (l_show_profiler)
			end

				-- Undo/redo, cut, copy, paste.
			create l_undo_cmd.make (develop_window)
			auto_recycle (l_undo_cmd)
			develop_window.commands.set_undo_cmd (l_undo_cmd)
			develop_window.commands.toolbarable_commands.extend (l_undo_cmd)

			create l_redo_cmd.make (develop_window)
			auto_recycle (l_redo_cmd)
			develop_window.commands.set_redo_cmd (l_redo_cmd)
			develop_window.commands.toolbarable_commands.extend (l_redo_cmd)

			create l_editor_cut_cmd.make (develop_window)
			auto_recycle (l_editor_cut_cmd)
			develop_window.commands.set_editor_cut_cmd (l_editor_cut_cmd)
			develop_window.commands.toolbarable_commands.extend (l_editor_cut_cmd)

			create l_editor_copy_cmd.make (develop_window)
			auto_recycle (l_editor_copy_cmd)
			develop_window.commands.set_editor_copy_cmd (l_editor_copy_cmd)
			develop_window.commands.toolbarable_commands.extend (l_editor_copy_cmd)

			create l_editor_paste_cmd.make (develop_window)
			auto_recycle (l_editor_paste_cmd)
			develop_window.commands.set_editor_paste_cmd (l_editor_paste_cmd)
			develop_window.commands.toolbarable_commands.extend (l_editor_paste_cmd)

			create l_new_cluster_cmd.make (develop_window)
			auto_recycle (l_new_cluster_cmd)
			develop_window.commands.set_new_cluster_cmd (l_new_cluster_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_cluster_cmd)

			create l_new_library_cmd.make (develop_window)
			auto_recycle (l_new_library_cmd)
			develop_window.commands.set_new_library_cmd (l_new_library_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_library_cmd)

			create l_new_assembly_cmd.make (develop_window)
			auto_recycle (l_new_assembly_cmd)
			develop_window.commands.set_new_assembly_cmd (l_new_assembly_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_assembly_cmd)

			create l_new_class_cmd.make (develop_window)
			auto_recycle (l_new_class_cmd)
			develop_window.commands.set_new_class_cmd (l_new_class_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_class_cmd)

			create l_delete_class_cluster_cmd.make (develop_window)
			auto_recycle (l_delete_class_cluster_cmd)
			develop_window.commands.set_delete_class_cluster_cmd (l_delete_class_cluster_cmd)
			develop_window.commands.toolbarable_commands.extend (l_delete_class_cluster_cmd)

			create l_new_feature_cmd.make (develop_window)
			auto_recycle (l_new_feature_cmd)
			develop_window.commands.set_new_feature_cmd (l_new_feature_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_feature_cmd)

			create l_toggle_stone_cmd.make (develop_window)
			auto_recycle (l_toggle_stone_cmd)
			develop_window.commands.set_toggle_stone_cmd (l_toggle_stone_cmd)
			develop_window.commands.toolbarable_commands.extend (l_toggle_stone_cmd)

			create l_send_stone_to_context_cmd.make
			auto_recycle (l_send_stone_to_context_cmd)
			develop_window.commands.set_send_stone_to_context_cmd (l_send_stone_to_context_cmd)
			l_send_stone_to_context_cmd.set_pixmap (develop_window.pixmaps.icon_pixmaps.context_sync_icon)
			l_send_stone_to_context_cmd.set_pixel_buffer (develop_window.pixmaps.icon_pixmaps.context_sync_icon_buffer)
			l_send_stone_to_context_cmd.set_tooltip (develop_window.Interface_names.e_send_stone_to_context)
			l_send_stone_to_context_cmd.set_menu_name (develop_window.Interface_names.m_send_stone_to_context)
			l_send_stone_to_context_cmd.set_name ("Send_to_context")
			l_send_stone_to_context_cmd.set_tooltext (develop_window.Interface_names.b_send_stone_to_context)
			l_send_stone_to_context_cmd.add_agent (agent develop_window.send_stone_to_context)
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("send_to_context")
			create l_accel.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			l_accel.actions.extend (agent develop_window.send_stone_to_context)
			l_send_stone_to_context_cmd.set_accelerator (l_accel)
			l_send_stone_to_context_cmd.set_referred_shortcut (l_shortcut)
			l_send_stone_to_context_cmd.disable_sensitive
			develop_window.commands.toolbarable_commands.extend (l_send_stone_to_context_cmd)

			develop_window.commands.toolbarable_commands.extend (develop_window.window_manager.minimize_all_cmd)
			develop_window.window_manager.minimize_all_cmd.enable_sensitive
			develop_window.commands.toolbarable_commands.extend (develop_window.window_manager.raise_all_cmd)
			develop_window.window_manager.raise_all_cmd.enable_sensitive

			develop_window.commands.toolbarable_commands.extend (develop_window.New_development_window_cmd)
				-- Show tool/toolbar commands (will be filled when tools will
				-- be created)

			create l_show_tool_commands.make (7)
			develop_window.commands.set_show_tool_commands (l_show_tool_commands)
			create l_show_toolbar_commands.make (3)
			develop_window.commands.set_show_toolbar_commands (l_show_toolbar_commands)
			create l_editor_commands.make (10)
			develop_window.commands.set_editor_commands (l_editor_commands)
			develop_window.commands.set_show_shell_tool_commands (create {HASH_TABLE [ES_SHOW_TOOL_COMMAND, ES_TOOL [EB_TOOL]]}.make (1))

			develop_window.commands.new_feature_cmd.disable_sensitive

			create l_reset_command.make (develop_window)
			develop_window.commands.set_reset_layout_command (l_reset_command)

			create l_save_layout_as_command.make (develop_window)
			develop_window.commands.set_save_layout_as_command (l_save_layout_as_command)

			create l_open_layout_command.make (develop_window)
			develop_window.commands.set_open_layout_command (l_open_layout_command)

			create l_lock_tool_bar_command.make (develop_window)
			develop_window.commands.set_lock_tool_bar_command (l_lock_tool_bar_command)

			create l_lock_docking_command.make (develop_window)
			develop_window.commands.set_lock_docking_command (l_lock_docking_command)

			create l_lock_editor_docking_command.make (develop_window)
			develop_window.commands.set_lock_editor_docking_command (l_lock_editor_docking_command)

			create l_minimize_editors_command.make (develop_window)
			develop_window.commands.set_minimize_editors_command (l_minimize_editors_command)

			create l_restore_editors_command.make (develop_window)
			develop_window.commands.set_restore_editors_command (l_restore_editors_command)

			create l_editor_font_zoom_in_command.make (develop_window)
			develop_window.commands.set_editor_font_zoom_in_command (l_editor_font_zoom_in_command)
			create l_editor_font_zoom_out_command.make (develop_window)
			develop_window.commands.set_editor_font_zoom_out_command (l_editor_font_zoom_out_command)
			create l_editor_font_zoom_reset_command.make (develop_window)
			develop_window.commands.set_editor_font_zoom_reset_command (l_editor_font_zoom_reset_command)

			develop_window.commands.set_customized_formatter_command (create {EB_SETUP_CUSTOMIZED_FORMATTER_COMMAND})
			develop_window.commands.set_customized_tool_command (create {EB_SETUP_CUSTOMIZED_TOOL_COMMAND})

			create l_edit_contracts_command.make (develop_window.shell_tools.tool ({ES_CONTRACT_TOOL}))
			develop_window.commands.set_edit_contracts_command (l_edit_contracts_command)

				-- Add history commands to toolbarable_commands.
				-- Setup its accelerators.
			l_toolbarable_commands.extend (develop_window.history_manager.back_command)
			l_toolbarable_commands.extend (develop_window.history_manager.forth_command)
			setup_history_back_and_forth_commands

			setup_focus_editor_accelerators
			build_close_content_accelerator
			setup_class_address_accelerators
		end

	init_tool_commands
			-- Initializes all command that require associated tools to be initialized prior to use
		local
			l_go_to_next_error_cmd: ES_NEXT_ERROR_COMMAND
			l_go_to_previous_error_cmd: ES_PREVIOUS_ERROR_COMMAND
			l_go_to_next_warning_cmd: ES_NEXT_WARNING_COMMAND
			l_go_to_previous_warning_cmd: ES_PREVIOUS_WARNING_COMMAND
			l_ear_commander: ES_ERROR_LIST_COMMANDER_I
			l_maximize_editor_area_command: EB_MAXIMIZE_EDITOR_AREA_COMMAND
			l_minimize_editor_area_command: EB_MINIMIZE_EDITOR_AREA_COMMAND
			l_restore_editor_area_command: EB_RESTORE_EDITOR_AREA_COMMAND
		do
				-- Error navigation
			l_ear_commander ?= develop_window.shell_tools.tool ({ES_ERROR_LIST_TOOL})
			check
				l_ear_commander_attached: l_ear_commander /= Void
			end
			if l_ear_commander /= Void then
				create l_go_to_previous_error_cmd.make (l_ear_commander)
				develop_window.commands.set_go_to_previous_error_command (l_go_to_previous_error_cmd)
				develop_window.commands.toolbarable_commands.extend (develop_window.commands.go_to_previous_error_command)

				create l_go_to_next_error_cmd.make (l_ear_commander)
				develop_window.commands.set_go_to_next_error_command (l_go_to_next_error_cmd)
				develop_window.commands.toolbarable_commands.extend (develop_window.commands.go_to_next_error_command)

				create l_go_to_previous_warning_cmd.make (l_ear_commander)
				develop_window.commands.set_go_to_previous_warning_command (l_go_to_previous_warning_cmd)
				develop_window.commands.toolbarable_commands.extend (develop_window.commands.go_to_previous_warning_command)

				create l_go_to_next_warning_cmd.make (l_ear_commander)
				develop_window.commands.set_go_to_next_warning_command (l_go_to_next_warning_cmd)
				develop_window.commands.toolbarable_commands.extend (develop_window.commands.go_to_next_warning_command)

				create l_maximize_editor_area_command.make (develop_window)
				develop_window.commands.set_maximize_editor_area_command (l_maximize_editor_area_command)

				create l_minimize_editor_area_command.make (develop_window)
				develop_window.commands.set_minimize_editor_area_command (l_minimize_editor_area_command)

				create l_restore_editor_area_command.make (develop_window)
				develop_window.commands.set_restore_editor_area_command (l_restore_editor_area_command)
			end
		end

	setup_history_back_and_forth_commands is
			-- Setup accelerators for back and forth commands.
		local
			l_shortcut: SHORTCUT_PREFERENCE
			l_cmd: EB_HISTORY_COMMAND
			l_accel: EV_ACCELERATOR
		do
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("go_forth")
			create l_accel.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			l_accel.actions.extend (agent (develop_window.agents).on_forth)
			l_cmd := develop_window.history_manager.forth_command
			l_cmd.set_referred_shortcut (l_shortcut)
			l_cmd.set_accelerator (l_accel)

			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("go_back")
			create l_accel.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			l_accel.actions.extend (agent (develop_window.agents).on_back)
			l_cmd := develop_window.history_manager.back_command
			l_cmd.set_referred_shortcut (l_shortcut)
			l_cmd.set_accelerator (l_accel)
		end

	set_up_accelerators is
			-- All proper configurable shortcut is related to the window.
		do
			develop_window.refresh_all_commands
		end

	build_formatters is
			-- Build all formatters used.
		local
			l_form: EB_CLASS_TEXT_FORMATTER

			l_managed_class_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
			l_managed_feature_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			l_managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			l_managed_dependency_formatters: ARRAYED_LIST [EB_DEPENDENCY_FORMATTER]
		do
			create l_managed_class_formatters.make (17)
			develop_window.set_managed_class_formatters (l_managed_class_formatters)
			l_managed_class_formatters.extend (create {EB_CLICKABLE_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_FLAT_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_SHORT_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_FLAT_SHORT_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (Void)
			l_managed_class_formatters.extend (create {EB_ANCESTORS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_DESCENDANTS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_CLIENTS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_SUPPLIERS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (Void)
			l_managed_class_formatters.extend (create {EB_ATTRIBUTES_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_ROUTINES_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_INVARIANTS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_CREATORS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_DEFERREDS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_ONCES_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_EXTERNALS_FORMATTER}.make (develop_window))
			l_managed_class_formatters.extend (create {EB_EXPORTED_FORMATTER}.make (develop_window))

			create l_managed_feature_formatters.make (12)
			develop_window.set_managed_feature_formatters (l_managed_feature_formatters)
			l_managed_feature_formatters.extend (create {EB_BASIC_FEATURE_FORMATTER}.make (develop_window))
			l_managed_feature_formatters.extend (create {EB_ROUTINE_FLAT_FORMATTER}.make (develop_window))
			l_managed_feature_formatters.extend (Void)
			l_managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (develop_window, 0))
			l_managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (develop_window,
				{DEPEND_UNIT}.is_in_assignment_flag))
			l_managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (develop_window,
				{DEPEND_UNIT}.is_in_creation_flag))
			l_managed_feature_formatters.extend (Void)

			l_managed_feature_formatters.extend (create {EB_CALLEES_FORMATTER}.make (develop_window, 0))
			l_managed_feature_formatters.extend (create {EB_CALLEES_FORMATTER}.make (develop_window,
				{DEPEND_UNIT}.is_in_assignment_flag))
			l_managed_feature_formatters.extend (create {EB_CALLEES_FORMATTER}.make (develop_window,
				{DEPEND_UNIT}.is_in_creation_flag))
			l_managed_feature_formatters.extend (Void)

			l_managed_feature_formatters.extend (create {EB_IMPLEMENTERS_FORMATTER}.make (develop_window))
			l_managed_feature_formatters.extend (create {EB_ROUTINE_ANCESTORS_FORMATTER}.make (develop_window))
			l_managed_feature_formatters.extend (create {EB_ROUTINE_DESCENDANTS_FORMATTER}.make (develop_window))
			l_managed_feature_formatters.extend (Void)
			l_managed_feature_formatters.extend (create {EB_HOMONYMS_FORMATTER}.make (develop_window))

			create l_managed_dependency_formatters.make (2)
			develop_window.set_managed_dependency_formatters (l_managed_dependency_formatters)
			l_managed_dependency_formatters.extend (create {EB_CLIENT_DEPENDENCY_FORMATTER}.make (develop_window))
			l_managed_dependency_formatters.extend (create {EB_SUPPLIER_DEPENDENCY_FORMATTER}.make (develop_window))

			create l_managed_main_formatters.make (6)
			develop_window.set_managed_main_formatters (l_managed_main_formatters)

			create {EB_BASIC_TEXT_FORMATTER} l_form.make (develop_window)
			setup_main_formatter (l_form, "basic_text_view")
			l_managed_main_formatters.extend (l_form)

			create {EB_CLICKABLE_FORMATTER} l_form.make (develop_window)
			setup_main_formatter (l_form, "clickable_text_view")
			l_managed_main_formatters.extend (l_form)

			create {EB_FLAT_FORMATTER} l_form.make (develop_window)
			setup_main_formatter (l_form, "flat_view")
			l_managed_main_formatters.extend (l_form)

			create {EB_SHORT_FORMATTER} l_form.make (develop_window)
			setup_main_formatter (l_form, "contract_view")
			l_managed_main_formatters.extend (l_form)

			create {EB_FLAT_SHORT_FORMATTER} l_form.make (develop_window)
			setup_main_formatter (l_form, "interface_view")
			l_managed_main_formatters.extend (l_form)
		end

	end_build_formatters is
			-- Finish initialization of formatters (associate them with editor
			-- and select a formatter).
		local
			l_f_ind: INTEGER
			l_managed_class_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
			l_managed_feature_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			l_managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			l_managed_dependency_formatters: ARRAYED_LIST [EB_DEPENDENCY_FORMATTER]
			l_editor_displayer: EB_FORMATTER_EDITOR_DISPLAYER
		do
			from
				l_managed_class_formatters := develop_window.managed_class_formatters
				l_managed_class_formatters.start
			until
				l_managed_class_formatters.after
			loop
				if l_managed_class_formatters.item /= Void then
					l_managed_class_formatters.item.set_manager (develop_window.tools)
				end
				l_managed_class_formatters.forth
			end
			from
				l_managed_feature_formatters := develop_window.managed_feature_formatters
				l_managed_feature_formatters.start
			until
				l_managed_feature_formatters.after
			loop
				if l_managed_feature_formatters.item /= Void then
					l_managed_feature_formatters.item.set_manager (develop_window.tools)
				end
				l_managed_feature_formatters.forth
			end
			create l_editor_displayer.make (develop_window.editors_manager.current_editor)
			from
				l_managed_main_formatters := develop_window.managed_main_formatters
				l_managed_main_formatters.start
			until
				l_managed_main_formatters.after
			loop
				if develop_window.editors_manager.current_editor /= Void then
					l_managed_main_formatters.item.set_editor_displayer (l_editor_displayer)
					l_managed_main_formatters.item.set_should_displayer_be_recycled (True)
				end
				l_managed_main_formatters.item.on_shown
				l_managed_main_formatters.forth
			end

			from
				l_managed_dependency_formatters := develop_window.managed_dependency_formatters
				l_managed_dependency_formatters.start
			until
				l_managed_dependency_formatters.after
			loop
				if l_managed_dependency_formatters.item /= Void then
					l_managed_dependency_formatters.item.set_manager (develop_window.tools)
				end
				l_managed_dependency_formatters.forth
			end

			(l_managed_main_formatters @ 1).enable_select;

				-- We now select the correct class formatter.
			l_f_ind := develop_window.preferences.context_tool_data.default_class_formatter_index
				--| This takes the formatter separators in consideration.
			if l_f_ind > 4 then
				l_f_ind := l_f_ind + 1
			end
			if l_f_ind > 8 then
				l_f_ind := l_f_ind + 1
			end
			if l_f_ind < 1 or l_f_ind > develop_window.managed_class_formatters.count then
				l_f_ind := 6
			end
			(develop_window.managed_class_formatters @ l_f_ind).enable_select;
				-- We now select the correct feature formatter.
			l_f_ind := develop_window.preferences.context_tool_data.default_feature_formatter_index
			if l_f_ind > 2 then
				l_f_ind := l_f_ind + 1
			end
			if l_f_ind < 1 or l_f_ind > develop_window.managed_feature_formatters.count then
				l_f_ind := 2
			end
			develop_window.managed_class_formatters.i_th (l_f_ind).enable_select

			l_f_ind := develop_window.preferences.context_tool_data.default_dependency_formatter_index
			if l_f_ind < 1 or l_f_ind > develop_window.managed_dependency_formatters.count then
				l_f_ind := 1
			end
			develop_window.managed_dependency_formatters.i_th (l_f_ind).enable_select
		end

	build_tools is
			-- Build all tools that can take place in this window and attach them with docking manager.
		local
			l_undo_redo_observer: UNDO_REDO_OBSERVER

			l_docking_manager: SD_DOCKING_MANAGER
			l_editors_manager: EB_EDITORS_MANAGER
			l_names: EB_DOCKING_NAMES
			l_sd_shared: SD_SHARED

		do
			develop_window.lock_update

				-- Set interface names for docking library.
			create l_sd_shared
			create l_names
			l_sd_shared.set_interface_names (l_names)

				-- Initialize docking manager.
			create l_docking_manager.make (develop_window.panel, develop_window.window)
			develop_window.set_docking_manager (l_docking_manager)
			develop_window.docking_manager.set_main_area_background_color ((create {EV_STOCK_COLORS}).grey)
			l_docking_manager.set_restoration_callback (agent retrieve_docking_content)

				-- Build dynmaic tools
			build_shell_tools

				-- Build the features tool
			build_customized_tools

			create l_editors_manager.make (develop_window)
			develop_window.set_editors_manager (l_editors_manager)

			l_editors_manager.add_edition_observer (develop_window.save_cmd)
			l_editors_manager.add_edition_observer (develop_window.commands.save_as_cmd)

			l_editors_manager.add_edition_observer (develop_window.save_all_cmd)

 			l_editors_manager.add_edition_observer (develop_window.commands.print_cmd)
			l_editors_manager.add_edition_observer (develop_window.agents)
			l_editors_manager.add_edition_observer (develop_window.tools.search_tool)
			l_editors_manager.add_cursor_observer (develop_window.agents)

			l_undo_redo_observer ?= develop_window.commands.undo_cmd
			check
				l_undo_redo_observer /= Void
			end
			develop_window.editors_manager.editor_switched_actions.extend (agent (a_editor: EB_SMART_EDITOR; a_observer: UNDO_REDO_OBSERVER) do a_observer.on_changed end (?, l_undo_redo_observer))

			l_undo_redo_observer ?= develop_window.commands.redo_cmd
			check
				l_undo_redo_observer /= Void
			end
			develop_window.editors_manager.editor_switched_actions.extend (agent (a_editor: EB_SMART_EDITOR; a_observer: UNDO_REDO_OBSERVER) do a_observer.on_changed end (?, l_undo_redo_observer))

				-- Refresh cursor position.
			develop_window.editors_manager.editor_switched_actions.extend (agent (a_editor: EB_SMART_EDITOR) do develop_window.refresh_cursor_position end)

				-- Following comments arr from non-docking Eiffel Studio
				-- The minimim height masks a bug on windows to do with the sizing of the editors
				-- scroll bars, which were affecting the resizing although they should not have done so.
				-- Having a default minimum height on the editor is perfectly reasonable.
				--			develop_window.tools.editor_tool.widget.set_minimum_height (20)

				-- Build the refactoring tools
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.pull_command)
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.rename_command)
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.undo_command)
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.redo_command)

				-- Force build
				-- FIXME: We force the tools to be built completely here in order to perform
				--        the necessary registration with parts of ES. This is only to preserve
				--        backwards compatibility with the older model until the tools have been
				--        fully converted to the dynamic model.
				-- Note:  Fetching the tool panel will cause it to be created.
			develop_window.shell_tools.tool ({ES_C_OUTPUT_TOOL}).panel.do_nothing

				-- Set the flag "Tools initialized"
			develop_window.set_tools_initialized (True)

			build_undo_redo_accelerators

			develop_window.unlock_update
		end

	prepare_editor_tool is
			-- Build address toolbar and docking manager.
		local
			l_editors_widget_for_docking: EV_HORIZONTAL_BOX
			l_editors_widget: EV_VERTICAL_BOX
		do
			create l_editors_widget_for_docking

			create l_editors_widget
			develop_window.ui.set_editors_widget (l_editors_widget)

			l_editors_widget.extend (l_editors_widget_for_docking)
		end

	build_vision_window is
			-- Build development window
		local
			l_window: EB_VISION_WINDOW
		do
				-- Vision2 initialization
			create l_window
			develop_window.set_window (l_window)
			register_action (l_window.restore_actions, agent safe_restore)
			init_size_and_position
			l_window.close_request_actions.wipe_out
			register_action (l_window.close_request_actions, agent develop_window.destroy)
			l_window.set_icon_pixmap (develop_window.pixmap)

			register_action (l_window.resize_actions, agent develop_window.save_size)
			register_action (l_window.move_actions, agent develop_window.save_position)

				-- Initialize commands and connect them.
			init_commands

				-- Build widget system & menus.
			build_interface

				-- Initialize commands and connect them.
			init_tool_commands
		end

	build_help_engine is
			-- Build help engine and focus in actions.
		local
			l_help_engine: EB_HELP_ENGINE
		do
				-- Set up the minimize title if it's not done
			if develop_window.minimized_title = Void or else develop_window.minimized_title.is_empty then
				develop_window.set_minimized_title (develop_window.title)
			end

			create l_help_engine.make
			develop_window.set_help_engine (l_help_engine)
			develop_window.register_action (develop_window.window.focus_in_actions, agent (develop_window.window_manager).set_focused_window (develop_window))
			develop_window.set_initialized_for_builder (True)
		end

	build_interface is
			-- Build system widget.
		local
			l_cell: EV_CELL
			l_stb: EV_STATUS_BAR

			l_favorites_manager: EB_FAVORITES_MANAGER
			l_cluster_manager: EB_CLUSTER_MANAGER
			l_container: EV_VERTICAL_BOX
			l_panel: EV_CELL
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			-- Build widgets -------------------------------------------

				-- Set up the favorites, the history, ...
			create l_favorites_manager.make (develop_window)
			develop_window.set_favorites_manager (l_favorites_manager)
				-- The favorites manager is already collected by the favorites tool.
			auto_recycle (l_favorites_manager)

			create l_cluster_manager.make (develop_window)
			develop_window.set_cluster_manager (l_cluster_manager)
			auto_recycle (l_cluster_manager)

				-- Set up the name of the window.
			develop_window.set_title (develop_window.Interface_names.t_Empty_development_window)
			develop_window.set_minimized_title (develop_window.Interface_names.t_Empty_development_window)

				-- Create the main container and the left + right panels.
			create l_container
			develop_window.set_container (l_container)

			develop_window.window.extend (develop_window.container)

			create l_panel
			develop_window.set_panel (l_panel)

				-- Create the status bar.
			create l_status_bar.make
			develop_window.set_status_bar (l_status_bar)
			auto_recycle (l_status_bar)

				-- Build all tools that can take place in this window.
			build_tools

			-- Build the layout -------------------------------------------

				-- Add the content of the window (left bar + right cell).
			l_container.extend (l_panel)

				-- Add a cell for spacing (we cannot use padding: there are toolbars coming).
			create l_cell
			l_cell.set_minimum_height (2)
			develop_window.container.extend (l_cell)
			develop_window.container.disable_item_expand (l_cell)

				-- And the status bar.
			l_stb := develop_window.status_bar.widget
			l_container.extend (l_stb)
			l_container.disable_item_expand (l_stb)

			setup_editor_close_action
		end

	register_customized_tools (a_tools: LIST [EB_CUSTOMIZED_TOOL]) is
			-- Register `a_tools' into `develop_window'.
		require
			a_tools_attached: a_tools /= Void
			a_tools_valid: not a_tools.has (Void)
		local
			l_cursor: CURSOR
			l_menu_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		do
				-- Register `a_tools' into `develop_window'.
			l_cursor := a_tools.cursor
			from
				a_tools.start
			until
				a_tools.after
			loop
				setup_tool (a_tools.item, a_tools.item.title_for_pre)
				a_tools.item.force_reload
				develop_window.tools.customized_tools.extend (a_tools.item)
				a_tools.forth
			end
			a_tools.go_to (l_cursor)

				-- Setup menus.
			create l_menu_builder.make (develop_window)
			l_menu_builder.attach_customized_tools (a_tools)
		end

	deregister_customized_tool (a_tool: EB_CUSTOMIZED_TOOL) is
			-- Delete `a_tool' from `develop_window'.
		require
			a_tool_attached: a_tool /= Void
		local
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_cmds: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
		do
			if a_tool.content /= Void then
				a_tool.content.close
			end

				--Remove `a_tool' from `develop_window'.`customized_tools'.
			develop_window.tools.customized_tools.start
			develop_window.tools.customized_tools.search (a_tool)
			if not develop_window.tools.customized_tools.exhausted then
				develop_window.tools.customized_tools.remove
			end

			develop_window.menus.remove_item_from_tools_list_menu (a_tool)

				-- Remove and recycle related command.
			l_show_cmd := develop_window.commands.show_tool_commands.item (a_tool)
			if l_show_cmd /= Void then
				l_cmds := develop_window.commands.toolbarable_commands
				develop_window.commands.show_tool_commands.remove (a_tool)
				l_cmds.start
				l_cmds.search (l_show_cmd)
				if not l_cmds.exhausted then
					l_cmds.remove
				end
				auto_recycle (a_tool)
			end
		end

feature {NONE} -- Access

	frozen tool_utils: ES_TOOL_UTILITIES
			-- Shared access to tool shim utilities
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Tool construction

	build_shell_tools is
			-- Builds all dynamically activated tools of {ES_SHELL_TOOLS}.
		do
			develop_window.shell_tools.all_tools.do_all (agent setup_shell_tool)
		end

	setup_shell_tool (a_tool: ES_TOOL [EB_TOOL]) is
			-- Sets up a dynamically created tool's shortcut, and commands.
		require
			a_tool_not_void: a_tool /= Void
		local
			l_show_cmd: ES_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
			l_shortcut: SHORTCUT_PREFERENCE
		do
			create l_show_cmd.make (a_tool)
			auto_recycle (l_show_cmd)
			develop_window.commands.show_shell_tool_commands.force (l_show_cmd, a_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			if a_tool.shortcut_preference_name /= Void and then a_tool.edition = 1 then
					-- Create shortcuts for first edition only!
				l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item (a_tool.shortcut_preference_name)
				if l_shortcut /= Void then
					create l_accel.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
					l_accel.actions.extend (agent l_show_cmd.execute)
					l_show_cmd.set_accelerator (l_accel)
					l_show_cmd.set_referred_shortcut (l_shortcut)
				end
			end
		end

feature {NONE} -- Docking

	frozen retrieve_docking_content (a_tool_id: STRING_GENERAL): SD_CONTENT is
			-- Performs dynamic creation of tools when restoration of the docked layout requires them.
			--
			-- `a_tool_id': The unique title for the persisted docking content.
			-- `Result': The docking content, attatched to the docking manager or Void if the
			--           tool id is indvalid.
		require
			a_tool_id_attached: a_tool_id /= Void
			not_a_tool_id_is_empty: not a_tool_id.is_empty
		local
			l_tool: ES_TOOL [EB_TOOL]
			l_info: TUPLE [type: TYPE [ES_TOOL [EB_TOOL]]; edition: NATURAL_8]
			l_eb_debugger_manager: EB_DEBUGGER_MANAGER
			l_ignore: BOOLEAN
			l_internal: INTERNAL
		do
			l_eb_debugger_manager ?= develop_window.debugger_manager
			check not_void: l_eb_debugger_manager /= Void end
			if not l_eb_debugger_manager.raised then
				-- We don't restore debug related tools for non-debug mode.
				create l_internal
				check exists: l_internal.dynamic_type_from_string ("ES_CALL_STACK_TOOL") /= -1 end
				check exists: l_internal.dynamic_type_from_string ("ES_OBJECTS_TOOL") /= -1 end
				check exists: l_internal.dynamic_type_from_string ("ES_OBJECT_VIEWER_TOOL") /= -1 end
				check exists: l_internal.dynamic_type_from_string ("ES_WATCH_TOOL") /= -1 end
				check exists: l_internal.dynamic_type_from_string ("ES_THREADS_TOOL") /= -1 end
				check exists: l_internal.dynamic_type_from_string ("ES_BREAKPOINTS_TOOL") /= -1 end
				if a_tool_id.as_string_8.is_equal ("ES_CALL_STACK_TOOL") or
					a_tool_id.as_string_8.is_equal ("ES_OBJECTS_TOOL") or
					a_tool_id.as_string_8.is_equal ("ES_OBJECT_VIEWER_TOOL") or
					a_tool_id.as_string_8.has_substring  ("ES_WATCH_TOOL") or -- We use `has_substring' here since second watch tool's name is ES_WATCH_TOOL:2, 3rd tool's name is ES_WATCH_TOOL:3, ...
					a_tool_id.as_string_8.is_equal ("ES_THREADS_TOOL") or
					a_tool_id.as_string_8.is_equal ("ES_BREAKPOINTS_TOOL") then
					l_ignore := True
				end
			end
			if not l_ignore then
				l_info := tool_utils.tool_info (a_tool_id)
				if l_info /= Void and then l_info.edition = 1 then
						-- We only want to rebuild first edition tools! We might want to change this in the future.
					l_tool := develop_window.shell_tools.tool_next_available_edition (l_info.type, True)
					if l_tool /= Void then
						check
								-- This check is just for the future, if we support reinstantiation of multiple editions.
							l_tool_is_supporting_multiple_instance: l_tool.edition > 1 implies l_tool.is_supporting_multiple_instances
						end

							-- The following initialize the tool and attached it to the docking manager.
						Result := l_tool.panel.content
					end
				end
			end
		end

feature{NONE} -- Implementation

	build_customized_tools is
			-- Build customized tools.
		local
			l_customized_tool: EB_CUSTOMIZED_TOOL
			l_manager: EB_CUSTOMIZED_TOOL_MANAGER
			l_descriptors: LIST [EB_CUSTOMIZED_TOOL_DESP]
			l_tools: LIST [EB_CUSTOMIZED_TOOL]
		do
			l_manager := develop_window.customized_tool_manager
			l_tools := develop_window.tools.customized_tools
			l_tools.wipe_out
			if not l_manager.is_loaded then
				l_manager.load (Void)
			end
			if l_manager.has_tools then
				from
					l_descriptors := l_manager.tool_descriptors
					l_descriptors.start
				until
					l_descriptors.after
				loop
					l_customized_tool := l_descriptors.item.new_tool (develop_window)
					setup_tool (l_customized_tool, l_customized_tool.id)
					l_tools.extend (l_customized_tool)
					l_descriptors.forth
				end
			end
		end

	setup_tool (a_tool: EB_TOOL; a_shortcut_string: STRING) is
			-- Setup tool.
		require
			a_tool_not_void: a_tool /= Void
			a_shortcut_string_not_void: a_shortcut_string /= Void
		local
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
			l_shortcut: SHORTCUT_PREFERENCE
		do
			a_tool.attach_to_docking_manager (develop_window.docking_manager)

			create l_show_cmd.make (develop_window, a_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, a_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)
			auto_recycle (a_tool)

			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item (a_shortcut_string)
			if l_shortcut /= Void then
				create l_accel.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
				l_accel.actions.extend (agent l_show_cmd.execute)
				l_show_cmd.set_accelerator (l_accel)
				l_show_cmd.set_referred_shortcut (l_shortcut)
			end
		end

	setup_main_formatter (a_form: EB_CLASS_TEXT_FORMATTER; a_shortcut_string: STRING) is
			-- Setup formatter.
		require
			a_form_not_void: a_form /= Void
			a_shortcut_string_not_void: a_shortcut_string /= Void
		local
			l_accel: EV_ACCELERATOR
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item (a_shortcut_string)
			create l_accel.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			l_accel.actions.extend (agent develop_window.save_and_switch_formatter (a_form))
			a_form.set_accelerator (l_accel)
			a_form.set_viewpoints (develop_window.view_points_combo)
			a_form.post_execution_action.extend (agent develop_window.update_viewpoints)
			a_form.set_referred_shortcut (l_shortcut)
		end

	build_undo_redo_accelerators is
			-- Initialize undo / redo accelerators.
		local
			l_undo_accelerator: EV_ACCELERATOR
			l_redo_accelerator: EV_ACCELERATOR
			l_shortcut: EB_FIXED_SHORTCUT
		do
			l_shortcut := develop_window.preferences.misc_shortcut_data.undo_shortcut
			create l_undo_accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_alt, l_shortcut.is_ctrl, l_shortcut.is_shift)
			develop_window.set_undo_accelerator (l_undo_accelerator)

			if eiffel_layout.has_diagram then
				l_undo_accelerator.actions.extend (agent (develop_window.tools.diagram_tool.undo_cmd).on_ctrl_z)
			end

			l_shortcut := develop_window.preferences.misc_shortcut_data.redo_shortcut
			create l_redo_accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_alt, l_shortcut.is_ctrl, l_shortcut.is_shift)
			if eiffel_layout.has_diagram then
				l_redo_accelerator.actions.extend (agent (develop_window.tools.diagram_tool.redo_cmd).on_ctrl_y)
			end
			develop_window.window.accelerators.extend (l_undo_accelerator)
			develop_window.window.accelerators.extend (l_redo_accelerator)
		end

	build_close_content_accelerator is
			-- Build content close accelerator.
		local
			l_acc: EV_ACCELERATOR
			l_shortcut: SHORTCUT_PREFERENCE
			l_cmd: EB_SIMPLE_SHORTCUT_COMMAND
		do
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("close_focusing_docking_tool_or_editor")
			create l_acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_alt, l_shortcut.is_ctrl, l_shortcut.is_shift)
			l_acc.actions.extend (agent develop_window.close_focusing_content)

			create l_cmd.make (l_acc)
			l_cmd.set_referred_shortcut (l_shortcut)
			develop_window.commands.simple_shortcut_commands.extend (l_cmd)
		end

	setup_editor_close_action is
			-- Setup editor commands in editors manager.
			-- so that they are correctly disable when there is no editor open.
		do
			develop_window.editors_manager.editor_closed_actions.extend (agent (a_editor: EB_SMART_EDITOR) do develop_window.all_editor_closed end)
		end

	setup_focus_editor_accelerators is
			-- Setup accelerators of focusing current editor.
		local
			l_acc: EV_ACCELERATOR
			l_shortcut: EB_FIXED_SHORTCUT
		do
			l_shortcut := develop_window.preferences.misc_shortcut_data.focus_editor_shortcut
			create l_acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			l_acc.actions.extend (agent develop_window.set_focus_to_main_editor)
				-- We need to add it out of managed configurable shortcuts.
			check
				accelerator_not_exist: not develop_window.window.accelerators.has (l_acc)
			end
			develop_window.window.accelerators.extend (l_acc)
		end

	setup_class_address_accelerators is
			-- Setup accelerators for focus class combo box.
		local
			l_acc: EV_ACCELERATOR
			l_shortcut: SHORTCUT_PREFERENCE
			l_cmd: EB_SIMPLE_SHORTCUT_COMMAND
		do
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("focus_on_class_address")
			create l_acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_alt, l_shortcut.is_ctrl, l_shortcut.is_shift)
			l_acc.actions.extend (agent (develop_window.address_manager).set_focus)

			create l_cmd.make (l_acc)
			l_cmd.set_referred_shortcut (l_shortcut)
			develop_window.commands.simple_shortcut_commands.extend (l_cmd)
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

end
