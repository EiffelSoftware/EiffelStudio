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
	received: ?MESSAGE

	poll: MEDIUM_POLLER

	make_chat (argv: ARRAY [STRING])
		local
			l_port: INTEGER
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
			create message_out.make
			create connections.make
			connections.compare_objects
			execute
		rescue
			io.error.putstring ("IN RESCUE%N")
			message_out.extend ("The server is down. ")
			message_out.extend ("See you later...%N")
			message_out.set_over (True)
			from
				connections.start
			until
				connections.after
			loop
				message_out.independent_store (connections.item.active_medium)
				connections.item.active_medium.close
				connections.forth
			end
			cleanup
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
					if {l_message_in: MESSAGE} retrieved (connections.item.active_medium) then
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
			client_name: ?STRING
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
		local
			l_flow: like outflow
		do
			in.accept
			l_flow ?= in.accepted
			outflow := l_flow
			if l_flow /= Void then
				l_flow.set_blocking
				send_already_connected
				new_client
			end
			initialize_for_polling
			poll.execute (max_to_poll, 15000)
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

	new_client
		local
			new_connection: CONNECTION
			l_flow: like outflow
		do
			l_flow := outflow
			check l_flow_attached: l_flow /= Void end
			if max_to_poll <= l_flow.descriptor then
				max_to_poll := l_flow.descriptor + 1
			end
			create new_connection.make (l_flow)
			connections.extend (new_connection)
			poll.put_read_command (new_connection)
		end

	send_already_connected
		local
			l_name: ?STRING
			l_flow: like outflow
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
			l_flow := outflow
			check l_flow_attached: l_flow /= Void end
			message_out.independent_store (l_flow)
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

