note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_THREAD_NETWORK_STREAM_SOCKET

create
	make_client_by_port

feature {NONE} -- Initialization


	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING)
			-- <Precursor>
		do
			create socket.make_client_by_port (a_peer_port, a_peer_host)
			create mutex.make
		end

feature -- Wrapped features

	cleanup
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			socket.cleanup
			mutex.unlock
		end

	is_closed: BOOLEAN
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			Result := socket.is_closed
			mutex.unlock
		end

	connect
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			socket.connect
			mutex.unlock
		end

	is_connected: BOOLEAN
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			Result := socket.is_connected
			mutex.unlock
		end

	independent_store (a_arg: ANY)
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			socket.independent_store (a_arg)
			mutex.unlock
		end

	retrieved: ANY
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			Result := socket.retrieved
			mutex.unlock
		end



feature -- Access

		mutex: MUTEX
		socket: NETWORK_STREAM_SOCKET



end
