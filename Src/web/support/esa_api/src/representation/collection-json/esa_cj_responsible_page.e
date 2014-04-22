note
	description: "Summary description for {ESA_CJ_RESPONSIBLE_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_RESPONSIBLE_PAGE


inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL;a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		do
			set_template_folder (cj_path)
			set_template_file_name ("cj_responsible_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports.at (2), "reports")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.priorities, "priorities")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.severities, "severities")
			template.add_value (a_view, "view")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.size, "size")

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

			template_context.enable_verbose
			template.analyze
			template.get_output
				-- Workaround
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				l_output.replace_substring_all ("},]", "}]")

				representation := l_output
				debug
					print ("%N===========%N" + l_output)
				end
			end
		end
end
