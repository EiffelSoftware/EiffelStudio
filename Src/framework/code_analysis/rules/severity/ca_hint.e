note
	description: "A hint. Hints are not necessarily meant to implement. They just represent an alternative way of coding something."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_HINT

inherit
	CA_RULE_SEVERITY

feature {NONE} -- Initialization

	is_critical: BOOLEAN = False
			-- <Precursor>

	name: STRING_32 = "Hint"
			-- <Precursor>

	short_form: STRING_32 = "H"
			-- <Precursor>

end
