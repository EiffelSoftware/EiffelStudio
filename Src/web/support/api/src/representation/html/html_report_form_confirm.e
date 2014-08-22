note
	description: "Summary description for {ESA_REPORT_FORM_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REPORT_FORM_CONFIRM

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: report_form_confirm.tpl")
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
			if
				attached a_form.to_reproduce as l_reproduce and then
				not l_reproduce.is_empty
			then
				template.add_value (a_form.to_reproduce,"to_reproduce")
			end
			template.add_value (a_form.release, "release")
			template.add_value (a_form.synopsis, "synopsis")
			if
				attached a_form.temporary_files_names as l_files and then
				not l_files.is_empty
			then
				template.add_value (l_files, "attachments")
			end
			template.add_value (a_form.id, "id")


			if attached a_user then
				template.add_value (a_user, "user")
			end
				-- Process current template
			process

		end


end
