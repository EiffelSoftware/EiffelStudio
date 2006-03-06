indexing
	description	: "Interface between an eiffel project and the user interface, if any."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROJECT_MANAGER

inherit
	EB_SHARED_DEBUG_TOOLS

	EB_SHARED_INTERFACE_TOOLS

create
	make

feature -- Initialization

	make (a_project: E_PROJECT) is
			-- Associate `Current' with `a_project'.
		do
			project := a_project
			create load_agents.make (10)
			create close_agents.make (10)
			create create_agents.make (10)
			create edition_agents.make (10)
			create compile_start_agents.make (10)
			create compile_stop_agents.make (10)
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

	load_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Agents called when the associated project is retrieved.

	close_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Agents called when the associated project is closed.

	create_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Agents called when the associated project is created.

	edition_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Agents called when the associated project is edited for the first time after a compilation.

	compile_start_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Agents called when the associated project starts compiling.

	compile_stop_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Agents called when the associated project finishes compiling.

feature -- Status report

	is_created: BOOLEAN
			-- Is a project created?

	is_project_loaded: BOOLEAN
			-- Is a project loaded?

	has_edited_classes: BOOLEAN
			-- Have some classes been edited since last compilation was launched?
			-- In that case we might need to recompile to take the changes into account.

feature -- Status setting

	class_is_edited (ci: CLASS_I) is
			-- Add `ci' to the list of classes that were edited since last compilation.
		do
			if not has_edited_classes then
				has_edited_classes := True
				from
					edition_agents.start
				until
					edition_agents.after
				loop
					edition_agents.item.call (Void)
					edition_agents.forth
				end
			end
		end

feature -- Basic operations

	on_project_loaded is
			-- `project' has been loaded or re-loaded.
		local
			l_load_agents: like load_agents
		do
				-- Load application context (command line and breakpoints)
			Debugger_manager.load_debug_info
			is_project_loaded := True

			from
					-- We need to twin the list as items may be removed as a result or iteration.
				l_load_agents := load_agents.twin
				l_load_agents.start
			until
				l_load_agents.after
			loop
				l_load_agents.item.call (Void)
				l_load_agents.forth
			end
		end

	on_project_create is
			-- `project' has been created.
		require
			project_unloaded: not is_created
		local
			l_create_agents: like create_agents
		do
			is_created := True
			from
					-- We need to twin the list as items may be removed as a result or iteration.
				l_create_agents := create_agents.twin
				l_create_agents.start
			until
				l_create_agents.after
			loop
				l_create_agents.item.call (Void)
				l_create_agents.forth
			end
		end

	on_project_close is
			-- `project' has been closed.
		require
			project_loaded: is_created
		local
			l_close_agents: like close_agents
		do
			is_project_loaded := False
			is_created := False
				-- Save breakpoint status and command line.
			Debugger_manager.save_debug_info

			from
					-- We need to twin the list as items may be removed as a result or iteration.
				l_close_agents := close_agents.twin
				l_close_agents.start
			until
				l_close_agents.after
			loop
				l_close_agents.item.call (Void)
				l_close_agents.forth
			end
		end

	on_project_compiles is
			-- `project' starts a new compilation.
		require
			project_created: is_created
		do
			has_edited_classes := has_modified_classes
			from
				compile_start_agents.start
			until
				compile_start_agents.after
			loop
				compile_start_agents.item.call (Void)
				compile_start_agents.forth
			end
		end

	on_project_recompiled (is_successful: BOOLEAN) is
			-- `project' ends a compilation (not necessarily successfully).
		require
			project_created: is_created
		do
			from
				compile_stop_agents.start
			until
				compile_stop_agents.after
			loop
				compile_stop_agents.item.call (Void)
				compile_stop_agents.forth
			end

			if is_successful then
					-- Save breakpoint status and command line.
				Debugger_manager.save_debug_info
			end
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

end -- class EB_PROJECT_MANAGER
