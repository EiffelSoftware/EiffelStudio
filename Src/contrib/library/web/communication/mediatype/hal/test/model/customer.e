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
	make (a_name : STRING; an_email: STRING)
		do
			set_name (a_name)
			set_email (an_email)
		end

feature -- Acceess
	name : STRING
	email : STRING

feature -- Element change	

	set_name ( a_name : STRING)
		do
			name := a_name
		end

	set_email (an_email : STRING)
		do
			email := an_email
		end
end
