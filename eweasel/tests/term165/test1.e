note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST1

inherit
	TEST2
		redefine
			initialize
		end

feature

	initialize
		do
			Precursor
		end

end
