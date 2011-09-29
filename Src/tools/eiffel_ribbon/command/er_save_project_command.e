note
	description: "[
					Command to save project
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SAVE_PROJECT_COMMAND

inherit
	ER_COMMAND

create
	make

feature {NONE} -- Initlization

	make (a_menu: EV_MENU_ITEM)
			-- Creation method
		do
			init
			create shared_singleton
			menu_items.extend (a_menu)
		end

feature -- Command

	execute
			-- <Precursor>
		do
			if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
				l_layout_constructor.save_tree
			end
		end

feature -- Query

	new_menu_item: SD_TOOL_BAR_BUTTON
			-- Create a menu item
		do
			create Result.make
			Result.set_text ("Save Project")
			Result.set_name ("Save Project")
			Result.set_description ("Save Project")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

feature {NONE} -- Implementation

	main_window: detachable EV_WINDOW
			-- Tool's main window

	shared_singleton: ER_SHARED_SINGLETON
			-- Shared singleton
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
