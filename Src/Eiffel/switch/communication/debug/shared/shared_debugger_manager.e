indexing
	description: "Objects that shared an instance of DEBUGGER_MANAGER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	SHARED_DEBUGGER_MANAGER

inherit
	SHARED_EIFFEL_PROJECT

feature -- Access

	Debugger_manager: DEBUGGER_MANAGER is
			-- Manager in charge of debugging operations.
		do
			Result := Debugger_manager_cell.item
			if Result = Void then
				Result := (create {DEBUGGER_MANAGER_FACTORY}).new_default_debugger_manager
				set_debugger_manager (Result)
			end
		ensure
			debugger_manager_not_void: Result /= Void
		end

	Breakpoints_manager: BREAKPOINTS_MANAGER is
		do
			Result := Debugger_manager.breakpoints_manager
		end

	set_debugger_manager (v: like debugger_manager) is
		do
			Debugger_manager_cell.replace (v)
			debugger_manager_change_actions.call ([v])
		ensure
			Debugger_manager_is_set: Debugger_manager = v
		end

feature {NONE} -- Cell

	Debugger_manager_change_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]] is
			-- Actions executed when current active shared debugger_manager is changed.
		once
			create Result
		end

	Debugger_manager_cell: CELL [DEBUGGER_MANAGER] is
			-- Manager in charge of debugging operations.
		once
			create Result.put (Void)

			--| FIXME:jfiat:2008-01-04: find a better place for those agents setting
			Eiffel_project.Manager.load_agents.extend (agent debugger_on_project_loaded)
			Eiffel_project.Manager.close_agents.extend (agent debugger_on_project_closed)
			Eiffel_project.Manager.compile_stop_agents.extend (agent debugger_on_project_recompiled)
			if Eiffel_project.manager.is_project_loaded then
				debugger_on_project_loaded
			end
		end

	debugger_on_project_loaded is
			-- Propagate `Project loaded' event to `debugger_manager'
		local
			dm: like Debugger_manager
		do
				-- Load application context (command line and breakpoints)
			dm := Debugger_manager_cell.item
			if dm /= Void then
				dm.load_debugger_data
			end
		end

	debugger_on_project_closed is
			-- Propagate `Project closed' event to `debugger_manager'
		local
			dm: like Debugger_manager
		do
				-- Save application context (command line and breakpoints)
			dm := Debugger_manager_cell.item
			if dm /= Void then
				dm.save_debugger_data
			end
		end

	debugger_on_project_recompiled (is_successful: BOOLEAN) is
			-- Propagate `Project recompiled' event to `debugger_manager'
		local
			dm: like Debugger_manager
		do
			dm := Debugger_manager_cell.item
			if dm /= Void then
				dm.on_project_recompiled (is_successful)
			end
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
