indexing

	description: "Assigner commands of joined features should be the same.";
	date: "$Date$";
	revision: "$Revision$"

class VE09
	obsolete "Not defined in the standard"

inherit
	FEATURE_CONFLICT_ERROR

create {COMPILER_EXPORTER}

	make

feature -- Access

	code: STRING is "VE09"
			-- Error code

end
