indexing

	description:
		"Command to show the profile tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_PROFILE_TOOL

inherit
	EB_SHARED_INTERFACE_TOOLS
	EB_MENUABLE_COMMAND
	EB_CONSTANTS

feature -- Access

	menu_name: STRING is
			-- Menu entry associated with `Current'.
		do
			Result := Interface_names.m_Profile_tool
		end

feature -- Execution

	execute is
		local
--			p_win: EB_PROFILE_WINDOW
			wizard_manager: EB_PROFILER_WIZARD_MANAGER
		do
--|----------------------------------------------------------------------------------------
--| FIXME ARNAUD: To be removed if we are sure we don't want the profiler window anymore.
--|----------------------------------------------------------------------------------------
--			if not profiler_is_valid then
--				create p_win.make
--				set_profiler_window (p_win)
--			end
--			profiler_window.raise
--|----------------------------------------------------------------------------------------
			create wizard_manager.make_and_launch (window_manager.last_focused_development_window.window)
		end

end -- class EB_SHOW_PROFILE_TOOL
