note
	description: "Summary description for {ESA_ACTIVATION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACTIVATION_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: detachable ESA_ACTIVATION_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("activation.tpl")
			template.add_value (a_host, "host")
			if attached a_form as l_form then
				template.add_value (l_form, "form")
				if attached l_form.error_message as l_message then
					template.add_value (l_message, "error")
				end
			end
			if attached a_user as l_user then
				template.add_value (l_user, "user")
			end

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end

end
