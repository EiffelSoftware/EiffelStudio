note
	description: "Activation page, setting common properties to CJ and HTML"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_ACTIVATION

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_user_host
		end

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: detachable ESA_ACTIVATION_VIEW; a_user: detachable ANY; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			make_user_host (a_host, a_user, a_template)
			template.add_value (a_form, "form")
			if
				attached a_form and then
				attached a_form.error_message as l_message
			then
				template.add_value (l_message, "error")
			end
		end
end
