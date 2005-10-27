indexing
	description: "Objects that represent a new show project settings command."
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

end -- class GB_SHOW_PROJECT_SETTINGS_COMMAND
