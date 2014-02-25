note
	description: "Template class to generate an CJ API with details"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_REPORT_DETAIL_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- {Initialization}

	make (a_host: READABLE_STRING_GENERAL; a_report: detachable REPORT;)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("cj_reports_detail.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_report, "report")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
						l_output.replace_substring_all ("<", "{")
						l_output.replace_substring_all (">", "}")
						l_output.replace_substring_all ("},]", "}]")
						l_output.replace_substring_all (",]", "]")

						representation := l_output
						print ("%N===========%N" + l_output)
			end
		end

end
