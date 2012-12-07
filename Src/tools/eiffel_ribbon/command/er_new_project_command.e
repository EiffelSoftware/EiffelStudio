note
	description: "[
					Command to create a new ribbon project
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_NEW_PROJECT_COMMAND

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
		local
			l_folder: EV_DIRECTORY_DIALOG
			l_misc: ER_MISC_CONSTANTS
		do
			if attached main_window as l_win then
				create l_folder
				l_folder.show_modal_to_window (l_win)

				if attached shared_singleton.project_info_cell.item as l_item then
					if not l_folder.path.is_empty then
						l_item.set_project_location (l_folder.path)

						if attached shared_singleton.tool_info_cell.item as l_tool_info then
							create l_misc
							if attached l_misc.project_full_file_name as l_config_file then
								l_tool_info.recent_projects.extend (l_config_file)
							end

						else
							check should_not_happen: False end
						end

						l_win.save_project_command.enable
						l_win.gen_code_command.enable

						disable
						l_win.new_project_command.disable
						l_win.recent_project_command.disable
					else
						-- User didn't select any folder
					end
				else
					check False end
				end
			end
		end

	set_main_window (a_main_window: ER_MAIN_WINDOW)
			-- Set `main_window' with `a_main_window'
		do
			main_window := a_main_window
		end

feature {NONE} -- Implementation

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
