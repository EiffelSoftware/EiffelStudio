indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature -- Access

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
