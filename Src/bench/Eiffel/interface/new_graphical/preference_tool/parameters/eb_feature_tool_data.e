indexing
	description:
		"All shared attributes specific to the feature tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_DATA

feature -- Access

	Feature_Resources: EB_FEATURE_PARAMETERS is
			-- Feature tool specific parameters
		once
			create Result.make
		end

end -- class EB_FEATURE_TOOL_DATA
