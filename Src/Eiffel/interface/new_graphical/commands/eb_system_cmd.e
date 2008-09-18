indexing
	description: "Command to open system configuration tool window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext
		end

	EB_SHARED_INTERFACE_TOOLS
		export {NONE} all end

	EB_GRAPHICAL_ERROR_MANAGER
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

	EB_SHARED_PREFERENCES
		export {NONE} all end

	EV_SHARED_APPLICATION
		export {NONE} all end

	SHARED_CONFIG_WINDOWS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default_values.
		do
		end

feature -- Access

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON is
			-- Redefine
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
			Result.set_menu (drop_down_menu)
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
			Result.drop_actions.extend (agent on_drop)
			Result.drop_actions.set_veto_pebble_function (agent dropable)
		end

feature -- Basic operations

	execute is
			-- Open the Project configuration window.
		local
			rescued: BOOLEAN
			l_debugs: SEARCH_TABLE [STRING]
			l_sorted_debugs: DS_ARRAYED_LIST [STRING]
			l_fact: CONF_COMP_FACTORY
			l_load: CONF_LOAD
			l_config: STRING
		do
			if not rescued then
				if ev_application.ctrl_pressed then
						-- Displays memory tool.
					window_manager.last_focused_development_window.shell_tools.show_tool ({ES_MEMORY_TOOL}, True)
				else
					l_config := lace.conf_system.file_name
					config_windows.search (l_config)
					if config_windows.found and then config_windows.found_item.is_show_requested then
						configuration_window := config_windows.found_item
						configuration_window.raise
					else
						create l_fact
						create l_load.make (l_fact)
						l_load.retrieve_configuration (l_config)
						if l_load.is_error then
							(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (l_load.last_error.out, Void, Void)
								else
								-- display warnings
							if l_load.is_warning then
								(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (l_load.last_warning_messages, Void, Void)
							end
								-- sort debugs
							if workbench.system_defined then
								l_debugs := system.debug_clauses
							end
							if l_debugs /= Void then
								create l_sorted_debugs.make (l_debugs.count)
								from
									l_debugs.start
								until
									l_debugs.after
								loop
									l_sorted_debugs.put_last (l_debugs.item_for_iteration)
									l_debugs.forth
								end
								l_sorted_debugs.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
							else
								create l_sorted_debugs.make_default
							end

								-- only create a new configuration window if the data changed
							if configuration_window /= Void and then not configuration_window.is_canceled and configuration_window.conf_system.file_date = l_load.last_system.file_date then
								configuration_window.set_debugs (l_sorted_debugs)
							else
								create configuration_window.make_for_target (l_load.last_system, lace.target_name , l_fact, l_sorted_debugs, pixmaps.configuration_pixmaps, agent (preferences.misc_data).external_editor_cli)
							end

							configuration_window.set_size (preferences.dialog_data.project_settings_width, preferences.dialog_data.project_settings_height)
							configuration_window.set_position (preferences.dialog_data.project_settings_position_x, preferences.dialog_data.project_settings_position_y)
							configuration_window.set_split_position (preferences.dialog_data.project_settings_split_position)

--							configuration_window.show_modal_to_window (window_manager.last_focused_development_window.window)
							configuration_window.hide_actions.extend (agent on_hide_window (configuration_window))
							configuration_window.show
						end
					end
				end
			end
		rescue
			display_error_message (window_manager.last_focused_development_window.window)
			if catch_exception then
				rescued := True
				retry
			end
		end

feature {NONE} -- Actions

	on_drop (a_stone: STONE) is
			-- If we have a group stone for an editable library, edit this library.
		require
			a_stone_not_void: a_stone /= Void
		local
			l_lib: CONF_LIBRARY
			l_sorted_debugs: DS_ARRAYED_LIST [STRING]
			l_fact: CONF_COMP_FACTORY
			l_load: CONF_LOAD
			l_config: STRING
			l_stone: CLUSTER_STONE
		do
			l_stone ?= a_stone
			if l_stone /= Void and then l_stone.group.is_library then
				l_lib ?= l_stone.group
				check
					library: l_lib /= Void
				end
				l_config := l_lib.location.evaluated_path
				config_windows.search (l_config)
				if config_windows.found and then config_windows.found_item.is_show_requested then
					configuration_window := config_windows.found_item
					configuration_window.raise
				else
					create l_fact
					create l_load.make (l_fact)
					l_load.retrieve_configuration (l_config)
					if l_load.is_error then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (l_load.last_error.out, Void, Void)
					else
							-- display warnings
						if l_load.is_warning then
							(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (l_load.last_warning_messages, Void, Void)
						end

						create l_sorted_debugs.make_default
						create configuration_window.make_for_target (l_load.last_system, lace.target_name,
							l_fact, l_sorted_debugs, pixmaps.configuration_pixmaps, agent (preferences.misc_data).external_editor_cli)

						configuration_window.set_size (preferences.dialog_data.project_settings_width, preferences.dialog_data.project_settings_height)
						configuration_window.set_position (preferences.dialog_data.project_settings_position_x, preferences.dialog_data.project_settings_position_y)
						configuration_window.set_split_position (preferences.dialog_data.project_settings_split_position)

						configuration_window.hide_actions.extend (agent on_hide_window (configuration_window))
						configuration_window.show
					end
				end
			end
		end

	dropable (a_stone: STONE): BOOLEAN is
			-- Can `st' be dropped on `Current'?
		local
			l_stone: CLUSTER_STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void and then l_stone.group.is_library
		end

feature {NONE} -- Implementation

	configuration_window: CONFIGURATION_WINDOW
			-- Configuration window, as a class attribute in order for it to not get collecte by the gc.

	name: STRING is "System_tool"
			-- Name of command. Used to store command in preferences

	pixmap: EV_PIXMAP is
			-- Pixmap representing command.
		do
			Result := pixmaps.icon_pixmaps.tool_config_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.tool_config_icon_buffer
		end

	description: STRING_GENERAL is
			-- Description for command
		do
			Result := Interface_names.e_Project_settings
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for toolbar button
		do
			Result := Interface_names.e_Project_settings
		end

	tooltext: STRING_GENERAL is
			-- Tooltip for toolbar button
		do
			Result := Interface_names.b_Project_settings
		end

	menu_name: STRING_GENERAL is
		do
			Result := Interface_names.m_System_new
		end

	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Show the ace file in editor.
		local
			cmd_exec: COMMAND_EXECUTOR
		do
			if a_button = {EV_POINTER_CONSTANTS}.right and is_sensitive then
				create cmd_exec
				cmd_exec.execute (preferences.misc_data.external_editor_cli (eiffel_ace.lace.file_name, 1))
			end
		end

	on_hide_window (a_window: CONFIGURATION_WINDOW) is
			-- A configuration window was hidden, store layout values of `a_window' into the preferences, set changed if user pressed ok.
		require
			a_window_not_void: a_window /= Void
		do
			preferences.dialog_data.project_settings_width_preference.set_value (a_window.width)
			preferences.dialog_data.project_settings_height_preference.set_value (a_window.height)
			preferences.dialog_data.project_settings_position_x_preference.set_value (a_window.x_position)
			preferences.dialog_data.project_settings_position_y_preference.set_value (a_window.y_position)
			preferences.dialog_data.project_settings_split_position_preference.set_value (a_window.split_position)
			if not a_window.is_canceled then
				workbench.set_changed
			end
		end

	drop_down_menu: EV_MENU is
			-- Drop down menu for `new_sd_toolbar_item'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result

			create l_item.make_with_text (tooltext)
			l_item.set_pixmap (pixmap)
			l_item.select_actions.extend (agent execute)
			Result.extend (l_item)

			create l_item.make_with_text (interface_names.m_Eidt_in_external_editor)
			l_item.select_actions.extend (agent button_right_click_action (0, 0, {EV_POINTER_CONSTANTS}.right, 0, 0, 0 ,0 ,0))
			Result.extend (l_item)
		ensure
			not_void: Result /= Void
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
