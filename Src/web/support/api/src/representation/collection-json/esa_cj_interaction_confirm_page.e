note
	description: "Summary description for {ESA_CJ_INTERACTION_CONFIRM_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	ESA_CJ_INTERACTION_CONFIRM_PAGE

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_interaction_confirm.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_interaction_confirm.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.status, "status")
			template.add_value (a_form, "form")
			template.add_value (a_form.report, "report")

			if attached a_form.report as l_report then
				if attached l_report.status as l_status and then
				   l_status.id /= a_form.selected_status then
				    template.add_value (a_form.selected_status, "new_status")
				end
				if l_report.confidential /= a_form.private then
					template.add_value (a_form.private, "private")
				end
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
