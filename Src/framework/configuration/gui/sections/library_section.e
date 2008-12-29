note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_SECTION

inherit
	GROUP_SECTION
		redefine
			group,
			remove_group,
			context_menu,
			update_toolbar_sensitivity
		end

	SHARED_CONFIG_WINDOWS
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make

feature -- Access

	group: CONF_LIBRARY
		-- Group for which information are displayed.

feature -- Element update

	remove_group
			-- Remove `Current' from the configuration and from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		do
			target.remove_library (group.name)
			Precursor
		end

feature -- Basic operations

	edit_configuration
			-- Open a new dialog to edit the `group'.
		local
			l_config: STRING
			l_load: CONF_LOAD
			l_lib_conf: CONFIGURATION_WINDOW
		do
			l_config := group.location.evaluated_path
				-- see if we already have a window for this configuration and reuse it
			config_windows.search (l_config)
			if config_windows.found and then config_windows.found_item.is_show_requested then
				l_lib_conf := config_windows.found_item
				l_lib_conf.raise
			else
				create l_load.make (configuration_window.conf_factory)
				l_load.retrieve_configuration (l_config)
				if l_load.is_error then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (l_load.last_error.out, configuration_window, Void)
				elseif l_load.last_system.library_target = Void then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt ((create {CONF_ERROR_NOLIB}.make (group.name)).out, configuration_window, Void)
				else
					if l_load.is_warning then
							-- add warnings
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (l_load.last_warning_messages, configuration_window, Void)
					end

					create l_lib_conf.make_for_target (l_load.last_system, l_load.last_system.library_target.name, configuration_window.conf_factory, create {DS_ARRAYED_LIST [STRING]}.make (0), conf_pixmaps, configuration_window.external_editor_command)

					l_lib_conf.set_size (configuration_window.width, configuration_window.height)
					l_lib_conf.set_position (configuration_window.x_position, configuration_window.y_position)
					l_lib_conf.set_split_position (configuration_window.split_position)

					l_lib_conf.show
				end
			end
		end

feature {NONE} -- Implementation

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (3)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_group)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.general_delete_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_edit_config, agent edit_configuration)
			Result.extend (l_item)
			if group.is_readonly then
				l_item.disable_sensitive
			end
			l_item.set_pixmap (conf_pixmaps.project_settings_edit_library_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.tool_properties_icon)
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_group)
			toolbar.remove_button.enable_sensitive

			toolbar.edit_library.select_actions.wipe_out
			toolbar.edit_library.select_actions.extend (agent edit_configuration)
			toolbar.edit_library.enable_sensitive
		end

note
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
