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
			number_state:= 1
			location:= " "
			wizard_name:= " "
		end

	set_number_state (i: INTEGER) is
		do
			number_state:= i
		end

	set_location (s: STRING) is
		do
			location:= s
		end

	set_wizard_name (s: STRING) is
		do
			wizard_name:= s
		end

	number_state: INTEGER

	location, wizard_name: STRING

feature -- Setting



end -- class WIZARD_INFORMATION
