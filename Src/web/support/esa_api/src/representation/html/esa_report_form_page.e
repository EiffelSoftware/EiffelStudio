note
	description: "Summary description for {ESA_REPORT_FORM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_FORM_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("report_form.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.severities, "severities")
			template.add_value (a_form.classes, "classes")
			template.add_value (a_form.priorities, "priorities")
			template.add_value (a_form.confidential, "confidential")
			template.add_value (a_form.description, "description")
			template.add_value (a_form.environment, "environment")
			template.add_value (a_form.to_reproduce,"to_reproduce")
			template.add_value (a_form.release, "release")
			template.add_value (a_form.synopsis, "synopsis")
			template.add_value (a_form.priority, "priority")
			template.add_value (a_form.category, "category")
			template.add_value (a_form.severity, "severity")
			template.add_value (a_form.selected_class, "class")

			if attached a_form.temporary_files as l_files then
				template.add_value (l_files, "temporary_files")
			end

			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end


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
