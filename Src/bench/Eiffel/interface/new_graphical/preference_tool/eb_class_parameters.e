indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_PARAMETERS

inherit
	EB_PARAMETERS
		redefine
			users, add_user,
			modified_resources, add_modified_resource,
			update
		end

creation
	make

feature -- Access

	users: LINKED_LIST [RESOURCE_USER] is

		do
			Result := Class_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			Class_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := Class_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			Class_resources.add_modified_resource (mr)
		end

	update is
		do
			Class_resources.update
		end

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
