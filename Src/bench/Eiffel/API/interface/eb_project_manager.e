indexing
	description	: "Interface between an eiffel project and the user interface, if any."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROJECT_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

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

feature -- Status report

	is_created: BOOLEAN
			-- Is a project created?

	is_project_loaded: BOOLEAN
			-- Is a project loaded?

feature -- Basic operations

	on_project_loaded is
			-- `project' has been loaded or re-loaded.
		do
				-- Load application context (command line and breakpoints)
			Application.load_debug_info
			is_project_loaded := True

			from
				load_agents.start
			until
				load_agents.after
			loop
				load_agents.item.call (create {TUPLE}.make)
				load_agents.forth
			end
		end

	on_project_create is
			-- `project' has been created.
		require
			project_unloaded: not is_created
		do
			is_created := True
			from
				create_agents.start
			until
				create_agents.after
			loop
				create_agents.item.call (create {TUPLE}.make)
				create_agents.forth
			end
		end

	on_project_close is
			-- `project' has been closed.
		require
			project_loaded: is_created
		do
			is_project_loaded := False
			is_created := False
				-- Save breakpoint status and command line.
			Application.save_debug_info

			from
				close_agents.start
			until
				close_agents.after
			loop
				close_agents.item.call (create {TUPLE}.make)
				close_agents.forth
			end
		end

feature {NONE} -- Implementation

end -- class EB_PROJECT_MANAGER
