note
	description: "Register template page, setting common properties for CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_REGISTER

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_user_host
		end
create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REGISTER_VIEW; a_user: detachable ANY; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			make_user_host (a_host, a_user, a_template)
			template.add_value (a_form.questions, "questions")
			template.add_value (a_form, "form")
		end

end
