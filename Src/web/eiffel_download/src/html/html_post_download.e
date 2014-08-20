note
	description: "Summary description for {HTML_POST_DOWNLOAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_POST_DOWNLOAD

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
			set_template_file_name ("post_download.tpl")
			template.add_value (a_host, "host")
			process
		end
end
