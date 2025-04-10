note
	description: "Director of all EB_DEVELOPMENT_WINDOW_BUILDERs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_DIRECTOR

inherit
	EB_SHARED_ID_SOLUTION

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		do
		end

feature -- Command

	construct
			-- Create a new development window.
		local
			l_x, l_y: INTEGER
			l_debugger_manager: detachable EB_DEBUGGER_MANAGER
			l_window: EB_VISION_WINDOW
		do
			internal_construct
			l_window := develop_window.window

				-- Save position in case of maxmized state or for Windows where we will
				-- move the window offscreen.
			l_x := l_window.x_position
			l_y := l_window.y_position
			if {PLATFORM}.is_windows then
					-- Offscreen setting is only guaranteed with MS Windows Manager.
				l_window.set_position ({INTEGER_16}.min_value, {INTEGER_16}.min_value)
			end
			l_window.show

			l_debugger_manager := {EB_DEBUGGER_MANAGER} / develop_window.debugger_manager
			if
				not develop_window.development_window_data.is_force_debug_mode or
				l_debugger_manager = Void or
				not develop_window.docking_manager.is_config_data_path_valid (eiffel_layout.user_docking_standard_file_name (develop_window.window_id)) or else
				l_debugger_manager.debug_mode_forced -- There is already a window forced debug mode. We open an normal window.
			then
				develop_window.docking_layout_manager.restore_tools_docking_layout
				if l_debugger_manager /= Void then
					l_debugger_manager.force_debug_mode_cmd.synchronize_items
				end
			else
				l_debugger_manager.force_debug_mode_cmd.execute_for_opening (False)
			end
			if l_debugger_manager /= Void then
				l_debugger_manager.update_debugging_tools_menu_from (develop_window)
			end
			develop_window.docking_manager.show_displayed_floating_windows_in_idle
			if can_lock then
				l_window.unlock_update
			end

			l_window.hide

			if
				attached {EB_DEVELOPMENT_WINDOW_DATA} develop_window.session_data.value (develop_window.development_window_data.development_window_data_id) as l_data and then
				l_data.is_maximized
			then
					-- Position the maximized window to the same screen as before using the saved maximized positions.
				l_window.set_position (l_data.maximized_x_position, l_data.maximized_y_position)
					-- Make sure that window is maximized next time we show it.
				l_window.show_actions.extend_kamikaze (agent l_window.maximize)
					-- Once it is maximized, we make sure to restore the window to its former
					-- unmaximized position.
				l_window.restore_actions.extend_kamikaze (agent l_window.set_position (l_x, l_y))
			elseif {PLATFORM}.is_windows then
					-- Restore position of window to what was obtained before
					-- putting it offscreen.
				l_window.set_position (l_x, l_y)
			end
		end

	construct_with_session_data (a_dev_window: EB_DEVELOPMENT_WINDOW)
			-- Recreate a previously existing development window using `a_session_data'.
		local
			l_conf_class: CONF_CLASS
			l_class_c_stone: CLASSC_STONE
			l_class_i_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_class_id, l_feature_id: STRING
			l_has_editor_restored: BOOLEAN
			l_feature_stone: FEATURE_STONE
			l_session_data, l_project_session_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA
			l_builder: EB_DEVELOPMENT_WINDOW_MAIN_BUILDER
			l_open_classes: detachable HASH_TABLE [STRING, STRING]
			l_open_clusters: detachable HASH_TABLE [STRING, STRING]
		do
			if a_dev_window = Void then
				construct
			else
				develop_window := a_dev_window
				create l_builder.make (develop_window)
			end

			l_session_data := {EB_DEVELOPMENT_WINDOW_SESSION_DATA} / develop_window.session_data.value (develop_window.development_window_data.development_window_data_id)

			if (create {SHARED_WORKBENCH}).workbench.system_defined then
				l_project_session_data := {EB_DEVELOPMENT_WINDOW_SESSION_DATA} / develop_window.project_session_data.value (develop_window.development_window_data.development_window_project_data_id)
			end

				-- Initial editors.
			if l_session_data /= Void and then develop_window.editors_manager.show_formatting_marks /= l_session_data.show_formatter_marks then
				develop_window.editors_manager.toggle_formatting_marks
				develop_window.refresh_toggle_formatting_marks_command
			end

			-- For first time, no `l_editors_data' saved before
			if l_project_session_data /= Void then
				l_open_classes := l_project_session_data.open_classes
				l_open_clusters := l_project_session_data.open_clusters
				if l_open_classes = Void then
					create l_open_classes.make (0)
				end
				if l_open_clusters = Void then
					create l_open_clusters.make (0)
				end
				l_has_editor_restored := develop_window.editors_manager.restore_editors (l_open_classes, l_open_clusters)
					-- If ever there is a session saved, and we tried to restore it, the window is informed.
					-- So that the window knows at least root feature has no need to display.
				develop_window.editor_session_loaded := True
			end
			if l_has_editor_restored then
				develop_window.layout_manager.restore_editors_layout
				develop_window.editors_manager.show_editors_possible
				if attached {EB_DEBUGGER_MANAGER} develop_window.debugger_manager as l_debugger_manager and then l_debugger_manager.raised then
					develop_window.docking_manager.open_maximized_tool_config_with_path (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
				else
					develop_window.docking_manager.open_maximized_tool_config_with_path (eiffel_layout.user_docking_standard_file_name (develop_window.window_id))
				end
			end
				-- Attempt to reload last edited class of `Current'.
			if l_session_data /= Void then
				if l_session_data.current_target /= Void and then develop_window.editors_manager.editor_count > 0 then

					if not l_session_data.current_target_type then
							-- A class target
						l_conf_class := class_of_id (l_session_data.current_target)
						if
							l_conf_class /= Void and then
							attached {CLASS_I} l_conf_class as l_class_i
						then
							if l_class_i.is_compiled then
								create l_class_c_stone.make (l_class_i.compiled_class)
								develop_window.set_stone (l_class_c_stone)
							else
								create l_class_i_stone.make (l_class_i)
								develop_window.set_stone (l_class_i_stone)
							end
						else
							check is_class_i: l_conf_class /= Void implies False end
						end
					else
							-- A group target
						if attached group_of_id (l_session_data.current_target) as l_group then
							create l_cluster_stone.make (l_group)
							develop_window.set_stone (l_cluster_stone)
						end
					end
					if
						l_session_data.editor_position > 0
						and then develop_window.editors_manager.current_editor /= Void
					then
						develop_window.editors_manager.current_editor.display_line_when_ready (l_session_data.editor_position, 0, False)
					end
				end
				l_class_id := l_session_data.class_class_id
				l_feature_id := l_session_data.feature_relation_feature_id
				if
					l_feature_id /= Void and then
					attached feature_of_id (l_feature_id) as l_feature
				then
					create l_feature_stone.make (l_feature)
					develop_window.tools.set_stone (l_feature_stone)
				end
				if
					l_class_id /= Void and then
					attached {CLASS_I} class_of_id (l_class_id) as l_class_i
				then
					create l_class_i_stone.make (l_class_i)
					develop_window.tools.set_stone (l_class_i_stone)
				end
			end

		end

feature -- Query

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Result of Current.

feature{NONE} -- Implementation

	can_lock: BOOLEAN
			-- Can we lock development window update?

	internal_construct
			-- Construct a development window.
		local
			l_history_manager: EB_HISTORY_MANAGER
			l_address_manager: EB_ADDRESS_MANAGER
		do
			create develop_window.make
			create main_builder.make (develop_window)
			create menu_builder.make (develop_window)
			create toolbar_builder.make (develop_window)

			develop_window.set_is_unified_stone (develop_window.preferences.development_window_data.context_unified_stone)
				-- Build the history manager, the address manager, ...

			create l_history_manager.make (develop_window)
			develop_window.set_history_manager (l_history_manager)

			create l_address_manager.make (develop_window, False)
			develop_window.set_address_manager (l_address_manager)
			main_builder.build_formatters
			develop_window.address_manager.set_formatters (develop_window.managed_main_formatters)

				-- Init commands, build interface, build menus, ...
			main_builder.build_vision_window

			can_lock := ((create {EV_ENVIRONMENT}).application.locked_window = Void)
			if can_lock then
				-- We call lock update here to make sure only refresh whole window for one-time which is Windows lock update side-effect.	
				develop_window.window.lock_update
			end

			menu_builder.build_menus

			develop_window.set_initialized_for_builder (False)

			main_builder.set_up_accelerators

			develop_window.register_action (develop_window.window.focus_in_actions, agent (develop_window.agents).on_focus)

				-- Create the toolbars.
			toolbar_builder.build_toolbars_area

				-- Rebuild toolbar menu in View menu
			develop_window.menus.view_menu.put_front (menu_builder.build_toolbar_menu)

				-- Update widgets visibilities
			develop_window.status_bar.remove_cursor_position
			develop_window.address_manager.set_output_line (develop_window.status_bar.label)

				-- Finish initializing the main editor formatters
			main_builder.end_build_formatters

			develop_window.address_manager.disable_formatters
			if develop_window.Eiffel_project.manager.is_project_loaded then
				develop_window.agents.on_project_created
				develop_window.agents.on_project_loaded
			elseif develop_window.Eiffel_project.manager.is_created then
				develop_window.agents.on_project_unloaded
				develop_window.agents.on_project_created
			else
				develop_window.agents.on_project_unloaded
			end

			develop_window.set_initialized_for_builder (True)
			develop_window.set_is_destroying (False)
--			develop_window.agents.register_action (develop_window.customized_tool_manager.change_actions, develop_window.agents.on_customized_tools_changed_agent)
		end

	main_builder: EB_DEVELOPMENT_WINDOW_MAIN_BUILDER
			-- Builder which build tools, commands, formatters.

	menu_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
			-- Builder which build menus.

	toolbar_builder: EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER;
			-- Builder which build toolbars.

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
