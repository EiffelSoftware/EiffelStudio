note
	description: "Summary description for {JWT_DEV_ERROR}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_DEV_ERROR

inherit
	JWT_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_8; msg: READABLE_STRING_8)
		do
			id := a_id
			message := msg
		end

feature -- Access

	id: STRING

	message: READABLE_STRING_8

end
