indexing
	description	: "Window holding a project tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW

inherit
	EB_TOOL_MANAGER
		rename
			file_menu as file_menu_not_use,
			edit_menu as edit_menu_not_use,
			tools_menu as tools_menu_not_use,
			window_menu as window_menu_not_use,
			help_menu as help_menu_not_use
		export
			{EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_PART, EB_ADDRESS_MANAGER}
				Warning_messages, Interface_names,
				init_commands, Pixmaps
			{EB_DEVELOPMENT_WINDOW_COMMANDS, EB_TOOL, EB_STONE_CHECKER}
				Debugger_manager
			{EB_STONE_FIRST_CHECKER}
				Ev_application
		redefine
			refresh,
			internal_recycle,
			destroy_imp,
			destroy,
			position,
			pos_container
		end

	EB_FILEABLE
		export {NONE}
			set_position,
			set_pos_container
		redefine
			set_stone,
			reset,
			stone,
			on_text_saved,
			perform_check_before_save,
			check_passed,
			update_save_symbol,
			position,
			pos_container
		select
			set_stone
		end

	EB_FILEABLE
		rename
			set_stone as old_set_stone
		export {NONE}
			set_position,
			set_pos_container
				{EB_STONE_CHECKER}
			old_set_stone
		redefine
			reset,
			stone,
			on_text_saved,
			perform_check_before_save,
			check_passed,
			update_save_symbol,
			position,
			pos_container
		end

		-- Shared tools & contexts
	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	EB_SHARED_MANAGERS
		export
			{EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_PART} Refactoring_manager
		end

	EB_SHARED_GRAPHICAL_COMMANDS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EV_STOCK_PIXMAPS

	EB_CONFIRM_SAVE_CALLBACK

		-- Errors
	EB_GRAPHICAL_ERROR_MANAGER

	EV_KEY_CONSTANTS
		export
			{NONE} All
		end

	EC_EIFFEL_LAYOUT
		export
			{EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_PART, EB_DIAGRAM_TOOL}
				 has_case, has_metrics, has_dll_generation, has_profiler, has_documentation_generation, has_xmi_generation
			{EB_DEBUGGER_MANAGER} Docking_standard_layout_path, standard_tools_debug_layout_name
			{NONE} All
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{EB_STONE_FIRST_CHECKER} pixmap_from_class_i
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} All
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

create {EB_DEVELOPMENT_WINDOW_DIRECTOR}
	make

feature {NONE} -- Initialization

	make is
			-- Creation method.
		do
			create commands.make (Current)
			create menus.make (Current)
			create agents.make (Current)
			create tools.make (Current)
			create ui.make (Current)
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initialization

	set_save_cmd (a_cmd: like save_cmd) is
			-- Set `save_cmd'
		do
			save_cmd := a_cmd
		ensure
			set: save_cmd = a_cmd
		end

	set_save_all_cmd (a_cmd: like save_all_cmd) is
			-- Set `save_all_cmd'
		do
			save_all_cmd := a_cmd
		ensure
			set: save_all_cmd = a_cmd
		end

feature -- Access

	group: CONF_GROUP is
			-- Group of current class. Void if none.
		local
			classi_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
		do
			classi_stone ?= stone
			if classi_stone /= Void then
				Result := classi_stone.group
			end
			cluster_stone ?= stone
			if cluster_stone /= Void then
				Result := cluster_stone.group
			end
		end

	class_name: STRING is
			-- Name of the current class, Void if none.
		local
			class_stone: CLASSI_STONE
		do
			class_stone ?= stone
			if class_stone /= Void and then class_stone.is_valid then
				Result := class_stone.class_name
			end
		end

feature -- Querys

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager, one instance per one EB_DEVELOPMENT_WINDOW.

	editors_manager: EB_EDITORS_MANAGER
			-- Editors manager

feature -- Settings

	set_docking_manager (a_manager: SD_DOCKING_MANAGER) is
			-- Set `docking_manager'
		do
			docking_manager := a_manager
		ensure
			set: docking_manager = a_manager
		end

	set_editors_manager (a_manager: like editors_manager) is
			-- Set `editors_manager'
		do
			editors_manager := a_manager
		ensure
			set: editors_manager = a_manager
		end

feature -- Status setting

	set_focus_to_main_editor is
			-- Set focus to main current editor.
		do
			if editors_manager.current_editor /= Void then
				editors_manager.select_editor (editors_manager.current_editor)
			end
		end

feature -- Window Settings

	set_initialized is
			-- Set `initialized' to True.
		do
			initialized := True
		end

feature -- Window Properties

	changed: BOOLEAN is
			-- Has something been changed and not yet been saved?
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.changed
			end
		end

	any_editor_changed: BOOLEAN
			-- Has any editor been changed?
		do
			Result := editors_manager.changed
		end

	is_empty: BOOLEAN is
			-- Does `Current's text is empty?
		do
			Result := editors_manager = Void or else editors_manager.current_editor = Void or else editors_manager.current_editor.is_empty
		end

	text: STRING is
			-- Text representing Current
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.text
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing Current window.
		do
			Result := pixmaps.icon_pixmaps.general_dialog_icon
		end

	close_focusing_content is
			-- Close focusing content.
		local
			l_content: SD_CONTENT
			l_tools: ARRAYED_LIST [EB_TOOL]
			l_tool: EB_TOOL
			l_comb: EV_COMBO_BOX
			l_is_comb: BOOLEAN
		do
			l_content := docking_manager.focused_content
			l_comb ?= ev_application.focused_widget
			l_is_comb := l_comb /= Void
			if l_content /= Void then
				l_tools := tools.all_tools
				from
					l_tools.start
				until
					l_tools.after or l_tool /= Void
				loop
					if l_tools.item.content = l_content then
					 	l_tool := l_tools.item
					end
					l_tools.forth
				end
				if l_tool /= Void and then (l_tool.has_focus or not l_is_comb) then
					l_tool.close
				else
					if editors_manager.current_editor /= Void and then
						editors_manager.current_editor.docking_content = l_content and then
						(editors_manager.current_editor.has_focus or not l_is_comb)
					then
						editors_manager.close_editor (editors_manager.current_editor)
					end
				end
			end
		end

feature -- Update

	synchronize is
			-- Synchronize stones.
		local
			st: STONE
			l_text_area: EB_SMART_EDITOR
		do
			during_synchronization := True

			if
				stone = Void and then
				eiffel_project.system_defined and then
				eiffel_project.initialized and then
				eiffel_system.workbench.is_already_compiled and then
				eiffel_system.workbench.last_reached_degree <= 5 and then
				eiffel_system.root_cluster /= Void and then
				eiffel_system.root_class /= Void
			then
				if eiffel_system.root_class.is_compiled then
					stone := create {CLASSC_STONE}.make (eiffel_system.system.root_class.compiled_class)
				else
					stone := create {CLASSI_STONE}.make (eiffel_system.system.root_class)
				end
				if
					eiffel_system.universe.target.clusters.count = 1
				then
					tools.cluster_tool.show_current_class_cluster_cmd.execute
				end
			end

			favorites_manager.refresh

			tools.synchronize

			if not unified_stone then

			end
			tools.class_tool.invalidate
			tools.features_relation_tool.invalidate
			if has_case then
				tools.diagram_tool.synchronize
			end

			tools.cluster_tool.synchronize
			history_manager.synchronize
			tools.features_tool.synchronize
			tools.breakpoints_tool.synchronize
				-- Update main views
			managed_main_formatters.i_th (2).invalidate
			managed_main_formatters.i_th (3).invalidate
			managed_main_formatters.i_th (4).invalidate
			managed_main_formatters.i_th (5).invalidate
			if stone /= Void then
				st := stone.synchronized_stone
			end

			set_stone (st)

				-- Reload possible class after the stone is set.
			l_text_area := editors_manager.current_editor
			if l_text_area /= Void then
				l_text_area.update_click_list (False)
				if l_text_area.file_loaded then
					l_text_area.check_document_modifications_and_reload
				end
			end

			update_save_symbol
			address_manager.refresh
			during_synchronization := False
			tools.search_tool.rebuild_scope_list
		end

	synchronize_routine_tool_to_default is
			-- Synchronize the editor tool to the debug format.
		do
			--| FIXME ARNAUD: To be implemented
		end

	clear_object_tool is
			-- Clear the contents of the object tool if shown.
		do
			--| FIXME ARNAUD: To be implemented
		end

feature -- Stone process

	stone: STONE
			-- Current stone

	toggle_unified_stone is
			-- Change the stone management mode.
		do
			unified_stone := not unified_stone
			if unified_stone then
				send_stone_to_context
				commands.send_stone_to_context_cmd.disable_sensitive
			else
				if stone /= Void then
					commands.send_stone_to_context_cmd.enable_sensitive
				end
			end
		end

	set_stone (a_stone: STONE) is
			-- Change the currently focused stone.
		local
			cd: EB_DISCARDABLE_CONFIRMATION_DIALOG
			cv_cst: CLASSI_STONE
			ef_stone: EXTERNAL_FILE_STONE
			l: LIST [EB_DEVELOPMENT_WINDOW]
			l_filename: FILE_NAME
		do
			cv_cst ?= a_stone
			if cv_cst /= Void then
				l_filename := cv_cst.file_name
			else
				ef_stone ?= a_stone
				if ef_stone /= Void then
					l_filename := ef_stone.file_name
				end
			end

			if cv_cst /= Void or ef_stone /= Void then
				l := Window_manager.development_windows_with_class (l_filename)
				if l.is_empty or else l.has (Current) then
						-- We're not editing the class in another window.
					set_stone_after_first_check (a_stone)
				else
					create cd.make_initialized (2,
						preferences.dialog_data.already_editing_class_string,
						warning_messages.w_class_already_edited,
						Interface_names.l_do_not_show_again,
						preferences.preferences)
					cd.set_ok_action (agent set_stone_after_first_check (a_stone))
					cd.show_modal_to_window (window)
				end
			else
				set_stone_after_first_check (a_stone)
			end
			update_save_symbol
		end

	set_stone_after_first_check (a_stone: STONE) is
			-- Display text associated with `a_stone', if any and if possible
		local
			l_checker: EB_STONE_FIRST_CHECKER
		do
			create l_checker.make (Current)
			l_checker.set_stone_after_first_check (a_stone)
		end

	force_stone (s: STONE) is
			-- make `s' the new value of `stone', and
			-- change the display accordingly. Try to
			-- extract a class from `s' whenever possible.
		do
			if s.is_storable then
				set_stone (s)
				if not unified_stone then
					tools.set_stone (s)
				end
			end
		end

	refresh is
			-- Synchronize clickable elements with text, if possible.
		do
	--| FIXME ARNAUD
	--			synchronise_stone
	--| END FIXME
	--| FIXME XR: Refresh current display in the editor.
			if editors_manager.current_editor /= Void then
				editors_manager.current_editor.update_click_list (False)
			end
			update_save_symbol
			address_manager.refresh
				-- The cluster manager should already be refreshed by the window manager.
--			cluster_manager.refresh

			tools.refresh
		end

	quick_refresh_editors is
			-- Redraw editors' drawing area.
		do
			if editors_manager.current_editor /= Void then
				editors_manager.current_editor.refresh
			end
			tools.output_tool.quick_refresh_editor
			tools.external_output_tool.quick_refresh_editor
			tools.c_output_tool.quick_refresh_editor
			tools.class_tool.quick_refresh_editor
			tools.features_relation_tool.quick_refresh_editor

			tools.errors_tool.quick_refresh_editor
			tools.warnings_tool.quick_refresh_editor
		end

	quick_refresh_margins is
			-- Redraw the main editor's drawing area.
		do
			if editors_manager.current_editor /= Void then
				editors_manager.current_editor.margin.refresh
			end
			tools.output_tool.quick_refresh_margin
			tools.external_output_tool.quick_refresh_margin
			tools.c_output_tool.quick_refresh_margin
			tools.class_tool.quick_refresh_margin
			tools.features_relation_tool.quick_refresh_margin

			tools.errors_tool.quick_refresh_margin
			tools.warnings_tool.quick_refresh_margin
		end

feature -- Position provider

	position: like position_internal is
			-- Currently shown text position in the editor
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.first_line_displayed
			end
		end

	pos_container: like pos_container_internal is
			-- Current selected formatter
		do
			Result := selected_formatter
		end

feature -- Resource Update

	update_viewpoints is
			-- Update viewpoints
		local
			l_formatter: EB_FORMATTER
			l_end_loop: BOOLEAN
			l_index: INTEGER
		do
			view_points_combo.disable_sensitive
			if view_points_combo.has_renamed_view_point then
				l_index := managed_main_formatters.index
				from
					managed_main_formatters.start
					managed_main_formatters.forth
				until
					managed_main_formatters.after or l_end_loop
				loop
					l_formatter := managed_main_formatters.item
					if l_formatter.selected and l_formatter.is_button_sensitive  then
						l_end_loop := True
						view_points_combo.enable_sensitive
					end
					managed_main_formatters.forth
				end
				managed_main_formatters.go_i_th (l_index)
			end
		end

	register is
			-- Register to preferences we want notification of.
		do
		end

	unregister is
			-- unregister to preferences we want notification of.
		do
		end

	reset is
			-- Reset the window contents
		do
			Precursor
			address_manager.reset

	--| FIXME ARNAUD, multiformat not yet implemented.
	--			format_list.enable_imp_formats_sensitive
	--| END FIXME
		end

	syntax_is_correct: BOOLEAN is
			-- Current editor was successfully parsed?
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.syntax_is_correct
			else
				Result := True
			end
		end

	save_before_compiling is
			-- save the text but do not update clickable positions
		do
			save_only := True
			save_all
		end

	perform_check_before_save is
			-- Perform any pre-save operations/checks
		do
			-- FIXIT: temp comment by larry
			-- May be problems here of tabbed editor
			if editors_manager.current_editor /= Void then
				perform_check_before_save_with (editors_manager.current_editor)
			end
		end

	perform_check_before_save_with (a_editor: EB_SMART_EDITOR) is
			-- Perform any pre-save operations with `a_editor'
		require
			a_editor_not_void: a_editor /= Void
		local
			dial: EB_CONFIRMATION_DIALOG
		do
				-- Remove trailing blanks.
			if preferences.editor_data.auto_remove_trailing_blank_when_saving then
				a_editor.text_displayed.remove_trailing_blanks
			else
				a_editor.text_displayed.remove_trailing_fake_blanks
			end
			a_editor.refresh_now

			if a_editor.open_backup then
				dial := ui.save_backup_dialog
				dial.show_modal_to_window (window)
			else
				check_passed := True
			end
		end

	continue_save is
			-- Continue saving
		do
			check_passed := True
		end

	cancel_save is
			-- Cancel saving
		do
			check_passed := False
		end

	process is
			-- process the user entry in the address bar
		local
			l_class_stone: CLASSI_STONE
			l_multi_search_tool: EB_MULTI_SEARCH_TOOL
		do
			save_canceled := False
			l_class_stone ?= stone
			if l_class_stone /= Void then
				l_multi_search_tool ?= tools.search_tool
				if l_multi_search_tool /= Void then
					l_multi_search_tool.class_changed (l_class_stone.class_i)
				end
			end
		end

	save_and (an_action: PROCEDURE [ANY, TUPLE]) is
			-- Save and `an_actions'.
		local
			save_dialog: EB_CONFIRM_SAVE_DIALOG
		do
			save_canceled := True
			set_last_save_failed (False)
			text_saved := False
			create save_dialog.make_and_launch (Current, Current)
			if not last_save_failed and then not save_canceled and then syntax_is_correct then
				an_action.call(Void)
			end
		end

	set_classi_changed (a_class: CLASS_I) is
			-- Change a_class in shared project.
		do
			Eiffel_project.Workbench.change_class (a_class)
		end

	on_text_saved is
			-- Notify the editor that the text has been saved
		local
			str: STRING_32
		do
			Precursor
			if editors_manager.current_editor /= Void then
				editors_manager.current_editor.on_text_saved
				if not save_only then
					editors_manager.current_editor.update_click_list (True)
				end
			end
			text_saved := True
			save_only := False
			str := title.twin.as_string_32
			if str @ 1 = '*' then
				str.keep_tail (str.count - 2)
				set_title (str)
			end
			update_formatters
			lock_update
			tools.features_tool.synchronize
			refresh_cursor_position
			refresh_context_info
			unlock_update
			if editors_manager.current_editor.syntax_is_correct then
				status_bar.display_message ("")
			else
				status_bar.display_message (Interface_names.L_syntax_error)
			end
			text_edited := False
		end

	disable_editors_command is
			-- Disable `a_command'.
		require
			editors_manager_not_void: editors_manager /= Void
			commands_not_void: commands /= Void and then commands.editor_commands /= Void
		local
			l_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
		do
			l_commands := commands.editor_commands
			if editors_manager.editors.count = 0 then
				from
					l_commands.start
				until
					l_commands.after
				loop
					l_commands.item.disable_sensitive
					l_commands.forth
				end
			end
		end

feature -- Window management

	give_focus is
			-- Give the focus to the address manager.
		do
			if address_manager.widget.is_displayed then
				address_manager.set_focus
			end
		end

	save_layout is
			-- Store layout of `current'.
		do
				-- Commit saves
			preferences.preferences.save_preferences
		end

	save_layout_to_session (a_session: ES_SESSION) is
			-- Save session data of `Current' to session object `a_session'.
		local
			a_window_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA
			a_class_stone: CLASSI_STONE
			a_cluster_stone: CLUSTER_STONE
			l_class_id, l_feature_id: STRING
			l_feature_stone: FEATURE_STONE
			l_class_stone: CLASSI_STONE
		do
			save_window_state
			create a_window_data.make_from_window_data (preferences.development_window_data)

			a_class_stone ?= stone
			a_cluster_stone ?= stone
			if a_class_stone /= Void then
				a_window_data.save_current_target (id_of_class (a_class_stone.class_i.config_class), False)
			elseif a_cluster_stone /= Void then
				a_window_data.save_current_target (id_of_group (a_cluster_stone.group), True)
			else
				a_window_data.save_current_target (Void, False)
			end
			if a_class_stone /= Void or else a_cluster_stone /= Void then
				if editors_manager.current_editor /= Void then
					a_window_data.save_editor_position (editors_manager.current_editor.text_displayed.current_line_number)
				else
					a_window_data.save_editor_position (1)
				end
			else
				a_window_data.save_editor_position (1)
			end

			save_editors_to_session_data (a_window_data)

			save_editors_docking_layout

			if tools.features_relation_tool /= Void then
				l_feature_stone ?= tools.features_relation_tool.stone
				if l_feature_stone /= Void then
					l_feature_id := id_of_feature (l_feature_stone.e_feature)
				end
			end
			if tools.class_tool /= Void then
				l_class_stone ?= tools.class_tool.stone
				if l_class_stone /= Void then
					check
						class_not_void: l_class_stone.class_i.config_class /= Void
					end
					l_class_id := id_of_class (l_class_stone.class_i.config_class)
				end
			end
			a_window_data.save_context_data (l_class_id, l_feature_id, 1)

 				-- Add the session data of `Current' to the session object.
			a_session.window_session_data.extend (a_window_data)
		end

	save_editors_to_session_data (a_window_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA) is
			-- Save editor number, open classes and open clusters.
		local
			l_open_classes: HASH_TABLE [STRING, STRING]
			l_open_clusters: HASH_TABLE [STRING, STRING]
		do
			l_open_classes := editors_manager.open_classes
			l_open_classes.merge (editors_manager.open_fake_classes)
			l_open_clusters := editors_manager.open_clusters
			l_open_clusters.merge (editors_manager.open_fake_clusters)
			a_window_data.save_open_classes (l_open_classes)
			a_window_data.save_open_clusters (l_open_clusters)
		end

	save_tools_docking_layout is
			-- Save all tools docking layout.
		local
			l_eb_debugger_manager: EB_DEBUGGER_MANAGER
		do
			l_eb_debugger_manager ?= debugger_manager
			-- If directly exiting Eiffel Studio from EB_DEBUGGER_MANAGER, then we don't save the tools layout,
			-- because current widgets layout is debug mode layout (not normal mode layout),
			-- and the debug mode widgets layout is saved by EB_DEBUGGER_MANAGER already.
			if l_eb_debugger_manager /= Void and then not l_eb_debugger_manager.is_exiting_eiffel_studio then
				docking_manager.save_tools_config (docking_config_tools_file)
			end
		end

	save_editors_docking_layout is
			-- Save all editors docking layout.
		do
			docking_manager.save_editors_config (docking_config_editors_file)
		end

	open_tools_docking_layout is
			-- Open tools docking layout.
		local
			l_result: BOOLEAN
		do
			l_result := docking_manager.open_tools_config (docking_config_tools_file)
		end

	open_editors_docking_layout is
			-- Open editors docking layout.
		do
			docking_manager.open_editors_config (docking_config_editors_file)
		end

	internal_construct_standard_layout_by_code is
			-- After docking manager have all widgets, set all tools to standard default layout.
		local
			l_tool: EB_TOOL
			l_tool_bar_content: SD_TOOL_BAR_CONTENT
			l_no_locked_window: BOOLEAN
		do
			l_no_locked_window := ((create {EV_ENVIRONMENT}).application.locked_window = Void)
			if l_no_locked_window then
				window.lock_update
			end
			close_all_tools

			-- Right bottom tools
			l_tool := tools.output_tool
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)
			l_tool := tools.diagram_tool
			l_tool.content.set_tab_with (tools.output_tool.content, False)
			l_tool := tools.class_tool
			l_tool.content.set_tab_with (tools.diagram_tool.content, False)
			l_tool := tools.features_relation_tool
			l_tool.content.set_tab_with (tools.class_tool.content, False)

			l_tool := tools.dependency_tool
			l_tool.content.set_tab_with (tools.features_relation_tool.content, False)

			l_tool := tools.metric_tool
			l_tool.content.set_tab_with (tools.dependency_tool.content, False)
			l_tool := tools.external_output_tool
			l_tool.content.set_tab_with (tools.metric_tool.content, False)
			l_tool := tools.c_output_tool
			l_tool.content.set_tab_with (tools.external_output_tool.content, False)
			l_tool := tools.errors_tool
			l_tool.content.set_tab_with (tools.c_output_tool.content, False)
			l_tool := tools.warnings_tool
			l_tool.content.set_tab_with (tools.errors_tool.content, False)
			l_tool.content.set_split_proportion (0.7)

			-- Left tools
			l_tool := tools.features_tool
			l_tool.content.set_top ({SD_ENUMERATION}.left)
			l_tool := tools.cluster_tool
			l_tool.content.set_relative (tools.features_tool.content, {SD_ENUMERATION}.bottom)
			l_tool.content.set_split_proportion (0.2)

			-- Tool bars
			l_tool_bar_content := docking_manager.tool_bar_manager.content_by_title (interface_names.to_standard_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := docking_manager.tool_bar_manager.content_by_title (interface_names.to_address_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := docking_manager.tool_bar_manager.content_by_title (interface_names.to_project_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := docking_manager.tool_bar_manager.content_by_title (interface_names.to_refactory_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			if l_no_locked_window then
				window.unlock_update
			end
		end

	restore_tools_docking_layout is
			-- Restore docking layout information.
		local
			l_raw_file: RAW_FILE
			l_result: BOOLEAN
		do
			create l_raw_file.make (docking_config_tools_file)
			if l_raw_file.exists then
				l_result := docking_manager.open_tools_config (docking_config_tools_file)
			end

			if not l_result then
				restore_standard_tools_docking_layout
			end
		end

	restore_editors_docking_layout is
			-- Restore docking layout information.
		local
			l_raw_file: RAW_FILE
		do
			create l_raw_file.make (docking_config_editors_file)
			if l_raw_file.exists then
				-- We call it here to prevent Windows Desktop flickers.
				window.lock_update
				docking_manager.open_editors_config (docking_config_editors_file)
				window.unlock_update
			end
		end

	restore_standard_tools_docking_layout is
			-- Restore statndard layout.
		local
			l_file: RAW_FILE
			l_result: BOOLEAN
			retried: BOOLEAN
			l_fn: FILE_NAME
		do
			if not retried then
				l_fn := docking_standard_layout_path.twin
				l_fn.set_file_name (standard_tools_layout_name)
				create l_file.make (l_fn )
				if l_file.exists then
					l_result := docking_manager.open_tools_config (l_fn)
					check l_result end
				else
					internal_construct_standard_layout_by_code
				end
			else
				internal_construct_standard_layout_by_code
			end
		rescue
			retried := True
			retry
		end

	close_all_tools is
			-- Close all tools.
		local
			l_tools: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_tools := docking_manager.contents
				l_tools.start
			until
				l_tools.after
			loop
				if l_tools.item.type = {SD_ENUMERATION}.tool then
					l_tools.item.hide
				end

				l_tools.forth
			end
		end

	docking_config_tools_file: FILE_NAME is
			-- Docking config file name.
		local
			l_env: EC_EIFFEL_LAYOUT
		once
			create l_env
			create Result.make_from_string (l_env.docking_standard_layout_path)
			Result.set_file_name ("layout.wb")
		end

	docking_config_editors_file: FILE_NAME is
			-- Docking config file name.
		do
			create Result.make_from_string (project_location.target_path)
			Result.set_file_name ("layout.wb")
		end

	docking_debug_config_file: FILE_NAME is
			-- Docking config file when debugging.
		local
			l_env: EC_EIFFEL_LAYOUT
		once
			create l_env
			create Result.make_from_string (l_env.docking_standard_layout_path)
			Result.set_file_name ("debug_layout.wb")
		end

feature -- Tools & Controls

	address_manager: EB_ADDRESS_MANAGER
			-- Text field in the toolbar
			-- Allow user to enter the name
			-- of the class he wants to edit.

	project_manager: EB_PROJECT_MANAGER is
			-- Project manager associated to the project the user is working on.
		do
			Result := Eiffel_project.manager
		end

	managed_class_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
			-- All formatters that operate on a class.

	managed_feature_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			-- All formatters that operate on a class.

	managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			-- All formatters that can be displayed in the main editor frame.

	unified_stone: BOOLEAN
			-- Is the stone common with the context tool or not?

	view_points_combo: EB_VIEWPOINT_COMBO_BOX
			-- Combo box used to a select viewpoints

	managed_dependency_formatters: ARRAYED_LIST [EB_DEPENDENCY_FORMATTER]
			-- All formatters to display dependency relationship of a target/group/folder/class

feature -- Multiple editor management

	update_paste_cmd is
			-- Update `editor_paste_cmd'. To be performed when an editor grabs the focus.
		do
			if update_paste_cmd_agent = Void then
				update_paste_cmd_agent := agent
					local
						l_editor: EB_EDITOR
					do
						l_editor := editors_manager.current_editor
						if
							l_editor /= Void and then
							not l_editor.is_empty and then
							l_editor.is_editable and then
							l_editor.clipboard.has_text
						then
							commands.editor_paste_cmd.enable_sensitive
						else
							commands.editor_paste_cmd.disable_sensitive
						end
					end
			end
			ev_application.do_once_on_idle (update_paste_cmd_agent)
		end

	update_paste_cmd_agent: PROCEDURE [ANY, TUPLE]
		-- Agent used for updating the paste command.

feature {EB_EDITORS_MANAGER, EB_STONE_CHECKER} -- Tabbed editor

	is_dropping_on_editor: BOOLEAN
			-- Is pick and droping on an editor?

	set_dropping_on_editor (a_dropping: BOOLEAN) is
			-- Set `Is dropping_on_editor' with `a_dropping'.
		do
			is_dropping_on_editor := a_dropping
		end

	refresh_tab (a_stone: STONE) is
			-- Refresh pixmap and title of current editor's tab.
		local
			l_class_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_group: CONF_GROUP
		do
			if editors_manager.current_editor /= Void then
				if a_stone /= Void then
					l_class_stone ?= a_stone
					l_cluster_stone ?= a_stone
					if l_class_stone /= Void and then l_class_stone.is_valid then
						editors_manager.current_editor.docking_content.set_pixmap (pixmap_from_class_i (l_class_stone.class_i))
						editors_manager.current_editor.docking_content.set_short_title (l_class_stone.class_name)
						editors_manager.current_editor.docking_content.set_long_title (l_class_stone.class_name)
						editors_manager.current_editor.set_title_saved (not changed)
					elseif l_cluster_stone /= Void then
						l_group := l_cluster_stone.group
						editors_manager.current_editor.docking_content.set_pixmap (pixmap_from_group (l_group))
						editors_manager.current_editor.docking_content.set_short_title (l_group.name)
						editors_manager.current_editor.docking_content.set_long_title (l_group.name)
					end
				end
			end
		end

feature {EB_FEATURES_TOOL, EB_FEATURES_TREE, DOTNET_CLASS_AS, EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_PART} -- Feature Clauses

	set_feature_clauses (a_features: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]; a_type: STRING) is
			-- Set 'features' to 'a_features' and store in hash table with key 'a_type' denoting name of consumed
			-- type pertinent to 'a_features'.
		require
			a_features_not_void: a_features /= Void
		do
			if feature_clauses = Void then
				create feature_clauses.make (5)
			end
			feature_clauses.put (a_features, a_type)
		end

	set_feature_locating (a_locating: BOOLEAN) is
			-- Set `feature_locating' with `a_locating'.
		do
			feature_locating := a_locating
		end

	get_feature_clauses (a_type: STRING): ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]] is
			-- Get list of feature clauses relevant to .NET type with name 'a_type'.
		require
			a_type_not_void: a_type /= Void
			has_type_clauses: feature_clauses.has (a_type)
		do
			Result := feature_clauses.item (a_type)
		ensure
			result_not_void: Result /= Void
		end

	feature_clauses: HASH_TABLE [ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]], STRING]
			-- List of features clauses for Current window hashed by the .NET name of the consumed_type.

	feature_locating: BOOLEAN
			-- Is feature tool locating a feature?

feature {EB_WINDOW_MANAGER, EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Window management / Implementation

	destroy_imp is
			-- Destroy window.
		do
				-- To avoid reentrance
			if not is_destroying then
				is_destroying := True

					-- If a launched application is still running, kill it.
				if
					Eb_debugger_manager.application_is_executing
					and then Eb_debugger_manager.debugging_window = Current
				then
					Eb_debugger_manager.application.kill
				end

					-- Save width & height.
				save_window_state
				hide

					-- Commit saves
				preferences.preferences.save_preferences

				estudio_debug_cmd.unattach_window (window)
				toolbars_area.wipe_out
				address_manager.recycle
				favorites_manager.recycle
				cluster_manager.recycle
				menus.recycle_menus
				history_manager.recycle

				Precursor {EB_TOOL_MANAGER}
				if menus.view_menu /= Void then
					menus.view_menu.destroy
				end

				managed_class_formatters.wipe_out
				managed_class_formatters := Void
				managed_feature_formatters.wipe_out
				managed_feature_formatters := Void
				managed_main_formatters.wipe_out
				managed_main_formatters := Void
				commands.toolbarable_commands.wipe_out

				if editors_manager /= Void then
					editors_manager.recycle
					editors_manager := Void
				end

				stone := Void
			end
		end

	save_size is
			-- Save window size.
		do
			if not window.is_maximized and not window.is_minimized then
					development_window_data.save_size (window.width, window.height)
			end
		end

	save_position is
			-- Save window position.
		do
			if not window.is_maximized and not window.is_minimized then
				development_window_data.save_position (window.screen_x, window.screen_y)
			end
		end

	 save_window_state is
	 		-- Save window state information to preference data.
	 	do
			development_window_data.save_window_state (window.is_minimized, window.is_maximized)
	 	end

feature {EB_STONE_FIRST_CHECKER, EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Implementation

	set_stone_after_check (a_stone: STONE) is
			-- Set stone after check
		local
			l_checker: EB_STONE_CHECKER
		do
			create l_checker.make (Current)
			l_checker.set_stone_after_check (a_stone)
		end

	check_passed: BOOLEAN
			-- If check passed?

	save_canceled: BOOLEAN
			-- did user cancel save ?

	save_only: BOOLEAN
			-- skip parse and update after save ?

	is_destroying: BOOLEAN
			-- Is `current' being currently destroyed?

	on_cursor_moved is
			-- The cursor has moved, reflect the change in the status bar.
			-- And reflect location editing in the text in features tool and address bar.
		do
			refresh_cursor_position
			if context_refreshing_timer = Void then
				create context_refreshing_timer.make_with_interval (100)
				context_refreshing_timer.actions.extend (agent refresh_context_info)
			end
			if feature_locating then
				context_refreshing_timer.set_interval (0)
			else
				context_refreshing_timer.set_interval (100)
			end
		end

	all_editor_closed is
			-- All editor closed.
		do
			if editors_manager.editors.count <= 0 then
				disable_editors_command
				tools.features_tool.set_stone (Void)
				set_title (window_manager.new_title)
				if not window.is_destroyed and window.is_displayed and window.is_sensitive then
					window.set_focus
				end
			end
		end

feature {EB_STONE_CHECKER, EB_STONE_FIRST_CHECKER, EB_DEVELOPMENT_WINDOW_PART} -- Internal issues with EB_STONE_CHECKER

	is_text_loaded: BOOLEAN is
			-- Text is loaded in current editor?
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.is_text_loaded (stone)
			else
				Result := True
			end
		end

	set_feature_stone_already_processed (a_bool: like feature_stone_already_processed) is
			-- Set `feature_stone_already_processed'
		do
			feature_stone_already_processed := a_bool
		ensure
			set: feature_stone_already_processed = a_bool
		end

	feature_stone_already_processed: BOOLEAN
			-- Is the processed stone a feature stone and has it
			-- been already processed by the editor ?

	set_text_saved (a_bool: like text_saved) is
			-- Set `text_saved'
		do
			text_saved := a_bool
		ensure
			set: text_saved = a_bool
		end

	text_saved: BOOLEAN
			-- has the user chosen to save the file

	set_during_synchronization (a_bool: BOOLEAN) is
			-- Set `during_synchronization'
		do
			during_synchronization := a_bool
		ensure
			set: during_synchronization = a_bool
		end

	during_synchronization: BOOLEAN
			-- Are we during a resynchronization?

	update_formatters is
			-- Give a correct sensitivity to formatters.
		local
			cist: CLASSI_STONE
			cst: CLASSC_STONE
			type_changed: BOOLEAN
			cluster_st: CLUSTER_STONE
		do
			cst ?= stone
			cist ?= stone
			-- Check to if formatting context has changed.
			if cst /= Void then
				type_changed := (cst.e_class.is_true_external and not is_stone_external) or
					(not cst.e_class.is_true_external and is_stone_external)
			elseif cist /= Void then
				type_changed := (cist.class_i.is_external_class and not is_stone_external) or
					(not cist.class_i.is_external_class and is_stone_external)
			end

			if type_changed then
					-- Toggle stone flag.
				is_stone_external := not is_stone_external
			end

			if cst /= Void then
				address_manager.enable_formatters
				if is_stone_external then
						-- Change formatters to .NET sensitivity (from normal).
					enable_dotnet_formatters
					if type_changed then
						managed_main_formatters.i_th (4).enable_select
					end
				else
					if changed then
						address_manager.disable_formatters
					else
						--managed_main_formatters.first.disable_sensitive
					end
				end
			elseif cist /= Void and is_stone_external then
					-- Change formatters to .NET sensitivity (from normal).
				enable_dotnet_formatters
				if type_changed then
					managed_main_formatters.i_th (4).enable_select
				end
			else
				address_manager.disable_formatters
				cluster_st ?= stone
				if cist /= stone and cluster_st = Void then
					managed_main_formatters.first.execute
				end
			end
		end

	scroll_to_feature (feat_as: E_FEATURE; displayed_class: CLASS_I) is
			-- highlight the feature correspnding to `feat_as' in the class represented by `displayed_class'
		require
			class_is_not_void: displayed_class /= Void
			feat_as_is_not_void: feat_as /= Void
		local
			begin_index: INTEGER
			l_feat_as: FEATURE_AS
			l_feature: E_FEATURE
			l_names: EIFFEL_LIST [FEATURE_NAME]
			offset: TUPLE [start_offset: INTEGER; end_offset: INTEGER]
		do
			if not feat_as.is_il_external then
				if not managed_main_formatters.first.selected then
					if feat_as.ast /= Void then
						editors_manager.current_editor.find_feature_named (feat_as.name)
					end
				else
					if displayed_class.is_compiled then
							-- We need to adapt E_FEATURE to the current displayed class
							-- since we could manipulate the E_FEATURE of a descendant class
							-- whose name is different from its definition in the displayed_class.
							-- Fixes bug#11330.
						l_feature := feat_as.ancestor_version (displayed_class.compiled_class)
						if l_feature = Void then
								-- It should not happen, but maybe the system is in a very unstable state.
							l_feature := feat_as
						end
					else
						l_feature := feat_as
					end
					l_feat_as := l_feature.ast
					if l_feat_as /= Void then
						from
							l_names := l_feat_as.feature_names
							l_names.start
						until
							l_names.after or else
							l_feature.name.is_case_insensitive_equal (l_names.item.internal_name.name)
						loop
							l_names.forth
						end
						if not l_names.after then
							begin_index := l_names.item.start_position
						else
								-- Something wrong happened, the feature does not exist anymore.
								-- We simply take the position of the first one.
							begin_index := l_names.start_position
						end
						offset := relative_location_offset ([begin_index, 0], displayed_class)
						editors_manager.current_editor.scroll_to_when_ready (begin_index - offset.start_offset)
					end
				end
			else
					-- Nothing for .NET features for now.
				fixme ("It should be implemented.")
			end
		end

	scroll_to_ast (a_ast: AST_EIFFEL; displayed_class: CLASS_I; a_selected: BOOLEAN) is
			-- Scroll to `a_ast' in `displayed_class'.
			-- If `a_selected' is True, select region of `a_ast'.
		local
			begin_index: INTEGER
			offset: TUPLE [start_offset: INTEGER; end_offset: INTEGER]
		do
			begin_index := a_ast.start_position
			offset := relative_location_offset ([begin_index, a_ast.end_position], displayed_class)

			if a_selected then
				editors_manager.current_editor.select_region_when_ready (begin_index - offset.start_offset, a_ast.end_position - offset.end_offset + 1)
			else
				editors_manager.current_editor.scroll_to_when_ready (begin_index - offset.start_offset)
			end
		end

	relative_location_offset (a_location: TUPLE [a_start_pos: INTEGER; a_end_pos: INTEGER]; a_displayed_class: CLASS_I): TUPLE [related_start_pos: INTEGER; related_end_pos: INTEGER] is
			-- Relative editor location offset (the number of all '%R' removed) of `a_location' in context of `a_displayed_class'
		require
			a_location_attached: a_location /= Void
			a_displayed_class_attached: a_displayed_class /= Void
		local
			class_text: STRING
			tmp_text: STRING
			begin_offset: INTEGER
			end_offset: INTEGER
			a_start_pos, a_end_pos: INTEGER
		do
			a_start_pos := a_location.a_start_pos
			a_end_pos := a_location.a_end_pos

			class_text := a_displayed_class.text
			if class_text /= Void then
				tmp_text := class_text.substring (1, a_start_pos)
				begin_offset := tmp_text.occurrences('%R')

				if a_start_pos >= a_end_pos then
					tmp_text := class_text.substring (a_start_pos + 1, a_end_pos)
					end_offset := tmp_text.occurrences ('%R')
				end
				Result := [begin_offset, begin_offset + end_offset]
			else
				Result := [0, 0]
			end
		ensure
			result_attached: Result /= Void
		end

feature {EB_DEVELOPMENT_WINDOW_PART, EB_STONE_FIRST_CHECKER, EB_DEVELOPMENT_WINDOW_BUILDER} -- Implementation

	update_save_symbol is
			-- Update save symbol.
		do
			Precursor {EB_FILEABLE}
			if editors_manager.current_editor /= Void then
				if changed then
					save_cmd.enable_sensitive
					address_manager.disable_formatters
					editors_manager.current_editor.set_title_saved (false)
				else
					save_cmd.disable_sensitive
					update_formatters
					editors_manager.current_editor.set_title_saved (true)
				end
			end
			if is_empty then
				commands.print_cmd.disable_sensitive
				commands.save_as_cmd.disable_sensitive
			else
				commands.print_cmd.enable_sensitive
				commands.save_as_cmd.enable_sensitive
			end
			if any_editor_changed then
				save_all_cmd.enable_sensitive
			else
				save_all_cmd.disable_sensitive
			end
			if editors_manager.editors.count > 0 then
				commands.shell_cmd.enable_sensitive
			else
				commands.shell_cmd.disable_sensitive
			end
		end

	is_stone_external: BOOLEAN
			-- Does 'stone' contain a .NET consumed type?

	enable_dotnet_formatters is
			-- Enable only the .NET class text formatters.
		local
			l_formatters: like managed_main_formatters
		do
			l_formatters := managed_main_formatters.twin
			from
				l_formatters.start
			until
				l_formatters.after
			loop
				if l_formatters.item.is_dotnet_formatter then
					l_formatters.item.enable_sensitive
				else
					l_formatters.item.disable_sensitive
				end
				l_formatters.forth
			end
		end

	text_edited: BOOLEAN
			-- Do we know that the text was edited?
			-- If so, no need to update the display each time it is edited.

	saved_cursor: CURSOR
			-- Saved cursor position for displaying the stack.

	terminate_external_command_and_destroy is
			-- Terminate running external command and destroy.
		do
			process_manager.terminate_external_command
			destroy
		ensure
			external_command_not_running: not process_manager.is_external_command_running
		end

	save_and_destroy is
			-- Save text then destroy.
		do
			save_text
			destroy
		end

	force_destroy is
			-- Destroy without asking.
		do
			confirmed := True
			destroy
			confirmed := False
		end

	confirmed: BOOLEAN
			-- Did the user say he wanted to exit?

	context_refreshing_timer: EV_TIMEOUT
			-- Timer to refresh feature tree address bar.

	selected_formatter: EB_CLASS_TEXT_FORMATTER is
			-- Current selected formatter
		local
			l_end : BOOLEAN
			l_index: INTEGER
			l_formatter: like managed_main_formatters
		do
			l_formatter := managed_main_formatters
			l_index := l_formatter.index
			from
				l_formatter.start
			until
				l_formatter.after or l_end
			loop
				if l_formatter.item.selected then
					l_end := True
					Result := l_formatter.item
				end
				l_formatter.forth
			end
			l_formatter.go_i_th (l_index)
		ensure
			selected_formatter_not_void: Result /= Void
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- Recycle all.
		do
			recycle_command
			recycle_formatters
			recycle_menu
			Precursor {EB_TOOL_MANAGER}
			if commands.save_as_cmd /= Void then
				commands.save_as_cmd.recycle
			end
			if save_cmd /= Void then
				save_cmd.recycle
			end
			commands.set_save_as_cmd (Void)
			save_cmd := Void
			command_controller.recycle
			if refactoring_manager /= Void then
				refactoring_manager.destroy
			end
			tools.set_windows_tool (Void)
			tools.set_favorites_tool (Void)
			history_manager := Void
			tools.set_features_tool (Void)
			tools.set_breakpoints_tool (Void)
			favorites_manager := Void
			cluster_manager := Void
			tools.set_search_tool (Void)

			if editors_manager /= Void then
				editors_manager.recycle
				editors_manager := Void
			end

			agents.manager.remove_observer (agents)
			docking_manager.destroy
		end

	recycle_command is
			-- Recycle command
		do
			commands.recycle
		end

	recycle_formatters is
			-- Recycle formatters
		do
			from
				managed_class_formatters.start
			until
				managed_class_formatters.after
			loop
				if managed_class_formatters.item /= Void then
					managed_class_formatters.item.recycle
				end
				managed_class_formatters.forth
			end

			from
				managed_feature_formatters.start
			until
				managed_feature_formatters.after
			loop
				if managed_feature_formatters.item /= Void then
					managed_feature_formatters.item.recycle
				end
				managed_feature_formatters.forth
			end

			from
				managed_main_formatters.start
			until
				managed_main_formatters.after
			loop
				if managed_main_formatters.item /= Void then
					managed_main_formatters.item.recycle
				end
				managed_main_formatters.forth
			end
		end

	recycle_menu is
			-- Recycle menus.
		do
			menus.recycle_menus
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initliazed by EB_DEVELOPMENT_WINDOW_BUILDER

	show_dynamic_library_dialog is
			-- Create a new dynamic library window and display it.
		do
			Window_manager.create_dynamic_lib_window
		end

	send_stone_to_context is
			-- Send current stone to the context tool.
			-- Send current targeting feature to context tool if possible.
			-- Used by `send_stone_to_context_cmd'.
		local
			l_feature_text: STRING
			l_class_stone: CLASSI_STONE
			l_feature_stone: FEATURE_STONE
			l_class_c: CLASS_C
			l_feature: E_FEATURE
		do
			if address_manager /= Void then
				l_feature_text := address_manager.feature_address.text.as_string_8
			end
			l_class_stone ?= stone
			if l_class_stone /= Void then
				l_class_c := l_class_stone.class_i.compiled_representation
				if l_class_c /= Void then
					if l_feature_text /= Void and then not l_feature_text.is_empty and then l_class_c.has_feature_table then
						l_feature := l_class_c.feature_with_name (l_feature_text)
					end
					if l_feature /= Void then
						create l_feature_stone.make (l_feature)
						tools.set_stone_and_pop_tool (l_feature_stone)
					else
						tools.set_stone_and_pop_tool (stone)
					end
				end
			end
		end

feature {EB_DEVELOPMENT_WINDOW_MENU_BUILDER, EB_DEVELOPMENT_WINDOW_PART,
			EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Implementation: Editor commands

	refresh_cursor_position is
			-- Display the current cursor position in the status bar.
		require
			text_loaded: not is_empty
		local
			l, c, v: INTEGER
			ed: EB_EDITOR
		do
			ed := editors_manager.current_editor
			if ed /= Void then
				l := ed.cursor_y_position
				c := ed.cursor_x_position
				v := ed.cursor_visible_x_position
			end
			status_bar.set_cursor_position (l, c, v)
		end

	refresh_context_info is
			-- Refresh address bar and features tool to relect
			-- where in the code the cursor is located.
		local
			l_feature: TUPLE [feat_as: FEATURE_AS; name: FEATURE_NAME]
			l_classc_stone: CLASSC_STONE
			ed: EB_SMART_EDITOR
		do
				-- we may have been called from a timer and have to deactivate the timer
			if context_refreshing_timer /= Void then
				context_refreshing_timer.set_interval (0)
			end
			if managed_main_formatters.first.selected then
					-- We only do that for the clickable view
				l_classc_stone ?= stone
				if l_classc_stone /= Void then
					ed := editors_manager.current_editor
					if
						ed /= Void
						and then ed.text_displayed /= Void
					then
						l_feature := ed.text_displayed.current_feature_containing
						if l_feature /= Void then
							set_editing_location_by_feature (l_feature.name)
						else
							set_editing_location_by_feature (Void)
						end
					end
				end
			end
		end

	set_editing_location_by_feature (a_feature_name: FEATURE_NAME) is
			-- Set editing location, feature tool and combo box changes according to `a_feature_name'.
		local
			l_efeature: E_FEATURE
			l_class_i: CLASS_I
			l_classc: CLASS_C
		do
			if a_feature_name /= Void then
				address_manager.set_feature_text_simply (a_feature_name.internal_name.name)
				if class_name /= Void and group /= Void then
					l_class_i := eiffel_universe.safe_class_named (class_name, group)
					if l_class_i /= Void and then l_class_i.is_compiled then
						l_classc := l_class_i.compiled_class
						if l_classc.has_feature_table then
							l_efeature := l_classc.feature_with_name (a_feature_name.internal_name.name)
							if l_efeature /= Void and then l_efeature.written_in /= l_classc.class_id then
								l_efeature := Void
							end
						end
					end
				end
				if l_efeature /= Void then
					seek_item_in_feature_tool (l_efeature)
				else
					tools.features_tool.seek_ast_item_in_feature_tool (a_feature_name.internal_name.name)
				end
			else
				address_manager.set_feature_text_simply (once "")
				seek_item_in_feature_tool (Void)
			end
		end

	seek_item_in_feature_tool (a_feature: E_FEATURE) is
			-- Seek and select item contains data of `a_feature' in features tool.
			-- If `a_feature' is void, deselect item in features tool.
		do
			tools.features_tool.seek_item_in_feature_tool (a_feature)
		end

	select_all is
			-- Select the whole text in the focused editor.
		local
			l_editor: EB_EDITOR
		do
			l_editor := ui.current_editor
			if l_editor /= Void and then not l_editor.is_empty then
				l_editor.select_all
			end
		end

	search is
			-- Search some text in the focused editor.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			cv_ced ?= editors_manager.current_editor
			if cv_ced /= Void then
				cv_ced.search
			end
		end

	goto is
			-- Display a dialog to select a line to go to in the editor.
		local
			ed: EB_EDITOR
			l_dialog: EB_GOTO_DIALOG
		do
			ed ?= editors_manager.current_editor
			if ed /= Void then
				create l_dialog.make (ed)
				ui.set_goto_dialog (l_dialog)
				l_dialog.show_modal_to_window (Current.window)
			end
		end

	toggle_line_number_display is
			-- Toggle line number display on/off in editor
		do
			preferences.editor_data.show_line_numbers_preference.set_value (not preferences.editor_data.show_line_numbers)
		end

	find_next is
			-- Find the next occurrence of the search text.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			if tools.search_tool.currently_searched /= Void then
				cv_ced ?= ui.current_editor
				if cv_ced /= Void then
					cv_ced.find_next
				end
			else
				tools.search_tool.show_and_set_focus
			end
		end

	find_previous is
			-- Find the previous occurrence of the search text.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			if tools.search_tool.currently_searched /= Void then
				cv_ced ?= ui.current_editor
				if cv_ced /= Void then
					cv_ced.find_previous
				end
			else
				tools.search_tool.show_and_set_focus
			end
		end

	find_next_selection is
			-- Find the next occurrence of the selection.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			cv_ced := ui.current_editor
			if cv_ced /= Void then
				cv_ced.find_next_selection
			end
		end

	find_previous_selection is
			-- Find the next occurrence of the selection.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			cv_ced := ui.current_editor
			if cv_ced /= Void then
				cv_ced.find_previous_selection
			end
		end

	cut_selection is
			-- Cut the selection in the current editor.
		do
			if ui.current_editor /= Void then
				ui.current_editor.cut_selection
			end
		end

	copy_selection is
			-- Cut the selection in the current editor.
		do
			if ui.current_editor /= Void then
				ui.current_editor.copy_selection
			end
		end

	toggle_formatting_marks is
			-- Show/Hide formatting marks in the editor and update related menu item.
		do
			editors_manager.current_editor.toggle_view_invisible_symbols
			if editors_manager.current_editor.view_invisible_symbols then
				formatting_marks_command_menu_item.set_text (Interface_names.m_hide_formatting_marks)
			else
				formatting_marks_command_menu_item.set_text(Interface_names.m_show_formatting_marks)
			end
		end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Implementation / Menus

	set_undo_accelerator (a_accelerator: like undo_accelerator) is
			-- Set `undo_accelerator'
		do
			undo_accelerator := a_accelerator
		ensure
			set: undo_accelerator = a_accelerator
		end

	undo_accelerator: EV_ACCELERATOR
			-- Accelerator for Ctrl+Z

	set_redo_accelerator (a_accelerator: like redo_accelerator) is
			-- Set `redo_accelerator'
		do
			redo_accelerator := a_accelerator
		ensure
			set: redo_accelerator = a_accelerator
		end

	redo_accelerator: EV_ACCELERATOR
			-- Accelerator for Ctrl+Y

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_ADDRESS_MANAGER} -- Builder issues

	set_tools_initialized (a_bool: like tools_initialized) is
			-- Set `tools_initialized'
		do
			tools_initialized := a_bool
		ensure
			set: tools_initialized = a_bool
		end

	set_toolbars_area (a_area: like toolbars_area) is
			-- Set `toolbars_area'
		do
			toolbars_area := a_area
		ensure
			set: toolbars_area = a_area
		end

	set_view_points_combo (a_view_points_combo: like view_points_combo) is
			-- Set `view_points_combo'
		do
			view_points_combo := a_view_points_combo
		ensure
			set: view_points_combo = a_view_points_combo
		end

	set_managed_class_formatters (a_formatters: like managed_class_formatters) is
			-- Set `managed_class_formatters'
		do
			managed_class_formatters := a_formatters
		ensure
			set: managed_class_formatters = a_formatters
		end

	set_managed_feature_formatters (a_formatters: like managed_feature_formatters) is
			-- Set `managed_feature_formatters'
		do
			managed_feature_formatters := a_formatters
		ensure
			set: managed_feature_formatters = a_formatters
		end

	set_managed_main_formatters (a_formatters: like managed_main_formatters) is
			-- Set `managed_main_formatters'
		do
			managed_main_formatters := a_formatters
		ensure
			set: managed_main_formatters = a_formatters
		end

	set_managed_dependency_formatters (a_formatters: like managed_dependency_formatters) is
			-- Set `managed_dependency_formatters'
		do
			managed_dependency_formatters := a_formatters
		ensure
			set: managed_dependency_formatters = a_formatters
		end

	set_help_engine (a_engine: like help_engine) is
			-- Set `help_engine'
		do
			help_engine := a_engine
		ensure
			set: help_engine = a_engine
		end

	set_container (a_container: like container) is
			-- Set `container'
		do
			container := a_container
		ensure
			set: container = a_container
		end

	set_panel (a_panel: like panel) is
			-- Set `panel'
		do
			panel := a_panel
		ensure
			set: panel = a_panel
		end

	set_status_bar (a_bar: like status_bar) is
			-- Set `status_bar'
		do
			status_bar := a_bar
		ensure
			set: status_bar = a_bar
		end

	set_window (a_window: like window) is
			-- Set `window'
		do
			window := a_window
		ensure
			set: window = a_window
		end

	on_viewpoint_changed is
			-- Switch viewpoint.
		local
			l_formatter: EB_CLASS_TEXT_FORMATTER
			l_line: INTEGER
		do
			l_formatter := selected_formatter
			if l_formatter.is_button_sensitive and then
				l_formatter /= managed_main_formatters.first and then
				editors_manager.current_editor /= Void
			then
				l_line := editors_manager.current_editor.first_line_displayed
				l_formatter.execute
				editors_manager.current_editor.display_line_at_top_when_ready (l_line)
			end
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_PART} -- EB_DEVELOPMENT_WINDOW_MENU_BUILDER issues

	destroy is
			-- check if current text has been saved and destroy
		local
			dialog_w: EB_WARNING_DIALOG
		do
			if Window_manager.development_windows_count > 1 and then process_manager.is_external_command_running and then Current = external_output_manager.target_development_window then
				process_manager.confirm_external_command_termination (agent terminate_external_command_and_destroy, agent do_nothing, window)
			else
				if changed and then not confirmed then
					if Window_manager.development_windows_count > 1 then
						create dialog_w.make_with_text (Warning_messages.w_save_before_closing)
						dialog_w.set_buttons_and_actions (<<interface_names.b_yes, interface_names.b_no, interface_names.b_cancel>>, <<agent save_and_destroy, agent force_destroy, agent do_nothing>>)
						dialog_w.set_default_push_button (dialog_w.button(interface_names.b_yes))
						dialog_w.set_default_cancel_button (dialog_w.button(interface_names.b_cancel))
						dialog_w.show_modal_to_window (window)
					else
							-- We let the window manager handle the saving, along with other windows
							-- (not development windows)
						force_destroy
					end
				else
					Precursor {EB_TOOL_MANAGER}
					if context_refreshing_timer /= Void then
						context_refreshing_timer.destroy
						context_refreshing_timer := Void
					end
				end
			end
		end

	set_command_controller (a_controller: like command_controller) is
			-- Set `command_controller'
		do
			command_controller := a_controller
		ensure
			set: command_controller = a_controller
		end

	set_formatting_marks_command_menu_item (a_item: like formatting_marks_command_menu_item) is
			-- Set `formatting_marks_command_menu_item'
		do
			formatting_marks_command_menu_item := a_item
		ensure
			set: formatting_marks_command_menu_item = a_item
		end

	formatting_marks_command_menu_item: EB_COMMAND_MENU_ITEM
			-- Menu item used to shw/hide formatting marks.

	number_of_displayed_external_commands: INTEGER
			-- Number of external commands in the tools menu.

	set_number_of_displayed_external_commands (a_number: INTEGER) is
			-- Set `number_of_displayed_external_commands'
		do
			number_of_displayed_external_commands := a_number
		ensure
			set: number_of_displayed_external_commands = a_number
		end

	set_show_dynamic_lib_tool (a_cmd: like show_dynamic_lib_tool) is
			-- Set `show_dynamic_lib_tool'
		do
			show_dynamic_lib_tool := a_cmd
		ensure
			set: show_dynamic_lib_tool = a_cmd
		end

feature {EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_BUILDER, EB_ADDRESS_MANAGER} --EB_DEVELOPMENT_WINDOW_DIRECTOR issues.

	set_unified_stone (a_bool: like unified_stone) is
			-- Set `unified_stone'
		do
			unified_stone := a_bool
		ensure
			set: unified_stone = a_bool
		end

	set_history_manager (a_manager: like history_manager) is
			-- Set `history_manager'
		do
			history_manager := a_manager
		ensure
			set: history_manager = a_manager
		end

	set_address_manager (a_manager: like address_manager) is
			-- Set `address_manager'
		do
			address_manager := a_manager
		ensure
			set: address_manager = a_manager
		end

	set_view_points (a_view_points: like view_points_combo) is
			-- Set `view_points_combo'
		do
			view_points_combo := a_view_points
		ensure
			set: view_points_combo = a_view_points
		end

	set_initialized_for_builder (a_bool: like initialized) is
			-- Set `initialized'
		do
			initialized := a_bool
		ensure
			set: initialized = a_bool
		end

	set_is_destroying (a_bool: like is_destroying) is
			-- Set `is_destroying'
		do
			is_destroying := a_bool
		ensure
			set: is_destroying = a_bool
		end

feature{EB_TOOL, EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_PART}

	command_controller: EB_EDITOR_COMMAND_CONTROLLER
			-- Object that takes care of updating the sensitivity of all editor commands.

feature{EB_TOOL, EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_MENU_BUILDER}

	execute_show_favorites is
			-- Show `favorites_tool' if it is closed, close
			-- it in the opposite case.
		do
			tools.favorites_tool.show
		end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Execution

	save_and_switch_formatter (a_formatter: EB_FORMATTER) is
			-- Save the file before switching bewteen main formatters when the file is not saved.
		require
			a_formatter_not_void: a_formatter /= Void
		do
			if changed then
				save_and (agent a_formatter.execute)
			else
				a_formatter.execute
			end
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Access

	development_window_data: EB_DEVELOPMENT_WINDOW_DATA is
			-- Meta data describing `Current'.
		do
			Result := preferences.development_window_data
		end

feature -- Parts

	commands: EB_DEVELOPMENT_WINDOW_COMMANDS
			-- All commands except commands from EB_FILEABLE, EB_SHARED_GRAPHICAL_COMMANDS, `show_dynamic_lib_tool'

	menus: EB_DEVELOPMENT_WINDOW_MENUS
			-- All menus.

	agents: EB_DEVELOPMENT_WINDOW_AGENTS
			-- All agents.

	tools: EB_DEVELOPMENT_WINDOW_TOOLS
			-- All tools.

	ui: EB_DEVELOPMENT_WINDOW_UI
			-- All widgets, such as save file dialogs.

feature {EB_DEVELOPMENT_WINDOW_PART}

	set_text_edited (a_bool: like text_edited) is
			-- Set `text_edited'
		do
			text_edited := a_bool
		ensure
			set: text_edited = a_bool
		end

	set_context_refreshing_timer (a_timer: like context_refreshing_timer) is
			-- Set `context_refreshing_timer'
		do
			context_refreshing_timer := a_timer
		ensure
			set: context_refreshing_timer = a_timer
		end

invariant
	not_void: commands /= Void
	not_void: menus /= Void
	not_void: agents /= Void
	not_void: tools /= Void
	not_void: ui /= Void

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

end -- class EB_DEVELOPMENT_WINDOW
