note
	description: "The {RESPONSE} contains all the data which is sent back to the requester."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	RESPONSE

feature -- Element change

	append (a_string: STRING)
		do
			print ("APPEND:  " + a_string)
		end

end
