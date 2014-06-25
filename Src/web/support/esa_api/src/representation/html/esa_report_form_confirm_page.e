note
	description: "Summary description for {ESA_REPORT_FORM_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_FORM_CONFIRM_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("report_form_confirm.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.category, "category")
			template.add_value (a_form.severity, "severity")
			template.add_value (a_form.selected_class, "class")
			template.add_value (a_form.priority, "priority")
			template.add_value (a_form, "form")
			template.add_value (a_form.confidential, "confidential")
			template.add_value (a_form.description, "description")
			template.add_value (a_form.environment, "environment")
			template.add_value (a_form.to_reproduce,"to_reproduce")
			template.add_value (a_form.release, "release")
			template.add_value (a_form.synopsis, "synopsis")
			template.add_value (a_form.uploaded_files, "attachments")
			template.add_value (a_form.id, "id")


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
