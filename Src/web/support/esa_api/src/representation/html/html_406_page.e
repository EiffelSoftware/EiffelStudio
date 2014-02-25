note
	description: "Summary description for {HTML_406_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_406_PAGE
inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_resource: READABLE_STRING_GENERAL; a_accept: detachable READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("406.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_resource, "resource")
			template.add_value (a_accept, "accept")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end
end

