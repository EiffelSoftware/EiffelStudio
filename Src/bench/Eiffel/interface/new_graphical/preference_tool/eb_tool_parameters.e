indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_PARAMETERS

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
			Result := General_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			General_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := General_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			General_resources.add_modified_resource (mr)
		end

	update is
		do
			General_resources.update
		end

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

	window_free_list_number: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (General_resources.window_free_list_number)
		end

end -- class EB_TOOL_PARAMETERS
