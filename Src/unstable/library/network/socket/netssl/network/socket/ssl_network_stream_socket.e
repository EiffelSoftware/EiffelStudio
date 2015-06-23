note

	description:
		"A network stream socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SSL_NETWORK_STREAM_SOCKET

inherit

	NETWORK_STREAM_SOCKET
		undefine
			connect,
			error_number
		redefine
			make_empty,
			make_from_descriptor_and_address,
			read_to_managed_pointer,
			readstream, read_stream,
			put_managed_pointer,
			send, write,
			shutdown,
			close_socket,
			do_accept
		end

	SSL_NETWORK_SOCKET
		undefine
			support_storable,
			read_to_managed_pointer,
			readstream, read_stream,
			write
		redefine
			put_managed_pointer,
			shutdown,
			error_number,
			close_socket
		end

	SSL_STREAM_SOCKET
		undefine
			exists, is_valid_peer_address, is_valid_family, address_type,
			set_non_blocking, set_blocking
		redefine
			put_managed_pointer,
			read_to_managed_pointer,
			readstream, read_stream,
			send,
			write,
			error_number,
			shutdown
		end

create
	make, make_empty, make_client_by_port, make_client_by_address_and_port, make_server_by_port, make_loopback_server_by_port

create {SSL_NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address, create_from_descriptor

feature {NONE} -- Initialization

	make_empty
			-- Initialize an empty {SSL_NETWORK_STREAM_SOCKET}.
			-- The object does not have a C socket.
		do
			Precursor
			set_tls_protocol (default_tls_protocol)
		ensure then
			tls_protocol_set_to_default: tls_protocol = default_tls_protocol
		end

feature {SSL_NETWORK_STREAM_SOCKET} -- Initialization

	make_from_descriptor_and_address (a_fd: INTEGER; a_address: attached separate like address)
		do
			Precursor (a_fd, a_address)
			set_tls_protocol (default_tls_protocol)
		ensure then
			tls_protocol_set_to_default: tls_protocol = default_tls_protocol
		end

feature -- Access

	close_socket
			-- Close this socket, and cleanup the SSL context
		do
				--| Close the descriptor, from {NETWORK_SOCKET}
			Precursor
			if is_closed then
				if attached context as l_context then
					if attached l_context.last_ssl as l_ssl then
						l_ssl.free
					end
					l_context.free
				end
			end
		end

feature -- Input

	read_stream, readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		local
			ext: C_STRING
			return_val: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				create ext.make_empty (nb_char + 1)
				return_val := l_ssl.read (ext.item , nb_char)
				bytes_read := return_val
				if return_val >= 0 then
					ext.set_count (return_val)
					last_string := ext.substring (1, return_val)
				else
					last_string.wipe_out
				end
			else
				check has_context: False end
			end
		end


	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result available in `p' at position
			-- `start_pos'
		local
			l_read: INTEGER
			l_last_read: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				from
					l_last_read := 1
				until
					l_read = nb_bytes or l_last_read <= 0
				loop
					l_last_read := l_ssl.read (p.item + start_pos + l_read, nb_bytes - l_read)
					if l_last_read >= 0 then
						l_read := l_read + l_last_read
					end
				end
				bytes_read := l_read
			else
				check has_context: False end
			end
		end

feature -- Output

	write (a_packet: PACKET)
			-- Write packet `a_packet' to socket.
		local
			ext_data: POINTER
			count: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				ext_data := a_packet.data.item
				count := a_packet.count
				l_ssl.write (ext_data, count)
			else
				check has_last_ssl: False end
			end
		end

	send (a_packet: PACKET; flags: INTEGER)
			-- Send a packet `a_packet' of data to socket.
		do
			write (a_packet)
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at current position
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				l_ssl.write (p.item + start_pos, nb_bytes)
			else
				check has_last_ssl: False end
			end
		end


feature -- Status Report

	error_number: INTEGER
			-- <Precursor>
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl and then
				l_ssl.was_error
			then
				Result := l_ssl.ssl_error_number
			end
		end

feature {NONE} -- Implementation

	shutdown
			-- Send SSL/TLS close_notify
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				l_ssl.shutdown
			else
				check has_context: False end
			end
		end

	do_accept (other: separate like Current; a_address: attached like address)
			-- Accept a new connection.
			-- The new socket is stored in `other'.
			-- If the accept fails, `other.is_created' is still False.
		do
			Precursor (other, a_address)
			if other.is_created then
				other.set_tls_protocol (tls_protocol)

				if
					attached certificate_x509_string and then
					attached private_rsa_key_string
				then
					other.initialize_server_ssl_with_string (certificate_x509_string, private_rsa_key_string)
				elseif
					attached certificate_file_path and then
					attached key_file_path
				then
					other.initialize_server_ssl (certificate_file_path, key_file_path)
				else
					socket_error := "Certificate not found"
				end


			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class NETWORK_STREAM_SOCKET

