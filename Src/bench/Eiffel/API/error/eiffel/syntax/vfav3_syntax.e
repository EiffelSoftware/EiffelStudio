indexing
	description: "VFAV(3) error detected at parsing time."
	date: "$Date$"
	revision: "$Revision$"

class VFAV3_SYNTAX

inherit
	VFAV_SYNTAX

create 
	make

feature -- Access

	subcode: INTEGER is 3
			-- Error subcode

end