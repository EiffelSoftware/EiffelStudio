note
	description: "Summary description for {PHONE_LINE}."
	date: "$Date$"
	revision: "$Revision$"

class
	PHONE_LINE

create
	make

feature {NONE} -- Creation method

	make (a_id: INTEGER)
			-- Creation method
		do
			id := a_id
		ensure
			set: id = a_id
		end

feature -- Command

	connect (a_app: APPLICATION)
			-- Connect `a_app' with a phone line
		do
			print ("Connectted to phone line: (thread id) " + id.out)
			a_app.phone_line_test
		end


feature -- Query

	id: INTEGER
			-- Id of current phone line


end
