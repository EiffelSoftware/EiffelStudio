indexing
	description: "Simple toolbarable and menuable command.%
				%When using it, do not forget to define all the standardized fields"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_STANDARD_CMD

inherit
	GB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap
		end

feature -- Initialization

	make is
			-- Initialize `Current'.
		do
			create execute_agents.make
			name := "Default_command_name_Please_change_it"
		end

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		deferred
		ensure
			components_set: components = a_components
		end

feature -- Access

	execute_agents: LINKED_LIST [PROCEDURE [ANY, TUPLE []]]
			-- Agents that are called when `Current' is executed.

	pixmap: ARRAY [EV_PIXMAP]
			-- Icons for tool bar button representing `Current'.

	mini_pixmap: ARRAY [EV_PIXMAP]
			-- Icons for mini tool bar button representing `Current'.

	tooltip: STRING
			-- Help text displayed when associated buttons are focused.

	description: STRING
			-- Help text displayed in the customize tool bar dialog.

	menu_name: STRING
			-- Menu entry corresponding to `Current'.

	name: STRING
			-- Internal string identifier of `Current'.

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

feature -- Status setting

	set_pixmaps (new_p: ARRAY [EV_PIXMAP]) is
			-- Define pixmaps associated with `Current'.
		require
			new_p_non_void: new_p /= Void
			enough_icons: new_p.count >= 1
		do
			pixmap := new_p
		end

	set_tooltip (s: STRING) is
			-- Define a new tooltip for `Current', and possibly a new description.
		do
			tooltip := s
			if description = Void then
				description := s
			end
		end

	set_description (s: STRING) is
			-- Define a new description for `Current', and possibly a new tooltip.
		do
			description := s
			if tooltip = Void then
				tooltip := s
			end
		end

	set_accelerator (acc: EV_ACCELERATOR) is
			-- Define an accelerator for `Current'.
		do
			accelerator := acc
			if accelerator.actions.is_empty then
				accelerator.actions.extend (agent execute_if_executable)
			end
		end

	set_menu_name (s: STRING) is
			-- Define a new menu name for `Current'.
		do
			menu_name := s
		end

	set_name (s: STRING) is
			-- Define a new name for `Current'.
		do
			name := s
		end

	add_agent (a: PROCEDURE [ANY, TUPLE []]) is
			-- Extend `execute_agents' with `a'.
		do
			execute_agents.extend (a)
		end

	set_mini_pixmaps (p: ARRAY [EV_PIXMAP]) is
			-- Define the pixmaps displayed on mini buttons associated to `Current'.
		do
			mini_pixmap := p
		end

feature -- Basic operations

	execute is
			-- Call all agents associated with `Current'.
		do
			from
				execute_agents.start
			until
				execute_agents.after
			loop
				execute_agents.item.call ([])
				execute_agents.forth
			end
		end

	execute_if_executable is
			-- Call all agents associated with `Current' if
			-- executable.
		do
			if executable then
				from
					execute_agents.start
				until
					execute_agents.after
				loop
					execute_agents.item.call ([])
					execute_agents.forth
				end
			end
		end


end -- class EB_STANDARD_CMD
