indexing
	description: "VFAV(1) error detected at parsing time."
	date: "$Date$"
	revision: "$Revision$"

class VFAV1_SYNTAX

inherit
	VFAV_SYNTAX

create 
	make

feature -- Access

	subcode: INTEGER is 1
			-- Error subcode

end