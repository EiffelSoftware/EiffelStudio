indexing

	description: "Features with different alias names cannot be shared.";
	date: "$Date$";
	revision: "$Revision$"

class VE06
	obsolete "Not defined in the standard"

inherit
	DIFFERENT_ALIAS_ERROR

create {COMPILER_EXPORTER}

	make

feature -- Access

	code: STRING is "VE06"
			-- Error code

end
