indexing
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

	system_info_cmd: EB_STANDARD_CMD is
			-- Command to display information about the system (root class,...)
		do
			Result := develop_window.Eb_debugger_manager.system_info_cmd
		end

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

	melt_cmd: EB_MELT_PROJECT_COMMAND
			-- Command to start compilation.

	delete_class_cluster_cmd: EB_DELETE_CLASS_CLUSTER_COMMAND
			-- Command to remove a class or a cluster from the system
			-- (permanent deletion).

	show_profiler: EB_SHOW_PROFILE_TOOL
			-- What allows us to display the profiler window.

	save_as_cmd: EB_SAVE_FILE_AS_COMMAND
			-- Command to save a class with a different file name.

	Edit_external_commands_cmd: EB_EXTERNAL_COMMANDS_EDITOR is
			-- Command that lets the user add new external commands to the tools menu.
		once
			create Result.make
			Result.enable_sensitive
		end

	reset_layout_command: EB_RESET_LAYOUT_COMMAND
			-- Reset tools layout command

	set_default_layout_command: EB_SET_DEFAULT_LAYOUT_COMMAND
			-- Set Current layout as default layout command.

	save_layout_as_command: EB_SAVE_LAYOUT_AS_COMMAND
			-- Save layout as command.

	open_layout_command: EB_OPEN_LAYOUT_COMMAND
			-- Open layout command.

	lock_tool_bar_command: EB_LOCK_TOOL_BAR_COMMAND
			-- Lock tool bar command

	lock_docking_command: EB_LOCK_DOCKING_COMMAND
			-- Lock tools docking mechanism command

	lock_editor_docking_command: EB_LOCK_EDITOR_DOCKING_COMMAND
			-- Lock editors docking mechanims command

	maximize_editor_area_command: EB_MAXIMIZE_EDITOR_AREA_COMMAND
			-- Command that maximize whole editor area.

	minimize_editors_command: EB_MINIMIZE_EDITORS_COMMAND
			-- Command that minimized all editors.

	restore_editors_command: EB_RESTORE_EDITORS_COMMAND
			-- Command that restore all minimized editors.

	editor_font_zoom_in_command: EB_EDITOR_FONT_ZOOM_IN_COMMAND
			-- Command that increase editor font

	editor_font_zoom_out_command: EB_EDITOR_FONT_ZOOM_OUT_COMMAND
			-- Command that decrease editor font

	editor_font_zoom_reset_command: EB_EDITOR_FONT_ZOOM_RESET_COMMAND
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

	edit_contracts_command: !ES_EDIT_CONTRACTS_COMMAND
			-- Edit contracts command

feature -- Commands

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			-- All commands that can be put in a toolbar.

	show_tool_commands: HASH_TABLE [EB_SHOW_TOOL_COMMAND, EB_TOOL]
			-- Commands to show/hide a tool.

	show_shell_tool_commands: HASH_TABLE [ES_SHOW_TOOL_COMMAND, ES_TOOL [EB_TOOL]]
			-- Commands to show/hide a tool.

	editor_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
			-- Commands independent on the editor.

	show_toolbar_commands: HASH_TABLE [EB_SHOW_TOOLBAR_COMMAND, SD_TOOL_BAR_CONTENT]
			-- Commands to show/hide a toolbar.

	simple_shortcut_commands: ARRAYED_LIST [EB_SIMPLE_SHORTCUT_COMMAND]
			-- Simple shortcut commands.

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER, EB_DEVELOPMENT_WINDOW} -- Settings

	set_save_as_cmd (a_cmd: like save_as_cmd) is
			-- Set `save_as_cmd'
		do
			save_as_cmd := a_cmd
		ensure
			set: save_as_cmd = a_cmd
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER} -- Settings

	set_toolbarable_commands (a_commands: like toolbarable_commands) is
			-- Set `toolbarable_commands'.
		do
			toolbarable_commands := a_commands
		ensure
			set: toolbarable_commands = a_commands
		end

	set_new_tab_cmd (a_cmd: like new_tab_cmd) is
			-- Set `new_tab_cmd'
		do
			new_tab_cmd := a_cmd
		ensure
			set: new_tab_cmd = a_cmd
		end

	set_editor_cut_cmd (a_cmd: like editor_cut_cmd) is
			-- Set `editor_cut_cmd'
		do
			editor_cut_cmd := a_cmd
		ensure
			set: editor_cut_cmd = a_cmd
		end

	set_editor_copy_cmd (a_cmd: like editor_copy_cmd) is
			-- Set `editor_copy_cmd'
		do
			editor_copy_cmd := a_cmd
		ensure
			set: editor_copy_cmd = a_cmd
		end

	set_shell_cmd (a_cmd: like shell_cmd) is
			-- Set `shell_cmd;
		do
			shell_cmd := a_cmd
		ensure
			set: shell_cmd = a_cmd
		end

	set_print_cmd (a_cmd: like print_cmd) is
			-- Set `print_cmd'
		do
			print_cmd := a_cmd
		ensure
			set: print_cmd = a_cmd
		end

	set_c_workbench_compilation_cmd (a_cmd: like c_workbench_compilation_cmd) is
			-- Set `c_workbench_compilation_cmd'
		do
			c_workbench_compilation_cmd := a_cmd
		ensure
			set: c_workbench_compilation_cmd = a_cmd
		end

	set_c_finalized_compilation_cmd (a_cmd: like c_finalized_compilation_cmd) is
			-- Set `c_finalized_compilation_cmd'
		do
			c_finalized_compilation_cmd := a_cmd
		ensure
			set: c_finalized_compilation_cmd = a_cmd
		end

	set_undo_cmd (a_cmd: like undo_cmd) is
			-- Set `undo_cmd'
		do
			undo_cmd := a_cmd
		ensure
			set: undo_cmd = a_cmd
		end

	set_redo_cmd (a_cmd: like redo_cmd) is
			-- Set `redo_cmd'
		do
			redo_cmd := a_cmd
		ensure
			set: redo_cmd = a_cmd
		end

	set_editor_paste_cmd (a_cmd: like editor_paste_cmd) is
			-- Set `editor_paste_cmd'
		do
			editor_paste_cmd := a_cmd
		ensure
			set: editor_paste_cmd = a_cmd
		end

	set_new_cluster_cmd (a_cmd: like new_cluster_cmd) is
			-- Set `new_cluster_cmd'
		do
			new_cluster_cmd := a_cmd
		ensure
			set: new_cluster_cmd = a_cmd
		end

	set_new_library_cmd (a_cmd: like new_library_cmd) is
			-- Set `new_library_cmd'
		do
			new_library_cmd := a_cmd
		ensure
			set: new_library_cmd = a_cmd
		end

	set_new_assembly_cmd (a_cmd: like new_assembly_cmd) is
			-- Set `new_assembly_cmd'
		do
			new_assembly_cmd := a_cmd
		ensure
			set: new_assembly_cmd = a_cmd
		end

	set_new_class_cmd (a_cmd: like new_class_cmd) is
			-- Set `new_class_cmd'
		do
			new_class_cmd := a_cmd
		ensure
			set: new_class_cmd = a_cmd
		end

	set_delete_class_cluster_cmd (a_cmd: like delete_class_cluster_cmd)	is
			-- Set `delete_class_cluster_cmd"
		do
			delete_class_cluster_cmd := a_cmd
		ensure
			set: delete_class_cluster_cmd = a_cmd
		end

	set_new_feature_cmd (a_cmd: like new_feature_cmd) is
			-- Set `new_feature_cmd'
		do
			new_feature_cmd := a_cmd
		ensure
			set: new_feature_cmd = a_cmd
		end

	set_toggle_stone_cmd (a_cmd: like toggle_stone_cmd) is
			-- Set `toggle_stone_cmd'
		do
			toggle_stone_cmd := a_cmd
		ensure
			set: toggle_stone_cmd = a_cmd
		end

	set_send_stone_to_context_cmd (a_cmd: like send_stone_to_context_cmd) is
			-- Set `send_stone_to_context_cmd'
		do
			send_stone_to_context_cmd := a_cmd
		ensure
			set: send_stone_to_context_cmd = a_cmd
		end

	set_show_profiler (a_cmd: like show_profiler) is
			-- Set `show_profiler'
		do
			show_profiler := a_cmd
		ensure
			set: show_profiler = a_cmd
		end

	set_show_tool_commands (a_commands: like show_tool_commands) is
			-- Set `show_tool_commands'
		do
			show_tool_commands := a_commands
		ensure
			set: show_tool_commands = a_commands
		end

	set_show_shell_tool_commands (a_commands: like show_shell_tool_commands) is
			-- Set `show_tool_commands'
		do
			show_shell_tool_commands := a_commands
		ensure
			set: show_shell_tool_commands = a_commands
		end

	set_show_toolbar_commands (a_commands: like show_toolbar_commands) is
			-- Set `show_toolbar_commands'
		do
			show_toolbar_commands := a_commands
		ensure
			set: show_toolbar_commands = a_commands
		end

	set_editor_commands (a_commands: like editor_commands) is
			-- Set `editor_commands'
		do
			editor_commands := a_commands
		ensure
			set: editor_commands = a_commands
		end

	set_reset_layout_command (a_cmd: like reset_layout_command) is
			-- Set `reset_layout_command'
		do
			reset_layout_command := a_cmd
		ensure
			set: reset_layout_command = a_cmd
		end

	set_set_default_layout_command (a_cmd: like set_default_layout_command) is
			-- Set `set_default_layout_command'
		do
			set_default_layout_command := a_cmd
		ensure
			set: set_default_layout_command = a_cmd
		end

	set_open_layout_command (a_cmd: like open_layout_command) is
			-- Set `open_layout_command'
		do
			open_layout_command := a_cmd
		ensure
			set: open_layout_command = a_cmd
		end

	set_save_layout_as_command (a_cmd: like save_layout_as_command) is
			-- Set `save_layout_as_command'
		do
			save_layout_as_command := a_cmd
		ensure
			set: save_layout_as_command = a_cmd
		end

	set_simple_shortcut_commands (a_cmd: like simple_shortcut_commands) is
			-- Set `save_layout_as_command'
		do
			simple_shortcut_commands := a_cmd
		ensure
			set: simple_shortcut_commands = a_cmd
		end

	set_lock_tool_bar_command (a_cmd: like lock_tool_bar_command) is
			-- Set `lock_tool_bar_command'
		do
			lock_tool_bar_command := a_cmd
		ensure
			set: lock_tool_bar_command = a_cmd
		end

	set_lock_docking_command (a_cmd: like lock_docking_command) is
			-- Set `lock_docking_command'
		do
			lock_docking_command := a_cmd
		ensure
			set: lock_docking_command = a_cmd
		end

	set_lock_editor_docking_command (a_cmd: like lock_editor_docking_command) is
			-- Set `lock_docking_command'
		do
			lock_editor_docking_command := a_cmd
		ensure
			set: lock_editor_docking_command = a_cmd
		end

	set_maximize_editor_area_command (a_cmd: like maximize_editor_area_command) is
			-- Set `maximize_editor_area_command'
		do
			maximize_editor_area_command := a_cmd
		ensure
			set: maximize_editor_area_command = a_cmd
		end

	set_minimize_editors_command (a_cmd: like minimize_editors_command) is
			-- Set `minimize_editors_command'
		do
			minimize_editors_command := a_cmd
		ensure
			set: minimize_editors_command = a_cmd
		end

	set_restore_editors_command (a_cmd: like restore_editors_command) is
			-- Set `restore_editors_command'
		do
			restore_editors_command := a_cmd
		ensure
			set: restore_editors_command = a_cmd
		end

	set_editor_font_zoom_in_command (a_cmd: like editor_font_zoom_in_command) is
			-- Set `editor_font_zoom_in_command'
		do
			editor_font_zoom_in_command := a_cmd
		ensure
			set: editor_font_zoom_in_command = a_cmd
		end

	set_editor_font_zoom_out_command (a_cmd: like editor_font_zoom_out_command) is
			-- Set `editor_font_zoom_out_command'
		do
			editor_font_zoom_out_command := a_cmd
		ensure
			set: editor_font_zoom_out_command = a_cmd
		end

	set_editor_font_zoom_reset_command (a_cmd: like editor_font_zoom_reset_command) is
			-- Set `editor_font_zoom_reset_command'
		do
			editor_font_zoom_reset_command := a_cmd
		ensure
			set: editor_font_zoom_reset_command = a_cmd
		end

	set_customized_formatter_command (a_cmd: like customized_formatter_command) is
			-- Set `customized_formatter_command' with `a_cmd'.
		do
			customized_formatter_command := a_cmd
		ensure
			customized_formatter_command_set: customized_formatter_command = a_cmd
		end

	set_customized_tool_command (a_cmd: like customized_tool_command) is
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

	set_edit_contracts_command (a_command: like edit_contracts_command)
			-- Sets `edit_contracts_command' with `a_command'
		do
			edit_contracts_command := a_command
		ensure
			edit_contracts_command_set: edit_contracts_command = a_command
		end

feature -- Recycle

	internal_recycle is
			-- Recycle all commands.
		local
			os_cmd: EB_ON_SELECTION_COMMAND
			l_recyclable: EB_RECYCLABLE
		do
			new_tab_cmd.recycle
			reset_layout_command.recycle
			set_default_layout_command.recycle
			save_layout_as_command.recycle
			open_layout_command.recycle
			lock_docking_command.recycle
			lock_editor_docking_command.recycle
			maximize_editor_area_command.recycle
			lock_tool_bar_command.recycle
			save_as_cmd.recycle

			editor_font_zoom_in_command.recycle
			editor_font_zoom_out_command.recycle
			editor_font_zoom_reset_command.recycle
			
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
				show_tool_commands.start
			until
				show_tool_commands.after
			loop
				show_tool_commands.item_for_iteration.recycle
				show_tool_commands.forth
			end
			show_tool_commands.wipe_out
			show_tool_commands := Void

			from
				toolbarable_commands.start
			until
				toolbarable_commands.after
			loop
				os_cmd ?= toolbarable_commands.item
				if os_cmd /= Void then
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
				l_recyclable ?= editor_commands.item
				if l_recyclable /= Void then
					l_recyclable.recycle
				end
				editor_commands.forth
			end
			editor_commands := Void

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

			Precursor {EB_DEVELOPMENT_WINDOW_PART}
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
