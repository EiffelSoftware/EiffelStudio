indexing
	description: "Objects that represent system section of a configuration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_SECTION

inherit
	CONFIGURATION_SECTION
		rename
			make as make_section
		end

	DEFAULT_VALIDATOR
		undefine
			default_create,
			is_equal,
			copy
		end

	WRAPPER_HELPER
		undefine
			default_create,
			is_equal,
			copy
		end

	CONF_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_system: like system; a_window: like configuration_window) is
			-- Create.
		require
			a_system_not_void: a_system /= Void
			a_window_ok: a_window /= Void and then not a_window.is_destroyed
		do
			system := a_system
			make_section (a_window)
		end

feature -- Access

	system: CONF_SYSTEM
			-- Configuration system for which information should be displayed.

	name: STRING is
			-- Name of the section.
		once
			Result := conf_interface_names.section_system
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.project_settings_system_icon
		end

feature -- Element update

	add_target is
			-- Add a new target.
		local
			l_target: CONF_TARGET
		do
			if not system.targets.has ("new") then
					-- add it to the configuration
				l_target := configuration_window.conf_factory.new_target ("new", system)
				system.add_target (l_target)

					-- add and display the section
				configuration_window.add_target_sections (l_target, parent)
				parent.last.enable_select
			end
		end

feature {NONE} -- Implementation

	context_menu: ARRAYED_LIST [EV_MENU_ITEM] is
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (2)
			create l_item.make_with_text_and_action (conf_interface_names.add_target, agent add_target)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.new_target_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.tool_properties_icon)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_system)
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_target_button.select_actions.wipe_out
			toolbar.add_target_button.select_actions.extend (agent add_target)
			toolbar.add_target_button.enable_sensitive
		end

invariant
	system_not_void: system /= Void

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
