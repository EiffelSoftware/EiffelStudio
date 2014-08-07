note
	description: "Register template page, setting common properties for CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_REGISTER

inherit

	ESA_TEMPLATE_PAGE

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REGISTER_VIEW; a_user: detachable ANY; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template)
			template.add_value (a_host, "host")
			template.add_value (a_form.questions, "questions")
			template.add_value (a_form, "form")

			if attached a_user then
				template.add_value (a_user,"user")
			end
		end

end
