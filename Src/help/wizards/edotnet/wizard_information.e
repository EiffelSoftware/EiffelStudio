indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

create
	make

feature  -- Initialization

	make is
			-- Assign default values
		do
			Precursor
			icon_location := wizard_resources_path + "\eiffel.ico"
		end

feature -- Setting

	set_icon_location (s: STRING) is
		do
			icon_location := s
		end

feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
	
end -- class WIZARD_INFORMATION
