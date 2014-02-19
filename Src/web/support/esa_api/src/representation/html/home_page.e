note
	description: "Template class to generate an HTML Home page."
	date: "$Date$"
	revision: "$Revision$"

class
	HOME_PAGE

inherit

	TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("home.tpl")
			template.add_value (a_host, "host")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end

end
