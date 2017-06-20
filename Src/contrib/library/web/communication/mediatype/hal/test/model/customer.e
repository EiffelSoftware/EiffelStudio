note
	description: "Summary description for {CUSTOMER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOMER
create
	make
feature {NONE} -- Initialization

	make (a_name : READABLE_STRING_GENERAL; an_email: STRING)
		do
			set_name (a_name)
			set_email (an_email)
		end

feature -- Acceess

	name : STRING_32
	email : STRING

feature -- Element change	

	set_name ( a_name : READABLE_STRING_GENERAL)
		do
			name := a_name.as_string_32
		end

	set_email (an_email : STRING)
		do
			email := an_email
		end
end
