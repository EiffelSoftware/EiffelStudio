indexing
	description: "Strong signing for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

feature -- Access

	present: BOOLEAN is False
		-- On Unix platform, no strong signing ability.

end
