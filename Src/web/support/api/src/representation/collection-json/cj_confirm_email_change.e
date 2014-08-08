note
	description: "Summary description for {ESA_CJ_CONFIRM_EMAIL_CHANGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_CONFIRM_EMAIL_CHANGE

inherit

	TEMPLATE_CONFIRM_EMAIL_CHANGE
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_EMAIL_VIEW)
			-- Initialize `Current'.
		local
			l_error: STRING
		do
			log.write_information (generator + ".make render template: cj_confirm_change_email.tpl")
				-- Set template to HTML.
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_user, a_view, "cj_confirm_change_email.tpl")
				-- Custom fields
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
				-- Process current template
			process
		end

end
