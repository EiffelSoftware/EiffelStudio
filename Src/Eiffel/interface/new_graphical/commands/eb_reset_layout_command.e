indexing
	description	: "Command to reset docking layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_RESET_LAYOUT_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initlization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		require
			not_void: a_develop_window /= Void
		do
			develop_window := a_develop_window
			enable_sensitive
		ensure
			set: develop_window = a_develop_window
		end

feature -- Command

	execute is
			-- Reset to default docking layout
		local
			l_graphical_debugger: EB_DEBUGGER_MANAGER
			l_pointer_style: EV_POINTER_STYLE
			l_stock_pixmaps: EV_STOCK_PIXMAPS
		do
			l_graphical_debugger ?= debugger_manager
			if l_graphical_debugger /= Void then
				l_pointer_style := develop_window.window.pointer_style
				create l_stock_pixmaps
				develop_window.window.set_pointer_style (l_stock_pixmaps.busy_cursor)
				if l_graphical_debugger.application_is_executing then
					l_graphical_debugger.restore_standard_debug_docking_layout
				else
					develop_window.restore_standard_tools_docking_layout
				end
				develop_window.window.set_pointer_style (l_pointer_style)
			end
		end

feature -- Query

	menu_name: STRING_GENERAL is
			-- Menu name
		do
			Result := interface_names.m_reset_layout
		end


feature {NONE} -- Implementation

	develop_window: EB_DEVELOPMENT_WINDOW;
			-- Developement window.

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

end -- class EB_RESET_LAYOUT_COMMAND
