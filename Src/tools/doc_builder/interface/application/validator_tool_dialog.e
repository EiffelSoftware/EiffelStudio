indexing
	description: "Dialog for performaing validation tasks on projects."
	date: "$Date$"
	revision: "$Revision$"

class
	VALIDATOR_TOOL_DIALOG

inherit
	VALIDATOR_TOOL_DIALOG_IMP

	SHARED_OBJECTS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			apply_bt.select_actions.extend (agent apply)
			okay_bt.select_actions.extend (agent okay)
			cancel_bt.select_actions.extend (agent cancel)
			link_radio.select_actions.extend (agent radio_selected)
			schema_radio.select_actions.extend (agent radio_selected)
		end

feature {NONE} -- Implementation

	apply is
			-- Apply
		do
			run
		end
		
	okay is
			-- Okay
		do
			run
			hide
		end
		
	cancel is
			-- Cancel
		do
			hide			
		end

	run is
			-- Run
		do
			if schema_radio.is_selected then
				Shared_project.validate_files
			else
				Shared_project.validate_links
			end
		end

feature {NONE}  -- Events

	radio_selected is
			-- Radio was selected
		do
			if link_radio.is_selected then
				link_check.enable_sensitive
				images_check.enable_sensitive
			else
				link_check.disable_sensitive
				images_check.disable_sensitive
			end			
		end

end -- class VALIDATOR_TOOL_DIALOG

