note
	description: "[
					Client of class SERVER
					Server of class CLIENT
					It works as an active object in middle
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	MIDDLE_ACTIVE_OBJECT

inherit
	ACTIVE_OBJECT

create
	make

feature -- Initialization

	make (a_server: separate SERVER)
			-- Creation method
		do
			my_server := a_server
		ensure
			set: my_server = a_server
		end

feature -- Query

	out_data: INTEGER
			-- Output data for class CLIENT

feature {NONE} -- Implementation

	my_server: separate SERVER
			-- Server

	do_work
			-- <Precursor>
		local
			l_in_data: INTEGER
		do
			l_in_data := my_server.counter 	-- Get data from server
			out_data := l_in_data * 10	-- Local calculations
		end

end
