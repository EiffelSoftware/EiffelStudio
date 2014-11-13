note
	description: "Error from database"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_ERROR

inherit
	ERROR_CUSTOM

create
	make_from_message

feature {NONE} -- Init

	make_from_message (a_m: like message; a_code: like code)
			-- Create from `a_m'
		do
			make (a_code, once "Database Error", a_m)
		end

end
