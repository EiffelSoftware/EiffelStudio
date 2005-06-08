indexing

	description: "Feature redeclaration should have the same alias.";
	date: "$Date$";
	revision: "$Revision$"

class VDRD7_NEW

inherit
	FEATURE_CONFLICT_ERROR
		redefine
			help_file_name,
			subcode
		end

create {COMPILER_EXPORTER}

	make

feature -- Access

	code: STRING is "VDRD7 (ECMA)"
			-- Error code

	subcode: INTEGER is 7
			-- Error subcode

	help_file_name: STRING is "VDRD_ECMA"
			-- Associated file name where error explanation is located

end
