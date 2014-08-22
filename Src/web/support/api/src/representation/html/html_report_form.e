note
	description: "Summary description for {ESA_REPORT_FORM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REPORT_FORM

inherit

	TEMPLATE_SHARED
	
create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: report_form.tpl")
			set_template_folder (html_path)
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

			if
				attached a_form.temporary_files as l_files and then
				not l_files.is_empty
			then
				template.add_value (l_files, "temporary_files")
			end

			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end


			if attached a_user then
				template.add_value (a_user, "user")
			end

				-- Process current template
			process

		end

end
