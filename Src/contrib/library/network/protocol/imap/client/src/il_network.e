note
	description: "A network connection"
	author: "Basile Maret"

class
	IL_NETWORK

inherit

	SOCKET_RESOURCES

	IL_CONSTANTS

	IL_NETWORK_STATE

create
	make_with_address_and_port

feature {NONE} -- Initialization

	make_with_address_and_port (a_address: STRING; a_port: INTEGER)
			-- Set `address' to `a_address' and `port' to `a_port'
		require
			correct_port_number: a_port >= 1 and a_port <= 65535
			address_not_void: a_address /= void
		do
			address := a_address
			port := a_port
			create socket.make_client_by_port (port, address)
		ensure
			address_set: address = a_address
			port_set: port = a_port
		end

feature -- Basic functions

	connect
			-- connects the socket
		do
			if not socket.is_connected then
				socket.connect
			end
			if socket.is_connected and state = not_connected_state then
				set_state (Not_authenticated_state)
			end
		end

	is_connected: BOOLEAN
			-- returns true if the socket is connected
		do
			Result := socket.is_connected and state /= Not_connected_state
		end

	send_command (a_tag: STRING; a_command: STRING; a_arguments: LIST [STRING])
			-- Send the command `a_command' with the tag `a_tag' and the arguments in the list `a_arguments'
		require
			tag_not_empty: not a_tag.is_empty
			command_not_empty: not a_command.is_empty
			command_continuation_not_needed: not needs_continuation
		local
			l_str: STRING
		do
			l_str := a_tag + " " + a_command
			if a_arguments /= Void then
				across
					a_arguments as argument
				loop
					l_str := l_str + " " + argument.item
				end
			end
			send_raw_command (l_str)
		end

	send_command_continuation (a_continuation: STRING)
			-- Send the continuation `a_continuation' of a command
		require
			a_continuation_not_empty: a_continuation /= Void and then not a_continuation.is_empty
			command_continuation_needed: needs_continuation
		do
			send_raw_command (a_continuation)
			needs_continuation := false
		end

	send_raw_command (command: STRING)
			-- Sends command through `socket'
		require
			socket_connected: socket.is_connected
			command_not_empty: not command.is_empty
		do
			socket.put_string (command + "%R")
			socket.put_new_line
			debugger.debug_print (debugger.debug_sending, command)
		end

feature -- Access

	socket: NETWORK_STREAM_SOCKET
			-- The main connection to the server

	address: STRING

	port: INTEGER

feature -- Implementation

	line: STRING
			-- Returns the last line sent by the server and waits for it if none has been sent
		require
			socket.is_connected
		do
			socket.read_line
			Result := socket.last_string
			debugger.debug_print (debugger.debug_receiving, Result)
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
