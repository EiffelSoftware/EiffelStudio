note
	description: "Summary description for {USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER
create
	make
feature {NONE} -- Initialization
	make (a_name : STRING; a_phone: STRING)
		do
			name := a_name
			phone := a_phone
		end

feature -- Access

	name : STRING
	phone : STRING

end
