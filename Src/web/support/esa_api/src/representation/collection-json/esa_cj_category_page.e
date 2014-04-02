note
	description: "Summary description for {ESA_CJ_CATEGORY_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_CATEGORY_PAGE


inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_list: LIST[ESA_REPORT_CATEGORY]; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			p: PATH
			l_item: STRING
			l_template: STRING
			l_report: ESA_REPORT
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("cj_category.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_list, "categories")
			if attached a_user as l_user then
				template.add_value (l_user, "user")
			end
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				l_output.replace_substring_all ("},]", "}]")

				representation := l_output
				print ("%N===========%N" + l_output)
			end
		end

end
