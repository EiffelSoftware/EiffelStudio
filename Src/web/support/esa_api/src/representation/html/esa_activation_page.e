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
		do
			set_template_folder (html_path)
			set_template_file_name ("activation.tpl")
			template.add_value (a_host, "host")
			if attached a_form then
				template.add_value (a_form, "form")
				if attached a_form.error_message as l_message then
					template.add_value (l_message, "error")
				end
			end
			if attached a_user then
				template.add_value (a_user, "user")
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
