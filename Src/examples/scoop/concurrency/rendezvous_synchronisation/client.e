note
	description: "[
		Client of class MIDDLE ACTIVE OBJECT.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT

create
	make

feature {NONE} -- Initialization

	make (a_server: separate MIDDLE_ACTIVE_OBJECT; a_id: INTEGER)
			-- Creation method
		do
			my_server := a_server
		ensure
			set: my_server = a_server
		end

feature -- Command

	do_work
			-- Do work
		do
			print ("CLIENT id: " + id.out + " do_work : " + my_server.out_data.out + "%N")
		end

feature {NONE} -- Implementation

	my_server: separate MIDDLE_ACTIVE_OBJECT
			-- Server

	id: INTEGER
			-- Id of current

end
