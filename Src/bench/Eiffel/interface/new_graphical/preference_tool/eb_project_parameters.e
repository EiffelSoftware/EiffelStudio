indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_PARAMETERS

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
			Result := Project_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			Project_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := Project_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			Project_resources.add_modified_resource (mr)
		end

	update is
		do
			Project_resources.update
		end

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

	graphical_output_disabled: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.graphical_output_disabled)
		end

end -- class EB_PROJECT_PARAMETERS
