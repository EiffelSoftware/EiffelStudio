indexing
	description: "Builder which build toolbars for EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER

inherit
	EB_DEVELOPMENT_WINDOW_BUILDER

create
	make

feature -- Building commands

	build_toolbars_area	 is
			-- Build all the tool bars in Eiffel Studio.
		local
			l_toolbars_area: EV_VERTICAL_BOX
			l_debugger: EB_DEBUGGER_MANAGER
			l_file: RAW_FILE
			l_file_name: STRING
		do
			create l_toolbars_area
			develop_window.set_toolbars_area (l_toolbars_area)

			l_toolbars_area.set_padding (1)

			build_general_toolbar
			build_address_toolbar
			build_project_toolbar
			build_refactoring_toolbar

			l_debugger ?= develop_window.debugger_manager
			if l_debugger /= Void then
				if not l_debugger.raised then
					l_file_name := eiffel_layout.user_docking_standard_file_name (develop_window.window_id)
					create l_file.make (l_file_name)
					if l_file.exists then
						develop_window.docking_manager.open_tool_bar_item_config (l_file_name)
					end
				else
					l_file_name := eiffel_layout.user_docking_debug_file_name (develop_window.window_id)
					create l_file.make (l_file_name)
					if l_file.exists then
						develop_window.docking_manager.open_tool_bar_item_config (l_file_name)
					end
				end
			end
		end

	build_general_toolbar is
			-- Set up the general toolbar (New, Save, Search, Shell, Undo, Redo, ...)
		local
			l_content: SD_TOOL_BAR_CONTENT
			l_show_general_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			l_sd_toolbar: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			l_tool_bar_name: STRING_GENERAL
			l_recyclable: EB_RECYCLABLE
		do
			-- Retrieve items.
			l_sd_toolbar := develop_window.development_window_data.retrieve_general_toolbar (develop_window.commands.toolbarable_commands)

				-- In general toolbar, there are items from once command objects.
				-- We need to recycle those items.
			from
				l_sd_toolbar.start
			until
				l_sd_toolbar.after
			loop
				l_recyclable ?= l_sd_toolbar.item
				if l_recyclable /= Void then
					develop_window.auto_recycle (l_recyclable)
				end
				l_sd_toolbar.forth
			end

			l_tool_bar_name := develop_window.Interface_names.to_standard_toolbar

			create l_content.make_with_items (l_tool_bar_name, l_sd_toolbar)
			l_content.set_title (develop_window.Interface_names.t_standard_toolbar)
			develop_window.docking_manager.tool_bar_manager.contents.extend (l_content)

				-- Create the command to show this toolbar.
			create l_show_general_toolbar_command.make (l_content, develop_window.Interface_names.m_general_toolbar)
			develop_window.commands.show_toolbar_commands.force (l_show_general_toolbar_command, l_content)
			if develop_window.development_window_data.show_general_toolbar then
				l_show_general_toolbar_command.enable_visible
			else
				l_show_general_toolbar_command.disable_visible
			end
			l_content.close_request_actions.extend (agent l_show_general_toolbar_command.execute)
			l_content.show_request_actions.extend (agent l_show_general_toolbar_command.execute)
			develop_window.commands.editor_commands.extend (develop_window.commands.shell_cmd)
		end

	build_address_toolbar is
			-- Set up the address toolbar (Back, Forward, Current, Class name, feature name, ...)
		local
			l_show_address_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			l_sd_items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			l_tool_bar_item: SD_TOOL_BAR_ITEM
			l_content: SD_TOOL_BAR_CONTENT
			l_tool_bar_name: STRING_GENERAL
		do
			create l_sd_items.make (12)

				-- Back icon
			l_tool_bar_item := develop_window.history_manager.back_command.new_sd_toolbar_item (False)
			l_sd_items.extend (l_tool_bar_item)

				-- Forward icon
			l_tool_bar_item := develop_window.history_manager.forth_command.new_sd_toolbar_item (False)
			l_sd_items.extend (l_tool_bar_item)

			------------------------------------------
			-- Address bar (Class name & feature name)
			------------------------------------------
			l_sd_items.merge (develop_window.address_manager.tool_bar_items)
			l_sd_items.extend (l_tool_bar_item)

			l_tool_bar_name := develop_window.Interface_names.to_address_toolbar

			l_sd_items.extend (develop_window.address_manager.new_view_points_tool_bar_item)

			create l_content.make_with_items (l_tool_bar_name, l_sd_items)
			l_content.set_title (develop_window.Interface_names.t_address_toolbar)
			develop_window.docking_manager.tool_bar_manager.contents.extend (l_content)

				-- Create the command to show this toolbar.
			create l_show_address_toolbar_command.make (l_content, develop_window.Interface_names.m_address_toolbar)
			develop_window.commands.show_toolbar_commands.force (l_show_address_toolbar_command, l_content)

			if develop_window.development_window_data.show_address_toolbar then
				l_show_address_toolbar_command.enable_visible
			else
				l_show_address_toolbar_command.disable_visible
			end

			l_content.close_request_actions.extend (agent l_show_address_toolbar_command.execute)
			l_content.show_request_actions.extend (agent l_show_address_toolbar_command.execute)

--			l_formatters := develop_window.managed_main_formatters
--			from
--				l_formatters.start
--			until
--				l_formatters.after
--			loop
--				develop_window.commands.editor_commands.extend (l_formatters.item)
--				l_formatters.forth
--			end
		end

	build_project_toolbar is
			-- Build toolbar corresponding to the project options bar
		local
			l_sd_items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			l_content: SD_TOOL_BAR_CONTENT
			l_show_project_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			l_tool_bar_name: STRING_GENERAL
		do
			-- The following is for new EB_EXEC_FORMAT_CMD' execute from command
			develop_window.eb_debugger_manager.set_debugging_window (develop_window)

			l_sd_items := develop_window.Eb_debugger_manager.new_toolbar (develop_window)

			l_tool_bar_name := develop_window.Interface_names.to_project_toolbar

			create l_content.make_with_items (l_tool_bar_name, l_sd_items)
			l_content.set_title (develop_window.Interface_names.t_project_toolbar)
			develop_window.docking_manager.tool_bar_manager.contents.extend (l_content)
				-- Generate toolbar.

				-- Create command to show this toolbar.
			create l_show_project_toolbar_command.make (l_content, develop_window.Interface_names.m_project_toolbar)
			develop_window.commands.show_toolbar_commands.force (l_show_project_toolbar_command, l_content)

			if develop_window.development_window_data.show_project_toolbar then
				l_show_project_toolbar_command.enable_visible
			else
				l_show_project_toolbar_command.disable_visible
			end

			l_content.close_request_actions.extend (agent l_show_project_toolbar_command.execute)
			l_content.show_request_actions.extend (agent l_show_project_toolbar_command.execute)
		end

	build_refactoring_toolbar is
			-- Build refactoring toolbar.
		local
			l_content: SD_TOOL_BAR_CONTENT
			l_show_tool_bar_command: EB_SHOW_TOOLBAR_COMMAND
			l_tool_bar: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			l_tool_bar_name: STRING_GENERAL
			l_recyclable: EB_RECYCLABLE
		do
			l_tool_bar := develop_window.development_window_data.retrieve_refactoring_toolbar (develop_window.commands.toolbarable_commands)

				-- In refactoring toolbar, there are items from once command objects.
				-- We need to recycle those items.
			from
				l_tool_bar.start
			until
				l_tool_bar.after
			loop
				l_recyclable ?= l_tool_bar.item
				if l_recyclable /= Void then
					develop_window.auto_recycle (l_recyclable)
				end
				l_tool_bar.forth
			end

			l_tool_bar_name := develop_window.Interface_names.to_refactory_toolbar

			create l_content.make_with_items (l_tool_bar_name, l_tool_bar)
			l_content.set_title (develop_window.interface_names.t_refactory_toolbar)
			develop_window.docking_manager.tool_bar_manager.contents.extend (l_content)

				-- Create the command to show this toolbar.
			create l_show_tool_bar_command.make (l_content, develop_window.Interface_names.m_refactoring_toolbar)
			develop_window.commands.show_toolbar_commands.force (l_show_tool_bar_command, l_content)

			if develop_window.development_window_data.show_refactoring_toolbar then
				l_show_tool_bar_command.enable_visible
			else
				l_show_tool_bar_command.disable_visible
			end

			l_content.close_request_actions.extend (agent l_show_tool_bar_command.execute)
			l_content.show_request_actions.extend (agent l_show_tool_bar_command.execute)
		end

indexing
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

end
