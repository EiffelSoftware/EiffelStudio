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
			Wizard_title,
			prepare
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Prepare window.
		do
			first_window.add_help_button
			Precursor {BENCH_WIZARD_MANAGER}	
		end
		
	Wizard_title: STRING is 
			-- Window title for this wizard.
		once
			Result := Interface_names.t_Wizard_title
		end
	
end -- class WIZARD_MANAGER
