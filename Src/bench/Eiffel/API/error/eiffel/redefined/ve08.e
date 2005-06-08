indexing

	description: "[
		Feature redeclaration assigner command should not be
		different from precursor's assigner command.
	]";
	date: "$Date$";
	revision: "$Revision$"

class VE08
	obsolete "Not defined in the standard"

inherit
	FEATURE_CONFLICT_ERROR

create {COMPILER_EXPORTER}

	make

feature -- Access

	code: STRING is "VE08"
			-- Error code

end
