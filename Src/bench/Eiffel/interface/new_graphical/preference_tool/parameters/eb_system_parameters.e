indexing
	description: "Parameters for the system tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature -- Access

	tool_width: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (System_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (System_resources.tool_height)
		end

	command_bar: EB_BOOLEAN_RESOURCE is
		once
			Create Result.make_from_old (System_resources.command_bar)
		end

	parse_ace_after_saving: EB_BOOLEAN_RESOURCE is
		once
			Create Result.make_from_old (System_resources.parse_ace_after_saving)
		end
	
end -- class EB_SYSTEM_PARAMETERS
