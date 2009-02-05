note

	description:
		"Client root-class for the advanced example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class JOIN

inherit
	NETWORK_CLIENT
		redefine
			received
		end

create
	make_join

feature

	make_join (argv: ARRAY [STRING])
		local
			l_port: INTEGER
			l_host: STRING
		do
			if argv.count /= 3 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" hostname port%N")
				io.error.put_string ("Defaulting to port 2222 on localhost.%N")
				l_host := "localhost"
				l_port := 2222
			else
				l_host := argv.item (1)
				l_port := argv.item (2).to_integer
			end

			check_name

			make (l_port, l_host)
			max_to_poll := in_out.descriptor + 1

			create connection.make (in_out)
			create poll.make_read_only
			poll.put_read_command (connection)

			create std_input.make (io.input)
			create input_poll.make_read_only
			input_poll.put_read_command (std_input)

			send_name_to_server
			processing
		rescue
			io.error.putstring ("IN RESCUE%N");
			create message_out.make
			message_out.set_client_name (client_name)
			message_out.set_new (False)
			message_out.set_over (True)
			send (message_out)
			cleanup
		end

feature {NONE} -- Implementation

	send_name_to_server
		do
			create message_out.make
			message_out.set_client_name (client_name)
			message_out.set_new (True)
			message_out.set_over (False)
			send (message_out)
		end

	processing
		do
			from
				over := False
			until
				over
			loop
				scan_from_server
				if not over then
					scan_from_std_input
				end
			end
			cleanup
		end

	scan_from_std_input
		local
			temp: ?STRING
		do
			std_input.initialize
			input_poll.execute (1, 15000)
			if std_input.is_waiting then
				io.readline
				temp := io.laststring
				if temp /= Void then
					if temp.is_equal ("bye") then
						over := True
					end
					create message_out.make
					message_out.extend (temp)
					message_out.extend ("%N")
					message_out.set_over (over)
					message_out.set_client_name (client_name)
					message_out.set_new (False)
					send (message_out)
				end
			end
		end

	check_name
		local
			l_name: ?STRING
		do
			io.putstring ("Enter your name : ")
			io.readline
			l_name := io.laststring
			check l_name_attached: l_name /= Void end
			client_name := l_name
		end

	scan_from_server
		local
			l_received: like received
		do
			connection.initialize
			poll.execute (max_to_poll, 15000)
			if connection.is_waiting then
				receive
				l_received := received
				if l_received /= Void then
					l_received.print_message
					if l_received.over then
						over := True
					end
				end
			end
		end

	connection, std_input: CONNECTION

	message_out: MESSAGE
	received: ?MESSAGE

	client_name: STRING

	over: BOOLEAN

	poll, input_poll: MEDIUM_POLLER

	max_to_poll: INTEGER;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class JOIN

