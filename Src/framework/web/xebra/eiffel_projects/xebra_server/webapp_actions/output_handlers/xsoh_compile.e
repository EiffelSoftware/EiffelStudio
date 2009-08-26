note
	description: "[
		Implements a output handler for compilation
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSOH_COMPILE

inherit
	XS_OUTPUT_HANDLER
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			Precursor
			max_size := 0
		end

feature -- Status setting

	internal_handle_output (a_output: STRING)
			-- <Precursor>
		do
			log.dprint_noformat(a_output, log.debug_subtasks)
		end

feature -- Status report

	has_successfully_terminated: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end
end

