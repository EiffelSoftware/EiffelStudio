indexing
	description: "Dialog Selection Box"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIALOG_SELECTION_BOX

inherit
	SELECTION_BOX

feature -- Commands

	change is
			-- Change the value 
		require
			resource_exists: resource /= Void
		do
			create_tool
			dialog_tool.ok_actions.extend (~update_changes)
			dialog_tool.show_modal_to_window (caller)
		end 

	update_changes is
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

	dialog_tool: EV_STANDARD_DIALOG 
		-- Tool which may be popuped from Current.

	change_b: EV_BUTTON
		-- Button

end -- class DIALOG_SELECTION_BOX
