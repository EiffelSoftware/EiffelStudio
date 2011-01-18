note
	description : "[
					Practical framework for contract-based concurrent object-oriented programming
					section 10.2.1 
					redezvous synchronisation and active objects example
					
					More info please check Piotr Nienaltowski's SCOOP thesis, chapter 10.2
					link: http://se.ethz.ch/people/nienaltowski/papers/thesis.pdf
																									]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			create server
			create middle.make (server)
			create client_1.make (middle, 1)
			create client_2.make (middle, 2)

			server.do_work
			middle.live
			client_1.do_work
			client_2.do_work
		end

	server: separate SERVER
			-- Server

	middle: separate MIDDLE_ACTIVE_OBJECT
			-- Middle active object

	client_1, client_2: separate CLIENT
			-- Client

end
