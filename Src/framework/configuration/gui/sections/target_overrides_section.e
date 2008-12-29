note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_OVERRIDES_SECTION

inherit
	TARGET_CLUSTERS_SECTION
		redefine
			conf_item_type,
			section_item_type,
			add_dialog_type,
			name,
			icon,
			update_toolbar_sensitivity,
			context_menu
		end

create
	make

feature -- Access

	name: STRING_GENERAL
			-- Name of the section.
		once
			Result := conf_interface_names.group_override_tree
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.top_level_folder_overrides_icon
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (1)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_override, agent add_group)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_override_cluster_icon)
		end

feature {NONE} -- Implementation

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_override_button.select_actions.wipe_out
			toolbar.add_override_button.select_actions.extend (agent add_group)
			toolbar.add_override_button.enable_sensitive
		end

feature {NONE} -- Type anchors

	add_dialog_type: CREATE_OVERRIDE_DIALOG
			-- Type of the dialog to create a new item.

	conf_item_type: CONF_OVERRIDE
			-- Type of configuration objects represented.

	section_item_type: OVERRIDE_SECTION;
			-- Type of sections contained.

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
