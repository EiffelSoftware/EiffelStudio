note
	description: "Summary description for {ESA_CONFIRMATION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIRMATION_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY;)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("confirmation.tpl")
			template.add_value (a_host, "host")
			if attached a_user as l_user then
				template.add_value (l_user, "user")
			end

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


