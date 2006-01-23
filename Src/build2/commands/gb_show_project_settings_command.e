indexing
	description: "Objects that represent a new show project settings command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHOW_PROJECT_SETTINGS_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
			set_tooltip ("Settings...")
			set_pixmaps (<<(create {GB_SHARED_PIXMAPS}).icon_system_window>>)
			set_name ("Settings...")
			set_menu_name ("Settings...")
		end

feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only may be executed if the project settings window is
				-- not displayed. There must also be a project open.
			Result := components.system_status.project_open and then (not components.tools.project_settings_window.is_show_requested)

		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			do
					-- Disable all other floating windows.
				components.tools.all_floating_tools.do_all (agent {EV_DIALOG}.disable_sensitive)
					-- We must modify the icon displayed in `project_settings_window' dependent on
					-- whether other tools are all displayed
				if components.system_status.tools_always_on_top then
					components.tools.project_settings_window.set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
				else
					components.tools.project_settings_window.set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).icon_system_window)
				end
				components.tools.project_settings_window.show_modal_to_window (components.tools.main_window)
				components.tools.all_floating_tools.do_all (agent {EV_DIALOG}.enable_sensitive)
					-- Enable all other floating windows.
				components.commands.update
			end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_SHOW_PROJECT_SETTINGS_COMMAND
