note
	description: "Template post reminder page, with common properties to CJ and HTML"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_POST_REMINDER

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_email: detachable STRING; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template)
			add_host (a_host)
			if attached a_email then
				template.add_value (a_email, "email")
			end
		end
end
