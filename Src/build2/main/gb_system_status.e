indexing
	description: "Objects that represent the current status of the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_STATUS
	
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

feature {NONE} -- Implementation

	is_object_structure_changing_cell: CELL [BOOLEAN] is
			-- A cell to hold the value of `is_object_structure_changing'.
		once
			create Result
		end

end -- class GB_SYSTEM_STATUS
