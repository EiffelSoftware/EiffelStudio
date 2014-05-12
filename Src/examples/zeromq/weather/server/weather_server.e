note
	description: "[
		Weather update server
		Binds PUB socket to tcp://*:5556
		Publishes random weather updates
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Weather update server", "src=https://github.com/imatix/zguide/blob/master/examples/C/wuserver.c", "protocol=uri"

class
	WEATHER_SERVER

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_context: ZMQ_CONTEXT
			l_socket: ZMQ_SOCKET
			l_zipcode, l_temperature, l_humidity: INTEGER
		do
			create random_sequence.set_seed (10000)

				-- Initialize OMQ context and publisher
			create l_context.make
			l_socket := l_context.new_pub_socket
			l_socket.bind ("tcp://127.0.0.1:5556")
			check
				l_socket.exists
			end
			l_socket.bind ("ipc://weather.ipc")
			from
				l_zipcode := new_random \\ 10 + 10000
				l_temperature := new_random \\ 215 - 80
				l_humidity := new_random \\ 50 + 10
			until
				False
			loop
					--Send message to all subscribers
				l_socket.put_string (l_zipcode.out + " " + l_temperature.out + " " + l_humidity.out)
				l_zipcode := new_random \\ 100000
				l_temperature := new_random \\ 215 - 80
				l_humidity := new_random \\ 50 + 10
			end
			l_socket.close
		end

feature {NONE} -- RANDOM

	new_random: INTEGER
			-- Random integer
			-- Each call returns another random number.
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	random_sequence: RANDOM
			-- Random sequence

end
