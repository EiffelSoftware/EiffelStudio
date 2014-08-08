note
	description: "Summary description for {ESA_CJ_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_REGISTER

inherit

	TEMPLATE_REGISTER
		rename
			make as make_template
		end

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REGISTER_VIEW; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			l_error: STRING
		do
			log.write_information (generator + ".make render template: cj_register.tpl")
				-- Set template folder to CJ.
			set_template_folder (cj_path)

				-- Build common template
			make_template (a_host, a_form, a_user, "cj_register.tpl" )


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

				-- Process the current template.
			process

		end
end
