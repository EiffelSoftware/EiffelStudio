note
	description: "Wizard starting point."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	WIZARD_PROJECT_MANAGER
		redefine
			Wizard_title
		end

create
	make_and_launch

feature -- Initialization

	Wizard_title: STRING_32
			-- Window title for this wizard.
		once
			Result := {STRING_32} "New ${FL_WIZARD_NAME} Application Wizard"
		end

	wizard_factory: APPLICATION_FACTORY
		once
			create Result
		end

end
