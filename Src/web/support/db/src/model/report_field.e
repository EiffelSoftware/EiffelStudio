note
	description: "Summary description for {REPORT_FIELD}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPORT_FIELD

inherit
	DEBUG_OUTPUT

feature -- Access

	string: READABLE_STRING_8
		deferred
		end

	debug_output: READABLE_STRING_GENERAL
		do
			Result := string
		end

end
