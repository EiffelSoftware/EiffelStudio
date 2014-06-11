note
	description: "An error. Errors are critical for program execution."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ERROR

inherit
	CA_RULE_SEVERITY

feature -- Properties

	is_critical: BOOLEAN = True
			-- <Precursor>

	name: STRING_32 = "Error"
			-- <Precursor>

	short_form: STRING_32 = "E"
			-- <Precursor>

end
