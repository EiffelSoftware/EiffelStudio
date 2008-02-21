indexing
	description: "[
		An EiffelStudio debugging tool panel.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_DEBUGGING_UPDATE_ON_IDLE_TOOL_PANEL_I

inherit
	DEBUGGING_UPDATE_ON_IDLE

feature {ES_DEBUGGER_STONABLE_TOOL, ES_DEBUGGING_UPDATE_ON_IDLE_TOOL} -- Status

	is_visible: BOOLEAN is
			-- Is panel visible ?
		do
			Result := content /= Void and then content.is_visible
		end

feature {ES_DEBUGGER_STONABLE_TOOL, ES_DEBUGGING_UPDATE_ON_IDLE_TOOL, DEBUGGER_MANAGER} -- Access

	reset_tool is
			-- Reset tool
		deferred
		end

	refresh is
			-- Refresh tool
		deferred
		end

feature -- Access

	content: SD_CONTENT is
			-- Docking content
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
