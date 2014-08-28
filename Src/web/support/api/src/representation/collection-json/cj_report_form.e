note
	description: "Summary description for {ESA_CJ_REPORT_FORM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_REPORT_FORM

inherit

	TEMPLATE_SHARED

create
	make,
	make_with_error,
	make_with_data

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_form_report.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_form_report.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.severities, "severities")
			template.add_value (a_form.classes, "classes")
			template.add_value (a_form.priorities, "priorities")
			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end

			if attached a_user then
				template.add_value (a_user, "user")
			end

				-- Process current template
			process

		end


	make_with_data (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make_with_data render template: cj_form_report.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_form_report.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.severities, "severities")
			template.add_value (a_form.classes, "classes")
			template.add_value (a_form.priorities, "priorities")
			template.add_value (a_form, "form")
			template.add_value (a_form.category, "category")
			template.add_value (a_form.severity, "severity")
			template.add_value (a_form.selected_class, "class")
			template.add_value (a_form.priority, "priority")
			template.add_value (a_form.confidential, "confidential")
			template.add_value (a_form.description, "description")
			template.add_value (a_form.environment, "environment")
			template.add_value (a_form.to_reproduce,"to_reproduce")
			template.add_value (a_form.release, "release")
			template.add_value (a_form.synopsis, "synopsis")
			template.add_value (a_form.temporary_files,"uploaded_files")
			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end

			if attached a_user  then
				template.add_value (a_user, "user")
			end

				-- Process current template
			process
		end



	make_with_error (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			l_message: STRING
		do
			log.write_information (generator + ".make_with_error render template: cj_form_report.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_form_report.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.severities, "severities")
			template.add_value (a_form.classes, "classes")
			template.add_value (a_form.priorities, "priorities")
			template.add_value (a_host, "host")

			l_message := ""
			if attached a_form.errors as l_errors then
				from
					l_errors.start
				until
					l_errors.after
				loop
					l_message.append_string_general (l_errors.key_for_iteration)
					l_message.append (" : ")
					l_message.append_string_general (l_errors.item_for_iteration)
					l_message.append (" , ")
					l_errors.forth
				end
			end

			template.add_value (l_message, "error_message")
			template.add_value ("001", "code")
			template.add_value ("Validation Error", "title")

			if attached a_user then
				template.add_value (a_user, "user")
			end

				-- Process current template
			process
		end
end
