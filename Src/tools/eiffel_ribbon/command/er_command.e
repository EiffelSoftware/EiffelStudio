note
	description: "[
						Common ancestor for all commands in ribbon tool
						UI command pattern
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_COMMAND

feature {NONE} -- Initialization

	init
			-- Initialization
		do
			create menu_items.make (1)
			create tool_bar_items.make (1)
		end

feature -- Command

	execute
			-- Execute current command
		deferred
		end

	disable
			-- Disable current command
		do
			from
				menu_items.start
			until
				menu_items.after
			loop
				menu_items.item.disable_sensitive
				menu_items.forth
			end

			from
				tool_bar_items.start
			until
				tool_bar_items.after
			loop
				tool_bar_items.item.disable_sensitive
				tool_bar_items.forth
			end
		end

	enable
			-- Enable current command
		do
			from
				menu_items.start
			until
				menu_items.after
			loop
				menu_items.item.enable_sensitive
				menu_items.forth
			end

			from
				tool_bar_items.start
			until
				tool_bar_items.after
			loop
				tool_bar_items.item.enable_sensitive
				tool_bar_items.forth
			end
		end

feature {NONE}  -- Implementation

	menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Managed menu items

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_BUTTON]
			-- Managed tool bar items

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
