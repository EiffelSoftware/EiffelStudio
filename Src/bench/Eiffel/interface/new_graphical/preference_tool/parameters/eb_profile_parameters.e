indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make


feature -- Access

	tool_width: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (Profiler_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (Profiler_resources.tool_height)
		end

	query_tool_width: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (Profiler_resources.query_tool_width)
		end

	query_tool_height: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (Profiler_resources.query_tool_height)
		end

end -- class EB_PROFILE_PARAMETERS
