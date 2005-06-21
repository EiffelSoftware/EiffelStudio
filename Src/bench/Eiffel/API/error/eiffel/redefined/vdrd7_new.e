indexing

	description: "Feature redeclaration should have the same alias.";
	date: "$Date$";
	revision: "$Revision$"

class VDRD7_NEW

inherit
	VDRD_NEW

create {COMPILER_EXPORTER}

	make

feature -- Access

	subcode: INTEGER is 7
			-- Error subcode

end
