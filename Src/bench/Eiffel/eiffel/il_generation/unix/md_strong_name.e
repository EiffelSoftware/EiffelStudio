indexing
	description: "Strong signing for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

create
	make

feature

	make is
			-- Create instance of MD_STRONG_NAME.
		do
		end

feature -- Access

	exists: BOOLEAN is False
		-- On Unix platform, no strong signing ability.

end
