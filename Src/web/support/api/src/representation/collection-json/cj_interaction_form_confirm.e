note
	description: "Summary description for {ESA_CJ_INTERACTION_FORM_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_INTERACTION_FORM_CONFIRM

inherit

	TEMPLATE_SHARED

create
	make
feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_report_id: INTEGER; a_id: INTEGER; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_interaction_confirm_page.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_interaction_confirm_page.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_report_id, "report")
			template.add_value (a_id, "confirm")

			if attached a_user then
				template.add_value (a_user, "user")
			end

				-- Process current template
			process
		end
end
