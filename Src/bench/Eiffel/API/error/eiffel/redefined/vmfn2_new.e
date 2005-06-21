indexing

	description: "Features with different alias names cannot be shared.";
	date: "$Date$";
	revision: "$Revision$"

class VMFN2_NEW

inherit
	FEATURE_CONFLICT_ERROR
		redefine
			subcode
		end

create {COMPILER_EXPORTER}

	make

feature -- Access

	code: STRING is "ECMA-VMFN"
			-- Error code

	subcode: INTEGER is 2
			-- Error subcode

end
