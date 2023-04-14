note
	description: "All commands in EB_DEVELOPMENT_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_COMMANDS

inherit
	EB_DEVELOPMENT_WINDOW_PART
		redefine
			internal_recycle
		end

create
	make

feature -- Query

	restore_tab_cmd: EB_RESTORE_CLOSE_TAB_EDITOR_COMMAND
			-- Command to restore a closed tab.

	new_tab_cmd: EB_NEW_TAB_EDITOR_COMMAND
			-- Command to create a new tab.

	new_cluster_cmd: EB_NEW_CLUSTER_COMMAND
			-- Command to create a new cluster.

	new_library_cmd: EB_NEW_LIBRARY_COMMAND
			-- Command to create a new library.

	new_assembly_cmd: EB_NEW_ASSEMBLY_COMMAND
			-- Command to create a new assembly.

	new_class_cmd: EB_NEW_CLASS_COMMAND
			-- Command to create a new class.

	new_feature_cmd: EB_NEW_FEATURE_COMMAND
			-- Command to execute the feature wizard.

	toggle_stone_cmd: EB_UNIFY_STONE_CMD
			-- Command to toggle between the stone management modes.

	system_info_cmd: EB_SYSTEM_INFORMATION_CMD
			-- Command to display information about the system (root class,...)
	send_stone_to_context_cmd: EB_STANDARD_CMD
			-- Command to send the current stone to the context tool.

	print_cmd: EB_PRINT_COMMAND
			-- Command to print the content of editor with focus

	c_workbench_compilation_cmd: EB_C_COMPILATION_COMMAND
			-- Command to compile the workbench C code.

	c_finalized_compilation_cmd: EB_C_COMPILATION_COMMAND
			-- Command to compile the finalized C code.

	shell_cmd: EB_OPEN_SHELL_COMMAND
			-- Command to use an external editor.

	undo_cmd: EB_UNDO_COMMAND
			-- Command to undo in the editor.

	redo_cmd: EB_REDO_COMMAND
			-- Command to redo in the editor.

	editor_cut_cmd: EB_EDITOR_CUT_COMMAND
			-- Command to cut text in the editor.

	editor_copy_cmd: EB_EDITOR_COPY_COMMAND
			-- Command to copy text in the editor.

	editor_paste_cmd: EB_EDITOR_PASTE_COMMAND
			-- Command to paste text in the editor.

	editor_insert_symbol_cmd: EB_INSERT_SYMBOL_EDITOR_COMMAND

	melt_cmd: EB_MELT_PROJECT_COMMAND
			-- Command to start compilation.

	delete_class_cluster_cmd: EB_DELETE_CLASS_CLUSTER_COMMAND
			-- Command to remove a class or a cluster from the system
			-- (permanent deletion).

	show_profiler: EB_SHOW_PROFILE_TOOL
			-- What allows us to display the profiler window.

	save_as_cmd: EB_SAVE_FILE_AS_COMMAND
			-- Command to save a class with a different file name.

	Edit_external_commands_cmd: EB_EXTERNAL_COMMANDS_EDITOR
			-- Command that lets the user add new external commands to the tools menu.
		once
			create Result.make
			Result.enable_sensitive
		end

	reset_layout_command: EB_RESET_LAYOUT_COMMAND
			-- Reset tools layout command

	save_layout_as_command: EB_SAVE_LAYOUT_AS_COMMAND
			-- Save layout as command.

	lock_tool_bar_command: EB_LOCK_TOOL_BAR_COMMAND
			-- Lock tool bar command

	lock_docking_command: EB_LOCK_DOCKING_COMMAND
			-- Lock tools docking mechanism command

	lock_editor_docking_command: EB_LOCK_EDITOR_DOCKING_COMMAND
			-- Lock editors docking mechanims command

	maximize_editor_area_command: EB_MAXIMIZE_EDITOR_AREA_COMMAND
			-- Command that maximize whole editor area

	minimize_editor_area_command: EB_MINIMIZE_EDITOR_AREA_COMMAND
			-- Command that minimize whole editor area

	restore_editor_area_command: EB_RESTORE_EDITOR_AREA_COMMAND
			-- Command that restore editor area

	minimize_editors_command: EB_MINIMIZE_EDITORS_COMMAND
			-- Command that minimized all editors

	restore_editors_command: EB_RESTORE_EDITORS_COMMAND
			-- Command that restore all minimized editors

	edit_bp_here_command: ES_EDIT_BREAKPOINT_HERE_CMD
			-- Command that edit bp on current location

	enable_remove_bp_here_command: ES_TOGGLE_BREAKPOINT_HERE_CMD
			-- Command that enable/remove bp on current location

	enable_disable_bp_here_command: ES_TOGGLE_BREAKPOINT_HERE_CMD
			-- Command that enable/disable bp on current location

	run_to_this_point_command: ES_EXEC_RUN_TO_THIS_POINT_CMD
			-- Command to run to the cursor's location

	close_current_panel_command: EB_CLOSE_CURRENT_PANEL_COMMAND
			-- 	Command to close current focused (tab) editor/tool

	reload_current_panel_command: EB_RELOAD_CURRENT_PANEL_COMMAND
			-- 	Command to reload current focused (tab) editor/tool

	close_all_tab_command: EB_CLOSE_ALL_TAB_COMMAND
			-- Command to close all tabs in same notebook

	close_all_but_current_command: EB_CLOSE_ALL_BUT_CURRENT_COMMAND
			-- Command to close all tabs except current focused one

	close_all_but_unsaved_command: EB_CLOSE_ALL_BUT_UNSAVED_COMMAND
			-- Command to close all unsaved tab editors

	close_all_empty_tab_command: EB_CLOSE_ALL_EMPTY_TAB_COMMAND
			-- Command to close all empty tabs in current notebook

	editor_font_zoom_in_command: EB_EDITOR_FONT_ZOOM_IN_COMMAND
			-- Command that increase editor font

	editor_font_zoom_in_numpad_command: ES_EDITOR_FONT_ZOOM_IN_NUMPAD_COMMAND
			-- Command that increase editor font

	editor_font_zoom_out_command: EB_EDITOR_FONT_ZOOM_OUT_COMMAND
			-- Command that decrease editor font

	editor_font_zoom_out_numpad_command: ES_EDITOR_FONT_ZOOM_OUT_NUMPAD_COMMAND
			-- Command that decrease editor font

	editor_font_zoom_reset_command: EB_EDITOR_FONT_ZOOM_RESET_COMMAND
			-- Command that reset editor font

	editor_font_zoom_reset_numpad_command: ES_EDITOR_FONT_ZOOM_RESET_NUMPAD_COMMAND
			-- Command that reset editor font

	customized_formatter_command: EB_SETUP_CUSTOMIZED_FORMATTER_COMMAND
			-- Command to setup customzied formatter

	customized_tool_command: EB_SETUP_CUSTOMIZED_TOOL_COMMAND
			-- Command to setup customzied formatter

	go_to_next_error_command: ES_NEXT_ERROR_COMMAND
			-- Go to next error command

	go_to_previous_error_command: ES_PREVIOUS_ERROR_COMMAND
			-- Go to previous error command

	go_to_next_warning_command: ES_NEXT_WARNING_COMMAND
			-- Go to next warningcommand

	go_to_previous_warning_command: ES_PREVIOUS_WARNING_COMMAND
			-- Go to previous warning command

	apply_fix_command: ES_FIX_COMMAND
			-- "Apply fix" command

	edit_contracts_command: attached ES_EDIT_CONTRACTS_COMMAND
			-- Edit contracts command

	find_class_or_cluster_command: attached ES_FIND_CLASS_OR_CLUSTER_CMD
			-- Command used to locate a class or cluster

feature -- Commands

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			-- All commands that can be put in a toolbar

	show_shell_tool_commands: HASH_TABLE [ES_SHOW_TOOL_COMMAND, ES_TOOL [EB_TOOL]]
			-- Commands to show/hide a tool

	editor_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
			-- Commands independent on the editor

	focus_commands: ARRAYED_LIST [EB_FOCUS_PANEL_COMMAND]
			-- Commands related with focus in/out actions

	show_toolbar_commands: HASH_TABLE [EB_SHOW_TOOLBAR_COMMAND, SD_TOOL_BAR_CONTENT]
			-- Commands to show/hide a toolbar

	simple_shortcut_commands: ARRAYED_LIST [EB_SIMPLE_SHORTCUT_COMMAND]
			-- Simple shortcut commands

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER, EB_DEVELOPMENT_WINDOW} -- Settings

	set_save_as_cmd (a_cmd: like save_as_cmd)
			-- Set `save_as_cmd'
		do
			save_as_cmd := a_cmd
		ensure
			set: save_as_cmd = a_cmd
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER} -- Settings

	set_restore_tab_cmd (a_cmd: like restore_tab_cmd)
			-- Set `restore_tab_cmd'
		do
			restore_tab_cmd := a_cmd
		ensure
			set: restore_tab_cmd = a_cmd
		end

	set_toolbarable_commands (a_commands: like toolbarable_commands)
			-- Set `toolbarable_commands'.
		do
			toolbarable_commands := a_commands
		ensure
			set: toolbarable_commands = a_commands
		end

	set_new_tab_cmd (a_cmd: like new_tab_cmd)
			-- Set `new_tab_cmd'
		do
			new_tab_cmd := a_cmd
		ensure
			set: new_tab_cmd = a_cmd
		end

	set_editor_cut_cmd (a_cmd: like editor_cut_cmd)
			-- Set `editor_cut_cmd'
		do
			editor_cut_cmd := a_cmd
		ensure
			set: editor_cut_cmd = a_cmd
		end

	set_editor_copy_cmd (a_cmd: like editor_copy_cmd)
			-- Set `editor_copy_cmd'
		do
			editor_copy_cmd := a_cmd
		ensure
			set: editor_copy_cmd = a_cmd
		end

	set_shell_cmd (a_cmd: like shell_cmd)
			-- Set `shell_cmd`
		do
			shell_cmd := a_cmd
		ensure
			set: shell_cmd = a_cmd
		end

	set_print_cmd (a_cmd: like print_cmd)
			-- Set `print_cmd'
		do
			print_cmd := a_cmd
		ensure
			set: print_cmd = a_cmd
		end

	set_c_workbench_compilation_cmd (a_cmd: like c_workbench_compilation_cmd)
			-- Set `c_workbench_compilation_cmd'
		do
			c_workbench_compilation_cmd := a_cmd
		ensure
			set: c_workbench_compilation_cmd = a_cmd
		end

	set_c_finalized_compilation_cmd (a_cmd: like c_finalized_compilation_cmd)
			-- Set `c_finalized_compilation_cmd'
		do
			c_finalized_compilation_cmd := a_cmd
		ensure
			set: c_finalized_compilation_cmd = a_cmd
		end

	set_undo_cmd (a_cmd: like undo_cmd)
			-- Set `undo_cmd'
		do
			undo_cmd := a_cmd
		ensure
			set: undo_cmd = a_cmd
		end

	set_redo_cmd (a_cmd: like redo_cmd)
			-- Set `redo_cmd'
		do
			redo_cmd := a_cmd
		ensure
			set: redo_cmd = a_cmd
		end

	set_editor_paste_cmd (a_cmd: like editor_paste_cmd)
			-- Set `editor_paste_cmd'
		do
			editor_paste_cmd := a_cmd
		ensure
			set: editor_paste_cmd = a_cmd
		end

	set_editor_insert_symbol_cmd (a_cmd: like editor_insert_symbol_cmd)
			-- Set `editor_insert_symbol_cmd'
		do
			editor_insert_symbol_cmd := a_cmd
		ensure
			set: editor_insert_symbol_cmd = a_cmd
		end

	set_new_cluster_cmd (a_cmd: like new_cluster_cmd)
			-- Set `new_cluster_cmd'
		do
			new_cluster_cmd := a_cmd
		ensure
			set: new_cluster_cmd = a_cmd
		end

	set_new_library_cmd (a_cmd: like new_library_cmd)
			-- Set `new_library_cmd'
		do
			new_library_cmd := a_cmd
		ensure
			set: new_library_cmd = a_cmd
		end

	set_new_assembly_cmd (a_cmd: like new_assembly_cmd)
			-- Set `new_assembly_cmd'
		do
			new_assembly_cmd := a_cmd
		ensure
			set: new_assembly_cmd = a_cmd
		end

	set_new_class_cmd (a_cmd: like new_class_cmd)
			-- Set `new_class_cmd'
		do
			new_class_cmd := a_cmd
		ensure
			set: new_class_cmd = a_cmd
		end

	set_delete_class_cluster_cmd (a_cmd: like delete_class_cluster_cmd)
			-- Set `delete_class_cluster_cmd"
		do
			delete_class_cluster_cmd := a_cmd
		ensure
			set: delete_class_cluster_cmd = a_cmd
		end

	set_new_feature_cmd (a_cmd: like new_feature_cmd)
			-- Set `new_feature_cmd'
		do
			new_feature_cmd := a_cmd
		ensure
			set: new_feature_cmd = a_cmd
		end

	set_toggle_stone_cmd (a_cmd: like toggle_stone_cmd)
			-- Set `toggle_stone_cmd'
		do
			toggle_stone_cmd := a_cmd
		ensure
			set: toggle_stone_cmd = a_cmd
		end

	set_system_info_cmd (a_cmd: like system_info_cmd)
			-- Set `system_info_cmd'
		do
			system_info_cmd := a_cmd
		ensure
			set: system_info_cmd = a_cmd
		end

	set_send_stone_to_context_cmd (a_cmd: like send_stone_to_context_cmd)
			-- Set `send_stone_to_context_cmd'
		do
			send_stone_to_context_cmd := a_cmd
		ensure
			set: send_stone_to_context_cmd = a_cmd
		end

	set_show_profiler (a_cmd: like show_profiler)
			-- Set `show_profiler'
		do
			show_profiler := a_cmd
		ensure
			set: show_profiler = a_cmd
		end

	set_show_shell_tool_commands (a_commands: like show_shell_tool_commands)
			-- Set `show_tool_commands'
		do
			show_shell_tool_commands := a_commands
		ensure
			set: show_shell_tool_commands = a_commands
		end

	set_show_toolbar_commands (a_commands: like show_toolbar_commands)
			-- Set `show_toolbar_commands'
		do
			show_toolbar_commands := a_commands
		ensure
			set: show_toolbar_commands = a_commands
		end

	set_editor_commands (a_commands: like editor_commands)
			-- Set `editor_commands'
		do
			editor_commands := a_commands
		ensure
			set: editor_commands = a_commands
		end

	set_focus_commands (a_commands: like focus_commands)
			-- Set `focus_commands'
		do
			focus_commands := a_commands
		ensure
			set: focus_commands = a_commands
		end

	set_reset_layout_command (a_cmd: like reset_layout_command)
			-- Set `reset_layout_command'
		do
			reset_layout_command := a_cmd
		ensure
			set: reset_layout_command = a_cmd
		end

	set_save_layout_as_command (a_cmd: like save_layout_as_command)
			-- Set `save_layout_as_command'
		do
			save_layout_as_command := a_cmd
		ensure
			set: save_layout_as_command = a_cmd
		end

	set_simple_shortcut_commands (a_cmd: like simple_shortcut_commands)
			-- Set `save_layout_as_command'
		do
			simple_shortcut_commands := a_cmd
		ensure
			set: simple_shortcut_commands = a_cmd
		end

	set_lock_tool_bar_command (a_cmd: like lock_tool_bar_command)
			-- Set `lock_tool_bar_command'
		do
			lock_tool_bar_command := a_cmd
		ensure
			set: lock_tool_bar_command = a_cmd
		end

	set_lock_docking_command (a_cmd: like lock_docking_command)
			-- Set `lock_docking_command'
		do
			lock_docking_command := a_cmd
		ensure
			set: lock_docking_command = a_cmd
		end

	set_lock_editor_docking_command (a_cmd: like lock_editor_docking_command)
			-- Set `lock_docking_command'
		do
			lock_editor_docking_command := a_cmd
		ensure
			set: lock_editor_docking_command = a_cmd
		end

	set_maximize_editor_area_command (a_cmd: like maximize_editor_area_command)
			-- Set `maximize_editor_area_command'
		do
			maximize_editor_area_command := a_cmd
		ensure
			set: maximize_editor_area_command = a_cmd
		end

	set_minimize_editor_area_command (a_cmd: like minimize_editor_area_command)
			-- Set `minimize_editor_area_command'
		do
			minimize_editor_area_command := a_cmd
		ensure
			set: minimize_editor_area_command = a_cmd
		end

	set_restore_editor_area_command (a_cmd: like restore_editor_area_command)
			-- Set `restore_editor_area_command'
		do
			restore_editor_area_command := a_cmd
		ensure
			set: restore_editor_area_command = a_cmd
		end

	set_minimize_editors_command (a_cmd: like minimize_editors_command)
			-- Set `minimize_editors_command'
		do
			minimize_editors_command := a_cmd
		ensure
			set: minimize_editors_command = a_cmd
		end

	set_restore_editors_command (a_cmd: like restore_editors_command)
			-- Set `restore_editors_command'
		do
			restore_editors_command := a_cmd
		ensure
			set: restore_editors_command = a_cmd
		end

	set_edit_bp_here_command (a_cmd: like edit_bp_here_command)
			-- Set `edit_bp_here_command'
		do
			edit_bp_here_command := a_cmd
		ensure
			set: edit_bp_here_command = a_cmd
		end

	set_enable_remove_bp_here_command (a_cmd: like enable_remove_bp_here_command)
			-- Set `enable_bp_here_command'
		do
			enable_remove_bp_here_command := a_cmd
		ensure
			set: enable_remove_bp_here_command = a_cmd
		end

	set_enable_disable_bp_here_command (a_cmd: like enable_disable_bp_here_command)
			-- Set `enable_disable_bp_here_command'
		do
			enable_disable_bp_here_command := a_cmd
		ensure
			set: enable_disable_bp_here_command = a_cmd
		end

	set_run_to_this_point_command (a_cmd: like run_to_this_point_command)
			-- Set `run_to_this_point_command'
		do
			run_to_this_point_command := a_cmd
		ensure
			set: run_to_this_point_command = a_cmd
		end

	set_reload_current_panel_command (a_cmd: like reload_current_panel_command)
			-- Set `reload_current_panel_command'
		do
			reload_current_panel_command := a_cmd
		ensure
			set: reload_current_panel_command = a_cmd
		end

	set_close_current_panel_command (a_cmd: like close_current_panel_command)
			-- Set `close_current_panel_command'
		do
			close_current_panel_command := a_cmd
		ensure
			set: close_current_panel_command = a_cmd
		end

	set_close_all_tab_command (a_cmd: like close_all_tab_command)
			-- Set `close_all_tab_command'
		do
			close_all_tab_command := a_cmd
		ensure
			set: close_all_tab_command = a_cmd
		end

	set_close_all_but_current_command (a_cmd: like close_all_but_current_command)
			-- Set `close_all_but_current_command'
		do
			close_all_but_current_command := a_cmd
		ensure
			set: close_all_but_current_command = a_cmd
		end

	set_close_all_but_unsaved_command (a_cmd: like close_all_but_unsaved_command)
			-- Set `close_all_but_unsaved_command'
		do
			close_all_but_unsaved_command := a_cmd
		ensure
			set: close_all_but_unsaved_command = a_cmd
		end

	set_close_all_empty_tab_command (a_cmd: like close_all_empty_tab_command)
			-- Set `close_all_empty_tab_command'
		do
			close_all_empty_tab_command := a_cmd
		ensure
			set: close_all_empty_tab_command = a_cmd
		end

	set_editor_font_zoom_in_command (a_cmd: like editor_font_zoom_in_command)
			-- Set `editor_font_zoom_in_command'
		do
			editor_font_zoom_in_command := a_cmd
		ensure
			set: editor_font_zoom_in_command = a_cmd
		end

	set_editor_font_zoom_in_numpad_command (a_cmd: like editor_font_zoom_in_numpad_command)
			-- Set `editor_font_zoom_in_numpad_command'
		do
			editor_font_zoom_in_numpad_command := a_cmd
		ensure
			set: editor_font_zoom_in_numpad_command = a_cmd
		end

	set_editor_font_zoom_out_command (a_cmd: like editor_font_zoom_out_command)
			-- Set `editor_font_zoom_out_command'
		do
			editor_font_zoom_out_command := a_cmd
		ensure
			set: editor_font_zoom_out_command = a_cmd
		end

	set_editor_font_zoom_out_numpad_command (a_cmd: like editor_font_zoom_out_numpad_command)
			-- Set `editor_font_zoom_out_numpad_command'
		do
			editor_font_zoom_out_numpad_command := a_cmd
		ensure
			set: editor_font_zoom_out_numpad_command = a_cmd
		end

	set_editor_font_zoom_reset_command (a_cmd: like editor_font_zoom_reset_command)
			-- Set `editor_font_zoom_reset_command'
		do
			editor_font_zoom_reset_command := a_cmd
		ensure
			set: editor_font_zoom_reset_command = a_cmd
		end

	set_editor_font_zoom_reset_numpad_command (a_cmd: like editor_font_zoom_reset_numpad_command)
			-- Set `editor_font_zoom_reset_numpad_command'
		do
			editor_font_zoom_reset_numpad_command := a_cmd
		ensure
			set: editor_font_zoom_reset_numpad_command = a_cmd
		end

	set_customized_formatter_command (a_cmd: like customized_formatter_command)
			-- Set `customized_formatter_command' with `a_cmd'.
		do
			customized_formatter_command := a_cmd
		ensure
			customized_formatter_command_set: customized_formatter_command = a_cmd
		end

	set_customized_tool_command (a_cmd: like customized_tool_command)
			-- Set `customized_tool_command' with `a_cmd'.
		do
			customized_tool_command := a_cmd
		ensure
			customized_tool_command_set: customized_tool_command = a_cmd
		end

	set_go_to_next_error_command (a_command: like go_to_next_error_command)
			-- Sets `go_to_next_error_command' with `a_command'
		do
			go_to_next_error_command := a_command
		ensure
			go_to_next_error_command_set: go_to_next_error_command = a_command
		end

	set_go_to_previous_error_command (a_command: like go_to_previous_error_command)
			-- Sets `go_to_previous_error_command' with `a_command'
		do
			go_to_previous_error_command := a_command
		ensure
			go_to_previous_error_command_set: go_to_previous_error_command = a_command
		end

	set_go_to_next_warning_command (a_command: like go_to_next_warning_command)
			-- Sets `go_to_next_warning_command' with `a_command'
		do
			go_to_next_warning_command := a_command
		ensure
			go_to_next_warning_command_set: go_to_next_warning_command = a_command
		end

	set_go_to_previous_warning_command (a_command: like go_to_previous_warning_command)
			-- Sets `go_to_previous_warning_command' with `a_command'
		do
			go_to_previous_warning_command := a_command
		ensure
			go_to_previous_warning_command_set: go_to_previous_warning_command = a_command
		end

	set_apply_fix_command (a_command: like apply_fix_command)
			-- Sets `apply_fix_command' with `a_command'.
		do
			apply_fix_command := a_command
		ensure
			apply_fix_command_set: apply_fix_command = a_command
		end

	set_edit_contracts_command (a_command: like edit_contracts_command)
			-- Sets `edit_contracts_command' with `a_command'
		do
			edit_contracts_command := a_command
		ensure
			edit_contracts_command_set: edit_contracts_command = a_command
		end

	set_find_class_or_cluster_command (a_command: like find_class_or_cluster_command)
			-- Sets `find_class_or_cluster_command' with `a_command'.
		do
			find_class_or_cluster_command := a_command
		ensure
			find_class_or_cluster_command_set: find_class_or_cluster_command = a_command
		end

feature -- Recycle

	internal_recycle
			-- Recycle all commands.
		do
			restore_tab_cmd.recycle
			new_tab_cmd.recycle
			reset_layout_command.recycle
			save_layout_as_command.recycle
			lock_docking_command.recycle
			lock_editor_docking_command.recycle
			maximize_editor_area_command.recycle
			minimize_editor_area_command.recycle
			restore_editor_area_command.recycle
			lock_tool_bar_command.recycle
			save_as_cmd.recycle

			edit_bp_here_command.recycle
			enable_remove_bp_here_command.recycle
			enable_disable_bp_here_command.recycle
			run_to_this_point_command.recycle

			editor_font_zoom_in_command.recycle
			editor_font_zoom_in_numpad_command.recycle
			editor_font_zoom_out_command.recycle
			editor_font_zoom_out_numpad_command.recycle
			editor_font_zoom_reset_command.recycle
			editor_font_zoom_reset_numpad_command.recycle

			c_finalized_compilation_cmd.recycle
			c_workbench_compilation_cmd.recycle
			editor_cut_cmd.recycle
			editor_copy_cmd.recycle
			editor_paste_cmd.recycle
			new_class_cmd.recycle
			new_cluster_cmd.recycle
			new_library_cmd.recycle
			new_assembly_cmd.recycle
			new_feature_cmd.recycle
			shell_cmd.recycle

			undo_cmd.recycle
			redo_cmd.recycle
			toggle_stone_cmd.recycle
			delete_class_cluster_cmd.recycle
			print_cmd.recycle

			go_to_next_error_command.recycle
			go_to_previous_error_command.recycle
			go_to_next_warning_command.recycle
			go_to_previous_warning_command.recycle

			from
				toolbarable_commands.start
			until
				toolbarable_commands.after
			loop
				if attached {EB_ON_SELECTION_COMMAND} toolbarable_commands.item as os_cmd then
					os_cmd.recycle
				end
				toolbarable_commands.forth
			end

			from
				show_toolbar_commands.start
			until
				show_toolbar_commands.after
			loop
				show_toolbar_commands.item_for_iteration.recycle
				show_toolbar_commands.forth
			end
			show_toolbar_commands := Void

			from
				editor_commands.start
			until
				editor_commands.after
			loop
				if attached {EB_RECYCLABLE} editor_commands.item as l_recyclable then
					l_recyclable.recycle
				end
				editor_commands.forth
			end
			editor_commands := Void

			from
				focus_commands.start
			until
				focus_commands.after
			loop
				if attached {EB_RECYCLABLE} focus_commands.item as l_recyclable then
					l_recyclable.recycle
				end
				focus_commands.forth
			end
			focus_commands := Void

			c_finalized_compilation_cmd := Void
			c_finalized_compilation_cmd := Void
			new_class_cmd := Void
			new_cluster_cmd := Void
			new_feature_cmd := Void
			shell_cmd := Void
			undo_cmd := Void
			redo_cmd := Void
			toggle_stone_cmd := Void
			delete_class_cluster_cmd := Void
			print_cmd := Void
			go_to_next_error_command := Void
			go_to_previous_error_command := Void
			go_to_next_warning_command := Void
			go_to_previous_warning_command := Void
			apply_fix_command := Void

			Precursor {EB_DEVELOPMENT_WINDOW_PART}
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
