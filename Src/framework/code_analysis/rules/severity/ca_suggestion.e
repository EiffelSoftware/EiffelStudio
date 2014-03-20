note
	description: "A suggestion. Suggestions do not lead to dangerous or bad program behavior but are things that good code should follow."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SUGGESTION

inherit
	CA_RULE_SEVERITY

feature {NONE} -- Initialization

	is_critical: BOOLEAN = False
			-- <Precursor>

	name: STRING_32 = "Suggestion"
			-- <Precursor>

end
