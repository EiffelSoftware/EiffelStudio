indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature -- Access

	tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.tool_height)
		end

	keep_toolbar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.keep_toolbar)
		end

	double_line_toolbar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.double_line_toolbar)
		end

	show_all_callers: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.show_all_callers)
		end

	do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.do_flat_in_breakpoints)
		end

end -- class EB_FEATURE_PARAMETERS
