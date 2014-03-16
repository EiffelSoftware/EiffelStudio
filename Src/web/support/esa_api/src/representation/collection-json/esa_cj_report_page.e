note
	description: "Template class to generate an CJ API with reports."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_REPORT_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL;a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("cj_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports.at (2), "reports")

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
				print ("%N===========%N" + l_output)
			end

		end

end
