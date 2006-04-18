indexing
	description: "Factory for creating initial state of wizard and information."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_FACTORY

feature -- Factory

	new_wizard_initial_state: WIZARD_STATE_WINDOW is
			-- New initial state for wizard.
		deferred
		ensure
			new_wizard_initial_state_not_void: Result /= Void
		end

end
