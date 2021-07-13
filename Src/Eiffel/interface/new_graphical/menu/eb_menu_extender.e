note
	description: "[
		A menu extender for adding new entries to a menu.

		Use EB_SHARED_MENU_EXTENDER to access it.
	]"

class
	EB_MENU_EXTENDER

inherit
	EB_SHARED_PIXMAPS

create {EB_SHARED_MENU_EXTENDER}
	make

feature {NONE} -- Creation

	make
			-- Initialize a new extender object.
		do
			create icons.make (0)
		end

feature -- Basic operations

	extend (name: READABLE_STRING_32; icon: READABLE_STRING_8; is_sensitive: BOOLEAN; action: PROCEDURE; menu: EV_MENU)
			-- Extend `menu` with an entry `name` with an icon `icon` that is enabled if `is_sensitive` and disabled otherwise, using `action` on select.
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (name)
			if is_sensitive then
				i.select_actions.extend (action)
			else
				i.disable_sensitive
			end
			set_icon (icon, i)
			menu.extend (i)
		end

feature {NONE} -- Icons

	icons: STRING_TABLE [detachable EV_PIXMAP]
			-- A cache of menu icons indexed by their names.

	set_icon (name: READABLE_STRING_GENERAL; entry: EV_MENU_ITEM)
			-- Set an icon of name `name` for a menu entry `entry`.
		local
			p: EV_PIXMAP
		do
			icons.search (name)
			if icons.found then
				p := icons.found_item
			else
				p := icon_pixmaps.named_icon (name)
			end
			if attached p then
				entry.set_pixmap (p)
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
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
