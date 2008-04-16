indexing
	description	: "Interface between an eiffel project and the user interface, if any."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROJECT_MANAGER

create
	make

feature -- Initialization

	make (a_project: E_PROJECT) is
			-- Associate `Current' with `a_project'.
		require
			a_project_not_void: a_project /= Void
		do
			project := a_project
			create load_agents
			create close_agents
			create create_agents
			create compile_start_agents
			create compile_stop_agents
		ensure
			project_set: project = a_project
		end

feature -- Access

	initialized: BOOLEAN is
			-- Has `project' been initialized?
		do
			Result := project.initialized
		end

	project: E_PROJECT
			-- Actual Eiffel project associated with `Current'.

feature -- Event handlers

	load_agents: ACTION_SEQUENCE [TUPLE]
			-- Agents called when the associated project is retrieved.

	close_agents: ACTION_SEQUENCE [TUPLE]
			-- Agents called when the associated project is closed.

	create_agents: ACTION_SEQUENCE [TUPLE]
			-- Agents called when the associated project is created.

	compile_start_agents: ACTION_SEQUENCE [TUPLE]
			-- Agents called when the associated project starts compiling.

	compile_stop_agents: ACTION_SEQUENCE [TUPLE]
			-- Agents called when the associated project finishes compiling.

feature -- Status report

	is_created: BOOLEAN
			-- Is a project created?

	is_project_loaded: BOOLEAN
			-- Is a project loaded?

feature -- Basic operations

	on_project_loaded is
			-- `project' has been loaded or re-loaded.
		local
			l_load_agents: like load_agents
		do
			is_project_loaded := True
					-- We need to twin the list as items may be removed as a result or iteration.
			l_load_agents := load_agents.twin
			l_load_agents.call (Void)
		end

	on_project_create is
			-- `project' has been created.
		require
			project_unloaded: not is_created
		local
			l_create_agents: like create_agents
		do
			if project.project_directory.is_lock_file_present then
				-- Handle error
			end
			project.project_directory.create_lock_file
			is_created := True
				-- We need to twin the list as items may be removed as a result or iteration.
			l_create_agents := create_agents.twin
			l_create_agents.call (Void)
		end

	on_project_close is
			-- `project' has been closed.
		require
			project_loaded: is_created
		local
			l_close_agents: like close_agents
		do
			project.project_directory.delete_lock_file
			is_project_loaded := False
			is_created := False

				-- We need to twin the list as items may be removed as a result or iteration.
			l_close_agents := close_agents.twin
			l_close_agents.call (Void)
		end

	on_project_compiles is
			-- `project' starts a new compilation.
		require
			project_created: is_created
		do
			compile_start_agents.call (Void)
		end

	on_project_recompiled (is_successful: BOOLEAN) is
			-- `project' ends a compilation (not necessarily successfully).
		require
			project_created: is_created
		do
			compile_stop_agents.call ([is_successful])
		end

invariant
	project_not_void: project /= Void

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

end -- class EB_PROJECT_MANAGER
