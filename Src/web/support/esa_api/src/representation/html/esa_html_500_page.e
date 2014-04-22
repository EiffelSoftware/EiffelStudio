note
	description: "Summary description for {ESA_HTML_500_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_500_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("500.tpl")
			template.add_value (a_host, "host")
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
