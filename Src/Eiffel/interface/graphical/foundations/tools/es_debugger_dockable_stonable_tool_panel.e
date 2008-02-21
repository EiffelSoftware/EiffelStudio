indexing
	description: "[
		An EiffelStudio dockable debugging tool panel, allowing a context stone to be pushed, base implementation for EiffelStudio tools.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL [G -> EV_WIDGET]

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [G]
		redefine
			tool_descriptor
		end

	DEBUGGING_UPDATE_ON_IDLE

feature {ES_DEBUGGER_STONABLE_TOOL, DEBUGGER_MANAGER} -- Access

	reset_tool is
			-- Reset tool
		deferred
		end

	refresh is
			-- Refresh tool
		deferred
		end

feature {NONE} -- Access

	tool_descriptor: ES_DEBUGGER_STONABLE_TOOL [like Current]
			-- Descriptor used to created tool.

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
