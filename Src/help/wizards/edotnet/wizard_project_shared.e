indexing
	description	: "This class is inherited by all the application"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_SHARED

inherit
	BENCH_WIZARD_SHARED

feature -- Access

	Interface_names: INTERFACE_NAMES is
			-- All manifest strings used in the interface
		once
			create Result
		end

end -- class WIZARD_PROJECT_SHARED
