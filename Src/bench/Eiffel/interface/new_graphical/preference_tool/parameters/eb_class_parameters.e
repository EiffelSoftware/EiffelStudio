indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature -- Access

	tool_width: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (Class_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		once
			Create Result.make_from_old (Class_resources.tool_height)
		end

	command_bar: EB_BOOLEAN_RESOURCE is
		once
			Create Result.make_from_old (Class_resources.command_bar)
		end

	format_bar: EB_BOOLEAN_RESOURCE is
		once
			Create Result.make_from_old (Class_resources.format_bar)
		end

	parse_class_after_saving: EB_BOOLEAN_RESOURCE is
		once
			Create Result.make_from_old (Class_resources.parse_class_after_saving)
		end

	feature_clause_order: EB_ARRAY_RESOURCE is
		once
			Create Result.make_from_old (Class_resources.feature_clause_order)
		end

end -- class EB_CLASS_PARAMETERS
