note
	description: "Window holding a project tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
			{EB_STONE_CHECKER}
				Ev_application, shared_environment
			{ANY} auto_recycle, delayed_auto_recycle
		redefine
			set_title,
			show,
			refresh,
			refresh_all_commands,
			refresh_external_commands,
			internal_recycle,
			destroy_imp,
			destroy,
			position,
			pos_container,
			internal_detach_entities
		end

	EB_FILEABLE
		export
			{NONE} set_position, set_pos_container
		redefine
			set_stone,
			reset,
			stone,
			on_before_text_saved,
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
		export
			{NONE} set_position, set_pos_container
			{EB_STONE_CHECKER} old_set_stone
		redefine
			reset,
			stone,
			on_before_text_saved,
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
			{NONE} all
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_COMPILER_PROFILE
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

	HASHABLE

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

		-- Used to bind context sensitive help
	ES_HELP_REQUEST_BINDER
		export
			{NONE} all
		redefine
			show_help
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

		-- ESS Interfaces
	SHELL_WINDOW_I

	EVS_HELPERS

	EB_TOKEN_TOOLKIT

create {EB_DEVELOPMENT_WINDOW_DIRECTOR}
	make

feature {NONE} -- Initialization

	make
			-- Creation method.
		do
			create commands.make (Current)
			auto_recycle (commands)
			create menus.make (Current)
			auto_recycle (menus)
			create agents.make (Current)
			auto_recycle (agents)
			create tools.make (Current)
			auto_recycle (tools)
			create shell_tools.make (Current)
			auto_recycle (shell_tools)
			create ui.make (Current)
			auto_recycle (ui)
			create docking_layout_manager.make (Current)
			auto_recycle (docking_layout_manager)

			window_id := next_window_id
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initialization

	set_save_cmd (a_cmd: like save_cmd)
			-- Set `save_cmd'
		do
			save_cmd := a_cmd
		ensure
			set: save_cmd = a_cmd
		end

	set_save_all_cmd (a_cmd: like save_all_cmd)
			-- Set `save_all_cmd'
		do
			save_all_cmd := a_cmd
		ensure
			set: save_all_cmd = a_cmd
		end

feature -- DPI handling

	dpi_scaler: EVS_DPI_SCALER
		do
			Result := internal_dpi_scaler
			if Result = Void then
				create Result.make
				internal_dpi_scaler := Result
			end
		end

	internal_dpi_scaler: detachable like dpi_scaler

	dpi: NATURAL
			-- Return the dots per inch (dpi) of the monitor
			-- DPI sizes 96, 120, 144, 192, etc.
		do
			Result := dpi_scaler.dpi
		end

	update_dpi (a_dpi: NATURAL)
		require
			a_dpi > 0
		local
			l_dpi: NATURAL
		do
			if attached {EXECUTION_ENVIRONMENT}.item ("ISE_STUDIO_DPI") as l_forced_dpi and then l_forced_dpi.is_integer then
				l_dpi := l_forced_dpi.to_natural_32
				if l_dpi <= 0 then
					l_dpi := a_dpi
				end
			else
				l_dpi := a_dpi
			end
			dpi_scaler.update_dpi (l_dpi)
		end

	scaled_size (a_size: INTEGER): INTEGER
			-- Scaled size of `a_size`.
		do
			Result := dpi_scaler.scaled_size (a_size)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- Recycle all.
		local
			l_session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			l_sessions: ARRAYED_LIST [SESSION_I]
			l_session: SESSION_I
		do
			create l_session_manager
			if attached l_session_manager.service as l_session_service then
					-- Store and clear all session data related to the window.
				l_sessions := l_session_service.active_sessions
				from l_sessions.start until l_sessions.after loop
					l_session := l_sessions.item
					if l_session.is_interface_usable and then l_session.is_per_window and then l_session.window_id = window_id then
							-- Closes and stores session data.
						l_session_service.close_session (l_session)
					end
					l_sessions.forth
				end

					-- Store all other session data, that's not tied to the window, incase this is the last window.
				l_session_service.store_all
			end

			recycle_formatters
			shortcut_manager.clear_actions (window)
			agents.manager.remove_observer (agents)
--			customized_tool_manager.change_actions.prune_all (agents.on_customized_tools_changed_agent)
			if save_cmd /= Void then
				save_cmd.recycle
			end
			if save_all_cmd /= Void then
				save_all_cmd.recycle
			end
			commands.set_save_as_cmd (Void)
			if command_controller /= Void then
				command_controller.recycle
			end
			if refactoring_manager /= Void then
				refactoring_manager.destroy
			end
			if editors_manager /= Void then
				editors_manager.recycle
			end
			if docking_manager /= Void then
				docking_manager.destroy
			end

			managed_class_formatters.wipe_out
			managed_feature_formatters.wipe_out
			managed_dependency_formatters.wipe_out
			managed_main_formatters.wipe_out
--			commands.toolbarable_commands.wipe_out

			Precursor {EB_TOOL_MANAGER}
		end

	internal_detach_entities
			-- Detaches objects from their container
		do
			save_cmd := Void
			save_all_cmd := Void
			command_controller := Void
			docking_manager := Void
			editors_manager := Void
			history_manager := Void
			favorites_manager := Void
			cluster_manager := Void
			tools := Void
			commands := Void
			menus := Void
			agents := Void
			ui := Void
			shell_tools := Void
			address_manager := Void
			internal_session_data := Void
			internal_project_session_data := Void

			Precursor {EB_TOOL_MANAGER}
		ensure then
			save_cmd_detached: save_cmd = Void
			save_all_cmd_detached: save_all_cmd = Void
			command_controller_detached: command_controller = Void
			docking_manager_detached: docking_manager = Void
			editors_manager_detached: editors_manager = Void
			history_manager_detached: history_manager = Void
			favorites_manager_detached: favorites_manager = Void
			cluster_manager_detached: cluster_manager = Void
			tools_detached: tools = Void
			commands_detached: commands = Void
			menus_detached: menus = Void
			agents_detached: agents = Void
			ui_detached: ui = Void
			shell_tools_detached: shell_tools = Void
			internal_session_detached: internal_session_data = Void
			internal_project_session_detached: internal_project_session_data = Void
		end

feature -- Access

	group: CONF_GROUP
			-- Group of current class. Void if none.
		do
			if attached {CLASSI_STONE} stone as classi_stone then
				Result := classi_stone.group
			end
			if attached {CLUSTER_STONE} stone as cluster_stone then
				Result := cluster_stone.group
			end
		end

	class_name: STRING
			-- Name of the current class, Void if none.
		do
			if attached {CLASSI_STONE} stone as class_stone and then class_stone.is_valid then
				Result := class_stone.class_name
			end
		end

	session_data: detachable SESSION_I
			-- Access to window session data for the current window
		require
			not_is_recycled: not is_recycled
		local
			l_consumer: SERVICE_CONSUMER [SESSION_MANAGER_S]
		do
			Result := internal_session_data
			if Result = Void then
				create l_consumer
				if attached l_consumer.service as l_service then
					Result := l_service.retrieve_per_window (Current, False)
					internal_session_data := Result
				end
			end
		ensure
			result_attached: (create {SERVICE_CONSUMER [SESSION_MANAGER_S]}).service /= Void implies Result /= Void
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_consistent: Result = session_data
		end

	project_session_data: SESSION_I
			-- Access to window session data for the current project/window
			-- We must check if system defined here
			-- Otherwise {SESSION_MANAGER}.session_file_path don't know the *project* UUID for project session file name
		require
			system_defined: (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			l_consumer: SERVICE_CONSUMER [SESSION_MANAGER_S]
		do
			Result := internal_project_session_data
			if Result = Void then
				create l_consumer
				if attached l_consumer.service as l_service then
					Result := l_service.retrieve_per_window (Current, True)
					internal_project_session_data := Result
				end
			end
		ensure
			result_attached: (create {SERVICE_CONSUMER [SESSION_MANAGER_S]}).service /= Void implies Result /= Void
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = project_session_data
		end

	frozen layout_manager: attached ES_DEVELOPMENT_WINDOW_LAYOUT_MANAGER
			-- Handles all docking layout management
		require
			is_interface_usable: is_interface_usable
		local
			l_result: detachable like internal_layout_manager
		do
			l_result := internal_layout_manager
			if l_result = Void then
				create Result.make (Current)
				auto_recycle (Result)
				internal_layout_manager := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = layout_manager
		end

	frozen window_id: NATURAL_32
			-- Unique window identifier, used to reference a window without having to hold a reference to it

	hash_code: INTEGER
			-- Hash code value
		do
			Result := window_id.as_integer_32
		end

	selected_formatter: EB_CLASS_TEXT_FORMATTER
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

feature -- Access: Help

	help_context_id: STRING_32 = "E34647C8-840E-159D-74B3-07353A27472E"
			-- Id linked to Eiffel Studio help documentation book.
			-- <Precursor>

feature {NONE} -- Access

	frozen window_id_counter: CELL [NATURAL_32]
			-- Counter for generating unique window id's
		once
			create Result.put (1)
		ensure
			result_attached: Result /= Void
			result_item_positive: Result.item > 0
		end

	is_processing_stone: BOOLEAN
			-- To avoid recursion when processing stones in `set_stone'.

feature -- Querys

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager, one instance per one EB_DEVELOPMENT_WINDOW.

	editors_manager: EB_EDITORS_MANAGER
			-- Editors manager

feature -- Settings

	set_docking_manager (a_manager: SD_DOCKING_MANAGER)
			-- Set `docking_manager'
		do
			docking_manager := a_manager
		ensure
			set: docking_manager = a_manager
		end

	set_editors_manager (a_manager: like editors_manager)
			-- Set `editors_manager'
		do
			editors_manager := a_manager
		ensure
			set: editors_manager = a_manager
		end

feature -- Status setting

	set_title (a_title: like title)
			-- <Precursor>
		local
			l_title: STRING_32
			l_different: BOOLEAN
			l_special_option: BOOLEAN
		do
			l_different := (not attached title) or else not a_title.same_string (title)
			Precursor (a_title)
			l_special_option := not compiler_profile.is_default_mode
			if l_different and l_special_option then
				create l_title.make (a_title.count + 10)
				l_title.append_string_general (a_title)
				l_title.append_character (' ')
				l_title.append_character ('[')
				if compiler_profile.is_experimental_mode then
					l_title.append (locale_formatter.translation (t_experimental))
				else
					l_title.append (locale_formatter.translation (t_compatible))
				end
				l_title.append_character (']')
				window.set_title (l_title)
			end
		end

	set_focus_to_main_editor
			-- Set focus to main current editor.
		do
			if attached editors_manager as edmgr and then attached edmgr.current_editor as ed then
				edmgr.select_editor (ed, True)
			end
		end

	set_encoding (a_encoding: ENCODING)
			-- Set `encoding' with `a_encoding'.
		do
			if attached editors_manager.current_editor as l_editor then
				l_editor.set_encoding (a_encoding)
			end
		end

	set_bom (a_bom: like bom)
			-- Set `bom' with `a_bom'.
		do
			if attached editors_manager.current_editor as l_editor then
				l_editor.set_bom (a_bom)
			end
		end

feature -- Window Settings

	set_initialized
			-- Set `initialized' to True.
		do
			initialized := True
		end

feature -- Window Properties

	changed: BOOLEAN
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

	is_empty: BOOLEAN
			-- Does `Current's text is empty?
		do
			Result := editors_manager = Void or else editors_manager.current_editor = Void or else editors_manager.current_editor.is_empty
		end

	text: STRING_32
			-- Text representing Current
		do
			if attached editors_manager.current_editor as l_editor then
				Result := l_editor.wide_text
			end
		end

	encoding: ENCODING
			-- Encoding in which text is saved.
		do
			if attached editors_manager.current_editor as l_editor then
				Result := l_editor.encoding
			end
		end

	bom: detachable STRING_8
			-- Bom if needed by `encoding'.
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.bom
			end
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing Current window.
		do
			Result := pixmaps.icon_pixmaps.general_dialog_icon
		end

feature -- Update

	synchronize
			-- Synchronize stones.
		local
			st: STONE
			l_text_area: EB_SMART_EDITOR
			l_system: SYSTEM_I
			l_root: SYSTEM_ROOT
		do
			during_synchronization := True
			if eiffel_project.system_defined then
				l_system := eiffel_system.system
			end
			if
				not editor_session_loaded and then
				stone = Void and then
				l_system /= Void and then
				eiffel_project.initialized and then
				eiffel_system.workbench.is_already_compiled and then
				eiffel_system.workbench.last_reached_degree <= 5 and then
				not l_system.root_creators.is_empty
			then
					-- Note: this code must be updated to support multiple root features
				l_root := l_system.root_creators.first
				if l_root.root_class.is_compiled then
					stone := create {CLASSC_STONE}.make (l_root.root_class.compiled_class)
				else
					stone := create {CLASSI_STONE}.make (l_root.root_class)
				end
				if
					eiffel_system.universe.target.clusters.count = 1
				then
						-- Show the current class.
					commands.find_class_or_cluster_command.execute
				end
			end

			favorites_manager.refresh

			tools.synchronize

--			if not unified_stone then

--			end
--			tools.class_tool.invalidate
--			tools.features_relation_tool.invalidate
				-- Target diagram stone to root class or cluster if no stone is set.
			if
				tools.diagram_tool.last_stone = Void and then
				l_system /= Void and then
				eiffel_project.initialized and then
				eiffel_system.workbench.is_already_compiled and then
				not l_system.root_creators.is_empty
			then
				l_root := l_system.root_creators.first
				if l_root.root_class /= Void and then l_root.root_class.compiled_class /= Void then
					tools.diagram_tool.set_stone (create {CLASSC_STONE}.make (l_root.root_class.compiled_class))
				else
					tools.diagram_tool.set_stone (create {CLUSTER_STONE}.make (l_root.cluster))
				end
			end

			history_manager.synchronize
			tools.breakpoints_tool.synchronize

				-- Synchronizes all stonable tools
			shell_tools.all_requested_tools.do_all (agent (a_tool: ES_TOOL [EB_TOOL])
				do
					if a_tool.is_interface_usable and then attached {ES_STONABLE_I} a_tool as l_stonable then
							-- Synchronize stonable tool
						l_stonable.synchronize
					end
				end)

				-- Update main views
			from
				managed_main_formatters.go_i_th (2)
			until
				managed_main_formatters.after
			loop
				managed_main_formatters.item.invalidate
				managed_main_formatters.item.format
				managed_main_formatters.forth
			end

			if stone /= Void then
				st := stone.synchronized_stone
			end
			if editors_manager.editor_count > 0 then
				set_stone (st)
			end

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

	synchronize_routine_tool_to_default
			-- Synchronize the editor tool to the debug format.
		do
			--| FIXME ARNAUD: To be implemented
		end

	clear_object_tool
			-- Clear the contents of the object tool if shown.
		do
			--| FIXME ARNAUD: To be implemented
		end

	update_eis_system
			-- Update EIS storage and the tool if needed.
		local
			l_agent: like update_eis_system_agent
		do
			l_agent := update_eis_system_agent
			if l_agent = Void then
				l_agent := agent
					do
						if
							attached {ES_INFORMATION_TOOL_COMMANDER_I} shell_tools.tool ({ES_INFORMATION_TOOL}) as l_info_tool_commander and then
							l_info_tool_commander.is_interface_usable
						then
								-- Update Information tool.
							l_info_tool_commander.refresh_list
							l_info_tool_commander.request_eis_visit
						end
					end
				update_eis_system_agent := l_agent
			end
			ev_application.do_once_on_idle (l_agent)
		end

	update_eis_system_agent: detachable PROCEDURE
			-- Agent to update EIS system

feature -- Stone process

	stone: detachable STONE
			-- Current stone

	toggle_unified_stone
			-- Change the stone management mode.
		do
				-- Save new value of `is_unified_stone' after toggle.
			set_is_unified_stone (not is_unified_stone)

				-- Save the corresponding the preference.
			preferences.development_window_data.context_unified_stone_preference.set_value (is_unified_stone)

			if is_unified_stone then
				send_stone_to_context
				commands.send_stone_to_context_cmd.disable_sensitive
			elseif stone /= Void then
				commands.send_stone_to_context_cmd.enable_sensitive
			end
		end

	set_stone (a_stone: detachable STONE)
			-- Change the currently focused stone.
		local
			l_checker: EB_STONE_CHECKER
			l_override_pref: STRING
			l_editor: EB_SMART_EDITOR
		do
			if a_stone = Void then
					-- We reset the stone.
				old_set_stone (Void)

				update_save_symbol
			elseif
				attached {FILE_LOCATION_STONE} a_stone as l_file_location_stone and then
				attached stone_from_file_location (l_file_location_stone.file_name) as l_stone
			then
				set_stone (l_stone)
			elseif not is_processing_stone then
				is_processing_stone := True

				l_override_pref := preferences.development_window_data.override_tab_behavior

				if l_override_pref.same_string ({INTERFACE_NAMES}.co_editor) then
						-- Normal behavior, we replace the existing stone in the current editor if any.

				elseif l_override_pref.same_string ({INTERFACE_NAMES}.co_new_tab_editor) then
					l_editor := editors_manager.editor_with_stone (a_stone)
					if l_editor = Void then
							-- No editor has `a_stone', let's have a look at the current editor
							-- if present to see if it already has a stone, otherwise we create a new tab.
						l_editor := editors_manager.current_editor
						if l_editor = Void or else l_editor.stone /= Void then
								-- This is a new tab, there is no more stone associated to Current.
							old_set_stone (Void)
							commands.new_tab_cmd.execute
						else
							-- No need for creating a new tab since we have an empty editor.
						end
					else
						-- No need to create a new tab since a tab already has `a_stone'.
					end

				else
					check new_tab_if_edited: l_override_pref.same_string ({INTERFACE_NAMES}.co_new_tab_editor_if_edited) end
					l_editor := editors_manager.editor_with_stone (a_stone)
					if l_editor = Void then
							-- No editor has `a_stone', let's have a look at the current editor
							-- if present to see if we could replace the stone.
						l_editor := editors_manager.current_editor
						if l_editor = Void or else not l_editor.text_displayed.history.is_empty then
								-- This is a new tab, there is no more stone associated to Current.
							old_set_stone (Void)
							commands.new_tab_cmd.execute
						else
							-- No need for creating a new tab since no editing took place
						end
					else
						-- No need to create a new tab since a tab already has `a_stone'.
					end
				end

					-- Apply now the stone.							
				create l_checker.make (Current)
				l_checker.set_stone_after_first_check (a_stone)

				update_save_symbol
				is_processing_stone := False
			end
		ensure then
			-- stone_set: If there are no errors with the store, then: not is_processing_stone implies stone = a_stone
			-- editor_stone: If there are no errors with the store, then: (not is_processing_stone and then attached a_stone) implies editors_manager.current_editor.stone = a_stone
		end

	stone_from_file_location (a_file_name: READABLE_STRING_GENERAL): detachable STONE
		local
			p: PATH
			l_item: CLASS_I
			l_dropped_class_name: STRING_32
		do
			if workbench.universe_defined then
				create p.make_from_string (a_file_name)
				if
					attached p.entry as e and then
					attached e.extension as ext
				then
					if
						universe.target /= Void and then
						ext.is_case_insensitive_equal_general ("e")
					then
							-- FIXME: file name and class name must be same, problem here?
						l_dropped_class_name := e.name
						l_dropped_class_name.remove_tail (2) -- removed ".e"
						across
							universe.classes_with_name (l_dropped_class_name.as_upper) as class_cursor
						until
							Result /= Void
						loop
							l_item := class_cursor.item
							if l_item.file_name.same_as (p) then
								create {CLASSI_STONE} Result.make (l_item)
							end
						end
					elseif ext.is_case_insensitive_equal_general ("ecf") then
						if attached universe.library_at_location (p, True) as libs then
							if libs.count > 0 then
								create {CLUSTER_STONE} Result.make (libs.first)
							end
						end
					end
				end
			end
		end

	refresh
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

	refresh_all_commands
			-- Refresh all commands with their accelerators into the window and related interfaces.
		local
			l_toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			l_simple_cmds: ARRAYED_LIST [EB_SIMPLE_SHORTCUT_COMMAND]
			l_main_formatter: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			l_editor_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
		do
				-- Editor commands
			l_editor_commands := commands.editor_commands
			from
				l_editor_commands.start
			until
				l_editor_commands.after
			loop
				l_editor_commands.item.update (window)
				l_editor_commands.forth
			end

				-- Update toolbarable commands
				-- Show tool commands are included in toolbarable commands.
			l_toolbarable_commands := commands.toolbarable_commands
			from
				l_toolbarable_commands.start
			until
				l_toolbarable_commands.after
			loop
				l_toolbarable_commands.item.update (window)
				l_toolbarable_commands.forth
			end

				-- Update external commands
			refresh_external_commands

				-- Update simple shortcut commands
			l_simple_cmds := commands.simple_shortcut_commands
			from
				l_simple_cmds.start
			until
				l_simple_cmds.after
			loop
				l_simple_cmds.item.update (window)
				l_simple_cmds.forth
			end

				-- Update focus related commands
			across
				commands.focus_commands as ic
			loop
				ic.item.update (window)
			end

				-- Update main formatters shortcuts and interfaces
			l_main_formatter := managed_main_formatters.twin
			from
				l_main_formatter.start
			until
				l_main_formatter.after
			loop
				l_main_formatter.item.update (window)
				l_main_formatter.forth
			end

			check
				docking_manager_not_void: docking_manager /= Void
			end

				-- Update project commands.
			Melt_project_cmd.update (window)
			discover_melt_cmd.update (window)
			override_scan_cmd.update (window)
			Freeze_project_cmd.update (window)
			Finalize_project_cmd.update (window)
			project_cancel_cmd.update (window)
			clean_compile_project_cmd.update (window)

				-- Update analyzer commands.
			analyze_cmd.update (window)
			analyze_editor_cmd.update (window)
			analyze_parent_cmd.update (window)
			analyze_target_cmd.update (window)

				-- Update debug commands
			eb_debugger_manager.refresh_commands (Current)

			shortcut_manager.propagate_accelerators (Current)
		end

	refresh_external_commands
			-- Refresh external commands.
			-- FIXME: Move to EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		local
			l_external_command: HASH_TABLE [EB_EXTERNAL_COMMAND, INTEGER]
		do
			l_external_command := commands.Edit_external_commands_cmd.commands
			from
				l_external_command.start
			until
				l_external_command.after
			loop
				if attached l_external_command.item_for_iteration as l_cmd then
					l_cmd.update (window)
				end
				l_external_command.forth
			end
			commands.edit_external_commands_cmd.refresh_list_from_outside
		end

	quick_refresh_editors
			-- Redraw editors' drawing area.
		local
			l_service_consumer: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			l_outputs: DS_LINEAR [OUTPUT_I]
		do
				-- Refresh main editor.
			if attached editors_manager.current_editor as l_current_editor then
				l_current_editor.refresh
			end

				-- Refresh margins from all outputs.
			create l_service_consumer
			if attached l_service_consumer.service as l_service then
				l_outputs := l_service.active_outputs
				from l_outputs.start until l_outputs.after loop
					if attached {ES_OUTPUT_PANE_I} l_outputs.item_for_iteration as l_output then
						if attached {ES_EDITOR_WIDGET} l_output.widget_from_window (Current) as l_editor_widget then
							l_editor_widget.editor.refresh
						end
					end
					l_outputs.forth
				end
			end

				-- Refresh other tools
			tools.external_output_tool.quick_refresh_editor
			tools.class_tool.quick_refresh_editor
			tools.features_relation_tool.quick_refresh_editor
		end

	quick_refresh_margins
			-- Redraw the main editor's drawing area.
		local
			l_service_consumer: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			l_outputs: DS_LINEAR [OUTPUT_I]
		do
				-- Refresh main editor.
			if attached editors_manager.current_editor as l_current_editor then
				l_current_editor.margin.refresh
			end

				-- Refresh margins from all outputs.
			create l_service_consumer
			if attached l_service_consumer.service as l_service then
				l_outputs := l_service.active_outputs
				from l_outputs.start until l_outputs.after loop
					if attached {ES_OUTPUT_PANE_I} l_outputs.item_for_iteration as l_output then
						if attached {ES_EDITOR_WIDGET} l_output.widget_from_window (Current) as l_editor_widget then
							l_editor_widget.editor.margin.refresh
						end
					end
					l_outputs.forth
				end
			end

				-- Refresh other tools.
			tools.external_output_tool.quick_refresh_margin
			tools.class_tool.quick_refresh_margin
			tools.features_relation_tool.quick_refresh_margin
		end

feature -- Position provider

	position: like position_internal
			-- Currently shown text position in the editor
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.first_line_displayed
			end
		end

	pos_container: like pos_container_internal
			-- Current selected formatter
		do
			Result := selected_formatter
		end

feature -- Resource Update

	update_viewpoints
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

	register
			-- Register to preferences we want notification of.
		do
		end

	unregister
			-- unregister to preferences we want notification of.
		do
		end

	reset
			-- Reset the window contents
		do
			Precursor
			address_manager.reset

	--| FIXME ARNAUD, multiformat not yet implemented.
	--			format_list.enable_imp_formats_sensitive
	--| END FIXME
		end

	syntax_is_correct: BOOLEAN
			-- Current editor was successfully parsed?
		do
			if attached editors_manager.current_editor as l_current_editor then
				Result := l_current_editor.syntax_is_correct
			else
				Result := True
			end
		end

	save_before_compiling
			-- save the text but do not update clickable positions
		do
			save_only := True
			save_all
		end

	perform_check_before_save
			-- Perform any pre-save operations/checks
		do
			-- FIXIT: temp comment by larry
			-- May be problems here of tabbed editor
			if editors_manager.current_editor /= Void then
				perform_check_before_save_with (editors_manager.current_editor)
			end
		end

	perform_check_before_save_with (a_editor: EB_SMART_EDITOR)
			-- Perform any pre-save operations with `a_editor'
		require
			a_editor_not_void: a_editor /= Void
		do
				-- Remove trailing blanks.
			if preferences.editor_data.auto_remove_trailing_blank_when_saving then
				a_editor.text_displayed.remove_trailing_blanks
			else
				a_editor.text_displayed.remove_trailing_fake_blanks
			end
			a_editor.refresh_now

			if a_editor.open_backup then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt_with_cancel (
					Warning_messages.w_save_backup, window, agent continue_save, agent cancel_save)
			else
				check_passed := True
			end
		end

	continue_save
			-- Continue saving
		do
			check_passed := True
		end

	cancel_save
			-- Cancel saving
		do
			check_passed := False
		end

	process
			-- process the user entry in the address bar
		do
			save_canceled := False
			if
				attached {CLASSI_STONE} stone as l_class_stone and
				attached {ES_MULTI_SEARCH_TOOL_PANEL} tools.search_tool as l_multi_search_tool
			then
				l_multi_search_tool.class_changed (l_class_stone.class_i)
			end
		end

	save_and (an_action: PROCEDURE)
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

	set_classi_changed (a_class: CLASS_C)
			-- Change a_class in shared project.
		do
			Eiffel_project.Workbench.change_class (a_class.original_class)
		end


	on_before_text_saved
			-- Notify the editor that the text is about to be saved.
		local
			l_editor: EB_SMART_EDITOR
			l_class_i: CLASS_I
			l_modifier: ES_CLASS_LICENSER
		do
			Precursor
			l_editor := editors_manager.current_editor
			if l_editor /= Void and then l_editor.is_interface_usable and then attached {CLASSI_STONE} l_editor.stone as l_class then
					-- We have the class stone
				l_class_i := l_class.class_i
				if l_class_i /= Void then
					create l_modifier
					l_modifier.relicense (l_class_i)
				end
			end
		end

	on_text_saved
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
			if str [1] = '*' then
				str.keep_tail (str.count - 2)
				set_title (str)
			end
			update_formatters
			lock_update
			if attached {ES_FEATURES_TOOL} shell_tools.tool ({ES_FEATURES_TOOL}) as l_features_tool then
					-- Update features tool.
				l_features_tool.synchronize
			end
			update_eis_system
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

	disable_editors_command
			-- Disable `a_command'.
		require
			editors_manager_not_void: editors_manager /= Void
			commands_not_void: commands /= Void and then commands.editor_commands /= Void
		local
			l_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
		do
			if editors_manager.editors.is_empty then
				l_commands := commands.editor_commands
				from
					l_commands.start
				until
					l_commands.after
				loop
					l_commands.item.disable_sensitive
					l_commands.forth
				end
				commands.print_cmd.disable_sensitive
			end
		end

feature -- Window management

	show
			-- <Precursor>
		do
				-- Bind help
			bind_help_shortcut (window)
			Precursor
		end

	give_focus
			-- Give the focus to the address manager.
		do
			if address_manager.widget.is_displayed then
				address_manager.set_focus
			end
		end

	save_layout
			-- Store layout of `current'.
		do
				-- Commit saves
			preferences.preferences.save_preferences
		end

	save_layout_to_session: EB_DEVELOPMENT_WINDOW_SESSION_DATA
			-- Save session data of `Current' to session object `a_session'.
			-- This is project data session, not for all projects.
		local
			l_class_id, l_feature_id: STRING
			l_is_group_stone: BOOLEAN
		do
			save_window_state
			save_size
			save_position
			create Result.make_from_window_data (preferences.development_window_data)

			if attached {CLASSI_STONE} stone as l_class_stone then
				l_is_group_stone := True
				Result.save_current_target (id_of_class (l_class_stone.class_i.config_class), False)
			elseif attached {CLUSTER_STONE} stone as l_cluster_stone then
				l_is_group_stone := True
				Result.save_current_target (id_of_group (l_cluster_stone.group), True)
			else
				Result.save_current_target (Void, False)
			end
			if l_is_group_stone then
					-- CLASSI or CLUSTER stone
				if attached editors_manager.current_editor as l_current_editor then
					if not l_current_editor.text_displayed.is_empty then
						Result.save_editor_position (
							l_current_editor.text_displayed.current_line_number)
					else
						Result.save_editor_position (1)
					end
				else
					Result.save_editor_position (1)
				end
			else
				Result.save_editor_position (1)
			end

			save_editors_to_session_data (Result)

			layout_manager.store_editors_layout

			if attached tools.features_relation_tool as l_features_relation_tool then
				if attached {FEATURE_STONE} l_features_relation_tool.stone as l_feature_stone then
					l_feature_id := id_of_feature (l_feature_stone.e_feature)
				end
			end
			if attached tools.class_tool as l_class_tool then
				if attached {CLASSI_STONE} l_class_tool.stone as l_class_stone then
					check
						class_not_void: l_class_stone.class_i.config_class /= Void
					end
					l_class_id := id_of_class (l_class_stone.class_i.config_class)
				end
			end
			Result.save_context_data (l_class_id, l_feature_id, 1)
		ensure
			not_void: Result /= Void
		end

	save_editors_to_session_data (a_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA)
			-- Save editor number, open classes and open clusters.
		do
			a_data.save_open_classes (editors_manager.open_classes)
			a_data.save_open_clusters (editors_manager.open_clusters)

			a_data.save_formatting_marks (editors_manager.show_formatting_marks)
		end

	docking_layout_manager: EB_DOCKING_LAYOUT_MANAGER
			-- Docking layout manager

	close_all_tools
			-- Close all tools.
		local
			l_tools: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_tools := docking_manager.contents.twin
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

feature -- Tools & Controls

	address_manager: EB_ADDRESS_MANAGER
			-- Text field in the toolbar
			-- Allow user to enter the name
			-- of the class he wants to edit.

	project_manager: EB_PROJECT_MANAGER
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

	is_unified_stone: BOOLEAN
			-- Is the stone common with the context tool or not?

	link_tools: BOOLEAN
			-- Are tools linked?
		do
			Result := preferences.development_window_data.link_tools
		end

	view_points_combo: EB_VIEWPOINT_COMBO_BOX
			-- Combo box used to a select viewpoints

	managed_dependency_formatters: ARRAYED_LIST [EB_DEPENDENCY_FORMATTER]
			-- All formatters to display dependency relationship of a target/group/folder/class

feature -- Help system

	help_context: detachable HELP_CONTEXT_I assign set_help_context
			-- Context sensitive help context.
			-- Call `set_help_context' when tools gain and lose focus to set correct context.

	set_help_context (a_context: detachable HELP_CONTEXT_I)
			-- Pushes a help context on the help context stack.
			--
			-- `a_context': Help context to push on the stack.
		require
			not_a_context_is_interface_usable: attached a_context implies a_context.is_interface_usable
		do
			help_context := a_context
		ensure
			help_context_set: help_context = a_context
		end

	show_help
			-- <Precursor>
		do
			if attached help_providers.service as l_service then
				if attached help_context as l_help_context and then l_help_context.is_help_available then
					l_service.show_help (l_help_context)
				elseif attached editors_manager.current_editor as l_editor and then l_editor.has_focus then
					l_editor.show_help
				elseif is_help_available then
					l_service.show_help (Current)
				end
			end
		end

feature -- Multiple editor management

	update_paste_cmd
			-- Update `editor_paste_cmd'. To be performed when an editor grabs the focus.
		require
			is_interface_usable: is_interface_usable
		do
			if update_paste_cmd_agent = Void then
				update_paste_cmd_agent := agent
					local
						l_editor: EB_EDITOR
					do
							-- We might be called after the development window has been recycled.
						if editors_manager /= Void then
							l_editor := editors_manager.current_editor
						end
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

	update_paste_cmd_agent: PROCEDURE
		-- Agent used for updating the paste command.

feature {EB_EDITORS_MANAGER, EB_STONE_CHECKER} -- Tabbed editor

	is_dropping_on_editor: BOOLEAN
			-- Is pick and droping on an editor?

	set_dropping_on_editor (a_dropping: BOOLEAN)
			-- Set `Is dropping_on_editor' with `a_dropping'.
		do
			is_dropping_on_editor := a_dropping
		end

feature {ES_FEATURES_TOOL_PANEL, ES_FEATURES_GRID, EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_PART} -- Feature Clauses

	set_feature_locating (a_locating: BOOLEAN)
			-- Set `feature_locating' with `a_locating'.
		do
			feature_locating := a_locating
		end

	feature_locating: BOOLEAN
			-- Is feature tool locating a feature?

feature {EB_WINDOW_MANAGER, EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Window management / Implementation

	destroy_imp
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
				save_window_data

				hide

					-- Commit saves
				preferences.preferences.save_preferences

				estudio_debug_cmd.unattach_window (window)
				toolbars_area.wipe_out
				address_manager.recycle
				favorites_manager.recycle
				cluster_manager.recycle
				menus.recycle
				history_manager.recycle

				if menus.view_menu /= Void then
					menus.view_menu.destroy
				end

				Precursor {EB_TOOL_MANAGER}

				if editors_manager /= Void then
					editors_manager.recycle
				end

				managed_class_formatters := Void
				managed_feature_formatters := Void
				managed_dependency_formatters := Void
				managed_main_formatters := Void
--				editors_manager := Void
--				stone := Void
			end
		end

	save_size
			-- Save window size.
		do
			if not window.is_minimized then
				if not window.is_maximized then
						-- Only save the size of the window if not maximized,
						-- since if maximized we know the size of the window, it is
						-- the size of the screen.
					development_window_data.save_size (window.width, window.height)
				end
			end
		end

	save_size_and_dpi
			-- Save window size abd dpi.
		do
			if not window.is_minimized then
				if not window.is_maximized then
						-- Only save the size of the window if not maximized,
						-- since if maximized we know the size of the window, it is
						-- the size of the screen.
					development_window_data.save_size_and_dpi (dpi, window.width, window.height)
				end
			end
		end

	save_position
			-- Save window position.
		do
			if not window.is_minimized then
				if window.is_maximized then
					development_window_data.save_maximized_position (window.screen_x, window.screen_y)
				else
					development_window_data.save_position (window.screen_x, window.screen_y)
				end
			end
		end

	save_window_data
			-- Save Window size, position and states
		local
			l_develop_window_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA
		do
				-- Update position.
			save_window_state
			save_position
			save_size
				-- Create session data from above saved data.
			create l_develop_window_data.make_from_window_data (development_window_data)
			layout_manager.store_standard_tools_layout
			session_data.set_value (l_develop_window_data, development_window_data.development_window_data_id)

			if (create {SHARED_WORKBENCH}).workbench.system_defined then
				-- Editor data save to per-project session data.
				create l_develop_window_data.make_from_window_data (development_window_data)
				save_editors_to_session_data (l_develop_window_data)
				layout_manager.store_editors_layout

				-- Must use project *window* session data here.
				project_session_data.set_value (l_develop_window_data, development_window_data.development_window_project_data_id)
			end
		end

	 save_window_state
	 		-- Save window state information to preference data.
	 	do
			development_window_data.save_window_state (window.is_minimized, window.is_maximized)
			if attached {EB_DEBUGGER_MANAGER} debugger_manager as l_debugger_manager then
				development_window_data.save_force_debug_mode (l_debugger_manager.debug_mode_forced)
			end
	 	end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Implementation

	check_passed: BOOLEAN
			-- If check passed?

	save_canceled: BOOLEAN
			-- did user cancel save ?

	save_only: BOOLEAN
			-- skip parse and update after save ?

	is_destroying: BOOLEAN
			-- Is `current' being currently destroyed?

	all_editor_closed
			-- All editor closed.
		do
			if editors_manager.editors.count <= 0 then
				disable_editors_command
					-- Remove the stone being focused, otherwise the stone was thought being edited.
				old_set_stone (Void)
				if shell_tools.is_interface_usable then
						-- Remove stone from tool.
					if attached {ES_STONABLE_I} shell_tools.tool ({ES_FEATURES_TOOL}) as l_stonable then
						l_stonable.set_stone_with_query (Void)
					end
				end

				set_title (window_manager.new_title)
				if not window.is_destroyed and window.is_displayed and window.is_sensitive then
					window.set_focus
				end
			end
		end

feature {EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_PART} -- Internal issues with EB_STONE_CHECKER

	is_text_loaded: BOOLEAN
			-- Text is loaded in current editor?
		do
			if editors_manager.current_editor /= Void then
				Result := editors_manager.current_editor.is_text_loaded (stone)
			else
				Result := True
			end
		end

	set_feature_stone_already_processed (a_bool: like feature_stone_already_processed)
			-- Set `feature_stone_already_processed'
		do
			feature_stone_already_processed := a_bool
		ensure
			set: feature_stone_already_processed = a_bool
		end

	feature_stone_already_processed: BOOLEAN
			-- Is the processed stone a feature stone and has it
			-- been already processed by the editor ?

	set_text_saved (a_bool: like text_saved)
			-- Set `text_saved'
		do
			text_saved := a_bool
		ensure
			set: text_saved = a_bool
		end

	text_saved: BOOLEAN
			-- has the user chosen to save the file

	set_during_synchronization (a_bool: BOOLEAN)
			-- Set `during_synchronization'
		do
			during_synchronization := a_bool
		ensure
			set: during_synchronization = a_bool
		end

	during_synchronization: BOOLEAN
			-- Are we during a resynchronization?

	update_formatters
			-- Give a correct sensitivity to formatters.
		local
			cist: detachable CLASSI_STONE
			type_changed: BOOLEAN
		do
			if attached {CLASSI_STONE} stone as l_classi_stone then
				cist := l_classi_stone
			end

				-- Check to if formatting context has changed.
			if cist /= Void then
				type_changed := (cist.is_dotnet_class and not is_stone_external)
							or	(not cist.is_dotnet_class and is_stone_external)
			end

			if type_changed then
					-- Toggle stone flag.
				is_stone_external := not is_stone_external
			end

			if attached {CLASSC_STONE} stone then
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
				if
					cist /= stone and
					not attached {CLUSTER_STONE} stone -- not a cluster stone!
				then
					managed_main_formatters.first.execute
				end
			end
		end

	scroll_to_feature (feat_as: E_FEATURE; displayed_class: CLASS_I)
			-- highlight the feature correspnding to `feat_as' in the class represented by `displayed_class'
		require
			class_is_not_void: displayed_class /= Void
			feat_as_is_not_void: feat_as /= Void
		local
			l_feature: E_FEATURE
		do
			if not managed_main_formatters.first.selected then
					-- We are either in clickable mode or looking at a .NET class.
					-- Written feature is needed, otherwise renamed feature cannot be located.
					-- See bug#11354
				l_feature := feat_as.written_feature
				if l_feature = Void then
					l_feature := feat_as
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
			end
			editors_manager.current_editor.find_feature_named (l_feature.name_32)
		end

	scroll_to_ast (a_ast: AST_EIFFEL; displayed_class: CLASS_I; a_selected: BOOLEAN)
			-- Scroll to `a_ast' in `displayed_class'.
			-- If `a_selected' is True, select region of `a_ast'.
		local
			begin_index, end_index: INTEGER
			match_list: LEAF_AS_LIST
		do
				-- Do nothing is the class has been deleted.
			if attached displayed_class.text_8 as l_text then
				if displayed_class.is_compiled then
					match_list := system.match_list_server.item (displayed_class.compiled_class.class_id)
				end
				if match_list /= Void then
					begin_index := a_ast.complete_character_start_position (match_list)
					end_index := a_ast.complete_character_end_position (match_list)
				else
					begin_index := a_ast.character_start_position
					end_index := a_ast.character_end_position
				end
				scroll_to_selection ([begin_index, end_index + 1], a_selected)
			end
		end

	scroll_to_selection (a_selection: TUPLE [pos_start, pos_end: INTEGER]; a_selected: BOOLEAN)
			-- Scroll to the region of `a_selection'.
			-- If `a_selected' is True, `a_selection' is selected.
		require
			a_selection_not_void: a_selection /= Void
		do
			if a_selected then
				editors_manager.current_editor.select_region_when_ready (a_selection.pos_start, a_selection.pos_end)
			else
				editors_manager.current_editor.scroll_to_when_ready (a_selection.pos_start)
			end
		end

feature {EB_DEVELOPMENT_WINDOW_PART, EB_DEVELOPMENT_WINDOW_BUILDER} -- Implementation

	update_save_symbol
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
				analyze_editor_cmd.disable_sensitive
			else
				commands.print_cmd.enable_sensitive
				commands.save_as_cmd.enable_sensitive
				analyze_editor_cmd.update_sensitive
			end
			if any_editor_changed then
				save_all_cmd.enable_sensitive
			else
				save_all_cmd.disable_sensitive
			end
		end

	is_stone_external: BOOLEAN
			-- Does 'stone' contain a .NET consumed type?

	enable_dotnet_formatters
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

	terminate_external_command_and_destroy
			-- Terminate running external command and destroy.
		do
			process_manager.terminate_external_command
			destroy
		ensure
			external_command_not_running: not process_manager.is_external_command_running
		end

	save_and_destroy
			-- Save text then destroy.
		do
			save_text
			destroy
		end

	force_destroy
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

feature {NONE} -- Recycle

	recycle_formatters
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
				managed_dependency_formatters.start
			until
				managed_dependency_formatters.after
			loop
				if managed_dependency_formatters.item /= Void then
					managed_dependency_formatters.item.recycle
				end
				managed_dependency_formatters.forth
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

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initialized by EB_DEVELOPMENT_WINDOW_BUILDER

	show_dynamic_library_dialog
			-- Create a new dynamic library window and display it.
		do
			Window_manager.create_dynamic_lib_window
		end

	send_stone_to_context
			-- Send current stone to the context tool.
			-- Send current targeting feature to context tool if possible.
			-- Used by `send_stone_to_context_cmd'.
		local
			l_feature_text: STRING_32
			l_feature_stone: FEATURE_STONE
			l_class_c: detachable CLASS_C
			l_feature: E_FEATURE
		do
			if address_manager /= Void then
				l_feature_text := address_manager.feature_address.text
			end
			if attached {CLASSI_STONE} stone as l_class_stone then
				l_class_c := l_class_stone.class_i.compiled_representation
				if l_class_c /= Void then
					if l_feature_text /= Void and then not l_feature_text.is_empty and then l_class_c.has_feature_table then
						l_feature := l_class_c.feature_with_name_32 (l_feature_text)
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
			EB_DEVELOPMENT_WINDOW_MAIN_BUILDER, EB_DEVELOPMENT_WINDOW_DIRECTOR} -- Implementation: Editor commands

	refresh_cursor_position
			-- Display the current cursor position in the status bar.
		local
			l, c, v: INTEGER
			ed: EB_EDITOR
		do
			ed := editors_manager.current_editor
			if ed /= Void and then not ed.is_empty then
				l := ed.cursor_y_position
				c := ed.cursor_x_position
				v := ed.cursor_visible_x_position
			else
				l := 0
				c := 0
				v := 0
			end
			status_bar.set_cursor_position (l, c, v)
		end

	refresh_context_info
			-- Refresh address bar and features tool to relect
			-- where in the code the cursor is located.
		local
			l_feature: TUPLE [feat_as: FEATURE_AS; name: FEATURE_NAME]
			ed: EB_SMART_EDITOR
		do
				-- we may have been called from a timer and have to deactivate the timer
			if context_refreshing_timer /= Void then
				context_refreshing_timer.set_interval (0)
			end
			if managed_main_formatters.first.selected then
					-- We only do that for the clickable view
				if attached {CLASSC_STONE} stone as l_classc_stone then
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

	set_editing_location_by_feature (a_feature_name: FEATURE_NAME)
			-- Set editing location, feature tool and combo box changes according to `a_feature_name'.
		local
			l_efeature: E_FEATURE
			l_class_i: CLASS_I
			l_classc: CLASS_C
		do
			if a_feature_name /= Void then
				address_manager.set_feature_text_simply (a_feature_name.feature_name.name_32)
				if class_name /= Void and group /= Void then
					l_class_i := eiffel_universe.safe_class_named (class_name, group)
					if l_class_i /= Void and then l_class_i.is_compiled then
						l_classc := l_class_i.compiled_class
						if l_classc.has_feature_table then
							l_efeature := l_classc.feature_with_name_id (a_feature_name.feature_name.name_id)
							if l_efeature /= Void and then l_efeature.written_in /= l_classc.class_id then
								l_efeature := Void
							end
						end
					end
				end
				if l_efeature /= Void then
					seek_item_in_feature_tool (l_efeature)
				else
					if attached {ES_FEATURES_TOOL_COMMANDER_I} shell_tools.tool ({ES_FEATURES_TOOL}) as l_commander then
						if attached a_feature_name.feature_name.name_32 as l_name then
							l_commander.select_feature_item_by_name (l_name)
						end
					else
						check feature_tool_is_available: False end
					end
				end
			else
				address_manager.set_feature_text_simply (once "")
				seek_item_in_feature_tool (Void)
			end
		end

	seek_item_in_feature_tool (a_feature: E_FEATURE)
			-- Seek and select item contains data of `a_feature' in features tool.
			-- If `a_feature' is void, deselect item in features tool.
		do
			if attached {ES_FEATURES_TOOL_COMMANDER_I} shell_tools.tool ({ES_FEATURES_TOOL}) as l_commander then
				l_commander.select_feature_item (a_feature)
			else
				check False end
			end
		end

	goto
			-- Display a dialog to select a line to go to in the editor
			--	or a breakable index to go to in the flat formatter.
		local
			l_dialog: EB_GOTO_DIALOG
			l_bp_dialog: ES_BREAKABLE_INDEX_GOTO_DIALOG
		do
			if
				attached editors_manager.current_editor as ed and then
				widget_has_recursive_focus (ed.widget)
			then
				create l_dialog.make (ed)
				ui.set_goto_dialog (l_dialog)
				l_dialog.show_modal_to_window (window)
			elseif
				attached tools.features_relation_tool as ft and then
				attached ft.flat_formatter as flatf and then
				attached flatf.widget as ftw and then
				widget_has_recursive_focus (ftw)
			then
				create l_bp_dialog.make_with_editor (flatf.editor)
				l_bp_dialog.show_on_active_window
			end
		end

	toggle_line_number_display
			-- Toggle line number display on/off in editor
		do
			preferences.editor_data.show_line_numbers_preference.set_value (not preferences.editor_data.show_line_numbers)
		end

	find_next
			-- Find the next occurrence of the search text.
		do
			if tools.search_tool.currently_searched /= Void then
				if attached ui.current_editor as cv_ced then
					cv_ced.find_next
				end
			else
				tools.search_tool.show_and_set_focus
			end
		end

	find_previous
			-- Find the previous occurrence of the search text.
		do
			if tools.search_tool.currently_searched /= Void then
				if attached ui.current_editor as cv_ced then
					cv_ced.find_previous
				end
			else
				tools.search_tool.show_and_set_focus
			end
		end

	find_next_selection
			-- Find the next occurrence of the selection.
		do
			if attached ui.current_editor as cv_ced then
				cv_ced.find_next_selection
			end
		end

	find_previous_selection
			-- Find the next occurrence of the selection.
		do
			if attached ui.current_editor as cv_ced then
				cv_ced.find_previous_selection
			end
		end

	toggle_formatting_marks
			-- Show/Hide formatting marks in the editor and update related menu item.
		do
			editors_manager.toggle_formatting_marks
			refresh_toggle_formatting_marks_command
		end

	refresh_toggle_formatting_marks_command
			-- Refresh toggle formatting marks menu item.
		do
			if editors_manager.show_formatting_marks then
				menus.formatting_marks_command_menu_item.set_text (Interface_names.m_hide_formatting_marks)
			else
				menus.formatting_marks_command_menu_item.set_text(Interface_names.m_show_formatting_marks)
			end
		end

feature -- Implementation: Editor commands

	select_all
			-- Select the whole text in the focused editor.
		local
			l_editor: detachable EB_EDITOR
		do
			l_editor := ui.current_editor
			if l_editor /= Void and then not l_editor.is_empty then
				l_editor.select_all
			end
		end

feature {EB_ON_SELECTION_COMMAND} -- Commands

	cut_selection
			-- Cut the selection in the current editor.
		local
			l_editor: detachable EB_CLICKABLE_EDITOR
		do
			l_editor := ui.current_editor
			if l_editor /= Void and then not l_editor.is_recycled and then l_editor.number_of_lines /= 0 then
				l_editor.run_if_editable (agent l_editor.cut_selection)
			end
		end

	copy_selection
			-- Cut the selection in the current editor.
		local
			l_editor: detachable EB_CLICKABLE_EDITOR
		do
			l_editor := ui.current_editor
			if l_editor /= Void and then not l_editor.is_recycled and then l_editor.number_of_lines /= 0 then
				l_editor.copy_selection
			end
		end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Implementation / Menus

	set_undo_accelerator (a_accelerator: like undo_accelerator)
			-- Set `undo_accelerator'
		do
			undo_accelerator := a_accelerator
		ensure
			set: undo_accelerator = a_accelerator
		end

	undo_accelerator: EV_ACCELERATOR
			-- Accelerator for Ctrl+Z

	set_redo_accelerator (a_accelerator: like redo_accelerator)
			-- Set `redo_accelerator'
		do
			redo_accelerator := a_accelerator
		ensure
			set: redo_accelerator = a_accelerator
		end

	redo_accelerator: EV_ACCELERATOR
			-- Accelerator for Ctrl+Y

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_ADDRESS_MANAGER} -- Builder issues

	set_tools_initialized (a_bool: like tools_initialized)
			-- Set `tools_initialized'
		do
			tools_initialized := a_bool
		ensure
			set: tools_initialized = a_bool
		end

	set_toolbars_area (a_area: like toolbars_area)
			-- Set `toolbars_area'
		do
			toolbars_area := a_area
		ensure
			set: toolbars_area = a_area
		end

	set_view_points_combo (a_view_points_combo: like view_points_combo)
			-- Set `view_points_combo'
		do
			view_points_combo := a_view_points_combo
		ensure
			set: view_points_combo = a_view_points_combo
		end

	set_managed_class_formatters (a_formatters: like managed_class_formatters)
			-- Set `managed_class_formatters'
		do
			managed_class_formatters := a_formatters
		ensure
			set: managed_class_formatters = a_formatters
		end

	set_managed_feature_formatters (a_formatters: like managed_feature_formatters)
			-- Set `managed_feature_formatters'
		do
			managed_feature_formatters := a_formatters
		ensure
			set: managed_feature_formatters = a_formatters
		end

	set_managed_main_formatters (a_formatters: like managed_main_formatters)
			-- Set `managed_main_formatters'
		do
			managed_main_formatters := a_formatters
		ensure
			set: managed_main_formatters = a_formatters
		end

	set_managed_dependency_formatters (a_formatters: like managed_dependency_formatters)
			-- Set `managed_dependency_formatters'
		do
			managed_dependency_formatters := a_formatters
		ensure
			set: managed_dependency_formatters = a_formatters
		end

	set_container (a_container: like container)
			-- Set `container'
		do
			container := a_container
		ensure
			set: container = a_container
		end

	set_panel (a_panel: like panel)
			-- Set `panel'
		do
			panel := a_panel
		ensure
			set: panel = a_panel
		end

	set_status_bar (a_bar: like status_bar)
			-- Set `status_bar'
		do
			status_bar := a_bar
		ensure
			set: status_bar = a_bar
		end

	set_window (a_window: like window)
			-- Set `window'
		do
			window := a_window
		ensure
			set: window = a_window
		end

	on_viewpoint_changed
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
				editors_manager.current_editor.display_line_at_top_when_ready (l_line, 0)
			end
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_PART} -- EB_DEVELOPMENT_WINDOW_MENU_BUILDER issues

	destroy
			-- check if current text has been saved and destroy
		do
			if Window_manager.development_windows_count > 1 and then process_manager.is_external_command_running and then Current = external_output_manager.target_development_window then
				process_manager.confirm_external_command_termination (agent terminate_external_command_and_destroy, agent do_nothing, window)
			else
				if changed and then not confirmed then
					if Window_manager.development_windows_count > 1 then
						(create {EB_EXIT_APPLICATION_COMMAND}).execute
					else
							-- We let the window manager handle the saving, along with other windows
							-- (not development windows)
						force_destroy
					end
				else
					if context_refreshing_timer /= Void then
						context_refreshing_timer.destroy
						context_refreshing_timer := Void
					end
					Precursor {EB_TOOL_MANAGER}
				end
			end
		end

	set_command_controller (a_controller: like command_controller)
			-- Set `command_controller'
		do
			command_controller := a_controller
		ensure
			set: command_controller = a_controller
		end

	set_show_dynamic_lib_tool (a_cmd: like show_dynamic_lib_tool)
			-- Set `show_dynamic_lib_tool'
		do
			show_dynamic_lib_tool := a_cmd
		ensure
			set: show_dynamic_lib_tool = a_cmd
		end

feature {EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_BUILDER, EB_ADDRESS_MANAGER} --EB_DEVELOPMENT_WINDOW_DIRECTOR issues.

	set_is_unified_stone (a_bool: like is_unified_stone)
			-- Set `is_unified_stone' with `a_bool'.
		do
			is_unified_stone := a_bool
		ensure
			set: is_unified_stone = a_bool
		end

	set_history_manager (a_manager: like history_manager)
			-- Set `history_manager'
		do
			history_manager := a_manager
		ensure
			set: history_manager = a_manager
		end

	set_address_manager (a_manager: like address_manager)
			-- Set `address_manager'
		do
			address_manager := a_manager
		ensure
			set: address_manager = a_manager
		end

	set_view_points (a_view_points: like view_points_combo)
			-- Set `view_points_combo'
		do
			view_points_combo := a_view_points
		ensure
			set: view_points_combo = a_view_points
		end

	set_initialized_for_builder (a_bool: like initialized)
			-- Set `initialized'
		do
			initialized := a_bool
		ensure
			set: initialized = a_bool
		end

	set_is_destroying (a_bool: like is_destroying)
			-- Set `is_destroying'
		do
			is_destroying := a_bool
		ensure
			set: is_destroying = a_bool
		end

	set_editor_session_loaded (a_loaded: BOOLEAN)
			-- Set `editor_session_loaded' with `a_loaded'.
		do
			editor_session_loaded := a_loaded
		ensure
			editor_session_loaded_set: editor_session_loaded = a_loaded
		end

	editor_session_loaded: BOOLEAN assign set_editor_session_loaded
			-- Has editor session data loaded?

feature{EB_TOOL, EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_PART}

	command_controller: EB_EDITOR_COMMAND_CONTROLLER
			-- Object that takes care of updating the sensitivity of all editor commands.

feature{EB_TOOL, EB_STONE_CHECKER, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_MENU_BUILDER}

	execute_show_favorites
			-- Show `favorites_tool' if it is closed, close
			-- it in the opposite case.
		do
			tools.favorites_tool.show
		end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Execution

	save_and_switch_formatter (a_formatter: EB_FORMATTER)
			-- Save the file before switching bewteen main formatters when the file is not saved.
		require
			a_formatter_not_void: a_formatter /= Void
		do
			if a_formatter.is_button_sensitive then
				if changed then
					save_and (agent a_formatter.execute)
				else
					a_formatter.execute
				end
			end
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEBUGGER_MANAGER, EB_WINDOW_MANAGER,
		EB_NEW_DEVELOPMENT_WINDOW_COMMAND} -- Access

	development_window_data: EB_DEVELOPMENT_WINDOW_PREFERENCES
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

	shell_tools: ES_SHELL_TOOLS
		-- Access to the EiffelStudio shell embedded tools

feature {EB_DEVELOPMENT_WINDOW_PART}

	set_text_edited (a_bool: like text_edited)
			-- Set `text_edited'
		do
			text_edited := a_bool
		ensure
			set: text_edited = a_bool
		end

	set_context_refreshing_timer (a_timer: like context_refreshing_timer)
			-- Set `context_refreshing_timer'
		do
			context_refreshing_timer := a_timer
		ensure
			set: context_refreshing_timer = a_timer
		end

feature {NONE} -- Window management

	frozen next_window_id: like window_id
			-- Retrieve's the next window id in the sequence
		do
			Result := window_id_counter.item
			window_id_counter.put (Result + 1)
		ensure
			window_manager.windows.for_all (agent (a_window: EB_WINDOW; a_id: like window_id): BOOLEAN
				require
					a_window_attached: a_window /= Void
				do
					Result := a_window = Current or else
						(attached {EB_DEVELOPMENT_WINDOW} a_window as l_window and then l_window.window_id /= a_id)
				end (?, Result))
		end

feature {NONE} -- Internal implementation cache

	internal_session_data: detachable like session_data
			-- Cached version of `session_data'.
			-- Note: Do not use directly!

	internal_project_session_data: detachable like project_session_data
			-- Cached version of `project_session_data'.
			-- Note: Do not use directly!

	internal_layout_manager: detachable like layout_manager
			-- Cached version of `layout_manager'.
			-- Note: Do not use directly!

feature {NONE} -- Internationalization

	t_experimental: STRING = "Experimental"
	t_compatible: STRING = "Compatible"

invariant
	commands_attached: not is_recycled implies commands /= Void
	menus_attached: not is_recycled implies menus /= Void
	agents_attached: not is_recycled implies agents /= Void
	tools_attached: not is_recycled implies tools /= Void
	dynamic_tools_attached: not is_recycled implies shell_tools /= Void
	ui_attached: not is_recycled implies ui /= Void
	window_id_positive: window_id > 0

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
