indexing
	description	: "Class which is launching the application."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_WIZARD_PROJECT_MANAGER

inherit
	WIZARD_PROJECT_MANAGER
		redefine
			Wizard_title,
			prepare
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Prepare the first window to be displayed.
		do
			Precursor
		end

	Wizard_title: STRING is 
			-- Window title for this wizard.
		once
			Result := "New WEL Application Wizard"
		end
	
end -- class WEL_WIZARD_PROJECT_MANAGER
