note
	description: "[
		An ESF widget for the C/C++ compilation output in the Outputs Tool ({ES_OUTPUTS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_C_COMPILER_EDITOR_WIDGET

inherit
	ES_EDITOR_WIDGET
		redefine
			is_tool_bar_bottom_aligned,
			on_after_initialized,
			new_right_tool_bar_items
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization: User interface

	on_after_initialized
			-- <Precursor>
		do
			Precursor
--			if not workbench.system_defined then
--				open_file_button.disable_sensitive
--				open_button.disable_sensitive
--			else
--				open_file_button.enable_sensitive
--				open_button.enable_sensitive
--				if open_project_menu_item /= Void then
--					open_project_menu_item.enable_sensitive
--				end
--				if not workbench.is_already_compiled then
--						-- The project is not compiled so there is no compilation folders.
--					if open_workbench_menu_item /= Void then
--						open_workbench_menu_item.disable_sensitive
--					end
--					if open_finalized_menu_item /= Void then
--						open_finalized_menu_item.disable_sensitive
--					end
--				else
--					if open_workbench_menu_item /= Void then
--						open_workbench_menu_item.enable_sensitive
--					end
--					if open_finalized_menu_item /= Void then
--						open_finalized_menu_item.enable_sensitive
--					end
--				end
--			end
		end

feature {NONE} -- Access: User interface

	open_button: attached SD_TOOL_BAR_POPUP_BUTTON
			-- Button used to open a folder.

	open_project_menu_item: detachable EV_MENU_ITEM
			-- Menu item used to open the project folder.

	open_workbench_menu_item: detachable EV_MENU_ITEM
			-- Menu item used to open the compilation workbench folder.

	open_finalized_menu_item: detachable EV_MENU_ITEM
			-- Menu item used to open the compilation finalized folder.

	open_file_button: attached SD_TOOL_BAR_BUTTON
			-- Button use to open a parsed C/C++ file name in an external editor.

feature -- Status report

    is_tool_bar_bottom_aligned: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Basic operations

	open_folder (a_folder: attached READABLE_STRING_GENERAL)
			-- Attempts to open a folder in the default file browser.
			--
			-- `a_folder': The folder to open.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: (create {RAW_FILE}.make (a_folder.as_string_8)).exists
		local
			l_cmd: STRING
		do
			l_cmd := preferences.misc_data.file_browser_command
			if l_cmd /= Void then
				l_cmd := l_cmd.twin
				l_cmd.replace_substring_all ("$target", a_folder.as_string_8)
				(create {EXECUTION_ENVIRONMENT}).launch (l_cmd)
			end
		end

feature {NONE} -- Action handlers

	on_open_project_folder
			-- Opens the project folder.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do

		end

	on_open_workbench_folder
			-- Opens the workbench compilation folder.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do

		end

	on_open_finalized_folder
			-- Opens the finalized compilation folder.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do

		end

feature {NONE} -- Factory

	new_right_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_popup_button: SD_TOOL_BAR_POPUP_BUTTON
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (2)

			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.command_send_to_external_editor_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.command_send_to_external_editor_icon)
			l_button.set_tooltip (locale_formatter.translation (tt_open_in_external_editor))
			Result.put_last (l_button)
			open_file_button := l_button

			create l_popup_button.make
			l_popup_button.set_pixel_buffer (stock_pixmaps.general_open_icon_buffer)
			l_popup_button.set_pixmap (stock_pixmaps.general_open_icon)
			l_popup_button.set_tooltip (locale_formatter.translation (tt_open_folder))
			l_popup_button.set_menu_function (agent: EV_MENU
				local
					l_menu_item: EV_MENU_ITEM
				do
					create Result
					create l_menu_item.make_with_text (locale_formatter.translation (l_project))
					l_menu_item.set_pixmap (stock_pixmaps.document_eiffel_project_icon)
					register_action (l_menu_item.select_actions, agent on_open_project_folder)
					Result.extend (l_menu_item)
					open_project_menu_item := l_menu_item

					create l_menu_item.make_with_text (locale_formatter.translation (l_workbench))
					l_menu_item.set_pixmap (stock_pixmaps.general_open_icon)
					register_action (l_menu_item.select_actions, agent on_open_workbench_folder)
					Result.extend (l_menu_item)
					open_workbench_menu_item := l_menu_item

					create l_menu_item.make_with_text (locale_formatter.translation (l_finalized))
					l_menu_item.set_pixmap (stock_pixmaps.general_open_icon)
					register_action (l_menu_item.select_actions, agent on_open_finalized_folder)
					Result.extend (l_menu_item)
					open_finalized_menu_item := l_menu_item
				end)
			Result.put_last (l_popup_button)
			open_button := l_popup_button
		end

feature {NONE} -- Internationalization

	tt_open_in_external_editor: STRING = "Open the selected file name in an external editor"
	tt_open_folder: STRING = "Open the selected folder"

	l_project: STRING = "Project Folder"
	l_workbench: STRING = "Workbench Compiler Folder"
	l_finalized: STRING = "Finalized Compiler Folder"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
