indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_PARAMETERS

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
			Result := Feature_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			Feature_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := Feature_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			Feature_resources.add_modified_resource (mr)
		end

	update is
		do
			Feature_resources.update
		end

	tool_width: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.tool_width)
		end

	tool_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.tool_height)
		end

	keep_toolbar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.keep_toolbar)
		end

	double_line_toolbar: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.double_line_toolbar)
		end

	show_all_callers: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.show_all_callers)
		end

	do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Feature_resources.do_flat_in_breakpoints)
		end

end -- class EB_FEATURE_PARAMETERS
