indexing
	description: "Parameters common to all tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature -- Access

	regular_button: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (General_resources.regular_button)
		end

	close_button: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (General_resources.close_button)
		end

	history_size: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (General_resources.history_size)
		end

	default_window_position: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (General_resources.default_window_position)
		end

end -- class EB_TOOL_PARAMETERS
