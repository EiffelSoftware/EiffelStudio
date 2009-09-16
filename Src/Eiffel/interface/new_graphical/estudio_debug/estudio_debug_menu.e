note
	description: "Objects that represent the special debug menu for eStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_MENU

inherit
	EV_MENU

	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create, is_equal, copy
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create, is_equal, copy
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
			{ANY} file_system
		undefine
			default_create, is_equal, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, is_equal, copy
		end

create
	make_with_window

feature {NONE} -- Initialization

	make_with_window (w: EV_WINDOW)
		local
			menu_item: attached EV_MENU_ITEM
			menu: attached EV_MENU
		do
			window := w
			default_create
			set_text (compiler_version_number.version)

				--| Tools
			create menu.make_with_text ("Tools")
			extend (menu)
			build_tools_sub_menu (menu)

				--| Services
			create menu.make_with_text ("Services")
			extend (menu)
			build_services_sub_menu (menu)

				--| Foundataions
			create menu.make_with_text ("Foundations")
			extend (menu)
			build_foundations_sub_menu (menu)

			extend (create {EV_MENU_SEPARATOR})

				--| Editor
			create menu.make_with_text ("Editor")
			extend (menu)
			build_editor_sub_menu (menu)

			extend (create {EV_MENU_SEPARATOR})

				--| Recompile backups
			create menu_item.make_with_text_and_action ("Replay Backup", agent on_replay_backup)
			extend (menu_item)

			extend (create {EV_MENU_SEPARATOR})

				--| Recenter all floating tools
			create menu_item.make_with_text_and_action ("Force Show All Tools", agent on_force_show_tools)
			extend (menu_item)

				--| Recenter all floating tools
			create menu_item.make_with_text_and_action ("Center Floating Tools", agent on_center_floating_tools)
			extend (menu_item)

			extend (create {EV_MENU_SEPARATOR})

				--| Void safe helpers
			create menu_item.make_with_text_and_action ("Check all routines in system", agent on_check_routines)
			extend (menu_item)

				--| Interface comparer
			create menu_item.make_with_text_and_action ("Compare libraries", agent on_compare_library_classes)
			extend (menu_item)

			extend (create {EV_MENU_SEPARATOR})

				--| Debug
			create menu.make_with_text ("Debug")
			extend (menu)
			build_debug_sub_menu (menu)

		end

	build_tools_sub_menu (a_menu: attached EV_MENU)
			-- Builds the tools submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: attached EV_MENU_ITEM
		do
				--| UUID Generator
			create l_menu_item.make_with_text_and_action ("UUID Generator", agent on_generate_uuid)
			a_menu.extend (l_menu_item)

				--| Memory tool
			create l_menu_item.make_with_text_and_action ("Memory Analyzer", agent on_launch_memory_analyzer)
			a_menu.extend (l_menu_item)

			a_menu.extend (create {EV_MENU_SEPARATOR})

				--| Show memory tool
			create l_menu_item.make_with_text_and_action ("Show Memory Tool", agent on_show_memory_tool)
			a_menu.extend (l_menu_item)

				--| Show logger tool
			create l_menu_item.make_with_text_and_action ("Show Logger Tool", agent on_show_logger_tool)
			a_menu.extend (l_menu_item)

			if (create {SERVICE_CONSUMER [OUTPUT_MANAGER_S]}).is_service_available then
					--| Show logger tool
				create l_menu_item.make_with_text_and_action ("Show Outputs Tool (Experimental)", agent on_show_outputs_tool)
				a_menu.extend (l_menu_item)
			end
		end

	build_services_sub_menu (a_menu: attached EV_MENU)
			-- Builds the services submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: attached EV_MENU_ITEM
		do
			create l_menu_item.make_with_text_and_action ("Save All Session Data", agent on_save_session_data)
			a_menu.extend (l_menu_item)
			if not session_manager.is_service_available then
				l_menu_item.disable_sensitive
			end

			create l_menu_item.make_with_text_and_action ("Restore All Session Data", agent on_restore_session_data)
			a_menu.extend (l_menu_item)
			if not session_manager.is_service_available then
				l_menu_item.disable_sensitive
			end

			a_menu.extend (create {EV_MENU_SEPARATOR})

			create l_menu_item.make_with_text_and_action ("Rescan Code Template Catalog", agent on_rescan_code_template_catalog)
			a_menu.extend (l_menu_item)
			if not code_template_catalog.is_service_available then
				l_menu_item.disable_sensitive
			end
		end

	build_foundations_sub_menu (a_menu: attached EV_MENU)
			-- Builds the foundataions submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_check_menu_item: EV_CHECK_MENU_ITEM
		do
			create l_check_menu_item.make_with_text_and_action ("Non Discardable Prompts", agent on_toggle_discardable_prompts)
			if discardable_overrides.is_non_discardable then
				l_check_menu_item.enable_select
			end
			a_menu.extend (l_check_menu_item)
		end

	build_editor_sub_menu (a_menu: attached EV_MENU)
			-- Builds the editor submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: attached EV_MENU_ITEM
		do
				--| Force compilation
			create l_menu_item.make_with_text_and_action ("Force Compilation", agent on_force_compile_class)
			a_menu.extend (l_menu_item)

				--| Force compilation
			create l_menu_item.make_with_text_and_action ("Force Compilation On All Open", agent on_force_compile_all_classes)
			a_menu.extend (l_menu_item)

				--| Save all classes though the editor in current project
			create l_menu_item.make_with_text_and_action ("Save All Classes In The Project Through The Editor", agent on_resave_all_classes)
			a_menu.extend (l_menu_item)
		end

	build_debug_sub_menu (a_menu: attached EV_MENU)
			-- Builds the debug submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: attached EV_MENU_ITEM
		do
				--| Force Call on Void
			create l_menu_item.make_with_text_and_action ("Force Call on Void target", agent local s: STRING do s.to_lower end)
			a_menu.extend (l_menu_item)
		end

feature {NONE} -- Access

	window: EV_WINDOW
			-- Main development window.

	ma_window: MA_WINDOW;
			-- Memory analyzer window.

	replay_window: REPLAY_BACKUP_WINDOW
			-- Replace backup window
		once
			create Result.make
		ensure
			replay_window_not_void: Result /= Void
		end

	feature_checker_window: CELL [EB_FEATURE_CHECKER_TOOL]
			-- Link to window
		once
			create Result.put (Void)
		ensure
			feature_checker_window_not_void: Result /= Void
		end

	compare_library_classes_window: CELL [EB_COMPARE_LIBRARY_CLASSES_TOOL]
			-- Link to window
		once
			create Result.put (Void)
		ensure
			feature_checker_window_not_void: Result /= Void
		end

feature {NONE} -- Services

	frozen session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service
		once
			create Result
		ensure
			result_attached: attached Result
		end

	frozen code_template_catalog: SERVICE_CONSUMER [CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog service
		once
			create Result
		ensure
			result_attached: attached Result
		end

	frozen discardable_overrides: ES_DISCARDABLE_PROMPT_OVERRIDES
			-- Access to discardable overrides
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Query

	active_editor: detachable EB_SMART_EDITOR
			-- Attempts to locate the last active editor.
		do
			if attached window_manager.last_focused_development_window as l_window and then l_window.is_interface_usable then
				if attached l_window.editors_manager.current_editor as l_editor and then l_editor.is_interface_usable then
					Result := l_editor
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature {NONE} -- Basic operations

	paste_new_uuid (tf: EV_TEXTABLE)
		local
			uuid_gene: UUID_GENERATOR
		do
			create uuid_gene
			tf.set_text (uuid_gene.generate_uuid.out)
		end

feature {NONE} -- Actions

	on_launch_memory_analyzer
			-- Launch Memory Analyzer.
		local
			l_dir: DIRECTORY_NAME
		do
			if ma_window = Void or ma_window.is_destroyed then
				create l_dir.make_from_string (eiffel_layout.library_path)
				l_dir.extend ("memory_analyzer")
				create ma_window.make (l_dir)
				ma_window.close_request_actions.extend (agent ma_window.hide)
				ma_window.show
			else
				ma_window.show
			end
		end

	on_show_memory_tool
			-- Shows the integrated memory tool
		do
			window_manager.last_focused_development_window.shell_tools.show_tool ({ES_MEMORY_TOOL}, True)
		end

	on_show_logger_tool
			-- Shows the integrated memory tool
		do
			window_manager.last_focused_development_window.shell_tools.show_tool ({ES_LOGGER_TOOL}, True)
		end

	on_show_outputs_tool
			-- Shows the integrated memory tool
		do
			window_manager.last_focused_development_window.shell_tools.show_tool ({ES_OUTPUTS_TOOL}, True)
		end

	on_generate_uuid
			-- Launch UUID generator
		local
			l_dlg: EV_DIALOG
			vb: EV_VERTICAL_BOX
			tf: EV_TEXT_FIELD
			but, cbut: EV_BUTTON
		do
			create l_dlg.make_with_title ("UUID Generator")
			create vb
			create tf.make_with_text ("")
			create but.make_with_text_and_action ("New UUID", agent paste_new_uuid (tf))
			create cbut.make_with_text_and_action ("Close", agent l_dlg.destroy)
			vb.extend (tf)
			vb.extend (but)
			vb.extend (cbut)
			vb.disable_item_expand (tf)
			vb.disable_item_expand (cbut)
			l_dlg.extend (vb)
			l_dlg.set_default_cancel_button (cbut)
			cbut.hide
			l_dlg.set_width (300)
			paste_new_uuid (tf)
			if window /= Void then
				l_dlg.show_relative_to_window (window)
			else
				l_dlg.show
			end
		end

	on_replay_backup
			-- Launch tool that enables us to replay precisely a backup.
		do
			replay_window.window.raise
		end

	on_force_compile_class
			-- Forces the active editor's class to be compiled.
		local
			l_error: ES_ERROR_PROMPT
		do
			if not eiffel_project.is_compiling then
					-- Do not process this whilst compiling
				if
					attached window_manager.last_focused_development_window as l_window and then
					l_window.is_interface_usable
				then
					if
						attached active_editor as l_editor and then
						attached {CLASSI_STONE} l_editor.stone as l_class
					then
							-- We have the class stone
						if attached l_class.class_i as l_class_i then
							if l_class_i.is_compiled then
								create l_error.make_standard ("The class " + l_class_i.name + " is already compiled!")
								l_error.show_on_active_window
							else
									-- Add the class
								l_class_i.system.add_unref_class (l_class_i)
							end
						end
					end
				end
			else
				create l_error.make_standard ("Unable to force compilation whilst compiling.")
				l_error.show_on_active_window
			end
		end

	on_force_compile_all_classes
			-- Forces the active editor's class to be compiled.
		local
			l_error: ES_ERROR_PROMPT
			l_classes: STRING
			l_nb: INTEGER
		do
			if not eiffel_project.is_compiling then
					-- Do not process this whilst compiling
				if attached window_manager.windows as l_windows then
					if attached {EB_DEVELOPMENT_WINDOW} l_windows.item as l_window and then l_window.is_interface_usable then
						if attached l_window.editors_manager.editors as l_editors then
							create l_classes.make (256)
							from l_editors.start until l_editors.after loop
								if
									attached l_editors.item as l_editor and then
									l_editor.is_interface_usable and then
									attached {CLASSI_STONE} l_editor.stone as l_class
								then
										-- We have the class stone
									if attached l_class.class_i as l_class_i then
										if l_class_i.is_compiled then
											l_classes.append_string_general (l_class_i.name)
											l_classes.append_character ('%N')
											l_nb := l_nb + 1
										else
												-- Add the class
											l_class_i.system.add_unref_class (l_class_i)
										end
									end
								end
								l_editors.forth
							end

							if not l_classes.is_empty then
								l_classes.prune_all_trailing ('%N')
								if l_classes.index_of ('%N', 1) > 0 then
									create l_error.make_standard ("The classes%N%N" + l_classes + "%N%Nare already compiled!")
								else
									create l_error.make_standard ("The class " + l_classes + " is already compiled!")
								end
								l_error.show_on_active_window
							end
						end
					end
				end
			else
				create l_error.make_standard ("Unable to force compilation whilst compiling.")
				l_error.show_on_active_window
			end
		end

	on_save_session_data
			-- Immediatly saves all the session data.
		require
			is_service_available: session_manager.is_service_available
		do
			session_manager.service.store_all
		end

	on_restore_session_data
			-- Immediatly restores all the session data to the last saved state.
		require
			is_service_available: session_manager.is_service_available
		do
			session_manager.service.active_sessions.do_all (agent (session_manager.service).reload)
		end

	on_rescan_code_template_catalog
			-- Rescans the code template catalog to retrieve updated templates and any new templates.
		require
			is_service_available: code_template_catalog.is_service_available
		local
			l_window: ES_POPUP_TRANSITION_WINDOW
		do
			create l_window.make_with_icon (
				("Scanning catalog for changes...").as_string_32,
				(create {EB_SHARED_PIXMAPS}).icon_pixmaps.tool_search_icon_buffer)
			l_window.set_action (agent (code_template_catalog.service).rescan_catalog)
			l_window.show_relative_to_window (window)
		end

	on_toggle_discardable_prompts
			-- Toggles the state of non-discardable prompts (makes discardable prompts non-discardable)
		local
			l_overrides: like discardable_overrides
		do
			l_overrides := discardable_overrides
			l_overrides.is_non_discardable := not l_overrides.is_non_discardable
		end

	on_force_show_tools
			-- Force the display of all the tools, useful when diagnosing memory leaks
		local
			l_window: detachable EB_DEVELOPMENT_WINDOW
			l_error: attached ES_ERROR_PROMPT
		do
			l_window := window_manager.last_focused_development_window
			if l_window /= Void and then l_window.is_interface_usable then
--				l_window.commands.show_tool_commands.linear_representation.do_all (agent (ia_cmd: EB_SHOW_TOOL_COMMAND)
--						-- Show legacy tools, should not be used anymore.
--					do
--						if ia_cmd /= Void and then ia_cmd.is_interface_usable and then ia_cmd.executable then
--							ia_cmd.execute
--						end
--					end)

				l_window.commands.show_shell_tool_commands.linear_representation.do_all (agent (ia_cmd: ES_SHOW_TOOL_COMMAND)
						-- Show ESF tools.
					local
						l_tool: ES_TOOL [EB_TOOL]
						l_show_debug_tools: BOOLEAN
					do
						if ia_cmd /= Void and then ia_cmd.is_interface_usable then
							l_tool := ia_cmd.tool
							if l_tool /= Void and then l_tool.is_interface_usable then
								if attached {EB_DEBUGGER_MANAGER} l_tool.window.debugger_manager as l_dm then
									l_show_debug_tools := l_dm.raised
								end
								if l_show_debug_tools or else not l_tool.profile_kind.is_equal ((create {ES_TOOL_PROFILE_KINDS}).debugger) then
										-- Show a regular tool or show a debugger tool if the debugger is active.
									l_tool.show (False)
								end
							end
						end
					end)
			else
				create l_error.make_standard ("Unable to retrieve the last focused window!")
				l_error.show (window)
			end
		end

	on_center_floating_tools
		local
			dw: EB_DEVELOPMENT_WINDOW
			lst: LIST [SD_CONTENT]

			c: SD_CONTENT
			wx,wy,ww,wh: INTEGER
		do
			dw := window_manager.last_focused_development_window
			if dw /= Void then
				lst := dw.docking_manager.contents
				if lst /= Void then
					wx := dw.window.x_position
					wy := dw.window.y_position
					ww := dw.window.width
					wh := dw.window.height
					from
						lst.start
					until
						lst.after
					loop
						c := lst.item_for_iteration
						if c /= Void and then c.is_visible and then c.is_floating then
							c.set_floating (wx + ww // 3, wy + wh // 3)
						end
						lst.forth
					end
				end
			end
		end

	on_resave_all_classes
			-- Resave all classes in current project through the editor,
			-- excluding classes in libraries.
			-- This applies all automatic behaviors enabled though the preferences in the editor to classes.
			-- Trailing space removing, copyright info, for example.
		local
			l_window: detachable EB_DEVELOPMENT_WINDOW
			l_target: detachable CONF_TARGET
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING_8]
			l_classes_in_cluster: PROCEDURE [ANY, TUPLE [CONF_CLUSTER]]
			l_stone: detachable STONE
		do
			l_window := window_manager.last_focused_development_window

			if l_window /= Void and then l_window.eiffel_project.initialized then
				l_stone := l_window.stone
				l_target := l_window.eiffel_universe.target
				check l_target_not_void: l_target /= Void end

				l_classes_in_cluster :=
				agent (a_cluster: detachable CONF_CLUSTER; a_window: EB_DEVELOPMENT_WINDOW)
					local
						l_classes: HASH_TABLE [CONF_CLASS, STRING_8]
						l_class_stone: CLASSI_STONE
						l_editor: EB_SMART_EDITOR
					do
						check a_cluster_not_void: a_cluster /= Void end
						l_classes := a_cluster.classes
						if l_classes /= Void then
							from
								l_classes.start
							until
								l_classes.after
							loop
								if attached {CLASS_I} l_classes.item_for_iteration as lt_class then
									create l_class_stone.make (lt_class)
									a_window.set_stone (l_class_stone)
									l_editor := a_window.editors_manager.current_editor
									if l_editor /= Void then
										l_editor.flush
										if l_editor.is_editable then
											l_editor.set_changed (True)
											a_window.save_cmd.execute
										end
									end
								end
								l_classes.forth
							end
						end
					end (?, l_window.as_attached)

				l_clusters := l_target.clusters
				l_clusters.linear_representation.do_all (l_classes_in_cluster)
				l_clusters := l_target.overrides
				l_clusters.linear_representation.do_all (l_classes_in_cluster)
				if l_stone /= Void then
					l_window.set_stone (l_stone)
				end
			end
		end

	on_check_routines
			-- Window that let you see all features in a system in the feature tool.
		local
			dw: EB_DEVELOPMENT_WINDOW
			feature_checker_tool: EB_FEATURE_CHECKER_TOOL
		do
			dw := window_manager.last_focused_development_window
			if dw /= Void and then dw.eiffel_project.initialized then
				feature_checker_tool := feature_checker_window.item
				if feature_checker_tool = Void then
					create feature_checker_tool.make (dw)
					feature_checker_window.put (feature_checker_tool)
				else
					feature_checker_tool.set_development_window (dw)
				end
				feature_checker_tool.show
			end
		end

	on_compare_library_classes
			-- Window that let you specify two libraries and compare their classes.
		local
			dw: EB_DEVELOPMENT_WINDOW
			compile_library_tool: EB_COMPARE_LIBRARY_CLASSES_TOOL
		do
			dw := window_manager.last_focused_development_window
			if dw /= Void and then dw.eiffel_project.initialized then
				compile_library_tool := compare_library_classes_window.item
				if compile_library_tool = Void then
					create compile_library_tool.make (dw)
					compare_library_classes_window.put (compile_library_tool)
				else
					compile_library_tool.set_development_window (dw)
				end
				compile_library_tool.show
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
