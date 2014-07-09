note
	description: "Summary description for {ESA_CJ_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_REGISTER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REGISTER_VIEW; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			l_error: STRING
		do
			log.write_information (generator + ".make render template: cj_register.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_register.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.questions, "questions")
			template.add_value (a_form, "form")

			l_error := ""
			if attached a_form.errors as l_errors then
				from
					l_errors.start
				until
					l_errors.after
				loop
					l_error.append (l_errors.item_for_iteration)
					l_errors.forth
					if not l_errors.after then
						l_error.append (" , ")
					end
				end
				template.add_value (l_error, "error")
				template.add_value ("Validation Error", "title")
				template.add_value ("400", "code")
			end

			if attached a_user then
				template.add_value (a_user,"user")
			end

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				l_output.replace_substring_all ("},]", "}]")
				l_output.replace_substring_all (",]", "]")
				representation := l_output
				debug
					log.write_debug (generator + ".make " + l_output)
				end
			end
		end
end
