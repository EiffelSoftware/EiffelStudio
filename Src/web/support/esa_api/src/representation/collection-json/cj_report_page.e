note
	description: "Template class to generate an CJ API with reports."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_REPORT_PAGE

inherit

	TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_reports: LIST[REPORT]; a_index: INTEGER; a_pages: INTEGER)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("cj_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_reports, "reports")
			if a_index > 1 then
				template.add_value (a_index-1 , "prev")
			else
				template.add_value (a_index , "prev")
			end
			if a_index < a_pages then
				template.add_value (a_index+1, "next")
			else
				template.add_value (a_index, "next")
			end
			template.add_value (a_pages, "last")

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
