note
	description : "[
					10.2.4 Event-driven programming example

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
		local
			l_server: SERVER
			l_client: CLIENT
			l_agent: detachable separate ROUTINE [ANY, TUPLE[]]
			l_count: INTEGER
		do
			-- Prepare
			create l_server

			from
			until
				l_count > 10
			loop
				create l_client.make (l_count)
				l_agent := agent l_client.test_feature
				l_server.subscribe (l_agent)
				l_count := l_count + 1
			end

			-- Fully asynchronous call
			l_server.publish ([])
		end

end
