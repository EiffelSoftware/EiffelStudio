note
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT

create
	make
	
feature {NONE} -- Initialization

	make (a_id: INTEGER)
			-- Creation method
		do
			id := a_id
		ensure
			set: id = a_id
		end

feature -- Command

	test_feature
			-- Feature for testing
		do
			print ("Test feature clinet id: " + id.out + "%N")
		end

feature -- Query

	id: INTEGER
			-- Client id

end
