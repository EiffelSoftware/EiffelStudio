indexing

	description: "Features with different alias names cannot be joined.";
	date: "$Date$";
	revision: "$Revision$"

class VDJR2_NEW

inherit
	FEATURE_CONFLICT_ERROR
		redefine
			help_file_name,
			subcode
		end

create {COMPILER_EXPORTER}

	make

feature -- Access

	code: STRING is "VDJR2 (ECMA)"
			-- Error code

	subcode: INTEGER is 2
			-- Error subcode

	help_file_name: STRING is "VDJR_ECMA"
			-- Associated file name where error explanation is located

end
