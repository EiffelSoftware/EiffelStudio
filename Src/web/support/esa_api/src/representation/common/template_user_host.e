note
	description: "Generic template with User and Host properties"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_USER_HOST

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template)
			add_host (a_host)
			add_user (a_user)
		end

end
