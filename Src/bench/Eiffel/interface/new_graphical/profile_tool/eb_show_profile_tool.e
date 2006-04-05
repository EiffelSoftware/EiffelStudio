indexing

	description:
		"Command to show the profile tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

end -- class EB_SHOW_PROFILE_TOOL
