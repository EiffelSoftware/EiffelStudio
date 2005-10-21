indexing
	description: "Cancel any current project executions."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_CANCEL_COMMAND

inherit
	EB_MENUABLE_COMMAND
		redefine
			default_create
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create
		end

feature {NONE} -- Initialization

	 default_create is
	 		-- Make and initialize command.
	 	do
	 		Precursor
			accelerator := create {EV_ACCELERATOR}.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_pause), True, False, False
			)
			accelerator.actions.extend (agent execute)
		end

feature -- Execution

	execute is
			-- Execute the command.
		do
			Degree_output.user_has_requested_cancellation
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := interface_names.B_cancel
		end	
	
end
