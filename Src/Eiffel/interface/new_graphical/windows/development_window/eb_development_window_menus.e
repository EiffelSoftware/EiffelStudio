indexing
	description: "All menus in EB_DEVELOPMENT_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_MENUS

inherit
	EB_DEVELOPMENT_WINDOW_PART
		redefine
			internal_recycle
		end

create
	make

feature -- Query

	file_menu: EV_MENU
			-- "File" menu

	edit_menu: EV_MENU
			-- "Edit" menu

	tools_menu: EV_MENU
			-- "Tools" menu

	window_menu: EB_WINDOW_MANAGER_MENU
			-- "Window" menu

	help_menu: EV_MENU
			-- "Help" menu

	format_menu: EV_MENU
			-- ID Menu for formats.
			-- Only used during debugging

	compile_menu: EV_MENU
			-- Compile ID menu.

	debug_menu: EV_MENU
			-- Debug ID menu.

	refactoring_menu: EV_MENU
			-- Refactoring menu.

	debugging_tools_menu: EV_MENU
			-- Debugging tools menu item

	active_menus (erase: BOOLEAN) is
			-- Enable all the menus and if `erase' clean
			-- the content of the Project tool.
		do
			compile_menu.enable_sensitive
			if erase then
				develop_window.output_manager.clear
			end
		end

	disable_menus is
			-- Disable all the menus.
		do
			compile_menu.disable_sensitive
		end

	update_debug_menu is
			-- Update debug menu
		do
			develop_window.Eb_debugger_manager.update_debugging_tools_menu_from (develop_window)
		end

	project_menu: EV_MENU
			-- Menu for entries relative to the Project.

	recent_projects_menu: EB_RECENT_PROJECTS_MANAGER_MENU
			-- SubMenu for recent projects.

	favorites_menu: EB_FAVORITES_MENU
			-- Menu representing the favorites.

	view_menu: EV_MENU
			-- Menu representing the different selectable views.

	tools_list_menu: EV_MENU
			-- Menu containing list of supported tools

	context_menu_factory: EB_CONTEXT_MENU_FACTORY is
			-- Context menu factory
		do
			Result := context_menu_factory_internal
			if Result = Void then
				build_context_menu_factory
				Result := context_menu_factory_internal
			end
		end

	remove_item_from_tools_list_menu (a_tool: EB_TOOL) is
			-- Remove item corresponding to `a_tool' from `tools_list_menu' and recycle their components.
		require
			a_tool_attached: a_tool /= Void
		local
			l_menu: like tools_list_menu
			l_menu_item: EV_MENU_ITEM
			l_data: TUPLE [menu_item: EB_COMMAND_MENU_ITEM; tool_id: STRING]
			l_develop_window: like develop_window
		do
			l_menu := tools_list_menu
			l_develop_window := develop_window
			from
				l_menu.start
			until
				l_menu.after
			loop
				l_menu_item := l_menu.item
				l_data ?= l_menu_item.data
				if l_data /= Void and then l_data.tool_id.is_equal (a_tool.title_for_pre) then
					l_menu.remove
					l_develop_window.auto_recycle (l_data.menu_item)
				else
					l_menu.forth
				end
			end
		end

	update_item_from_tools_list_menu (a_tool: EB_TOOL) is
			-- Update appearance such as title/pixmap for menu item of `a_tool' in `tools_list_menu'.
		require
			a_tool_attached: a_tool /= Void
		local
			l_menu: like tools_list_menu
			l_menu_item: EV_MENU_ITEM
			l_data: TUPLE [menu_item: EB_COMMAND_MENU_ITEM; tool_id: STRING]
			l_done: BOOLEAN
		do
			from
				l_menu := tools_list_menu
				l_menu.start
			until
				l_menu.after or l_done
			loop
				l_menu_item := l_menu.item
				l_data ?= l_menu_item.data
				if l_data /= Void and then l_data.tool_id.is_equal (a_tool.title_for_pre) then
					l_data.menu_item.set_pixmap (a_tool.pixmap)
					l_data.menu_item.set_text (a_tool.title)
					l_done := True
				else
					l_menu.forth
				end
			end
		end

feature -- Item querys

	melt_menu_item: EV_MENU_ITEM
			-- Melt menu entry

	freeze_menu_item: EV_MENU_ITEM
			-- Freeze menu entry

	finalize_menu_item: EV_MENU_ITEM
			-- Finalize menu entry

	show_favorites_menu_item: EV_MENU_ITEM
			-- Show/Hide favorites menu item.

	formatting_marks_command_menu_item: EB_COMMAND_MENU_ITEM
			-- Menu item used to shw/hide formatting marks.

feature -- Other querys

	number_of_displayed_external_commands: INTEGER
			-- Number of external commands in the tools menu.

feature{EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Settings

	set_debug_menu (a_menu: like debug_menu) is
			-- Set `debug_menu'
		do
			debug_menu := a_menu
		ensure
			set: debug_menu = a_menu
		end

	set_refactoring_menu (a_menu: like refactoring_menu) is
			-- Set `refactoring_menu'
		do
			refactoring_menu := a_menu
		ensure
			set: refactoring_menu = a_menu
		end

	set_debugging_tools_menu (a_menu: like debugging_tools_menu) is
			-- Set `debugging_tools_menu'
		do
			debugging_tools_menu := a_menu
		ensure
			set: debugging_tools_menu = a_menu
		end

	set_file_menu (a_menu: like file_menu) is
			-- Set `file_menu'
		do
			file_menu := a_menu
		ensure
			set: file_menu = a_menu
		end

	set_recent_projects_menu (a_menu: like recent_projects_menu) is
			-- Set `recent_projects_menu'
		do
			recent_projects_menu := a_menu
		ensure
			set: recent_projects_menu = a_menu
		end

	set_edit_menu (a_menu: like edit_menu) is
			-- Set `edit_menu'
		do
			edit_menu := a_menu
		ensure
			set: edit_menu = a_menu
		end

	set_tools_menu (a_menu: like tools_menu) is
			-- Set `tools_menu'
		do
			tools_menu := a_menu
		ensure
			set: tools_menu = a_menu
		end

	set_show_favorites_menu_item (a_item: like show_favorites_menu_item) is
			-- Set `show_favorites_menu_item'
		do
			show_favorites_menu_item := a_item
		ensure
			set: show_favorites_menu_item = a_item
		end

	set_project_menu (a_menu: like project_menu) is
			-- Set `project_menu'
		do
			project_menu := a_menu
		ensure
			set: project_menu = a_menu
		end

	set_view_menu (a_menu: like view_menu) is
			-- Set `view_menu'
		do
			view_menu := a_menu
		ensure
			set: view_menu = a_menu
		end

	set_window_menu (a_menu: like window_menu) is
			-- Set `a_menu'
		do
			window_menu := a_menu
		ensure
			set: window_menu = a_menu
		end

	set_help_menu (a_menu: like help_menu) is
			-- Set `help_menu'
		do
			help_menu := a_menu
		ensure
			set: help_menu = a_menu
		end

	set_favorites_menu (a_menu: like favorites_menu) is
			-- Set `favorites_menu'
		do
			favorites_menu := a_menu
		ensure
			set: favorites_menu = a_menu
		end

	set_formatting_marks_command_menu_item (a_item: like formatting_marks_command_menu_item) is
			-- Set `formatting_marks_command_menu_item'
		do
			formatting_marks_command_menu_item := a_item
		ensure
			set: formatting_marks_command_menu_item = a_item
		end

	set_number_of_displayed_external_commands (a_number: INTEGER) is
			-- Set `number_of_displayed_external_commands'
		do
			number_of_displayed_external_commands := a_number
		ensure
			set: number_of_displayed_external_commands = a_number
		end

	set_tools_list_menu (a_menu: like tools_list_menu) is
			-- Set `tools_list_menu' with `a_menu'.
		do
			tools_list_menu := a_menu
		ensure
			tools_list_menu_set: tools_list_menu = a_menu
		end

feature -- Command

	update_menu_lock_items is
			-- Update 'lock docking' and 'lock tool bar' menu items state.
		local
			l_docking_manager: SD_DOCKING_MANAGER
		do
			l_docking_manager := develop_window.docking_manager
			develop_window.commands.lock_docking_command.set_select (l_docking_manager.is_locked)
			develop_window.commands.lock_tool_bar_command.set_select (l_docking_manager.tool_bar_manager.is_locked)
			develop_window.commands.lock_editor_docking_command.set_select (l_docking_manager.is_editor_locked)
		end

	update_show_tool_bar_items is
			-- Update show/hide tool bar menu items state.
		local
			l_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			l_commands: EB_DEVELOPMENT_WINDOW_COMMANDS
			l_command: EB_SHOW_TOOLBAR_COMMAND
		do
			from
				l_contents := develop_window.docking_manager.tool_bar_manager.contents
				l_commands := develop_window.commands
				l_contents.start
			until
				l_contents.after
			loop
				l_command := l_commands.show_toolbar_commands.item (l_contents.item)

				if l_command /= Void then
					if l_contents.item.is_visible then
						l_command.enable_visible
					else
						l_command.disable_visible
					end
				end
				l_contents.forth
			end
		end

feature {NONE} -- Context menu factory

	build_context_menu_factory is
			-- Build context menu factory.
		do
			create context_menu_factory_internal.make (develop_window)
			develop_window.auto_recycle (context_menu_factory_internal)
		ensure
			context_menu_factory_internal_not_void: context_menu_factory_internal /= Void
		end

	context_menu_factory_internal: EB_CONTEXT_MENU_FACTORY

feature -- Recycle

	internal_recycle is
			-- Recycyle all menus.
		do
			if tools_menu /= Void then
				tools_menu.destroy
			end
			if window_menu /= Void then
				window_menu.destroy
			end
			if debug_menu /= Void then
				debug_menu.destroy
			end
			if refactoring_menu /= Void then
				refactoring_menu.destroy
			end
			if debugging_tools_menu /= Void then
				debugging_tools_menu.destroy
			end
			if favorites_menu /= Void then
				favorites_menu.destroy
			end
			if view_menu /= Void then
				view_menu.destroy
			end

			tools_menu := Void
			window_menu := Void
			format_menu := Void
			compile_menu := Void
			debug_menu := Void
			refactoring_menu := Void
			debugging_tools_menu := Void
			favorites_menu := Void
			view_menu := Void
			Precursor {EB_DEVELOPMENT_WINDOW_PART}
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
