indexing

	description:
		"A network socket address."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_SOCKET_ADDRESS

inherit

	INET_ADDRESS_FACTORY
		export {NONE}
			All
		undefine
			copy, is_equal, get_sock_family
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

	make_from_hostname_and_port, make_from_address_and_port, make_any_local, make_localhost

feature -- Initialization

	make_from_address_and_port (an_address: INET_ADDRESS;  a_port: INTEGER) is
		require
			valid_address: an_address /= Void
			valid_port: a_port >= 0 and then a_port <= 0xFFFF
		do
			socket_address := an_address.sockaddr (a_port)
		ensure
			socket_address /= Void
		end

	make_from_hostname_and_port (a_hostname: STRING;  a_port: INTEGER) is
		require
			non_void_hostname: a_hostname /= Void
			-- TODO look at this valid_host: is_valid_host (a_hostname)
			valid_port: a_port >= 0 and then a_port <= 0xFFFF
		local
			addr: INET_ADDRESS
		do
			addr := create_from_name (a_hostname)
			if addr /= Void then
				socket_address := addr.sockaddr (a_port)
			end
		ensure
			socket_address /= Void
		end

	make_any_local (a_port: INTEGER) is
			--
		local
			addr: INET_ADDRESS
		do
			addr := create_any_local
			if addr /= Void then
				socket_address := addr.sockaddr (a_port)
			end
		ensure
			socket_address /= Void
		end

	make_localhost (a_port: INTEGER) is
			--
		local
			addr: INET_ADDRESS
		do
			addr := create_localhost
			if addr /= Void then
				socket_address := addr.sockaddr (a_port)
			end
		ensure
			socket_address /= Void
		end

feature -- Status report

	port: INTEGER is
			-- Port number
		do
			Result := get_sock_port (socket_address.item)
		end

	host_address: INET_ADDRESS is
			-- Host address of address
		do
			Result := create_from_sockaddr(socket_address.item)
		end

feature --

	is_valid_host (hostname: STRING): BOOLEAN is
			--
		require
			hostname_not_void: hostname /= Void
		do
			Result := create_from_name (hostname) /= Void
		end

feature -- Status setting

	set_port_from_name (a_name, protocol: STRING) is
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
		end;

	set_port (p: INTEGER) is
			-- Set port to `p'.
		do
			set_sock_port (socket_address.item, p)
		end

	set_host_address (a_host_address: INET_ADDRESS) is
			-- Set host address to `a_host_address'
		do
			make_from_address_and_port (a_host_address, port)
		end

feature {NONE} -- External

	address_size: INTEGER is
			-- Size of address in bytes.
		external
			"C"
		alias
			"inet_address_size"
		end

	set_sock_family (address: POINTER; a_family: INTEGER) is
			-- Set the family in the address structure.
		external
			"C"
		alias
			"en_sockaddr_set_family"
		end

	get_sock_family (address: POINTER): INTEGER is
			-- Get the family from the address structure.
		external
			"C"
		alias
			"en_sockaddr_get_family"
		end

	set_sock_port (address: POINTER; a_port: INTEGER) is
			-- Set the port in the address structure.
		external
			"C"
		alias
			"en_sockaddr_set_port"
		end

	get_sock_port (address: POINTER): INTEGER is
			-- Get the port from the address structure.
		external
			"C"
		alias
			"en_sockaddr_get_port"
		end

	get_servent_port (name, proto: POINTER): INTEGER is
			-- Get the services entry using `name' and `proto'
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


end -- class NETWORK_SOCKET_ADDRESS

