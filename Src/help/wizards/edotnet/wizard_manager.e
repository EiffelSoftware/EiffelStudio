indexing
	description	: "Class which is launching the application."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_MANAGER

inherit
	BENCH_WIZARD_MANAGER
		redefine
			Wizard_title
		end

create
	make_and_launch

feature -- Initialization

	Wizard_title: STRING is 
			-- Window title for this wizard.
		once
			Result := Interface_names.t_Wizard_title
		end
	
end -- class WIZARD_MANAGER
