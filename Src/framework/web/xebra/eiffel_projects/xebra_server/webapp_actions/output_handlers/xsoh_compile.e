note
	description: "[
		Implements a output handler for compilation
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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
			max_size := 200
		end

feature -- Status setting

	internal_handle_output (a_output: STRING)
			-- <Precursor>
		do
			print(a_output)
		end

feature -- Status report

	has_successfully_terminated: BOOLEAN
			-- <Precursor>
		do
			Result := False
			--print ("TESSSSSTING output!!! output is '" + output + "'")

			if output.has_substring ("C compilation completed") or output.has_substring ("System Recompiled.") then
				Result := True
			end
		end
end

