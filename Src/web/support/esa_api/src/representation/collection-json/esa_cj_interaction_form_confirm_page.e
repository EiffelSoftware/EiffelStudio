note
	description: "Summary description for {ESA_CJ_INTERACTION_FORM_CONFIRM_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_INTERACTION_FORM_CONFIRM_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make
feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_report_id: INTEGER; a_id: INTEGER; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			set_template_folder (cj_path)
			set_template_file_name ("cj_interaction_confirm_page.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_report_id, "report")
			template.add_value (a_id, "confirm")

			if attached a_user then
				template.add_value (a_user, "user")
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
