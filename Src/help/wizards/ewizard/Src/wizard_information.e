indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "davids"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize
		do
			Precursor
			number_state := 1
		end

feature -- Access

	number_state: INTEGER
			-- Number of states in the wizard

feature -- Element change

	set_number_state (a_number_state: INTEGER) is
			-- Set the number of states in the wizard to `a_number_state'
		do
			number_state := a_number_state
		end

end -- class WIZARD_INFORMATION
