indexing
	description: "All information about the wizard ... This class is inherited in each state "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

Creation
	make

feature  -- Initialization
	make is
		do
		
		end

feature -- Setting

	set_location (s: STRING) is
		do
			location:= s
		end

	location: STRING

end -- class WIZARD_INFORMATION
