note

	description:
		"Server root-class for the advanced example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CHAT

inherit
	NETWORK_SERVER
		redefine
			receive, received, close
		end

	STORABLE

create
	make_chat

feature

	close
		do
		end

	connections: LINKED_LIST [CONNECTION]

	max_to_poll: INTEGER

	message_out: MESSAGE
	received: detachable MESSAGE

	poll: MEDIUM_POLLER

	make_chat (argv: ARRAY [STRING])
		local
			l_port: INTEGER
			l_message_out: detachable like message_out
			l_connections: detachable like connections
			l_in: detachable like in
		do
			if argv.count /= 2 then
				io.error.put_string ("Usage: ")
				io.error.put_string (argv.item (0))
				io.error.put_string (" port_number%N")
				io.error.put_string ("Defaulting to port 2222.%N")
				l_port := 2222
			else
				l_port := argv.item (1).to_integer
			end
			make (l_port)
			max_to_poll := 1
			create poll.make_read_only
			in.set_non_blocking
			l_in := in
			create l_message_out.make
			message_out := l_message_out
			create l_connections.make
			connections := l_connections
			connections.compare_objects
			execute
		rescue
			io.error.putstring ("IN RESCUE%N")
			if l_message_out /= Void then
				l_message_out.extend ("The server is down. ")
				l_message_out.extend ("See you later...%N")
				l_message_out.set_over (True)
				if l_connections /= Void then
					from
						l_connections.start
					until
						l_connections.after
					loop
						l_message_out.independent_store (l_connections.item.active_medium)
						l_connections.item.active_medium.close
						l_connections.forth
					end
				end
				if l_in /= Void and then not l_in.is_closed then
					l_in.close
				end
			end
		end

	process_message
		local
			stop: BOOLEAN
				-- When we receive a message tagged "over", we remove connections
				-- from the list, so we want to exit from the loop...
			pos: INTEGER
		do
			from
				connections.start
			until
				connections.after or stop
			loop
				if connections.item.is_waiting then
					if attached {MESSAGE} retrieved (connections.item.active_medium) as l_message_in then
						if l_message_in.new then
							connections.item.set_client_name (l_message_in.client_name)
							create message_out.make
							message_out.set_client_name (l_message_in.client_name)
							message_out.extend (l_message_in.client_name)
							message_out.extend (" has just joined the server%N")
						elseif l_message_in.over then
							poll.remove_associated_read_command (connections.item.active_medium)
							connections.remove
							create message_out.make
							message_out.set_client_name (l_message_in.client_name)
							message_out.extend (l_message_in.client_name)
							message_out.extend (" has just gone%N")
							stop := True
						else
							message_out := l_message_in.deep_twin
							message_out.put_front (" has just sent that :%N")
							message_out.put_front (message_out.client_name)
							message_out.put_front ("-> ")
						end
						pos := connections.index
						l_message_in.print_message
						message_out.print_message
						broadcast
						connections.go_i_th (pos)
					end
				end
				if not stop then
					connections.forth
				end
			end
		end

	broadcast
		local
			client_name: detachable STRING
		do
			client_name := message_out.client_name
			if client_name /= Void then
				from
					connections.start
				until
					connections.after
				loop
					if connections.item.client_name /~ client_name then
						message_out.independent_store (connections.item.active_medium)
					end
					connections.forth
				end
			end
		end

	receive
		do
			in.accept
			if attached {like outflow} in.accepted as l_outflow then
				outflow := l_outflow
				l_outflow.set_blocking
				send_already_connected (l_outflow)
				new_client (l_outflow)
			else
				outflow := Void
			end
			initialize_for_polling
			poll.execute (max_to_poll, 1000)
		end

	initialize_for_polling
		do
			from
				connections.start
			until
				connections.after
			loop
				connections.item.initialize
				connections.forth
			end
		end

	new_client (a_flow: attached like outflow)
		local
			new_connection: CONNECTION
		do
			if max_to_poll <= a_flow.descriptor then
				max_to_poll := a_flow.descriptor + 1
			end
			create new_connection.make (a_flow)
			connections.extend (new_connection)
			poll.put_read_command (new_connection)
		end

	send_already_connected (a_flow: attached like outflow)
		local
			l_name: detachable STRING
		do
			create message_out.make
			if connections.count > 0 then
				message_out.extend ("These people are already connected :")
				from
					connections.start
				until
					connections.after
				loop
					l_name := connections.item.client_name
					if l_name /= Void then
						message_out.extend ("%N-> ")
						message_out.extend (l_name)
					end
					connections.forth
				end
				message_out.extend ("%N")
			else
				message_out.extend ("Nobody is connected%N")
			end
			message_out.independent_store (a_flow)
		end

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


end -- class CHAT

