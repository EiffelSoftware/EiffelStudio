indexing
	description	: "All constants used in wizards for new projects for EiffelStudio"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BENCH_WIZARD_CONSTANTS

feature -- Initialization

	Bench_interface_names: BENCH_WIZARD_INTERFACE_NAMES is
			-- All string constants used in Bench wizard constants
		once
			create Result
		end

end -- class BENCH_WIZARD_CONSTANTS
