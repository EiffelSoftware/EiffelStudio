note
	description: "Command that may be linked with a toolbar button and a menu item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMMAND_FEEDBACK

inherit
	EB_COMMAND

feature -- Initialization

	set_button (a_button: like button)
			-- Set `button' to `a_button'.
		require
			a_button_non_void: a_button /= Void
		do
			button := a_button
			button.select_actions.extend (agent execute)
		ensure
			properly_set: button = a_button
		end

	set_sd_button (a_button: like sd_button)
			-- Set `a_button' to `sd_button'.
		require
			not_void: a_button /= Void
		do
			sd_button := a_button
			sd_button.select_actions.extend (agent execute)
		ensure
			set: sd_button = a_button
		end

	set_menu_item (a_menu_item: like menu_item)
			-- Set `menu_item' to `a_menu_item'.
		require
			a_menu_item_non_void: a_menu_item /= Void
		do
			menu_item := a_menu_item
			menu_item.select_actions.extend (agent execute)
		ensure
			properly_set: menu_item = a_menu_item
		end

feature -- Status setting

	enable_sensitive
			-- Set both the `associated_button' and
			-- `associated_menu_entry' to be sensitive.
		do
			if button /= Void then
				button.enable_sensitive
			end
			if sd_button /= Void then
				sd_button.enable_sensitive
			end
			if menu_item /= Void then
				menu_item.enable_sensitive
			end
		end

	disable_sensitive
			-- Set both the `associated_button' and
			-- `associated_menu_entry' to be insensitive.
		do
			if button /= Void then
				button.disable_sensitive
			end
			if sd_button /= Void then
				sd_button.disable_sensitive
			end
			if menu_item /= Void then
				menu_item.disable_sensitive
			end
		end

feature -- Access

	button: EV_TOOL_BAR_BUTTON
			-- Button on the toolbar.

	sd_button: SD_TOOL_BAR_BUTTON
			-- Button on toolbar.

	menu_item: EV_MENU_ITEM;
			-- Menu entry in the menu.

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

end -- class EB_COMMAND_FEEDBACK
