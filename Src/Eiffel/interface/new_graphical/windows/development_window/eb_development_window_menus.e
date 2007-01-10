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

feature -- Item querys

	melt_menu_item: EV_MENU_ITEM
			-- Melt menu entry

	freeze_menu_item: EV_MENU_ITEM
			-- Freeze menu entry

	finalize_menu_item: EV_MENU_ITEM
			-- Finalize menu entry

	show_favorites_menu_item: EV_MENU_ITEM
			-- Show/Hide favorites menu item.

feature{EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Settings

	set_debug_menu (a_menu: like debug_menu) is
			-- Set `debug_menu'
		do
			debug_menu := a_menu
		ensure
			set: debug_menu = a_menu
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

feature -- Recycle

	recycle_menus is
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
			debugging_tools_menu := Void
			favorites_menu := Void
			view_menu := Void
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
