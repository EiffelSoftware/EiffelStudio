indexing
	description: "All user definable parameters for the debugger."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_DATA

inherit
	ES_TOOLBAR_PREFERENCE

feature -- Access

	stack_element_width: INTEGER is
		do
			Result := integer_resource_value ("debugger__stack_element_width", 200)
		end

	default_maximum_stack_depth: INTEGER is
		do
			Result := integer_resource_value ("debugger__default_maximum_stack_depth", 100)
		end

	show_text_in_project_toolbar: BOOLEAN is
			-- Show selected text in the project toolbar?
		do
			Result := boolean_resource_value ("debugger__show_text_in_project_toolbar", False)
		end

	display_dotnet_cmd: BOOLEAN is
			-- Should we display the .Net command? (ie is the user either Raphael or Karine?)
		do
			Result := boolean_resource_value ("display_dotnet_cmd", False)
		end
	
	retrieve_project_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, project_toolbar_layout)
			if boolean_resource_value ("debugger__show_text_in_project_toolbar", False) then
				Result.enable_text_displayed
			end

		end

	save_project_toolbar (project_toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_resources' to have the changes actually saved.
		do
			set_array ("debugger__project_toolbar_layout", save_toolbar (project_toolbar))
			set_boolean ("debugger__show_text_in_project_toolbar", project_toolbar.is_text_displayed)
		end

feature {NONE} -- Implementation

	project_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := array_resource_value ("debugger__project_toolbar_layout", <<"Clear_bkpt__visible">>)
		end

end -- class EB_DEBUGGER_DATA
