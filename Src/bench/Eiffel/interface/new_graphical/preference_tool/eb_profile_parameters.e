indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_PARAMETERS

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
			Result := Profiler_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			Profiler_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := Profiler_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			Profiler_resources.add_modified_resource (mr)
		end

	update is
		do
			Profiler_resources.update
		end

	tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Profiler_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Profiler_resources.tool_height)
		end

	query_tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Profiler_resources.query_tool_width)
		end

	query_tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Profiler_resources.query_tool_height)
		end

end -- class EB_PROFILE_PARAMETERS
