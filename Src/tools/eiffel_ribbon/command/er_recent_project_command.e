note
	description: "[
					Command for recent items
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_RECENT_PROJECT_COMMAND

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
			-- Nothing to do
		end

	restore_recent_item_menu
			-- Restore recent item menu
		local
			l_menu_item: EV_MENU_ITEM
			l_projects: like {ER_TOOL_INFO}.recent_projects
		do
			if attached shared_singleton.tool_info_cell.item as l_tool_info then
				if attached main_window as l_win then
					l_projects := l_tool_info.recent_projects
					from
						l_projects.finish
					until
						l_projects.before or l_projects.index > 10
					loop
						create l_menu_item.make_with_text_and_action (l_projects.item.name, agent (l_win.open_project_command).execute_with_file_name (l_projects.item))
						l_win.recent_projects.extend (l_menu_item)
						l_projects.back
					end
				end
			end
		end

	set_main_window (a_main_window: ER_MAIN_WINDOW)
			-- Set `main_window' with `a_main_window'
		do
			main_window := a_main_window
		end

feature {NONE}	-- Implementation

	main_window: detachable ER_MAIN_WINDOW
			-- Tool's main window

	shared_singleton: ER_SHARED_TOOLS
			-- Shared singleton

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
