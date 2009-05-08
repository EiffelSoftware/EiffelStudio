note

	description:
		"Client root-class for the predef example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OUR_CLIENT

inherit

	NETWORK_CLIENT
		redefine
			received
		end

create

	make_client

feature

	our_list: OUR_MESSAGE

	received: detachable OUR_MESSAGE -- Type redefinition

	make_client (argv: ARRAY [STRING])
			-- Build list, send it, receive modified list, and print it.
		local
			l_host: STRING
			l_port: INTEGER
		do
			if argv.count /= 3 then
				io.error.put_string ("Usage: ")
				io.error.put_string (argv.item (0))
				io.error.put_string (" hostname portnumber%N")
				io.error.put_string ("Defaulting to host `localhost' and port `2000'.%N")
				l_port := 2000
				l_host := "localhost"
			else
				l_port := argv.item (2).to_integer
				l_host := argv.item (1)
			end
			make (l_port, l_host)
			build_list
			send (our_list)
			receive
			process_received
			cleanup
		rescue
			cleanup
		end

	build_list
			-- Build list of strings `our_list' for transmission to server.
		do
			create our_list.make
			our_list.extend ("This ")
			our_list.extend ("is ")
			our_list.extend ("our ")
			our_list.extend ("test.")
		end

	process_received
			-- Print the contents of received in sequence.
		do
			if attached {OUR_MESSAGE} received as l_received then
				from
					l_received.start
				until
					l_received.after
				loop
					io.put_string (l_received.item)
					l_received.forth
				end
			else
				io.put_string ("No list received.")
			end
			io.new_line
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


end

