note
	description: "Summary description for {ESA_CJ_CHANGE_PASSWORD_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_CHANGE_PASSWORD

inherit

	TEMPLATE_PASSWORD
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_PASSWORD_VIEW)
			-- Initialize `Current'.
		local
			l_error: STRING
		do
			log.write_information (generator + ".make render template: cj_change_password.tpl")
				-- Set folder to CJ.			
			set_template_folder (cj_path)
				-- Build Common Template
			make_template (a_host, a_user, "cj_change_password.tpl")

			if attached a_view.errors as l_errors then
				l_error := ""
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
				template.add_value ("Validation Error:", "title")
				template.add_value ("400", "code")
				template.add_value (l_error, "error")
			end

				-- Proccess Current template.
			process
		end
end
