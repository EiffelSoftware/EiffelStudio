indexing
	description	: "Interface between an eiffel project and the user interface, if any."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROJECT_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

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
					edition_agents.item.call ([])
					edition_agents.forth
				end
			end
		end

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
				compile_start_agents.item.call ([])
				compile_start_agents.forth
			end
		end

	on_project_recompiled is
			-- `project' ends a compilation (not necessarily successfully).
		require
			project_created: is_created
		do
			from
				compile_stop_agents.start
			until
				compile_stop_agents.after
			loop
				compile_stop_agents.item.call ([])
				compile_stop_agents.forth
			end
		end

end -- class EB_PROJECT_MANAGER
