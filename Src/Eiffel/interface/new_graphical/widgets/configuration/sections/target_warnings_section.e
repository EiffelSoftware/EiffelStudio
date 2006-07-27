indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_WARNINGS_SECTION

inherit
	TARGET_SECTION
		redefine
			name,
			icon,
			context_menu,
			create_select_actions,
			update_toolbar_sensitivity
		end

create
	make

feature -- Access

	name: STRING is
			-- Name of the section.
		once
			Result := conf_interface_names.section_warning
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.project_settings_warnings_icon
		end

feature {NONE} -- Implementation

	context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		do
			create Result
			Result.extend (create {EV_MENU_ITEM}.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select))
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_target_warning (target))
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
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
