note
	description: "Summary description for {ITEM_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_PAGE
inherit

	TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_message: MESSAGES; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("item.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_message, "msg")
			template.add_value (a_user, "user")
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
