indexing
	description: "All shared attributes specific to the context tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_TOOL_DATA

inherit
	ES_TOOLBAR_PREFERENCE

feature -- Access

	retrieve_diagram_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, diagram_toolbar_layout)
		end

	save_diagram_toolbar (toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_resources' to have the changes actually saved.
		do
			set_array_resource ("diagram__toolbar_layout", save_toolbar (toolbar))
		end

feature {NONE} -- Implementation

	diagram_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := array_resource_value ("diagram__toolbar_layout", <<"Clear_bkpt__visible">>)
		end

end -- class EB_CONTEXT_TOOL_DATA

