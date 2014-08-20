note
	description: "Summary description for {HTML_400}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_400
inherit

	HTML_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_path: PATH; a_host: READABLE_STRING_GENERAL;)
			-- Initialize `Current'.
		do
			set_template_folder (a_path)
			set_template_file_name ("400.tpl")
			template.add_value (a_host, "host")
			process
		end
end
