note
	description: "Summary description for {HTML_DOWNLOAD_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_DOWNLOAD_OPTIONS

inherit

	HTML_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_path: PATH; a_host: READABLE_STRING_GENERAL; a_platform: READABLE_STRING_32; a_download: detachable DOWNLOAD_OPTIONS)
			-- Initialize `Current'.
		do
			set_template_folder (a_path)
			set_template_file_name ("download_options.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_platform, "platform")
			template.add_value (a_download, "options")
			process
		end
end


