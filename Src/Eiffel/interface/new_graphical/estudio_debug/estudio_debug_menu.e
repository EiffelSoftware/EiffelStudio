indexing
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

create
	make_with_window

feature {NONE} -- Initialization

	make_with_window (w: EV_WINDOW) is
		local
			menu_item: !EV_MENU_ITEM
			menu: !EV_MENU
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

		end

	build_tools_sub_menu (a_menu: !EV_MENU)
			-- Builds the tools submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: !EV_MENU_ITEM
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
		end

	build_services_sub_menu (a_menu: !EV_MENU)
			-- Builds the services submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: !EV_MENU_ITEM
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

	build_editor_sub_menu (a_menu: !EV_MENU)
			-- Builds the editor submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: !EV_MENU_ITEM
		do
				--| Force compilation
			create l_menu_item.make_with_text_and_action ("Force Compilation", agent on_force_compile_class)
			a_menu.extend (l_menu_item)

				--| Force compilation
			create l_menu_item.make_with_text_and_action ("Force Compilation On All Open", agent on_force_compile_all_classes)
			a_menu.extend (l_menu_item)
		end

feature {NONE} -- Access

	window: EV_WINDOW
			-- Main development window.

	ma_window: MA_WINDOW;
			-- Memory analyzer window.

	replay_window: REPLAY_BACKUP_WINDOW is
			-- Replace backup window
		once
			create Result.make
		ensure
			replay_window_not_void: Result /= Void
		end

feature {NONE} -- Services

	frozen session_manager: !SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service
		once
			create Result
		end

	frozen code_template_catalog: !SERVICE_CONSUMER [CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog service
		once
			create Result
		end

feature {NONE} -- Query

	active_editor: ?EB_SMART_EDITOR
			-- Attempts to locate the last active editor.
		do
			if {l_window: EB_DEVELOPMENT_WINDOW} window_manager.last_focused_development_window and then l_window.is_interface_usable then
				if {l_editor: EB_SMART_EDITOR} l_window.editors_manager.current_editor and then l_editor.is_interface_usable then
					Result := l_editor
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature {NONE} -- Basic operations

	paste_new_uuid (tf: EV_TEXTABLE) is
		local
			uuid_gene: UUID_GENERATOR
		do
			create uuid_gene
			tf.set_text (uuid_gene.generate_uuid.out)
		end

feature {NONE} -- Actions

	on_launch_memory_analyzer is
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

	on_generate_uuid is
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
			vb.disable_item_expand (but)
			vb.disable_item_expand (cbut)

			l_dlg.extend (vb)
			l_dlg.set_default_cancel_button (cbut)
			cbut.hide
			l_dlg.set_width (200)
			paste_new_uuid (tf)
			if window /= Void then
				l_dlg.show_relative_to_window (window)
			else
				l_dlg.show
			end
		end

	on_replay_backup is
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
				if {l_window: EB_DEVELOPMENT_WINDOW} window_manager.last_focused_development_window and then l_window.is_interface_usable then
					if {l_editor: EB_SMART_EDITOR} active_editor and then {l_class: CLASSI_STONE} l_editor.stone then
							-- We have the class stone
						if {l_class_i: CLASS_I} l_class.class_i then
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
			l_windows: BILINEAR [EB_WINDOW]
			l_editors: ARRAYED_LIST [EB_SMART_EDITOR]
			l_error: ES_ERROR_PROMPT
		do
			if not eiffel_project.is_compiling then
					-- Do not process this whilst compiling
				l_windows := window_manager.windows
				if l_windows /= Void then
					if {l_window: EB_DEVELOPMENT_WINDOW} l_windows.item and then l_window.is_interface_usable then
						l_editors := l_window.editors_manager.editors
						if l_editors /= Void then
							from l_editors.start until l_editors.after loop
								if {l_editor: EB_SMART_EDITOR} l_editors.item and then l_editor.is_interface_usable and then {l_class: CLASSI_STONE} l_editor.stone then
										-- We have the class stone
									if {l_class_i: CLASS_I} l_class.class_i then
										if l_class_i.is_compiled then
											create l_error.make_standard ("The class " + l_class_i.name + " is already compiled!")
											l_error.show_on_active_window
										else
												-- Add the class
											l_class_i.system.add_unref_class (l_class_i)
										end
									end
								end
								l_editors.forth
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

	on_force_show_tools
			-- Force the display of all the tools, useful when diagnosing memory leaks
		local
			l_window: ?EB_DEVELOPMENT_WINDOW
			l_error: !ES_ERROR_PROMPT
		do
			l_window := window_manager.last_focused_development_window
			if l_window /= Void and then l_window.is_interface_usable then
				l_window.commands.show_tool_commands.linear_representation.do_all (agent (ia_cmd: EB_SHOW_TOOL_COMMAND)
						-- Show legacy tools, should not be used anymore.
					do
						if ia_cmd /= Void and then ia_cmd.is_interface_usable and then ia_cmd.executable then
							ia_cmd.execute
						end
					end)

				l_window.commands.show_shell_tool_commands.linear_representation.do_all (agent (ia_cmd: ES_SHOW_TOOL_COMMAND)
						-- Show ESF tools.
					local
						l_tool: ES_TOOL [EB_TOOL]
						l_show_debug_tools: BOOLEAN
					do
						if ia_cmd /= Void and then ia_cmd.is_interface_usable then
							l_tool := ia_cmd.tool
							if l_tool /= Void and then l_tool.is_interface_usable then
								if {l_dm: EB_DEBUGGER_MANAGER} l_tool.window.debugger_manager then
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

	on_center_floating_tools is
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
