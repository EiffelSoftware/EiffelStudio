indexing
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

	remove_group is
			-- Remove `Current' from the configuration and from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		do
			target.remove_library (group.name)
			Precursor
		end

feature -- Basic operations

	edit_configuration is
			-- Open a new dialog to edit the `group'.
		require
			group_not_readonly: not group.is_readonly
		local
			l_config: STRING
			l_load: CONF_LOAD
			wd: EV_WARNING_DIALOG
			l_lib_conf: CONFIGURATION_WINDOW
		do
			l_config := group.location.evaluated_path
				-- see if we already have a window for this configuration and reuse it
			config_windows.search (l_config)
			if config_windows.found and then config_windows.found_item.is_show_requested then
				l_lib_conf := config_windows.found_item
				l_lib_conf.bring_to_front
			else
				create l_load.make (configuration_window.conf_factory)
				l_load.retrieve_configuration (l_config)
				if l_load.is_error then
					create wd.make_with_text (l_load.last_error.out)
					wd.show_modal_to_window (configuration_window)
				else
					l_load.last_system.targets.start
					l_load.last_system.set_application_target (l_load.last_system.targets.item_for_iteration)
					create l_lib_conf.make (l_load.last_system, configuration_window.conf_factory, create {DS_ARRAYED_LIST [STRING]}.make (0))
					l_lib_conf.show
					l_lib_conf.close_request_actions.extend (agent config_windows.remove (l_config))
				end
			end
		end

	update_edit_action is
			-- Disable/enable sensitivity of the edit action depending on whether the library is read only or not.
		local
			l_button: EV_TOOL_BAR_BUTTON
		do
			l_button := toolbar.edit_library
			if group.is_readonly and l_button.is_sensitive then
				l_button.disable_sensitive
			elseif not group.is_readonly and not l_button.is_sensitive then
				l_button.enable_sensitive
			end
		end

feature {NONE} -- Implementation

	context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result
			Result.extend (create {EV_MENU_ITEM}.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_group))
			create l_item.make_with_text_and_action (conf_interface_names.menu_edit_config, agent edit_configuration)
			Result.extend (l_item)
			if group.is_readonly then
				l_item.disable_sensitive
			end
			Result.extend (create {EV_MENU_ITEM}.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select))
			update_edit_action
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_group)
			toolbar.remove_button.enable_sensitive

			toolbar.edit_library.select_actions.wipe_out
			toolbar.edit_library.select_actions.extend (agent edit_configuration)
			toolbar.edit_library.enable_sensitive

			update_edit_action
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
