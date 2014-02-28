note
	description: "Summary description for {USER_REPORT_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER_REPORT_PAGE
inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_reports: TUPLE[REPORT_STATISTICS,LIST[REPORT]]; a_index: INTEGER; a_pages: INTEGER; a_user: STRING)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("user_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_reports.at (1), "statistics")
			template.add_value (a_reports.at (2), "reports")
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

		 	template.add_value (a_user,"user")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end

end
