indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_PARAMETERS

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

	debugger_feature_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_feature_height)
		end

	debugger_object_height: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_object_height)
		end

	interrupt_every_n_instructions: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.interrupt_every_n_instructions)
		end

	debugger_show_all_callers: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_show_all_callers)
		end

	debugger_do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (Project_resources.debugger_do_flat_in_breakpoints)
		end


end -- class EB_DEBUGGER_PARAMETERS
