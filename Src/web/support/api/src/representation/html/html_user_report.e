note
	description: "Summary description for {USER_REPORT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_USER_REPORT

inherit

	TEMPLATE_REPORT
		rename
			make as make_template
		end
create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		local
			tpl_inspector: TEMPLATE_INSPECTOR
		do
			log.write_information (generator + ".make render template: user_reports.tpl")
			create {ESA_REPORT_CATEGORY_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable REPORT_CATEGORY}).out)
			set_selected_category (a_view.categories, a_view.selected_category)
			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable REPORT_STATUS}).out)
				-- Set template to HTML.
			set_template_folder (html_path)

				-- Building common template
			make_template (a_host, a_view, "user_reports.tpl")

				-- Process current template
			process
		end

end
