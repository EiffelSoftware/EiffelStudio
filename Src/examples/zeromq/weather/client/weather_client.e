note
	description: "[
		Weather update client  Connects SUB socket to tcp://localhost:5556
		Collects weather updates and finds avg temp in zipcode
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Weather update client", "src=https://github.com/imatix/zguide/blob/master/examples/C/wuclient.c", "protocol=uri"

class
	WEATHER_CLIENT

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_context: ZMQ_CONTEXT
			l_socket: ZMQ_SOCKET
			l_updates: INTEGER
			l_string: STRING
			l_total_temperature: INTEGER
		do

				-- Socket to talk to server
			print ("Collecting updates from weather server ...%N")
			create l_context.make
				-- Subscribe to zipcode, default is NYC, 10001
			l_socket := l_context.new_sub_socket ("10001")
			l_socket.connect ("tcp://127.0.0.1:5556")

				-- Process 100 updates
			from
				l_updates := 1
			until
				l_updates > 100
			loop
				l_socket.read_string
				l_string := l_socket.last_string
				if attached l_string.split (' ') as l_list then
					print ("%Nzipcode:" + l_list[1])
					print ("%Ntemperature:" + l_list[2])
					print ("%Nhumidity:" + l_list[3])
					l_total_temperature := l_total_temperature + l_list[2].to_integer
				end
				l_updates := l_updates + 1
			end
			print ("%NAverage temperature for zipcode 1001 (total_temp / update_nbr)" + (l_total_temperature / l_updates).out)
			l_socket.close
		end

end
