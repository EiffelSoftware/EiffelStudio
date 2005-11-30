indexing
	description: "Special calls to features of ANY for .NET code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	ANY_FEATURE_B

inherit
	FEATURE_B
		redefine
			is_any_feature
		end

create
	make

feature {NONE} -- IL code generation

	is_any_feature: BOOLEAN is True
			-- Is Current an instance of ANY_FEATURE_B?

end -- class ANY_FEATURE_B
