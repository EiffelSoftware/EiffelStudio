note
	description: "Interface {CONTACT_MESSAGE} representing the contact's message."
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_message: like message)
		do
			name := a_name
			message := a_message
			create date.make_now_utc
		end

feature -- Access

	name: READABLE_STRING_32

	message: READABLE_STRING_32

	date: DATE_TIME

	email: detachable READABLE_STRING_8

feature -- Change

	set_email (e: like email)
		do
			email := e
		end

	set_date (d: like date)
		do
			date := d
		end

end
