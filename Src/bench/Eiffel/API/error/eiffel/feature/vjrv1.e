indexing
	description: "Error for invalid reverse assignment attempt."
	date: "$Date$"
	revision: "$Revision$"

class
	VJRV1

inherit
	VJRV
		redefine
			subcode
		end

feature -- Properties

	subcode: INTEGER is 1

end -- class VJRV1
