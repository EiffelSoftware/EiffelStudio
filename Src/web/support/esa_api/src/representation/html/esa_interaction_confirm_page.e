note
	description: "Summary description for {ESA_INTERACTION_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_CONFIRM_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("interaction_form_confirm.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.status, "status")
			template.add_value (a_form, "form")

			if attached a_form.report as l_report then
				if attached l_report.status as l_status and then
				   l_status.id /= a_form.selected_status then
					template.add_value (a_form.selected_status, "new_status")
				end
				if l_report.confidential /= a_form.private then
					template.add_value (a_form.private, "private")
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
