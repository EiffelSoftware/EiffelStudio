indexing
	description: "Objects that represent the general tab in the project settings."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_GENERAL_TAB

inherit
	
	GB_SYSTEM_TAB

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' and build widget structure.
		local
			label: EV_LABEL
		do
			create label.make_with_text ("Project location:")
			extend (label)
			create location_field
			extend (location_field)
			location_field.disable_sensitive
			
			disable_all_items (Current)
			align_labels_left (Current)
			is_initialized := True
		end
		
feature -- Basic operation

	update_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Update all attributes of `Current' to reflect information
			-- in `project_settings'.
		do
			location_field.set_text (system_status.current_project_settings.project_location)
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		do
			-- Currently nothing to save, as fields in `Current'
			-- are not modifyable by the user.
		end	
	
feature -- Access

	name: STRING is "General"
		-- Name to be displayed for `Current'.
		
feature {GB_SYSTEM_WINDOW} -- Implementation

	validate is
			-- Validate input fields of `Current'.
		do
				-- There are no fields the user may
				-- modify in this tab, so validation
				-- must always succeed.
			validate_successful := True
		end
		
feature {NONE} -- Implementation

	location_field: EV_TEXT_FIELD
		
end -- class GB_SYSTEM_GENERAL_TAB
