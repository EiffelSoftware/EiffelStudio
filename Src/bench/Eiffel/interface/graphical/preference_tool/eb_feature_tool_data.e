indexing
	description:
		"All shared attributes specific to the feature tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_DATA

inherit
	EB_DEVELOPMENT_TOOL_DATA

feature -- Access

	show_all_callers: BOOLEAN is
			-- Should we show all callers or not - as specified in preference file?
		do
			Result := Feature_resources.show_all_callers.actual_value
		end

end -- class EB_FEATURE_TOOL_DATA