indexing

	description:
		"Server root-class for the advanced example.";

	status: "See notice at end of class";
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

	close is
		do
		end

	connections: LINKED_LIST [CONNECTION]

	max_to_poll: INTEGER

	message_in, message_out, received: MESSAGE

	poll: MEDIUM_POLLER

	make_chat (argv: ARRAY [STRING]) is
		do
			if argv.count /= 2 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" port_number%N")
			else	
				make (argv.item (1).to_integer)
				max_to_poll := 1
				create poll.make_read_only
				create connections.make
				connections.compare_objects
				in.set_non_blocking
				execute
			end
		rescue
			io.error.putstring ("IN RESCUE%N")
			create message_out.make_message
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

	process_message is
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
					message_in ?= retrieved (connections.item.active_medium)
					if message_in.new then
						connections.item.set_client_name (message_in.client_name)
						create message_out.make_message
						message_out.set_client_name (message_in.client_name)
						message_out.extend (message_in.client_name)
						message_out.extend (" has just joined the server%N")
					elseif message_in.over then
						poll.remove_associated_read_command (connections.item.active_medium)
						connections.remove
						create message_out.make_message
						message_out.set_client_name (message_in.client_name)
						message_out.extend (message_in.client_name)
						message_out.extend (" has just gone%N")
						stop := True
					else
						message_out := deep_clone (message_in)
						message_out.put_front (" has just sent that :%N")
						message_out.put_front (message_out.client_name)
						message_out.put_front ("-> ")
					end
					pos := connections.index
					message_in.print_message
					message_out.print_message
					broadcast
					connections.go_i_th (pos)
				end
				if not stop then
					connections.forth
				end
			end
		end

	broadcast is
		local
			client_name: STRING
		do
			client_name := clone (message_out.client_name)
			from
				connections.start
			until
				connections.after
			loop
				if not connections.item.client_name.is_equal (client_name) then
					message_out.independent_store (connections.item.active_medium)
				end
				connections.forth
			end
		end

	receive is
		do
			in.accept
			outflow ?= in.accepted
			if outflow /= Void then
				outflow.set_blocking
				send_already_connected
				new_client
			end
			initialize_for_polling
			poll.execute (max_to_poll, 15000)
		end

	initialize_for_polling is
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

	new_client is
		local
			new_connection: CONNECTION
		do
			if max_to_poll <= outflow.descriptor then
				max_to_poll := outflow.descriptor + 1
			end
			create new_connection.make (clone (outflow))
			connections.extend (new_connection)
			poll.put_read_command (new_connection)
		end

	send_already_connected is
		do
			create message_out.make_message
			if connections.count > 0 then
				message_out.extend ("These people are already connected :")
				from
					connections.start
				until
					connections.after
				loop
					message_out.extend ("%N-> ")
					message_out.extend (connections.item.client_name)
					connections.forth
				end
				message_out.extend ("%N")
			else
				message_out.extend ("Nobody is connected%N")
			end
			message_out.independent_store (outflow)
		end

end -- class CHAT

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

