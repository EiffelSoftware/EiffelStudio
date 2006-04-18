indexing
	description: "Factory for compiler wizard."
	date: "$Date$"
	revision: "$Revision$"

class
	PRECOMPILE_WIZARD_FACTORY

inherit
	WIZARD_FACTORY

feature -- Factory

	new_wizard_initial_state: WIZARD_INITIAL_STATE is
			-- New initial state for wizard.
		do
			create Result.make (create {WIZARD_INFORMATION}.make)
		end

end
