indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make


feature -- Access

	tool_x: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.tool_x)
		end

	tool_y: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.tool_y)
		end

	tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.tool_height)
		end

	command_bar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.command_bar)
		end
	
	format_bar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.format_bar)
		end

	selector_window: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.selector_window)
		end

	raise_on_error: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.raise_on_error)
		end

end -- class EB_PROJECT_PARAMETERS
