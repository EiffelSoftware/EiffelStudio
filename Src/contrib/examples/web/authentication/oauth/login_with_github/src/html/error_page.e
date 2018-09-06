note
	description: "Summary description for {ERROR_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_PAGE
inherit

	TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_error_message: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("error.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_error_message, "error_message")
			template.add_value (a_user, "user")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
			end
		end
end
