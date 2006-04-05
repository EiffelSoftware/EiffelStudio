indexing
	description: "Simple toolbarable and menuable command.%
				%When using it, do not forget to define all the standardized fields"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- class EB_STANDARD_CMD
