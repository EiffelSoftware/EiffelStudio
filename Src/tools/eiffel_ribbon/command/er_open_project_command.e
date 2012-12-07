note
	description: "[
					Command to open a ribbon project
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_OPEN_PROJECT_COMMAND

inherit
	ER_NEW_PROJECT_COMMAND
			redefine
				execute
			end

create
	make

feature -- Command

	execute
			-- <Precursor>
		local
			l_file: EV_FILE_OPEN_DIALOG
		do
			if attached main_window as l_win then
				create l_file
				l_file.filters.extend (["*.er", "EiffelRibbon Project Files"])
				l_file.filters.extend (["*.*", "All Files"])
				l_file.show_modal_to_window (l_win)

				execute_with_file_name (l_file.full_file_path)
			end
		end

	execute_with_file_name (a_project_file: PATH)
			-- Execute current command with `a_project_file'
		local
			l_warn: EV_WARNING_DIALOG
			l_singleton: ER_SHARED_TOOLS
		do
			if attached a_project_file as l_file and then not l_file.is_empty then
				open_project_file (l_file)
				if is_open_file_successed then
					if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
						create l_singleton
						if attached l_singleton.project_info_cell.item as l_project_info then
							l_layout_constructor.load_tree (l_project_info.ribbon_window_count)
						end
					end

					if attached shared_singleton.project_info_cell.item as l_info then
						l_info.update_ribbon_names_to_ui
					end

					if attached main_window as l_win then
						l_win.save_project_command.enable
						l_win.gen_code_command.enable

						disable
						l_win.new_project_command.disable
						l_win.recent_project_command.disable
					end
				else
					if attached main_window as l_win then
						create l_warn.make_with_text ({STRING_32} "Cannot open file: " + a_project_file.name + {STRING_32} ". Please select a valid project configuration file.")
						l_warn.show_modal_to_window (l_win)
					end
				end
			end
		end

	new_menu_item: SD_TOOL_BAR_BUTTON
			-- Create a menu item
		do
			create Result.make
			if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
				Result.set_text ("Open Project")
				Result.set_text ("Open Project")
				Result.set_description ("Open Project")
				Result.select_actions.extend (agent execute)

				tool_bar_items.extend (Result)
			end
		end

feature {NONE}	-- Implementation

	open_project_file (a_eiffel_ribbon_file: PATH)
			-- Open project file
		require
			not_void: a_eiffel_ribbon_file /= Void
		local
			l_dir: detachable PATH
		do
			if attached shared_singleton.tool_info_cell.item as l_tool_info then
				l_dir := a_eiffel_ribbon_file.parent

				if not l_tool_info.recent_projects.has (a_eiffel_ribbon_file) then
					l_tool_info.recent_projects.extend (a_eiffel_ribbon_file)
				end

				if attached shared_singleton.project_info_cell.item as l_project_info then
					l_project_info.set_project_location (l_dir)
					load_project_info
						-- Again, to update project location now after retrieved old project info object from disk
					if attached shared_singleton.project_info_cell.item as l_new_project_info then
						l_new_project_info.set_project_location (l_dir)
					end
				end
			end
		end

	load_project_info
			-- Load project info
		local
			l_sed: SED_MEDIUM_READER_WRITER
			l_sed_utility: SED_STORABLE_FACILITIES
			l_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_TOOLS
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_constants
				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then

					if attached l_constants.project_full_file_name as l_project_config then
						create l_file.make_with_path (l_project_config)
						l_file.open_read
						create l_sed.make (l_file)
						l_sed.set_for_reading

						create l_sed_utility
						if attached {ER_PROJECT_INFO} l_sed_utility.retrieved (l_sed, False) as l_data then
							l_singleton.project_info_cell.put (l_data)
						end

						l_file.close
					end
				end
				is_open_file_successed := True
			else
				is_open_file_successed := False
			end
		rescue
			l_retried := True
			retry
		end

	is_open_file_successed: BOOLEAN
			-- Is open project successed?

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
