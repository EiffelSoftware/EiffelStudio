indexing
	description: "Objects that represent the current status of the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_STATUS

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
		ensure
			components_set: components = a_components
		end

feature -- Access

	current_project_settings: GB_PROJECT_SETTINGS
		-- Information regarding the current project in the system.
		-- `Void' if none.

	project_open: BOOLEAN is
			-- Is there a project currently in the system?
		do
			Result := not (current_project_settings = Void)
		end

	project_modified: BOOLEAN
		-- Has `Current' been modified?
		-- Used to enable/disable the save button and other
		-- operations dependent on the user having modified something.

	tools_always_on_top: BOOLEAN
		-- Should all windows containing tools be shown modelessly
		-- to the main window. Otherwise, they are independent.

	loading_project: BOOLEAN
		-- Is the loading of a project currently underway?

	pick_and_drop_pebble: ANY

feature -- Status setting

	enable_loading_project is
			-- Ensure `loading_project' is True
		do
			loading_project := True
		ensure
			project_loading: loading_project
		end

	disable_loading_project is
			-- Ensure `loading_project' is False
		do
			loading_project := False
		ensure
			project_not_loading: not loading_project
		end

	set_current_project (new_project_settings: GB_PROJECT_SETTINGS) is
			-- Assign `new_project_settings' to `current_project_settings'.
		require
			no_project_open: not project_open
		do
			current_project_settings := new_project_settings
		end

	close_current_project is
			-- Assign `Void' to `current_project_settings'.
		require
			project_open: project_open
		do
			current_project_settings := Void
			disable_project_modified
		end

	enable_project_modified is
			-- Assign `True' to `project_modified'.
		do
			project_modified := True
		end

	disable_project_modified is
			-- Assign `False' to `project_modfied'.
		do
			project_modified := False
		end

	enable_tools_always_on_top is
			-- Assign `True' to `tools_always_on_top'.
		do
			tools_always_on_top := True
		end

	disable_tools_always_on_top is
			-- Assign `False' to `tools_always_on_top'.
		do
			tools_always_on_top := False
		end

	is_object_structure_changing: BOOLEAN is
			-- Are we currently in the process of changing the structure of an object?
			-- Some assertions may only be checked if we are not currently changing
			-- the structure.
		do
			Result := is_object_structure_changing_cell.item
		end

	set_object_structure_changing is
			-- Ensure `is_object_structure_changing' returns `True'.
		do
			is_object_structure_changing_cell.put (True)
		ensure
			is_object_structure_changing: is_object_structure_changing
		end

	set_object_structure_changed is
			-- Ensure `is_object_structure_changing' returns `False'.
		do
			is_object_structure_changing_cell.put (False)
		ensure
			not_is_object_structure_changing: not is_object_structure_changing
		end

	is_in_debug_mode: BOOLEAN
		-- Is `EiffelBuild' currently enabled for debugging?

	enable_debug_mode is
			-- Ensure `is_in_debug_mode' is `True'.
		do
			is_in_debug_mode := True
		ensure
			is_in_debug_mode: is_in_debug_mode
		end

	set_pick_and_drop_pebble (a_pebble: ANY) is
			-- Assign `a_pebble' to `pick_and_drop_pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		do
			pick_and_drop_pebble := a_pebble
		ensure
			pebble_set: pick_and_drop_pebble = a_pebble
		end

	remove_pick_and_drop_pebble is
			-- Ensure `pick_and_drop_pebble' = Void
		do
			pick_and_drop_pebble := Void
		ensure
			pebble_void: pick_and_drop_pebble = Void
		end

feature -- Access

	is_blocked: BOOLEAN

feature -- Status setting

	block is
			-- Block all further changes to status until `resume' is called.
		do
			is_blocked := True
		ensure
			is_blocked: is_blocked
		end

	resume is
			-- Resume changes to status (undo a call to `block')
		do
			is_blocked := False
		ensure
			not_is_blocked: not is_blocked
		end

	mark_as_dirty is
			-- If not `is_blocked' then mark project as modified.
		do
			if not is_blocked then
				enable_project_modified
				components.commands.update
				components.events.project_cleaned_actions.call (Void)
			end
		end

	mark_as_clean is
			-- If not `is_blocked' then mark project as unmodified.
		do
			if not is_blocked then
				disable_project_modified
				components.commands.update
				components.events.project_cleaned_actions.call (Void)
			end
		end

feature {NONE} -- Implementation

	is_object_structure_changing_cell: CELL [BOOLEAN] is
			-- A cell to hold the value of `is_object_structure_changing'.
		once
			create Result
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


end -- class GB_SYSTEM_STATUS
