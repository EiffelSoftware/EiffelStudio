note
	description: "Summary description for {MESSAGES}."
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGES

create
	make,
	make_from_separate

feature {NONE} -- Initialization

	make (a_user, a_message: READABLE_STRING_32; a_id: INTEGER_64)
		do
			user := a_user
			message := a_message
			create date.make_now
			id := a_id
		end

	make_from_separate (other: separate like Current)
			-- Initialize `Current' with the same values as `other'.
		local
			l_string: STRING_32
		do
			create l_string.make_from_separate (other.message)
			message := l_string
			create l_string.make_from_separate (other.user)
			user := l_string
			create date.make (other.date.year, other.date.month, other.date.day, 0, 0, 0)
			id := other.id
		end

feature -- Access

	id: INTEGER_64

	message: READABLE_STRING_32

	user: READABLE_STRING_32

	date: DATE_TIME

end
