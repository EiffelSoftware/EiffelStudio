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

create
	make

feature -- Command

	init_size_and_position is
			-- Initialize window size.
		local
			l_screen: EB_STUDIO_SCREEN
			l_x, l_y: INTEGER
		do
			create l_screen
			develop_window.window.set_size (
				develop_window.development_window_data.width.min (l_screen.width),
				develop_window.development_window_data.height.min (l_screen.height))
			l_x := develop_window.development_window_data.x_position
			if l_x < l_screen.virtual_left or l_x > l_screen.virtual_right then
					-- Somehow screens have changed, reset it to 0
				l_x := 0
			end
			l_y := develop_window.development_window_data.y_position
			if l_y < l_screen.virtual_top or l_y > l_screen.virtual_bottom then
					-- Somehow screens have changed, reset it to 0
				l_y := 0
			end
			develop_window.window.set_position (l_x, l_y)
		end

	window_displayed is
			-- `Current' has been displayed on screen.
		do
				-- Minimize or Maximize window if needed.
			if develop_window.development_window_data.is_maximized then
				develop_window.window.maximize
			elseif develop_window.development_window_data.is_minimized then
				develop_window.window.minimize
			end
		end

	init_commands is
			-- Initialize commands.
		local
			l_accel: EV_ACCELERATOR
			l_toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			l_new_tab_cmd: EB_NEW_TAB_EDITOR_COMMAND
--			l_open_cmd: EB_OPEN_FILE_COMMAND
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
			l_editor_paste_cmd: EB_EDITOR_PASTE_COMMAND
			l_new_cluster_cmd: EB_NEW_CLUSTER_COMMAND
			l_new_library_cmd: EB_NEW_LIBRARY_COMMAND
			l_new_assembly_cmd: EB_NEW_ASSEMBLY_COMMAND
			l_new_class_cmd: EB_NEW_CLASS_COMMAND
			l_delete_class_cluster_cmd: EB_DELETE_CLASS_CLUSTER_COMMAND
			l_new_feature_cmd: EB_NEW_FEATURE_COMMAND
			l_toggle_feature_alias_cmd: EB_TOGGLE_FEATURE_ALIAS_COMMAND
			l_toggle_feature_signature_cmd: EB_TOGGLE_FEATURE_SIGNATURE_COMMAND
			l_toggle_feature_assigner_cmd: EB_TOGGLE_FEATURE_ASSIGNER_COMMAND
			l_toggle_stone_cmd: EB_UNIFY_STONE_CMD
			l_send_stone_to_context_cmd: EB_STANDARD_CMD

			l_show_tool_commands: HASH_TABLE [EB_SHOW_TOOL_COMMAND, EB_TOOL]
			l_show_toolbar_commands: HASH_TABLE [EB_SHOW_TOOLBAR_COMMAND, SD_TOOL_BAR_CONTENT]
			l_editor_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
			l_editors: ARRAYED_LIST [EB_EDITOR]
		do
			-- Directly call a un-redefine init_commands in EB_DEVELOPMENT_WINDOW
			-- Non-docking Eiffel Studio was call Precursor
			develop_window.init_commands

			create l_toolbarable_commands.make (15)
			develop_window.commands.set_toolbarable_commands (l_toolbarable_commands)

				-- Open, save, ...
			create l_new_tab_cmd.make (develop_window)
			develop_window.commands.set_new_tab_cmd (l_new_tab_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.commands.new_tab_cmd)

-- Larry temp comment, remove it later
--			create l_open_cmd.make (develop_window)
--			develop_window.set_open_cmd (l_open_cmd)
--			develop_window.commands.toolbarable_commands.extend (develop_window.open_cmd)

			create l_save_cmd.make (develop_window)
			develop_window.set_save_cmd (l_save_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.save_cmd)

			create l_save_as_cmd.make (develop_window)
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
			develop_window.set_save_all_cmd (l_save_all_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.save_all_cmd)

			create l_shell_cmd.make (develop_window)
			develop_window.commands.set_shell_cmd (l_shell_cmd)
			develop_window.commands.toolbarable_commands.extend (develop_window.commands.shell_cmd)

			create l_print_cmd.make (develop_window)
			develop_window.commands.set_print_cmd (l_print_cmd)
			if develop_window.is_empty then
				develop_window.commands.print_cmd.disable_sensitive
			else
				develop_window.commands.print_cmd.enable_sensitive
			end
			develop_window.commands.toolbarable_commands.extend (develop_window.commands.print_cmd)

				-- Compilation
			create l_c_workbench_compilation_cmd.make_workbench (develop_window)
			develop_window.commands.set_c_workbench_compilation_cmd (l_c_workbench_compilation_cmd)
			create l_c_finalized_compilation_cmd.make_finalized (develop_window)
			develop_window.commands.set_c_finalized_compilation_cmd (l_c_finalized_compilation_cmd)
			if develop_window.has_dll_generation then
				create l_show_dynamic_lib_tool.make
				develop_window.set_show_dynamic_lib_tool (l_show_dynamic_lib_tool)
				develop_window.show_dynamic_lib_tool.set_menu_name (develop_window.Interface_names.m_new_dynamic_lib)
				develop_window.show_dynamic_lib_tool.add_agent (agent develop_window.show_dynamic_library_dialog)
			end
			if develop_window.has_profiler then
				create l_show_profiler
				develop_window.commands.set_show_profiler (l_show_profiler)
			end

				-- Undo/redo, cut, copy, paste.
			create l_undo_cmd.make (develop_window)
			develop_window.commands.set_undo_cmd (l_undo_cmd)
			develop_window.commands.toolbarable_commands.extend (l_undo_cmd)

			create l_redo_cmd.make (develop_window)
			develop_window.commands.set_redo_cmd (l_redo_cmd)
			develop_window.commands.toolbarable_commands.extend (l_redo_cmd)

			create l_editor_paste_cmd.make (develop_window)
			develop_window.commands.set_editor_paste_cmd (l_editor_paste_cmd)
			develop_window.commands.toolbarable_commands.extend (l_editor_paste_cmd)

			create l_new_cluster_cmd.make (develop_window)
			develop_window.commands.set_new_cluster_cmd (l_new_cluster_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_cluster_cmd)

			create l_new_library_cmd.make (develop_window)
			develop_window.commands.set_new_library_cmd (l_new_library_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_library_cmd)

			create l_new_assembly_cmd.make (develop_window)
			develop_window.commands.set_new_assembly_cmd (l_new_assembly_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_assembly_cmd)

			create l_new_class_cmd.make (develop_window)
			develop_window.commands.set_new_class_cmd (l_new_class_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_class_cmd)

			create l_delete_class_cluster_cmd.make (develop_window)
			develop_window.commands.set_delete_class_cluster_cmd (l_delete_class_cluster_cmd)
			develop_window.commands.toolbarable_commands.extend (l_delete_class_cluster_cmd)

			create l_new_feature_cmd.make (develop_window)
			develop_window.commands.set_new_feature_cmd (l_new_feature_cmd)
			develop_window.commands.toolbarable_commands.extend (l_new_feature_cmd)

			create l_toggle_feature_alias_cmd.make (develop_window)
			develop_window.commands.set_toggle_feature_alias_cmd (l_toggle_feature_alias_cmd)
			develop_window.commands.toolbarable_commands.extend (l_toggle_feature_alias_cmd)

			create l_toggle_feature_signature_cmd.make (develop_window)
			develop_window.commands.set_toggle_feature_signature_cmd (l_toggle_feature_signature_cmd)
			develop_window.commands.toolbarable_commands.extend (l_toggle_feature_signature_cmd)

			create l_toggle_feature_assigner_cmd.make (develop_window)
			develop_window.commands.set_toggle_feature_assigner_cmd (l_toggle_feature_assigner_cmd)
			develop_window.commands.toolbarable_commands.extend (l_toggle_feature_assigner_cmd)

			create l_toggle_stone_cmd.make (develop_window)
			develop_window.commands.set_toggle_stone_cmd (l_toggle_stone_cmd)
			develop_window.commands.toolbarable_commands.extend (l_toggle_stone_cmd)

			create l_send_stone_to_context_cmd.make
			develop_window.commands.set_send_stone_to_context_cmd (l_send_stone_to_context_cmd)
			l_send_stone_to_context_cmd.set_pixmap (develop_window.pixmaps.icon_pixmaps.context_sync_icon)
			l_send_stone_to_context_cmd.set_pixel_buffer (develop_window.pixmaps.icon_pixmaps.context_sync_icon_buffer)
			l_send_stone_to_context_cmd.set_tooltip (develop_window.Interface_names.e_send_stone_to_context)
			l_send_stone_to_context_cmd.set_menu_name (develop_window.Interface_names.m_send_stone_to_context)
			l_send_stone_to_context_cmd.set_name ("Send_to_context")
			l_send_stone_to_context_cmd.set_tooltext (develop_window.Interface_names.b_send_stone_to_context)
			l_send_stone_to_context_cmd.add_agent (agent develop_window.send_stone_to_context)
			create l_accel.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_down), False, True, False
			)
			l_accel.actions.extend (agent develop_window.send_stone_to_context)
			l_send_stone_to_context_cmd.set_accelerator (l_accel)
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

			develop_window.commands.new_feature_cmd.disable_sensitive
			develop_window.commands.toggle_feature_alias_cmd.disable_sensitive
			develop_window.commands.toggle_feature_signature_cmd.disable_sensitive
			develop_window.commands.toggle_feature_assigner_cmd.disable_sensitive

			create l_editors.make (5)
			develop_window.ui.set_editors (l_editors)
		end

	set_up_accelerators is
			-- Fill the accelerator of `window' with the accelerators of the `toolbarable_commands'.
		local
			l_cmds: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			i: INTEGER
			l_show_tool_commands: HASH_TABLE [EB_SHOW_TOOL_COMMAND, EB_TOOL]
			l_cmd: EB_SHOW_TOOL_COMMAND
			l_accelerators: EV_ACCELERATOR_LIST
			l_acc: EV_ACCELERATOR
		do
			l_accelerators := develop_window.window.accelerators
				--| Accelerators related to toolbarable_commands
			from
				l_cmds := develop_window.commands.toolbarable_commands
				l_cmds.start
			until
				l_cmds.after
			loop
				l_acc := l_cmds.item.accelerator
				if l_acc /= Void and then not l_accelerators.has (l_acc) then
					l_accelerators.extend (l_acc)
				end
				l_cmds.forth
			end

				--| Accelerators related to debugging toolbarable_commands
			from
				l_cmds := develop_window.Eb_debugger_manager.toolbarable_commands
				l_cmds.start
			until
				l_cmds.after
			loop
				l_acc := l_cmds.item.accelerator
				if l_acc /= Void and then not l_accelerators.has (l_acc) then
					l_accelerators.extend (l_acc)
				end
				l_cmds.forth
			end

				-- Show tool commands
			from
				l_show_tool_commands := develop_window.commands.show_tool_commands
				l_show_tool_commands.start
			until
				l_show_tool_commands.after
			loop
				l_cmd := l_show_tool_commands.item_for_iteration
				l_acc := l_cmd.accelerator
				if l_acc /= Void and then not l_accelerators.has (l_acc) then
					l_accelerators.extend (l_acc)
				end
				l_show_tool_commands.forth
			end
			setup_debug_tools_accelerators

				--| Accelerators related to external commands
			from
				i := 0
			until
				i > 9
			loop
				l_accelerators.extend (develop_window.commands.edit_external_commands_cmd.accelerators.item (i))
				i := i + 1
			end

			setup_focus_editor_accelerators
			build_close_content_accelerator
		end

	build_formatters is
			-- Build all formatters used.
		local
			l_form: EB_CLASS_TEXT_FORMATTER
			l_accel: EV_ACCELERATOR

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
			create l_accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_t),
					True, False, True)
			l_accel.actions.extend (agent develop_window.save_and_switch_formatter (l_form))
			l_form.set_accelerator (l_accel)
			l_form.set_viewpoints (develop_window.view_points_combo)
			l_form.post_execution_action.extend (agent develop_window.update_viewpoints)
			l_managed_main_formatters.extend (l_form)

			create {EB_CLICKABLE_FORMATTER} l_form.make (develop_window)
			create l_accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_c),
					True, False, True)
			l_accel.actions.extend (agent develop_window.save_and_switch_formatter (l_form))
			l_form.set_accelerator (l_accel)
			l_form.set_viewpoints (develop_window.view_points_combo)
			l_form.post_execution_action.extend (agent develop_window.update_viewpoints)
			l_managed_main_formatters.extend (l_form)

			create {EB_FLAT_FORMATTER} l_form.make (develop_window)
			create l_accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f),
					True, False, True)
			l_accel.actions.extend (agent develop_window.save_and_switch_formatter (l_form))
			l_form.set_accelerator (l_accel)
			l_form.set_viewpoints (develop_window.view_points_combo)
			l_form.post_execution_action.extend (agent develop_window.update_viewpoints)
			l_managed_main_formatters.extend (l_form)

			create {EB_SHORT_FORMATTER} l_form.make (develop_window)
			create l_accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_o),
					True, False, True)
			l_accel.actions.extend (agent develop_window.save_and_switch_formatter (l_form))
			l_form.set_accelerator (l_accel)
			l_form.set_viewpoints (develop_window.view_points_combo)
			l_form.post_execution_action.extend (agent develop_window.update_viewpoints)
			l_managed_main_formatters.extend (l_form)

			create {EB_FLAT_SHORT_FORMATTER} l_form.make (develop_window)
			create l_accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_i),
					True, False, True)
			l_accel.actions.extend (agent develop_window.save_and_switch_formatter (l_form))
			l_form.set_accelerator (l_accel)
			l_form.set_viewpoints (develop_window.view_points_combo)
			l_form.post_execution_action.extend (agent develop_window.update_viewpoints)
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
			from
				l_managed_main_formatters := develop_window.managed_main_formatters
				l_managed_main_formatters.start
			until
				l_managed_main_formatters.after
			loop
				if develop_window.editors_manager.current_editor /= Void then
					l_managed_main_formatters.item.set_editor (develop_window.editors_manager.current_editor)
				end
				l_managed_main_formatters.item.on_shown
				if l_managed_main_formatters.item.accelerator /= Void then
					develop_window.window.accelerators.extend (l_managed_main_formatters.item.accelerator)
				end
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
			-- Build all tools that can take place in this window and put them
			-- in `left_tools' or `bottom_tools'.
		local
			l_undo_redo_observer: UNDO_REDO_OBSERVER

			l_docking_manager: SD_DOCKING_MANAGER
			l_editors_manager: EB_EDITORS_MANAGER
		do
			develop_window.lock_update
			create l_docking_manager.make (develop_window.panel, develop_window.window)
			develop_window.set_docking_manager (l_docking_manager)
			develop_window.docking_manager.set_main_area_background_color ((create {EV_STOCK_COLORS}).grey)
				-- Build the features tool

			build_features_tool
			build_cluster_tool
			build_breakpoints_tool
			build_favorites_tool
			build_properties_tool
			build_windows_tool
			build_search_and_report_tool

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
			develop_window.editors_manager.editor_switched_actions.extend (agent l_undo_redo_observer.on_changed)
			l_undo_redo_observer := Void
			l_undo_redo_observer ?= develop_window.commands.redo_cmd
			check
				l_undo_redo_observer /= Void
			end
			develop_window.editors_manager.editor_switched_actions.extend (agent l_undo_redo_observer.on_changed)

				-- Following comments arr from non-docking Eiffel Studio
				-- The minimim height masks a bug on windows to do with the sizing of the editors
				-- scroll bars, which were affecting the resizing although they should not have done so.
				-- Having a default minimum height on the editor is perfectly reasonable.
				--			develop_window.tools.editor_tool.widget.set_minimum_height (20)

			build_output_tool
			build_diagram_tool
			build_class_tool
			build_features_relation_tool

			build_dependency_tool

			build_metric_tool  -- This line cause mini toolbar problem?
			build_external_output_tool
			build_c_output_tool
			build_errors_tool
			build_warnings_tool

				-- Build the refactoring tools
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.pull_command)
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.rename_command)
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.undo_command)
			develop_window.commands.toolbarable_commands.extend (develop_window.refactoring_manager.redo_command)

				-- Set the flag "Tools initialized"
			develop_window.set_tools_initialized (True)

			build_undo_redo_accelerators

			develop_window.unlock_update
		end

	prepare_editor_tool is
			-- Build address toolbar and docking manager.
		local
			l_icons: EB_SD_ICONS
			l_shared: SD_SHARED
			l_editors_widget_for_docking: EV_HORIZONTAL_BOX
			l_editors_widget: EV_VERTICAL_BOX
		do
			create l_editors_widget_for_docking

			create l_editors_widget
			develop_window.ui.set_editors_widget (l_editors_widget)

			l_editors_widget.extend (l_editors_widget_for_docking)
			create l_icons.make
			create l_shared
			l_shared.set_icons (l_icons)
		end

	build_vision_window is
			-- Build development window
		local
			l_window: EB_VISION_WINDOW
		do
				-- Vision2 initialization
			create l_window
			develop_window.set_window (l_window)
			l_window.show_actions.extend (agent window_displayed)
			init_size_and_position
			l_window.close_request_actions.wipe_out
			l_window.close_request_actions.put_front (agent develop_window.destroy)
			l_window.set_icon_pixmap (develop_window.pixmap)

			l_window.resize_actions.force_extend (agent develop_window.save_size)
			l_window.move_actions.force_extend (agent develop_window.save_position)
				-- Initialize commands and connect them.
			init_commands

				-- Build widget system & menus.
			build_interface
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

			develop_window.window.focus_in_actions.extend (agent (develop_window.window_manager).set_focused_window (develop_window))

			develop_window.set_initialized_for_builder (True)
		end

	build_interface is
			-- Build system widget.
		local
			l_cell: EV_CELL
			l_new_split_position: INTEGER
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
			develop_window.add_recyclable (l_favorites_manager)

			create l_cluster_manager.make (develop_window)
			develop_window.set_cluster_manager (l_cluster_manager)

			develop_window.add_recyclable (l_cluster_manager)

				-- Set up the name of the window.
			develop_window.set_title (develop_window.Interface_names.t_Empty_development_window)
			develop_window.set_minimized_title (develop_window.Interface_names.t_Empty_development_window)

				-- Create the main container and the left + right panels.
			create l_container
			develop_window.set_container (l_container)

			develop_window.window.extend (develop_window.container)

			create l_panel
			develop_window.set_panel (l_panel)

			develop_window.update_expanded_state_of_panel

				-- Create the status bar.
			create l_status_bar.make
			develop_window.set_status_bar (l_status_bar)
			develop_window.add_recyclable (l_status_bar)

				-- Build all tools that can take place in this window.
			build_tools

			-- Build the layout -------------------------------------------

				-- Add the content of the window (left bar + right cell).
			l_container.extend (l_panel)

			l_new_split_position := develop_window.preferences.development_window_data.left_panel_width

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

feature{NONE} -- Implementation

	build_features_tool is
			-- Build features tool
		local
			l_features_tool: EB_FEATURES_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_features_tool.make (develop_window)
			develop_window.tools.set_features_tool (l_features_tool)

			l_features_tool.attach_to_docking_manager (develop_window.docking_manager)

			create l_show_cmd.make (develop_window, l_features_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_features_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)
			develop_window.add_recyclable (l_features_tool)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_t), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_cluster_tool is
				-- Build cluster tool
		local
			l_cluster_tool: EB_CLUSTER_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_cluster_tool.make (develop_window, develop_window)
			develop_window.tools.set_cluster_tool (l_cluster_tool)
			develop_window.tools.cluster_tool.attach_to_docking_manager (develop_window.docking_manager)
			create l_show_cmd.make (develop_window, l_cluster_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_cluster_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)
			develop_window.add_recyclable (l_cluster_tool)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_l), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_output_tool is
			-- Build output tool.
		local
			l_output_tool: EB_OUTPUT_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_output_tool.make (develop_window)
			develop_window.tools.set_output_tool (l_output_tool)

			l_output_tool.attach_to_docking_manager (develop_window.docking_manager)

			create l_show_cmd.make (develop_window, l_output_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_output_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)
			develop_window.add_recyclable (l_output_tool)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_o), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_diagram_tool is
			-- Build diagram tool.
		local
			l_diagram_tool: EB_DIAGRAM_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			if develop_window.has_case then
				create l_diagram_tool.make (develop_window)
				develop_window.tools.set_diagram_tool (l_diagram_tool)
				l_diagram_tool.attach_to_docking_manager (develop_window.docking_manager)

				develop_window.add_recyclable (l_diagram_tool)

				create l_show_cmd.make (develop_window, l_diagram_tool)
				develop_window.commands.show_tool_commands.force (l_show_cmd, l_diagram_tool)
				develop_window.commands.toolbarable_commands.extend (l_show_cmd)

				create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_d), True, True, False)
				l_accel.actions.extend (agent l_show_cmd.execute)
				l_show_cmd.set_accelerator (l_accel)
			end
		end

	build_class_tool is
			-- Build class tool.
		local
			l_class_tool: EB_CLASS_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_class_tool.make (develop_window)
			develop_window.tools.set_class_tool (l_class_tool)

			l_class_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_class_tool)

			create l_show_cmd.make (develop_window, l_class_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_class_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_c), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_features_relation_tool is
			-- Build features relation tool.
		local
			l_features_relation_tool: EB_FEATURES_RELATION_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_features_relation_tool.make (develop_window)
			develop_window.tools.set_features_relation_tool (l_features_relation_tool)

			l_features_relation_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_features_relation_tool)

			create l_show_cmd.make (develop_window, l_features_relation_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_features_relation_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_v), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_dependency_tool is
			-- Build dependency tool.
		local
			l_dependency_tool: EB_DEPENDENCY_VIEW
			l_show_cmd: EB_SHOW_TOOL_COMMAND
		do
			create l_dependency_tool.make (develop_window)
			develop_window.tools.set_dependency_tool (l_dependency_tool)

			l_dependency_tool.attach_to_docking_manager (develop_window.docking_manager)
			develop_window.add_recyclable (l_dependency_tool)

			create l_show_cmd.make (develop_window, l_dependency_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_dependency_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			-- Accelerator not assigned. Key_d was already assigned to diagram tool.
		end

	build_metric_tool is
			-- Build metric tool.
		local
			l_metric_tool: EB_METRIC_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			check has_metric: develop_window.has_metrics end
			create l_metric_tool.make (develop_window)
			develop_window.tools.set_metric_tool (l_metric_tool)

			l_metric_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_metric_tool)

			create l_show_cmd.make (develop_window, l_metric_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_metric_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_m), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_external_output_tool is
			-- Build external output tool.
		local
			l_external_output_tool: EB_EXTERNAL_OUTPUT_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_external_output_tool.make (develop_window)
			develop_window.tools.set_external_output_tool (l_external_output_tool)

			l_external_output_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_external_output_tool)

			create l_show_cmd.make (develop_window, l_external_output_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_external_output_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_x), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_c_output_tool is
			-- Build c output tool.
		local
			l_c_output_tool: EB_C_OUTPUT_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_c_output_tool.make (develop_window)
			develop_window.tools.set_c_output_tool (l_c_output_tool)

			l_c_output_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_c_output_tool)

			create l_show_cmd.make (develop_window, l_c_output_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_c_output_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_0), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_warnings_tool is
			-- Build warnings tool.
		local
			l_warnings_tool: EB_WARNINGS_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_warnings_tool.make (develop_window)
			develop_window.tools.set_warnings_tool (l_warnings_tool)

			l_warnings_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_warnings_tool)

			create l_show_cmd.make (develop_window, l_warnings_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_warnings_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_w), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_errors_tool is
			-- Build errors tool.
		local
			l_errors_tool: EB_ERRORS_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_errors_tool.make (develop_window)
			develop_window.tools.set_errors_tool (l_errors_tool)

			l_errors_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_errors_tool)

			create l_show_cmd.make (develop_window, l_errors_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_errors_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_e), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_search_and_report_tool is
			-- Build search tool.
		local
			l_search_tool: EB_MULTI_SEARCH_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_show_report_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
			l_shortcut_preference: SHORTCUT_PREFERENCE
			l_shared_preference: EB_SHARED_PREFERENCES
			l_search_report_tool: EB_SEARCH_REPORT_TOOL
		do
				-- Search tool
			create l_search_tool.make (develop_window)
			develop_window.tools.set_search_tool (l_search_tool)
			l_search_tool.attach_to_docking_manager (develop_window.docking_manager)
			create l_show_cmd.make (develop_window, l_search_tool)
			create l_shared_preference
			l_shortcut_preference := l_shared_preference.preferences.editor_data.shortcuts.item ("show_search_panel")
			create l_accel.make_with_key_combination (l_shortcut_preference.key, l_shortcut_preference.is_ctrl, l_shortcut_preference.is_alt, l_shortcut_preference.is_shift)
			l_accel.actions.extend (agent l_search_tool.prepare_search)
			l_show_cmd.set_accelerator (l_accel)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_search_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)
			develop_window.add_recyclable (l_search_tool)

				-- Report tool
			l_search_report_tool := l_search_tool.report_tool
			l_search_report_tool.attach_to_docking_manager (develop_window.docking_manager)
			develop_window.tools.set_search_report_tool (l_search_report_tool)
			create l_show_report_cmd.make (develop_window, l_search_report_tool)
			develop_window.commands.show_tool_commands.force (l_show_report_cmd, l_search_report_tool)
			develop_window.add_recyclable (l_search_report_tool)
			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_r), True, True, False)
			l_accel.actions.extend (agent l_show_report_cmd.execute)
			l_show_report_cmd.set_accelerator (l_accel)

			l_search_tool.build_mini_toolbar
			l_search_report_tool.build_mini_toolbar
		end

	build_breakpoints_tool is
			-- Build breakpoints tool.
		local
			l_breakpoints_tool: ES_BREAKPOINTS_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_breakpoints_tool.make (develop_window)
			develop_window.tools.set_breakpoints_tool (l_breakpoints_tool)

			l_breakpoints_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_breakpoints_tool)

			create l_show_cmd.make (develop_window, l_breakpoints_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_breakpoints_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_b), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_favorites_tool is
			-- Build favorites tool.
		local
			l_favorites_tool: EB_FAVORITES_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_favorites_tool.make (develop_window, develop_window.favorites_manager)
			develop_window.tools.set_favorites_tool (l_favorites_tool)
			l_favorites_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_favorites_tool)

			create l_show_cmd.make (develop_window, l_favorites_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_favorites_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_properties_tool is
			-- Build properties tool.
		local
			l_properties_tool: EB_PROPERTIES_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_properties_tool.make (develop_window)
			develop_window.tools.set_properties_tool (l_properties_tool)
			l_properties_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_properties_tool)

			create l_show_cmd.make (develop_window, l_properties_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_properties_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f4), False, False, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_windows_tool is
			-- Build windows tool (formerly known as Selector tool).
		local
			l_windows_tool: EB_WINDOWS_TOOL
			l_show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
		do
			create l_windows_tool.make (develop_window)
			develop_window.tools.set_windows_tool (l_windows_tool)

			l_windows_tool.attach_to_docking_manager (develop_window.docking_manager)

			develop_window.add_recyclable (l_windows_tool)

			create l_show_cmd.make (develop_window, l_windows_tool)
			develop_window.commands.show_tool_commands.force (l_show_cmd, l_windows_tool)
			develop_window.commands.toolbarable_commands.extend (l_show_cmd)

			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_n), True, True, False)
			l_accel.actions.extend (agent l_show_cmd.execute)
			l_show_cmd.set_accelerator (l_accel)
		end

	build_undo_redo_accelerators is
			-- Initialize undo / redo accelerators.
		local
			l_undo_accelerator: EV_ACCELERATOR
			l_redo_accelerator: EV_ACCELERATOR
		do
			create l_undo_accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_z), True, False, False)
			develop_window.set_undo_accelerator (l_undo_accelerator)

			if develop_window.has_case then
				l_undo_accelerator.actions.extend (agent (develop_window.tools.diagram_tool.undo_cmd).on_ctrl_z)
			end

			create l_redo_accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_y), True, False, False)
			if develop_window.has_case then
				l_redo_accelerator.actions.extend (agent (develop_window.tools.diagram_tool.redo_cmd).on_ctrl_y)
			end
			develop_window.window.accelerators.extend (l_undo_accelerator)
			develop_window.window.accelerators.extend (l_redo_accelerator)
		end

	build_close_content_accelerator is
			-- Build content close accelerator.
		local
			l_acc: EV_ACCELERATOR
		do
			create l_acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f4), True, False, False)
			l_acc.actions.extend (agent develop_window.close_focusing_content)
			develop_window.window.accelerators.extend (l_acc)
		end

	setup_editor_close_action is
			-- Setup editor commands in editors manager.
			-- so that they are correctly disable when there is no editor open.
		do
			develop_window.editors_manager.editor_closed_actions.extend (agent develop_window.all_editor_closed)
		end

	setup_debug_tools_accelerators is
			-- Setup debug tools accelerators.
		local
			l_acc: EV_ACCELERATOR
		do
				-- Object tool
			create l_acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_j), True, True, False)
			l_acc.actions.extend (agent (develop_window.eb_debugger_manager).show_object_tool)

			develop_window.window.accelerators.extend (l_acc)

				-- Watch tool
			create l_acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_h), True, True, False)

			l_acc.actions.extend (agent (develop_window.eb_debugger_manager).show_a_hidden_watch_tool)
			develop_window.window.accelerators.extend (l_acc)

				-- Thread tool
			create l_acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_p), True, True, False)

			l_acc.actions.extend (agent (develop_window.eb_debugger_manager).show_thread_tool)
			develop_window.window.accelerators.extend (l_acc)
		end

	setup_focus_editor_accelerators is
			-- Setup accelerators of focusing current editor.
		local
			l_acc: EV_ACCELERATOR
		do
			create l_acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_escape), False, False, False)
			l_acc.actions.extend (agent develop_window.set_focus_to_main_editor)
			develop_window.window.accelerators.extend (l_acc)
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
