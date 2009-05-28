note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSOH_COMPILE

inherit
	XS_OUTPUT_HANDLER

create
	make

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
			if output.ends_with ("System compiled.") then
				Result := True
			end
		end
end

