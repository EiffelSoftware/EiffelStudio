indexing
	description: "Objects that represent the generation tab in the project settings."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_GENERATION_TAB

inherit
	
	GB_SYSTEM_TAB
	
	GB_NAMING_UTILITIES
		undefine
			is_equal, copy, default_create
		end
	
	GB_SHARED_TOOLS
		undefine
			is_equal, copy, default_create
		end
		
	GB_CONSTANTS

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' and build widget structure.
		local
			label: EV_LABEL
		do
			create local_check_button.make_with_text ("attribute declarations grouped?")
			extend (local_check_button)
			create attributes_local_check_button.make_with_text ("attributes declared as locals?")
			extend (attributes_local_check_button)
			create debugging_check_button.make_with_text ("Generate debugging information?")
			extend (debugging_check_button)
			create client_check_button.make_with_text ("client of EV_TITLED_WINDOW?")
			extend (client_check_button)
			is_initialized := True
			disable_all_items (Current)
			align_labels_left (Current)
		end
		
feature -- Access

	name: STRING is "Generation"
		-- Name to be displayed for `Current'.
		
feature -- Status setting

	update_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Update all attributes of `Current' to reflect information
			-- in `project_settings'.
		do
			if project_settings.grouped_locals then
				local_check_button.enable_select
			else
				local_check_button.disable_select
			end
			if project_settings.debugging_output then
				debugging_check_button.enable_select
			else
				debugging_check_button.disable_select
			end
			if project_settings.attributes_local then
				attributes_local_check_button.enable_select
			else
				attributes_local_check_button.disable_select
			end
			if project_settings.client_of_window then
				client_check_button.enable_select
			else
				client_check_button.disable_select
			end
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		do
			if local_check_button.is_selected then
				project_settings.enable_grouped_locals
			else
				project_settings.disable_grouped_locals
			end
			if debugging_check_button.is_selected then
				project_settings.enable_debugging_output
			else
				project_settings.disable_debugging_output
			end
			if attributes_local_check_button.is_selected then
				project_settings.enable_attributes_local
			else
				project_settings.disable_attributes_local
			end
			if client_check_button.is_selected then
				project_settings.enable_client_of_window
			else
				project_settings.disable_client_of_window
			end
		end	

feature {GB_SYSTEM_WINDOW} -- Implementation

	validate is
			-- Validate input fields of `Current'.
		do
				-- As we have only check buttons in `Current',
				-- their state cannot be invalid.
			validate_successful := True
		end
		

feature {NONE} -- Implementation

	local_check_button: EV_CHECK_BUTTON
		-- Should all locals be grouped per type, or on individual lines?

	attributes_local_check_button: EV_CHECK_BUTTON
		-- Should all locals be declared in `initialize' or as attributes of class?
		
	debugging_check_button: EV_CHECK_BUTTON
		-- Should debugging information be generated for events?
		
	client_check_button: EV_CHECK_BUTTON
		-- Should generated class be a client of EV_TITLED_WINDOW?

end -- class GB_SYSTEM_GENERATION_TAB
