indexing
	description: "VFAV(4) error detected at parsing time."
	date: "$Date$"
	revision: "$Revision$"

class VFAV4_SYNTAX

inherit
	VFAV_SYNTAX

create 
	make

feature -- Access

	subcode: INTEGER is 4
			-- Error subcode

end