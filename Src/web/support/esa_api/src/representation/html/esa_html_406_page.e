note
	description: "Summary description for {HTML_406_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_406_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_resource: READABLE_STRING_GENERAL; a_accept: detachable READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("406.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_resource, "resource")
			template.add_value (a_accept, "accept")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				debug
					print (representation)
				end
			end
		end
end

