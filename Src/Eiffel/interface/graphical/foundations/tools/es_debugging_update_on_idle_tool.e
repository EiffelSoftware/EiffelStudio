indexing
	description: "[
		A descriptor shim for all debugger tools, requiring access to the active debugger manager {ES_DEBUGGER_MANAGER}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_DEBUGGING_UPDATE_ON_IDLE_TOOL [G -> {ES_DOCKABLE_TOOL_PANEL [EV_WIDGET], ES_DEBUGGING_UPDATE_ON_IDLE_TOOL_PANEL_I}]

inherit
	ES_TOOL [G]

feature -- Access

	frozen debugger_manager: EB_DEBUGGER_MANAGER
			-- Debugger manager to use for tool creation
		do
			Result ?= window.debugger_manager
		ensure
			result_attached: Result /= Void
		end

feature {DEBUGGER_MANAGER, EB_TOOL} -- Access		

	force_update is
			-- Update now, no delay
		do
			if is_visible then
				panel.update
			end
		end

	request_update is
			-- Request an update, this should call update only
			-- once per debugging "operation"
			-- This is to avoid computing twice the data
			-- on specific cases
		do
			if is_visible then
				panel.request_update
			end
		end

	reset is
			-- Reset current's panel
		do
			if is_tool_instantiated and then panel.is_initialized then
				panel.reset_tool
			end
		end

	refresh is
			-- Call refresh on panel
		do
			if is_visible then
				panel.refresh
			end
		end

feature -- Status

	is_visible: BOOLEAN is
			--  Is Current's panel visible ?
			--| i.e: sd content exists
		do
			if is_tool_instantiated and then panel.is_initialized then
				Result := panel.is_visible
			end
		end

	shown: BOOLEAN is
			-- Is Current's panel shown on the screen?
		do
			if is_tool_instantiated and then panel.is_initialized then
				Result := panel.shown
			end
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
