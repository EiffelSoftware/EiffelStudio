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
	ES_LOCALE_EDITOR_WIDGET
		redefine
			on_after_initialized,
			is_tool_bar_bottom_aligned,
			new_right_tool_bar_items,
			on_locale_changed
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			Precursor

			if attached develop_window as l_window then
				if not l_window.project_manager.is_project_loaded then
					register_kamikaze_action (l_window.project_manager.load_agents, agent on_project_loaded)
				else
					on_project_loaded
				end
			end
		end

feature {NONE} -- Access: User interface

	open_file_button: attached SD_TOOL_BAR_BUTTON
			-- Button use to open a parsed C/C++ file name in an external editor.

	open_button: attached SD_TOOL_BAR_POPUP_BUTTON
			-- Button used to open a folder.

	open_terminal_button: attached SD_TOOL_BAR_POPUP_BUTTON
			-- Button used to open a terminal.

feature -- Status report

    is_tool_bar_bottom_aligned: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Query

	path (a_type: INTEGER): detachable like {PROJECT_DIRECTORY}.location
			-- Retrieves a path based on a defined path type
			--
			-- `a_type': The type of path to retrieve.
			-- `Result': An actual path on disk or Void if the path does not exists or a project has not been loaded.
		require
			workbench_system_defined: workbench.system_defined
			a_type_is_valid: a_type = path_type_project or
				a_type = path_type_workbench or
				a_type = path_type_finalized
		local
			l_location: detachable like {PROJECT_DIRECTORY}.location
		do
			if attached workbench.eiffel_project as l_project then
				inspect a_type
				when path_type_project then
					l_location := workbench.project_location.location
				when path_type_workbench then
					if workbench.is_already_compiled then
						l_location := workbench.project_location.workbench_path
					end
				when path_type_finalized then
					if workbench.is_already_compiled then
						l_location := workbench.project_location.final_path
					end
				end

				if attached l_location then
					Result := l_location.string
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	path_from_stone (a_stone: STONE): detachable like {FILED_STONE}.file_name
			-- Retrieves a path based on a supplied stone.
			--
			-- `a_stone': A stone to retrieve a path for.
			-- `Result': An actual path on disk or Void if the path does not exists or a project has not been loaded..
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_stone_attached: a_stone /= Void
			a_stone_is_filed_or_cluster: attached {FILED_STONE} a_stone or attached {CLUSTER_STONE} a_stone
		local
			l_class_type: detachable CLASS_TYPE
			l_mapper: ES_EIFFEL_TO_C_FUNCTION_MAPPER
			l_class_c: CLASS_C
			l_ctrl: BOOLEAN
			u: GOBO_FILE_UTILITIES
		do
				-- Should the generated F_code information be shown?
			l_ctrl := ev_application.ctrl_pressed

			if attached {CLUSTER_STONE} a_stone as l_group then
				Result := l_group.group.location.evaluated_directory
			elseif attached {CLASSC_STONE} a_stone as l_class then
				if attached {FEATURE_STONE} a_stone as l_feature then
						-- Retrieve the feature specific information.

						-- The feature may not be in the current class.
					l_class_c := l_feature.e_feature.written_class
					l_class_type := class_type_from_class (l_class_c)
					if attached l_class_type then
							-- Request to view the external C code.
						create l_mapper.make (l_class_c, l_class_type)
						l_mapper.is_for_finalized := l_ctrl
						Result := l_mapper.c_class_path
					end
				else
						-- Not a feature
					l_class_c := l_class.e_class
						-- Request to view the external C code.
					l_class_type := class_type_from_class (l_class_c)
					if attached l_class_type then
						create l_mapper.make (l_class_c, l_class_type)
						l_mapper.is_for_finalized := l_ctrl
						Result := l_mapper.c_class_path
					end
				end
			elseif attached {CLASSI_STONE} a_stone as l_class then
				if not l_ctrl then
						-- The class is not compiled so there will be no externally generated code.
					Result := l_class.group.location.evaluated_directory
				end
			elseif attached {FILED_STONE} a_stone as l_filed then
					-- Unknown stone type but it has a file associated with it.
				if not l_ctrl then
					Result := u.file_directory_path (l_filed.file_name)
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	file_name_from_stone (a_stone: STONE): detachable TUPLE [file_name: READABLE_STRING_GENERAL; line: INTEGER]
			-- Open a stone in the specified external editor.
			--
			-- `a_stone': The stone to open in the external editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_stone_is_filed: attached {FILED_STONE} a_stone
		local
			l_class_type: detachable CLASS_TYPE
			l_mapper: ES_EIFFEL_TO_C_FUNCTION_MAPPER
			l_class_c: CLASS_C
			l_file_name: detachable READABLE_STRING_GENERAL
			l_line: INTEGER
			l_ctrl: BOOLEAN
		do
				-- Should the generated F_code information be shown?
			l_ctrl := ev_application.ctrl_pressed

			if attached {CLASSC_STONE} a_stone as l_class then
				if attached {FEATURE_STONE} a_stone as l_feature then
						-- Retrieve the feature specific information.

						-- The feature may not be in the current class.
					l_class_c := l_feature.e_feature.written_class
						-- Request to view the external C code.
					l_class_type := class_type_from_class (l_class_c)
					if l_class_type /= Void then
						create l_mapper.make (l_class_c, l_class_type)
						l_mapper.is_for_finalized := l_ctrl
						l_file_name := l_mapper.c_class_file_name
						if attached l_file_name then
							Result := [l_file_name, l_mapper.c_feature_line (l_feature.e_feature).as_integer_32]
						end
					end
				else
						-- Not a feature
					l_class_c := l_class.e_class
						-- Request to view the external C code.
					l_class_type := class_type_from_class (l_class_c)
					if l_class_type /= Void then
						create l_mapper.make (l_class_c, l_class_type)
						l_mapper.is_for_finalized := l_ctrl
						l_file_name := l_mapper.c_class_file_name
					end

					if attached l_file_name then
						if (attached {LINE_STONE} a_stone as l_lined) then
							l_line := l_lined.line_number
						end
						Result := [l_file_name, l_line]
					end
				end
			elseif attached {CLASSI_STONE} a_stone as l_class then
				if not l_ctrl then
						-- The class is not compiled so there will be no externally generated code.
					l_file_name := l_class.file_name
					if attached {LINE_STONE} a_stone as l_lined then
						l_line := l_lined.line_number
					end
					Result := [l_file_name, l_line]
				end
			elseif attached {FILED_STONE} a_stone as l_filed then
					-- Unknown stone type but it has a file associated with it.
				if not l_ctrl then
					l_file_name := l_filed.file_name
					if attached {LINE_STONE} a_stone as l_lined then
						l_line := l_lined.line_number
					end
					Result := [l_file_name, l_line]
				end
			end
		ensure
			result_file_name_attached: (attached Result) implies attached Result.file_name
			not_result_file_name_is_empty: (attached Result) implies attached not Result.file_name.is_empty
		end

	class_type_from_class (a_class: CLASS_C): detachable CLASS_TYPE
			-- Attempt to retrieve a class type from a compiled class.
			--
			-- `a_class': The class to retrieve a class type for.
			-- `Result': A class type or a selected class type when the supplied class is generic.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_class_attached: attached a_class
		local
			l_dialog: ES_CLASS_TYPES_DIALOG
		do
			if a_class.is_generic and then a_class.types.count > 1 then
					-- Need to find generic variant.
				create l_dialog.make (a_class)
				l_dialog.show_on_active_window
				if l_dialog.dialog_result = l_dialog.dialog_buttons.ok_button then
					Result := l_dialog.selected_class_type
				end
			else
				Result := a_class.types.first
			end
		end

feature {NONE} -- Basic operations

	open_folder (a_folder: READABLE_STRING_GENERAL)
			-- Attempts to open a folder in the default file browser.
			--
			-- `a_folder': The folder to open.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_folder_attached: a_folder /= Void
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists:
		local
			l_error: ES_ERROR_PROMPT
			u: FILE_UTILITIES
		do
			if u.directory_exists (a_folder) then
				(create {EB_SHARED_MANAGERS}).external_launcher.open_dir_in_file_browser (a_folder)
			else
				create l_error.make_standard (interface_messages.e_folder_does_not_exists (a_folder))
				l_error.show_on_active_window
			end
		end

	open_terminal (a_folder: READABLE_STRING_GENERAL)
			-- Attempts to open in a folder in the default terminal.
			--
			-- `a_folder': The folder to open.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_folder_attached: a_folder /= Void
			not_a_folder_is_empty: not a_folder.is_empty
		local
			l_error: ES_ERROR_PROMPT
			u: FILE_UTILITIES
		do
			if u.directory_exists (a_folder) then
				(create {EB_SHARED_MANAGERS}).external_launcher.open_console_in_dir (a_folder)
			else
				create l_error.make_standard (interface_messages.e_folder_does_not_exists (a_folder))
				l_error.show_on_active_window
			end
		end

	open_external (a_file_name: READABLE_STRING_GENERAL; a_line: NATURAL)
			-- Attempts to open a file in an external editor at a specified line number
			--
			-- `a_file_name': The name of the file to open.
			-- `a_line': An optional line number to navigate to, if the external editor supports it.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_line_positive: a_line > 0
		local
			l_error: ES_ERROR_PROMPT
			u: FILE_UTILITIES
		do
			if u.file_exists (a_file_name) then
				(create {COMMAND_EXECUTOR}).execute (preferences.misc_data.external_editor_cli (a_file_name, a_line.as_integer_32))
			else
				create l_error.make_standard (interface_messages.e_file_does_not_exists (a_file_name))
				l_error.show_on_active_window
			end
		end

feature {NONE} -- Action handlers

	on_project_loaded
			-- Called when a project has been loaded
		require
			workbench_system_defined: workbench.system_defined
		do
			open_file_button.enable_sensitive
			open_button.enable_sensitive
			open_terminal_button.enable_sensitive
		end

	on_open_project_folder
			-- Opens the project folder.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached path (path_type_project) as l_path then
				open_folder (l_path)
			end
		end

	on_open_workbench_folder
			-- Opens the workbench compilation folder.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached path (path_type_workbench) as l_path then
				open_folder (l_path)
			end
		end

	on_open_finalized_folder
			-- Opens the finalized compilation folder.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached path (path_type_finalized) as l_path then
				open_folder (l_path)
			end
		end

	on_open_stone_folder (a_stone: STONE)
			-- Open a stone in the terminal window.
			--
			-- `a_stone': The stone folder to open.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_stone_attached: a_stone /= Void
			a_stone_is_filed_or_cluster: attached {FILED_STONE} a_stone or attached {CLUSTER_STONE} a_stone
		do
			if attached path_from_stone (a_stone) as l_path then
				open_folder (l_path)
			end
		end

	on_open_project_terminal
			-- Opens the project terminal.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached path (path_type_project) as l_path then
				open_terminal (l_path)
			end
		end

	on_open_workbench_terminal
			-- Opens the workbench compilation terminal.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached path (path_type_workbench) as l_path then
				open_terminal (l_path)
			end
		end

	on_open_finalized_terminal
			-- Opens the finalized compilation terminal.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached path (path_type_finalized) as l_path then
				open_terminal (l_path)
			end
		end

	on_open_stone_terminal (a_stone: STONE)
			-- Open a stone in the terminal window.
			--
			-- `a_stone': The stone to open in the terminal.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_stone_attached: a_stone /= Void
			a_stone_is_filed_or_cluster: attached {FILED_STONE} a_stone or attached {CLUSTER_STONE} a_stone
		do
			if attached path_from_stone (a_stone) as l_path then
				open_terminal (l_path)
			end
		end

	on_open_external
			-- Attempts to open an external selected in the C compilation window.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_selected: detachable STRING_32
			l_file_name: STRING_32
			l_compilation_folder: like {PROJECT_DIRECTORY}.path
			l_colon: INTEGER
			l_comma: INTEGER
			l_line_string: STRING_32
			l_line: NATURAL
			l_full_file_name: PATH
			l_files: ARRAYED_LIST [STRING_8]
			l_expr: RX_PCRE_MATCHER
			u: FILE_UTILITIES
		do
			l_selected := editor.text_displayed.selected_wide_string
			if l_selected /= Void and then not l_selected.is_empty then
				l_selected.right_adjust
				l_selected.left_adjust
				l_selected.prune_all_trailing (':')

				l_colon := l_selected.last_index_of (':', l_selected.count)
				if l_colon > 0  then
						-- Check for line number
					l_line_string := l_selected.substring (l_colon + 1, l_selected.count)
					if not l_line_string.is_empty then
						if l_line_string.item (1) = '(' and l_line_string.item (l_line_string.count) = ')' then
								-- Remove (###)
							l_line_string.keep_tail (l_line_string.count - 1)
							l_line_string.keep_head (l_line_string.count - 1)
						end
						l_comma := l_line_string.last_index_of (',', l_line_string.count)
						if l_comma > 0 then
								-- Remove ###,###
							l_line_string.keep_head (l_comma - 1)
						end

						if l_line_string.is_natural then
								-- Convert
							l_line := l_line_string.to_natural
							l_selected.keep_head (l_colon - 1)
						end
					end
				end

				l_file_name := l_selected
				if not u.file_exists (l_file_name) then

						-- Fetch the last applicable compilation folder
					if (create {SHARED_BYTE_CONTEXT}).context.workbench_mode then
						l_compilation_folder := workbench.project_location.workbench_path
					else
						l_compilation_folder := workbench.project_location.final_path
					end

						-- Check for relative paths
					create l_full_file_name.make_from_string (l_compilation_folder)
					l_full_file_name.extend (l_file_name)
					if not u.file_path_exists (l_full_file_name) then
							-- GCC doesn't show the full path name, so try scanning the compilation folder
						l_file_name.replace_substring_all (".", "\.")
						l_file_name.append_character ('$')
						create l_expr.make
						l_expr.compile (l_file_name)
						if l_expr.is_compiled then
								-- Perform scan...
							l_files := (create {GOBO_FILE_UTILITIES}).scan_for_files (l_compilation_folder, 2, l_expr, Void)
							if not l_files.is_empty then
								create l_full_file_name.make_from_string (l_files.first)
							end
						end
					end
					l_file_name := l_full_file_name.string_representation
				end

				if u.file_exists (l_file_name) then
						-- Open the external editor.
					open_external (l_file_name, l_line.max (1).as_natural_32)
				end
			end
		end

	on_open_stone_external (a_stone: STONE)
			-- Open a stone in the specified external editor.
			--
			-- `a_stone': The stone to open in the external editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_stone_is_filed: attached {FILED_STONE} a_stone
		do
			if attached file_name_from_stone (a_stone) as l_file_name then
				open_external (l_file_name.file_name, l_file_name.line.max (1).as_natural_32)
			end
		end

	on_locale_changed
			-- Called when the locale changes.
		do
			encoding := locale_manager.console_encoding
			editor.set_encoding (encoding)
		end

feature {NONE} -- Factory

	new_right_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_popup_button: SD_TOOL_BAR_POPUP_BUTTON
			l_button: SD_TOOL_BAR_BUTTON
		do
			Result := Precursor
			if Result = Void then
				create Result.make (3)
			else
				Result.resize (4 + Result.count)
				Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)
			end

			create l_popup_button.make
			l_popup_button.set_pixel_buffer (stock_pixmaps.general_open_icon_buffer)
			l_popup_button.set_pixmap (stock_pixmaps.general_open_icon)
			l_popup_button.set_tooltip (locale_formatter.translation (tt_open_folder))
			l_popup_button.disable_sensitive
			l_popup_button.set_menu_function (agent: EV_MENU
				local
					l_menu_item: EV_MENU_ITEM
				do
					create Result
					create l_menu_item.make_with_text (locale_formatter.translation (lb_project))
					l_menu_item.set_pixmap (stock_pixmaps.document_eiffel_project_icon)
					register_action (l_menu_item.select_actions, agent on_open_project_folder)
					Result.extend (l_menu_item)

					create l_menu_item.make_with_text (locale_formatter.translation (lb_workbench))
					l_menu_item.set_pixmap (stock_pixmaps.general_open_icon)
					register_action (l_menu_item.select_actions, agent on_open_workbench_folder)
					Result.extend (l_menu_item)

					create l_menu_item.make_with_text (locale_formatter.translation (lb_finalized))
					l_menu_item.set_pixmap (stock_pixmaps.general_open_icon)
 					register_action (l_menu_item.select_actions, agent on_open_finalized_folder)
					Result.extend (l_menu_item)
				end)
			l_popup_button.drop_actions.set_veto_pebble_function (agent (ia_stone: ANY): BOOLEAN
				do
					Result := attached {FILED_STONE} ia_stone or attached {CLUSTER_STONE} ia_stone
				end)
			register_action (l_popup_button.drop_actions, agent on_open_stone_folder)
			Result.put_last (l_popup_button)
			open_button := l_popup_button

			create l_popup_button.make
			l_popup_button.set_pixel_buffer (stock_pixmaps.tool_terminal_icon_buffer)
			l_popup_button.set_pixmap (stock_pixmaps.tool_terminal_icon)
			l_popup_button.set_tooltip (locale_formatter.translation (tt_open_terminal))
			l_popup_button.disable_sensitive
			l_popup_button.set_menu_function (agent: EV_MENU
				local
					l_menu_item: EV_MENU_ITEM
				do
					create Result
					create l_menu_item.make_with_text (locale_formatter.translation (lb_project))
					l_menu_item.set_pixmap (stock_pixmaps.document_eiffel_project_icon)
					register_action (l_menu_item.select_actions, agent on_open_project_terminal)
					Result.extend (l_menu_item)

					create l_menu_item.make_with_text (locale_formatter.translation (lb_workbench))
					l_menu_item.set_pixmap (stock_pixmaps.general_open_icon)
					register_action (l_menu_item.select_actions, agent on_open_workbench_terminal)
					Result.extend (l_menu_item)

					create l_menu_item.make_with_text (locale_formatter.translation (lb_finalized))
					l_menu_item.set_pixmap (stock_pixmaps.general_open_icon)
 					register_action (l_menu_item.select_actions, agent on_open_finalized_terminal)
					Result.extend (l_menu_item)
				end)
			l_popup_button.drop_actions.set_veto_pebble_function (agent (ia_stone: ANY): BOOLEAN
				do
					Result := attached {FILED_STONE} ia_stone or attached {CLUSTER_STONE} ia_stone
				end)
			register_action (l_popup_button.drop_actions, agent on_open_stone_terminal)
			Result.put_last (l_popup_button)
			open_terminal_button := l_popup_button

			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.command_send_to_external_editor_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.command_send_to_external_editor_icon)
			l_button.set_tooltip (locale_formatter.translation (tt_open_in_external_editor))
			l_button.disable_sensitive
			l_button.drop_actions.set_veto_pebble_function (agent (ia_stone: ANY): BOOLEAN
				do
					Result := attached {FILED_STONE} ia_stone
				end)
			register_action (l_button.drop_actions, agent on_open_stone_external)
			register_action (l_button.select_actions, agent on_open_external)

			Result.put_last (l_button)
			open_file_button := l_button
		end

feature {NONE} -- Constants

	path_type_project: INTEGER = 0
	path_type_workbench: INTEGER = 1
	path_type_finalized: INTEGER = 2

feature {NONE} -- Internationalization

	tt_open_in_external_editor: STRING = "Open the selected file name in an external editor"
	tt_open_folder: STRING = "Open the selected folder"
	tt_open_terminal: STRING = "Open the selected folder in a new terminal"

	lb_project: STRING = "Project Folder"
	lb_workbench: STRING = "Workbench Compiler Folder"
	lb_finalized: STRING = "Finalized Compiler Folder"

;note
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
