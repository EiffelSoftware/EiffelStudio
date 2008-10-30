indexing

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
		undefine
			send, put_character, putchar, put_string, putstring,
			put_integer, putint, put_integer_32, put_boolean, putbool,
			put_integer_8, put_integer_16, put_integer_64,
			put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
			put_real, putreal, put_double, putdouble, put_managed_pointer
		redefine
			address, cleanup, name
		end

feature -- Initialization

	create_from_descriptor (fd: INTEGER) is
			-- Create socket from descriptor `fd'.
		local
			retried: BOOLEAN
		do
			if not retried then
				descriptor := fd;
				create address.make;
				c_sock_name (descriptor, address.socket_address.item, address.count);
				family := address.family;
				descriptor_available := True;
				is_open_read := True;
				is_open_write := True
			end
		ensure
			family_valid: family = address.family;
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

	make_socket is
			-- Create socket descriptor.
		do
			descriptor := c_socket (family, type, protocol);
			if descriptor > -1 then
				descriptor_available := True;
				set_blocking
			end
		end

	bind is
			-- Bind socket to local address in `address'.
		local
			retried: BOOLEAN
		do
			if not retried then
				c_bind (descriptor, address.socket_address.item, address.count);
				is_open_read := True
			end
		rescue
			if not assertion_violation then
				is_open_read := False
				retried := True
				retry
			end
		end

	connect is
			-- Connect socket to peer address.
		local
			retried: BOOLEAN
		do
			if not retried then
				c_connect (descriptor, peer_address.socket_address.item, peer_address.count);
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

	shutdown is
		do
			c_shutdown (descriptor, 2)
		end

	close_socket is
			-- Close socket for current context.
		do
			c_close_socket (descriptor);
			descriptor := -2;
			descriptor_available := False;
			is_open_read := False;
			is_open_write := False
		end

	is_closed: BOOLEAN is
			-- Is socket closed?
		do
			Result := descriptor = -2
		end;

feature -- Status Report

	address: UNIX_SOCKET_ADDRESS;
			-- Local address of socket

	cleanup is
			-- Close socket and unlink it from file system.
		do
			close;
			if address /= Void then
				unlink
			end
		end;

	name: STRING is
			-- Socket name
		require else
			valid_address: address /= Void
		do
			create Result.make (10);
			Result.append (address.path)
		end

feature -- Status setting

	unlink is
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

	c_socket (add_family, a_type, protoc: INTEGER): INTEGER is
			-- External c routine to create the socket descriptor
		external
			"C"
		end

	c_bind (soc: INTEGER; addr: POINTER; length: INTEGER) is
			-- External c routine to bind the socket descriptor
			-- to a local address
		external
			"C"
		end

	c_connect (soc: INTEGER; addr: POINTER; length: INTEGER) is
			-- External c routine that connect the socket
			-- to the peer address
		external
			"C blocking"
		end

	c_unlink (nam: POINTER) is
			-- External c routine to remove socket file from file
			-- system
		external
			"C"
		end

	c_shutdown (s: INTEGER; how: INTEGER) is
			-- Shut down socket `s' with `how' modality
			-- (0 no more receive, 1 no more send, 2 no more both)
		external
			"C blocking"
		end

	c_close_socket (s: INTEGER) is
			-- External c routine to close the socket identified
			-- by the descriptor `s'
		external
			"C"
		end

	c_sock_name (soc: INTEGER; addr: POINTER; length: INTEGER) is
			-- External c routine that returns the socket name.
		external
			"C"
		end


indexing
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

