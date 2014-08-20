note
	description: "Summary description for {HTML_500}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_500

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
			set_template_file_name ("500.tpl")
			template.add_value (a_host, "host")
			process
		end
end
