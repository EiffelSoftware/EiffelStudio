note
	description: "Summary description for {ESA_CJ_RESPONSIBLE_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_RESPONSIBLE_PAGE

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL;a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: ch_responsible_reports.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_responsible_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports, "reports")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.priorities, "priorities")
			template.add_value (a_view.responsibles, "responsibles")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.severities, "severities")
			template.add_value (a_view, "view")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.size, "size")

			if attached a_view.id as l_id then
				template.add_value (l_id, "id")
			end

			if a_view.index > 1 then
				template.add_value (a_view.index-1 , "prev")
			end
			if a_view.index < a_view.pages then
				template.add_value (a_view.index+1, "next")
			end
			template.add_value (a_view.pages, "last")

			if attached a_view.user as l_user then
				template.add_value (a_view.user, "user")
			end

				-- Process current template
			process
		end
end
