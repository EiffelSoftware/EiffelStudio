note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_THREAD_NETWORK_STREAM_SOCKET

create
	make_client_by_port,
	make_server_by_port

feature {NONE} -- Initialization


	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING)
			-- <Precursor>
		do
			create socket.make_client_by_port (a_peer_port, a_peer_host)
			create mutex.make
		end

	make_server_by_port (a_port: INTEGER)
			-- <Precursor>
		do
			create socket.make_server_by_port (a_port)
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

	retrieved: detachable ANY
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			Result := socket.retrieved
			mutex.unlock

		end

	accept
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			socket.accept
			mutex.unlock
		end

	listen (a_i: INTEGER)
			-- See NETWORK_STREAM_SOCKET
		do
			mutex.lock
			socket.listen (a_i)
			mutex.unlock
		end



feature -- Access

		mutex: MUTEX
		socket: NETWORK_STREAM_SOCKET



;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
