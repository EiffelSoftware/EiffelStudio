indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_PARAMETERS

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
			Result := Explain_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			Explain_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := Explain_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			Explain_resources.add_modified_resource (mr)
		end

	update is
		do
			Explain_resources.update
		end

	tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Explain_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Explain_resources.tool_height)
		end

	command_bar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Explain_resources.command_bar)
		end
	
end -- class EB_EXPLAIN_PARAMETERS
