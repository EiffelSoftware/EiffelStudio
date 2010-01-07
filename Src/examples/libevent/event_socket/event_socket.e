note
	description : "event-test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EVENT_SOCKET

inherit
	ARGUMENTS

	INET_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_listener_event: EVENT
		do
			set_ipv4_stack_preferred (True)

			create ev_base.make
			create ev_loop.make_with_base (ev_base)

			create listener.make_server_by_port (port)
			if listener.is_open_read then
				listener.set_non_blocking
				listener.listen (1)
			end

			create l_listener_event.make (listener.descriptor, {EVENT}.ev_read | {EVENT}.ev_persist)
			l_listener_event.actions.extend (agent accept_connection)
			ev_loop.add_event (l_listener_event, create {EVENT_TIME}.make_infinite)

			create timeout_event.make (-1, {EVENT}.ev_timeout)
			timeout_event.actions.extend (agent start_client)

			ev_loop.add_event (timeout_event, create {EVENT_TIME}.make (1, 0))
			ev_loop.dispatch
			listener.close
		end

	start_client (a_type: INTEGER; a_event: EVENT)
			-- Handler to file event.
		local
			l_client: detachable NETWORK_STREAM_SOCKET
			l_client_event: EVENT
			l_address: detachable INET_ADDRESS
			l_f: INET_ADDRESS_FACTORY
		do
				-- Event the event is deactivated, remove it since it is not used anymore.
			ev_loop.remove_event (timeout_event)

			create l_f
			l_address := l_f.create_from_name ("127.0.0.1")
			if l_address /= Void then
				create l_client.make_client_by_address_and_port (l_address, port)
				client := l_client
				l_client.connect
				if l_client.is_connected then
					l_client.put_string ("Hello Server!%N")

					create l_client_event.make (l_client.descriptor, {EVENT}.ev_read | {EVENT}.ev_persist)
					l_client_event.actions.extend (agent client_event_handler)
					ev_loop.add_event (l_client_event, create {EVENT_TIME}.make_infinite)
				end
			end
		end

feature -- Events

	accept_connection (a_event_type: INTEGER; a_event: EVENT)
			-- Event handler of the listener.
		local
			l_con: detachable NETWORK_STREAM_SOCKET
			l_str: detachable STRING
			l_event: EVENT
		do
			if a_event_type = {EVENT}.ev_read then
				listener.accept
				l_con := listener.accepted
				connection := l_con
				if l_con /= Void then
					l_con.read_line
					l_str := l_con.last_string
					io.put_string ("Connected!%N")
					io.put_string ("Listener Got: " + l_str)
					io.put_new_line
					l_con.put_string ("Hello Client!%N")
					ev_loop.remove_event (a_event)

					create l_event.make (l_con.descriptor, {EVENT}.ev_read | {EVENT}.ev_persist)
					l_event.actions.extend (agent listerner_connection_handler)
					ev_loop.add_event (l_event, create {EVENT_TIME}.make_infinite)
				else
					io.put_string ("Connection failure. Address could be already in use.%N")
					ev_loop.break
				end
			end
		end

	listerner_connection_handler (a_event_type: INTEGER; a_event: EVENT)
			-- Event handler of the listener connection.
		local
			l_con: detachable NETWORK_STREAM_SOCKET
			l_str: detachable STRING
		do
			l_con := connection
			check l_con /= Void end
			l_con.read_line
			l_str := l_con.last_string
			io.put_string ("Listener Got: " + l_str)
			io.put_new_line
			if l_str.has_substring ("Goodbye") then
				l_con.put_string ("Goodbye Client!%N")
				l_con.close
				ev_loop.remove_event (a_event)
				if ev_loop.is_empty then
					ev_loop.break
				end
			end
		end

	client_event_handler (a_event_type: INTEGER; a_event: EVENT)
			-- Event handler of the listener.
		local
			l_str: detachable STRING
		do
			if a_event_type = {EVENT}.ev_read then
				if attached client as l_client then
					l_client.read_line
					l_str := l_client.last_string
					io.put_string ("Client Got: " + l_str)
					io.put_new_line
					if l_str.has_substring ("Goodbye") then
						l_client.close
						ev_loop.remove_event (a_event)
						if ev_loop.is_empty then
							ev_loop.break
						end
					else
						l_client.put_string ("Goodbye Server!%N")
					end
				end
			end
		end

feature -- Access

	listener: NETWORK_STREAM_SOCKET
	client: detachable NETWORK_STREAM_SOCKET
	connection: detachable NETWORK_STREAM_SOCKET

	timeout_event: EVENT

	ev_base: EVENT_BASE
	ev_loop: EVENT_LOOP

	port: INTEGER = 36521

end
