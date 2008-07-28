indexing
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

	make is
			-- Creation method
		do
		end

feature -- Command

	construct is
			-- Create a new development window.
		local
			l_x, l_y: INTEGER
			l_debugger_manager: EB_DEBUGGER_MANAGER
			l_window: EB_VISION_WINDOW
		do
			internal_construct
			l_window := develop_window.window

			l_x := l_window.x_position
			l_y := l_window.y_position
			l_window.set_position ({INTEGER_16}.min_value, {INTEGER_16}.min_value)
			l_window.show

			l_debugger_manager ?= develop_window.debugger_manager
			if
				not develop_window.development_window_data.is_force_debug_mode or
				l_debugger_manager = Void or
				not develop_window.docking_manager.is_config_data_valid (eiffel_layout.user_docking_standard_file_name (develop_window.window_id)) or else
				l_debugger_manager.debug_mode_forced -- There is already a window forced debug mode. We open an normal window.
			then
				develop_window.restore_tools_docking_layout
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
			l_window.set_position (l_x, l_y)

			if develop_window.development_window_data.is_maximized then
					-- Make sure that window is maximized next time we show it.
				l_window.show_actions.extend_kamikaze (agent l_window.maximize)
			end
		end

	construct_as_context_tool is
			-- Create a new development window and expand the context tool.
		do
			construct
				-- Perform window setting from `show_actions', as the
				-- resizing executed as a result only works correctly
				-- while the window is displayed.
			develop_window.window.show_actions.extend (agent set_context_mode)
		end

	set_context_mode is
			-- Set `current' into context mode, that is the context tool
			-- maximized, and the non editor panel is hidden.
		do
			if not develop_window.unified_stone then
				develop_window.commands.toggle_stone_cmd.execute
			end
		end

	construct_as_editor is
			-- Create a new development window and expand the editor tool.
		do
			construct

			-- Following comments are from non-docking Eiffel Studio.
			-- Perform window setting from `show_actions', as the resizing executed
			-- must be performed after `current' is displayed.
		end

	construct_with_session_data (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Recreate a previously existing development window using `a_session_data'.
		local
			l_conf_class: CONF_CLASS
			l_group: CONF_GROUP
			l_class_i: CLASS_I
			l_class_c_stone: CLASSC_STONE
			l_class_i_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_class_id, l_feature_id: STRING
			l_has_editor_restored: BOOLEAN
			l_feature: E_FEATURE
			l_feature_stone: FEATURE_STONE
			l_debugger_manager: EB_DEBUGGER_MANAGER
			l_session_data, l_project_session_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA
			l_builder: EB_DEVELOPMENT_WINDOW_MAIN_BUILDER
		do
			if a_dev_window = Void then
				construct
			else
				develop_window := a_dev_window
				create l_builder.make (develop_window)
			end

			l_session_data ?= develop_window.session_data.value (develop_window.development_window_data.development_window_data_id)

			if (create {SHARED_WORKBENCH}).workbench.system_defined then
				l_project_session_data ?= develop_window.project_session_data.value (develop_window.development_window_data.development_window_project_data_id)
			end

				-- Initial editors.
			if l_session_data /= Void and then develop_window.editors_manager.show_formatting_marks /= l_session_data.show_formatter_marks then
				develop_window.editors_manager.toggle_formatting_marks
				develop_window.refresh_toggle_formatting_marks_command
			end

			-- For first time, no `l_editors_data' saved before
			if l_project_session_data /= Void then
				l_has_editor_restored := develop_window.editors_manager.restore_editors (l_project_session_data.open_classes, l_project_session_data.open_clusters)
			end
			if l_has_editor_restored then
				develop_window.restore_editors_docking_layout
				develop_window.editors_manager.show_editors_possible
				l_debugger_manager ?= develop_window.debugger_manager
				if not l_debugger_manager.raised then
					develop_window.docking_manager.open_maximized_tool_config (eiffel_layout.user_docking_standard_file_name (develop_window.window_id))
				else
					develop_window.docking_manager.open_maximized_tool_config (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
				end
			end
				-- Attempt to reload last edited class of `Current'.
			if l_session_data /= Void then
				if l_session_data.current_target /= Void and then develop_window.editors_manager.editor_count > 0 then

					if not l_session_data.current_target_type then
							-- A class target
						l_conf_class := class_of_id (l_session_data.current_target)
						if l_conf_class /= Void then
							l_class_i ?= l_conf_class
							check
								l_class_i_not_void: l_class_i /= Void
							end
							if l_class_i.is_compiled then
								create l_class_c_stone.make (l_class_i.compiled_class)
								develop_window.set_stone (l_class_c_stone)
							else
								create l_class_i_stone.make (l_class_i)
								develop_window.set_stone (l_class_i_stone)
							end
						end
					else
							-- A group target
						l_group := group_of_id (l_session_data.current_target)
						if l_group /= Void then
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
				if l_feature_id /= Void then
					l_feature := feature_of_id (l_feature_id)
					if l_feature /= Void then
						create l_feature_stone.make (l_feature)
						develop_window.tools.set_stone (l_feature_stone)
					end
				end
				if l_class_id /= Void then
					l_class_i ?= class_of_id (l_class_id)
					if l_class_i /= Void then
						create l_class_i_stone.make (l_class_i)
						develop_window.tools.set_stone (l_class_i_stone)
					end
				end
			end

		end

feature -- Query

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Result of Current.

feature{NONE} -- Implementation

	can_lock: BOOLEAN
			-- Can we lock development window update?

	internal_construct is
			-- Construct a development window.
		local
			l_history_manager: EB_HISTORY_MANAGER
			l_address_manager: EB_ADDRESS_MANAGER
		do
			create develop_window.make
			create main_builder.make (develop_window)
			create menu_builder.make (develop_window)
			create toolbar_builder.make (develop_window)

			develop_window.set_unified_stone (develop_window.preferences.development_window_data.context_unified_stone)
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
			main_builder.build_help_engine

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
			develop_window.agents.register_action (develop_window.customized_tool_manager.change_actions, develop_window.agents.on_customized_tools_changed_agent)
		end

	main_builder: EB_DEVELOPMENT_WINDOW_MAIN_BUILDER
			-- Builder which build tools, commands, formatters.

	menu_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
			-- Builder which build menus.

	toolbar_builder: EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER;
			-- Builder which build toolbars.

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
