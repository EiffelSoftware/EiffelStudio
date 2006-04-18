indexing
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

	Wizard_title: STRING is
			-- Window title for this wizard.
		once
			Result := "New ${FL_WIZARD_NAME} Application Wizard"
		end

	wizard_factory: APPLICATION_FACTORY is
		once
			create Result
		end

end
