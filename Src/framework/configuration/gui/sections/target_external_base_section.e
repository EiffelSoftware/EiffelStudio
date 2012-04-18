note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TARGET_EXTERNAL_BASE_SECTION

inherit
	TARGET_SECTION
		undefine
			name,
			icon,
			update_toolbar_sensitivity,
			context_menu
		redefine
			create_select_actions
		end

	CONF_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Element update

	add_external
			-- Add a new external.
		deferred
		end

feature {NONE} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (1)
			create l_item.make_with_text_and_action (add_text, agent add_external)
			l_item.set_pixmap (add_icon)
			Result.extend (l_item)
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			add_button.select_actions.wipe_out
			add_button.select_actions.extend (agent add_external)
			add_button.enable_sensitive
		end

feature {NONE} -- Section properties

	add_text: STRING_GENERAL
			-- Menu entry text to add a new item.
		deferred
		end

	add_icon: EV_PIXMAP
			-- Menu entry icon to add a new item.
		deferred
		end

	add_button: SD_TOOL_BAR_BUTTON
			-- Toolbar button to add a new item.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
