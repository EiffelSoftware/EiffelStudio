indexing
	description:
		"All shared attributes specific to the feature tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	show_all_callers: BOOLEAN is
		do
			Result := boolean_resource_value ("show_all_callers", False)
		end

	expand_feature_tree: BOOLEAN is
		do
			Result := boolean_resource_value ("expand_feature_tree", True)
		end

end -- class EB_FEATURE_TOOL_DATA
