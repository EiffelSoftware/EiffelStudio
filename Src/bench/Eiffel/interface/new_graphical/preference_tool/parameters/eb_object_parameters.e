indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_PARAMETERS

inherit
	EB_PARAMETERS

creation

	make

feature -- Access

	tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Object_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Object_resources.tool_height)
		end

	command_bar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Object_resources.command_bar)
		end

end -- class EB_OBJECT_PARAMETERS
