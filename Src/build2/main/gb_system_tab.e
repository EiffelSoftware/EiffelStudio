indexing
	description: "Objects that represent a tab for the project settings."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_SYSTEM_TAB

inherit

	EV_VERTICAL_BOX
		undefine
			is_in_default_state,
			initialize
		end
		
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_SYSTEM_STATUS
		undefine
			default_create, copy, is_equal
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy, is_equal
		end
		
feature -- Basic operation.

	update_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Update all attributes of `Current' to reflect information
			-- in `project_settings'.
		require
			project_settings_not_void: project_settings /= Void
		deferred
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		require
			project_settings_not_void: project_settings /= Void
		deferred
		end
		
	validate is
			-- Check all fields for valid input.
		require
			parented: parent /= Void
		deferred
		end
		
	validate_successful: BOOLEAN
		-- Was the last call to `validate' succesful?
		
feature {NONE} -- Implementation

	select_in_parent is
			-- Ensure `Current' is the visible
			-- tab in `parent'.
		local
			notebook_parent: EV_NOTEBOOK
		do
			notebook_parent ?= parent
			check
				parent_is_a_notebook: notebook_parent /= Void
			end
			notebook_parent.select_item (Current)
		end

end -- class GB_SYSTEM_TAB
