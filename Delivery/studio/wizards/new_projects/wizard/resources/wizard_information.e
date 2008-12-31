note
	description: "All information about the wizard ... This class is inherited in each state "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	WIZARD_STATE_DATA

create
	make

feature  -- Initialization
	make
		do
		
		end

feature -- Setting

	set_location (s: STRING)
		do
			location:= s
		end

	location: STRING

end -- class WIZARD_INFORMATION
