note
	description: "Bad Request template page, setting common properties for CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_TEMPLATE_BAD_REQUEST

inherit

	ESA_TEMPLATE_PAGE

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_template_name: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template_name)
			template.add_value (a_host, "host")
			if attached a_user  then
				template.add_value (a_user, "user")
			end
		end

end
