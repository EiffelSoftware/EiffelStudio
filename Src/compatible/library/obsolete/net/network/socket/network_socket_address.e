note

	description:
		"A network socket address."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_SOCKET_ADDRESS

inherit

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

	SOCKET_ADDRESS
		redefine
			address_size, set_sock_family, get_sock_family, make
		select 
			make
		end

create

	make, make_local_from_port, make_from_name_and_port,
		make_from_ip_and_port

feature -- Initialization

	make
			-- Create a network address.
		do
			socket_address_make;
			set_family (af_inet)
		end;

	make_local_from_port (a_port: INTEGER)
			-- Create a local address with port `a_port'.
		local
			an_host_address: HOST_ADDRESS
		do
			make;
			create an_host_address.make_local;
			set_host_address (an_host_address);
			set_port (a_port)
		end;

	make_from_name_and_port (a_hostname: STRING; a_port: INTEGER)
			-- Create an address from host name `a_hostname' and
			-- port `a_port'.
		local
			an_host_address: HOST_ADDRESS
		do
			make;
			create an_host_address.make_from_name (a_hostname);
			set_host_address (an_host_address);
			set_port (a_port)
		end;

	make_from_ip_and_port (an_ip_number: STRING; a_port: INTEGER)
			-- Create an address from ip number `an_ip_number'
			-- (in dotted format) and port `a_port'.
		local
			an_host_address: HOST_ADDRESS
		do
			make;
			create an_host_address.make_from_ip_number (an_ip_number);
			set_host_address (an_host_address);
			set_port (a_port)
		end
			
			
feature -- Status report

	port: INTEGER
			-- Port number
		do
			Result := get_sock_port (socket_address.item)
		end;

	host_address: HOST_ADDRESS
			-- Host address of address
		do
			create Result.make;
			Result.from_c (get_sock_addr_in (socket_address.item))
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
		end;

	set_port (p: INTEGER)
			-- Set port to `p'.
		do
			set_sock_port (socket_address.item, p)
		end;

	set_host_address (a_host_address: HOST_ADDRESS)
			-- Set host address to `a_host_address'
		do
			set_sock_addr_in (socket_address.item, a_host_address.address_host.item)
		end;

	clear_zero
			-- Set zero attribute in address structure.
		local
			null_pointer: POINTER
		do
			set_sock_zero (socket_address.item, null_pointer)
		end

feature {NONE} -- External

	address_size: INTEGER
			-- Size of address in bytes.
		external
			"C"
		alias
			"inet_address_size"
		end;

	set_sock_family (address: POINTER; a_family: INTEGER)
			-- Set the family in the address structure.
		external
			"C"
		alias
			"set_inet_sock_family"
		end;

	get_sock_family (address: POINTER): INTEGER
			-- Get the family from the address structure.
		external
			"C"
		alias
			"get_inet_sock_family"
		end;

	set_sock_port (address: POINTER; a_port: INTEGER)
			-- Set the port in the address structure.
		external
			"C"
		end;

	get_sock_port (address: POINTER): INTEGER
			-- Get the port from the address structure.
		external
			"C"
		end;

	set_sock_addr_in (address: POINTER; a_addr_in: POINTER)
			-- Set the host address in the address structure.
		external
			"C"
		end;

	get_sock_addr_in (address: POINTER): POINTER
			-- Get the host address from the address structure.
		external
			"C"
		end;

	set_sock_zero (address: POINTER; a_zero: POINTER)
			-- Set zero attribute in address structure.
		external
			"C"
		end;

	get_sock_zero (address: POINTER): POINTER
			-- Get zero attribute from address structure.
		external
			"C"
		end;

	get_servent_port (name, proto: POINTER): INTEGER
			-- Get the services entry using `name' and `proto'
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




end -- class NETWORK_SOCKET_ADDRESS

