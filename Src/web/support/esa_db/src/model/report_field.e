note
	description: "Summary description for {REPORT_FIELD}."
	author: ""
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

	debug_output: STRING
		do
			Result := string
		end

end
