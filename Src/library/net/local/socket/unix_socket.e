note

	description:
		"An unix socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	UNIX_SOCKET

inherit

	SOCKET
		redefine
			address_type, cleanup, name
		end

feature -- Initialization

	create_from_descriptor (fd: INTEGER)
			-- Create socket from descriptor `fd'.
		local
			retried: BOOLEAN
			l_address: like address
		do
			if not retried then
				descriptor := fd;
				create l_address.make
				address := l_address
				c_sock_name (descriptor, l_address.socket_address.item, l_address.count);
				family := l_address.family;
				descriptor_available := True;
				is_open_read := True;
				is_open_write := True
			end
		ensure
			family_valid: attached address as l_address_att and then family = l_address_att.family;
			opened_all: is_open_write and is_open_read
		rescue
			if not assertion_violation then
				is_open_read := False
				is_open_write := False
				retried := True
				retry
			end
		end;

feature

	descriptor: INTEGER;
			-- Socket descriptor of current socket

	make_socket
			-- Create socket descriptor.
		do
			descriptor := c_socket (family, type, protocol);
			if descriptor > -1 then
				descriptor_available := True;
				set_blocking
			end
		end

	bind
			-- Bind socket to local address in `address'.
		local
			retried: BOOLEAN
			l_address: like address
		do
			if not retried then
				l_address := address
					-- Per inherited precondition
				check l_address_attached: l_address /= Void end
				c_bind (descriptor, l_address.socket_address.item, l_address.count);
				is_open_read := True
			end
		rescue
			if not assertion_violation then
				is_open_read := False
				retried := True
				retry
			end
		end

	connect
			-- Connect socket to peer address.
		local
			retried: BOOLEAN
			l_peer_address: like peer_address
		do
			if not retried then
				l_peer_address := peer_address
					-- Per inherited precondition
				check l_peer_address_attached: l_peer_address /= Void end
				c_connect (descriptor, l_peer_address.socket_address.item, l_peer_address.count);
				is_open_write := True;
				is_open_read := True
			end
		rescue
			if not assertion_violation then
				is_open_read := False
				is_open_write := False
				retried := True
				retry
			end
		end;

	shutdown
		do
			c_shutdown (descriptor, 2)
		end

	close_socket
			-- Close socket for current context.
		do
			c_close_socket (descriptor);
			descriptor := -2;
			descriptor_available := False;
			is_open_read := False;
			is_open_write := False
		end

	is_closed: BOOLEAN
			-- Is socket closed?
		do
			Result := descriptor = -2
		end;

feature -- Status Report

	address_type: UNIX_SOCKET_ADDRESS
			-- <Precursor>
		local
			l_result: detachable like address_type
		do
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

	cleanup
			-- Close socket and unlink it from file system.
		do
			close;
			if address /= Void then
				unlink
			end
		end;

	name: STRING
			-- Socket name
		require else
			valid_address: address /= Void
		local
			l_address: like address
		do
			create Result.make (10);
			l_address := address
				-- Per precondition
			check l_address_attached: l_address /= Void end
			Result.append (l_address.path)
		end

feature -- Status setting

	unlink
			-- Remove associate name from file system.
		require else
			name_address: address /= void
		local
			ext: C_STRING
		do
			create ext.make (name)
			c_unlink (ext.item)
		end

feature {NONE} -- Externals

	c_socket (add_family, a_type, protoc: INTEGER): INTEGER
			-- External c routine to create the socket descriptor
		external
			"C"
		end

	c_bind (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine to bind the socket descriptor
			-- to a local address
		external
			"C"
		end

	c_connect (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine that connect the socket
			-- to the peer address
		external
			"C blocking"
		end

	c_unlink (nam: POINTER)
			-- External c routine to remove socket file from file
			-- system
		external
			"C"
		end

	c_shutdown (s: INTEGER; how: INTEGER)
			-- Shut down socket `s' with `how' modality
			-- (0 no more receive, 1 no more send, 2 no more both)
		external
			"C blocking"
		end

	c_close_socket (s: INTEGER)
			-- External c routine to close the socket identified
			-- by the descriptor `s'
		external
			"C"
		end

	c_sock_name (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine that returns the socket name.
		external
			"C"
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




end -- class UNIX_SOCKET

