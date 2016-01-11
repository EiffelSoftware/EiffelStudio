note
	description: "Template report detail page, with common properties to CJ and HTML"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_REPORT_DETAIL

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_user_host
		end

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_report: detachable REPORT; a_user: detachable ANY; a_template: READABLE_STRING_32)
		do
			make_user_host (a_host, a_user, a_template)
			template.add_value (a_report, "report")
		end
end
