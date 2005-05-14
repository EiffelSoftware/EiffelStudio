indexing
	description: "VFAV(2) error detected at parsing time."
	date: "$Date$"
	revision: "$Revision$"

class VFAV2_SYNTAX

inherit
	VFAV_SYNTAX

create 
	make

feature -- Access

	subcode: INTEGER is 2
			-- Error subcode

end