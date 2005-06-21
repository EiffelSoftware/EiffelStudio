indexing

	description: "[
		Feature redeclaration assigner command should not be
		different from precursor's assigner command.
	]";
	date: "$Date$";
	revision: "$Revision$"

class VDRD8_NEW

inherit
	VDRD_NEW

create {COMPILER_EXPORTER}

	make

feature -- Access

	subcode: INTEGER is 8
			-- Error subcode

end
