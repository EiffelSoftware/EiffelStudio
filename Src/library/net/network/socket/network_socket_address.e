note
	description: "A network socket address."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	NETWORK_SOCKET_ADDRESS

inherit

	INET_ADDRESS_FACTORY
		export
			{NONE} all
		undefine
			copy, is_equal
		redefine
			get_sock_family
		end

	SOCKET_RESOURCES
		undefine
			copy, is_equal
		end

	SOCKET_ADDRESS
		rename
			make as socket_address_make
		redefine
			address_size, set_sock_family, get_sock_family
		end

create
	make_from_hostname_and_port,
	make_from_address_and_port,
	make_any_local,
	make_localhost,
	make_loopback,
	make_from_separate

feature -- Initialization

	make_from_address_and_port (an_address: INET_ADDRESS;  a_port: INTEGER)
		require
			valid_address: an_address /= Void
			valid_port: a_port >= 0 and then a_port <= 0xFFFF
		do
			socket_address := an_address.sockaddr (a_port)
		ensure
			socket_address /= Void
		end

	make_from_hostname_and_port (a_hostname: STRING_8;  a_port: INTEGER)
		require
			non_void_hostname: a_hostname /= Void
			-- TODO look at this valid_host: is_valid_host (a_hostname)
			valid_port: a_port >= 0 and then a_port <= 0xFFFF
		local
			addr: detachable INET_ADDRESS
			l_socket_address: like socket_address
		do
			addr := create_from_name (a_hostname)
			if addr /= Void then
				l_socket_address := addr.sockaddr (a_port)
			else
				create l_socket_address.make (address_size)
			end
			socket_address := l_socket_address
		ensure
			socket_address /= Void
		end

	make_any_local (a_port: INTEGER)
			--
		local
			addr: INET_ADDRESS
		do
			addr := create_any_local
			socket_address := addr.sockaddr (a_port)
		ensure
			socket_address /= Void
		end

	make_localhost (a_port: INTEGER)
			--
		local
			addr: INET_ADDRESS
		do
			addr := create_localhost
			socket_address := addr.sockaddr (a_port)
		end

	make_loopback (a_port: INTEGER)
			--
		local
			addr: INET_ADDRESS
		do
			addr := create_loopback
			socket_address := addr.sockaddr (a_port)
		end

feature -- Status report

	port: INTEGER
			-- Port number
		do
			Result := get_sock_port (socket_address.item)
		end

	host_address: INET_ADDRESS
			-- Host address of address
		do
			check has_address: attached create_from_sockaddr (socket_address.item) as l_address then
					-- Since we are providing a correct C pointer `socket_address' the result should
					-- be attached.
				Result := l_address
			end
		end

feature --

	is_valid_host (hostname: STRING_8): BOOLEAN
			--
		require
			hostname_not_void: hostname /= Void
		do
			Result := create_from_name (hostname) /= Void
		end

feature -- Status setting

	set_port_from_name (a_name, protocol: STRING)
			-- Set port number using `a_name' and `protocol'
			-- to refer into the (local) services file.
		local
			ext1, ext: C_STRING
			return: INTEGER
		do
			create ext1.make (a_name)
			create ext.make (protocol)
			return := get_servent_port (ext1.item, ext.item);
			set_port (return)
		end

	set_port (p: INTEGER)
			-- Set port to `p'.
		do
			set_sock_port (socket_address.item, p)
		end

	set_host_address (a_host_address: INET_ADDRESS)
			-- Set host address to `a_host_address'
		do
			make_from_address_and_port (a_host_address, port)
		end

feature {NONE} -- External

	address_size: INTEGER
			-- Size of address in bytes.
		external
			"C"
		alias
			"inet_address_size"
		end

	set_sock_family (address: POINTER; a_family: INTEGER)
			-- Set the family in the address structure.
		external
			"C"
		alias
			"en_sockaddr_set_family"
		end

	get_sock_family (address: POINTER): INTEGER
			-- Get the family from the address structure.
		external
			"C"
		alias
			"en_sockaddr_get_family"
		end

	set_sock_port (address: POINTER; a_port: INTEGER)
			-- Set the port in the address structure.
		external
			"C"
		alias
			"en_sockaddr_set_port"
		end

	get_sock_port (address: POINTER): INTEGER
			-- Get the port from the address structure.
		external
			"C"
		alias
			"en_sockaddr_get_port"
		end

	get_servent_port (name, proto: POINTER): INTEGER
			-- Get the services entry using `name' and `proto'
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
