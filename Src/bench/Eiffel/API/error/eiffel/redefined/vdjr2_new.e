indexing

	description: "Features with different alias names cannot be joined.";
	date: "$Date$";
	revision: "$Revision$"

class VDJR2_NEW

inherit
	VDJR_NEW

create {COMPILER_EXPORTER}

	make

feature -- Access

	subcode: INTEGER is 2
			-- Error subcode

end
