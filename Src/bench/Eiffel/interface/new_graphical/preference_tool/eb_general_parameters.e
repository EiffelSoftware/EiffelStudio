indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_PARAMETERS

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

	acrobat_reader: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.acrobat_reader)
		end

	text_mode: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.text_mode)
		end

	tab_step: EB_INTEGER_RESOURCE is
		do
			Create Result.make_from_old (General_resources.tab_step)
		end

	editor: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.editor)
		end

	filter_path: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.filter_path)
		end

	profile_path: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.profile_path)
		end

	tmp_path: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.tmp_path)
		end

	shell_command: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.shell_command)
		end 

	filter_name: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.filter_name)
		end

	filter_command: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.filter_command)
		end

	print_shell_command: EB_STRING_RESOURCE is
		do
			Create Result.make_from_old (General_resources.print_shell_command)
		end

	browsing_facilities: EB_BOOLEAN_RESOURCE is
		do
			Create Result.make_from_old (General_resources.browsing_facilities)
		end

end -- class EB_GENERAL_PARAMETERS
