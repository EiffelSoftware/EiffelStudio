indexing
	description: "Dialog Selection Box"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIALOG_SELECTION_BOX

inherit
	SELECTION_BOX

feature -- Commands

	change (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Change the value 
		require
			resource_exists: resource /= Void
		local
			com: EV_ROUTINE_COMMAND
		do
			create_tool
			create com.make(~dialog_ok)
			dialog_tool.add_ok_command(com, Void)
			dialog_tool.show
		end 

	dialog_ok (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Dialog Committing.
		require
			dialog_tool_exists: dialog_tool /= Void
		deferred 
		end

	create_tool is
		deferred 
		ensure
			tool_created: dialog_tool /= Void
		end

feature -- Implementation

	dialog_tool: EV_SELECTION_DIALOG 
		-- Tool which may be popuped from Current.

	change_b: EV_BUTTON
		-- Button

end -- class DIALOG_SELECTION_BOX
