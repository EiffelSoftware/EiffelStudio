indexing

	description:
		"A network socket address.";

	status: "See notice at end of class";
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

creation

	make, make_local_from_port, make_from_name_and_port,
		make_from_ip_and_port

feature -- Initialization

	make is
			-- Create a network address.
		do
			socket_address_make;
			set_family (af_inet)
		end;

	make_local_from_port (a_port: INTEGER) is
			-- Create a local address with port `a_port'.
		local
			an_host_address: HOST_ADDRESS
		do
			make;
			create an_host_address.make_local;
			set_host_address (an_host_address);
			set_port (a_port)
		end;

	make_from_name_and_port (a_hostname: STRING; a_port: INTEGER) is
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

	make_from_ip_and_port (an_ip_number: STRING; a_port: INTEGER) is
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

	port: INTEGER is
			-- Port number
		do
			Result := get_sock_port ($socket_address)
		end;

	host_address: HOST_ADDRESS is
			-- Host address of address
		do
			create Result.make;
			Result.from_c (get_sock_addr_in ($socket_address))
		end

feature -- Status setting

	set_port_from_name (a_name, protocol: STRING) is
			-- Set port number using `a_name' and `protocol'
			-- to refer into the (local) services file.
		local
			ext1, ext: ANY;
			return: INTEGER
		do
			ext1 := a_name.to_c;
			ext := protocol.to_c;
			return := get_servent_port ($ext1, $ext);
			set_port (return)
		end;

	set_port (p: INTEGER) is
			-- Set port to `p'.
		do
			set_sock_port ($socket_address, p)
		end;

	set_host_address (a_host_address: HOST_ADDRESS) is
			-- Set host address to `a_host_address'
		local
			ext: ANY
		do
			ext := a_host_address.address_host;
			set_sock_addr_in ($socket_address, $ext)
		end;

	clear_zero is
			-- Set zero attribute in address structure.
		local
			null_pointer: POINTER
		do
			set_sock_zero ($socket_address, null_pointer)
		end

feature {NONE} -- External

	address_size: INTEGER is
			-- Size of address in bytes.
		external
			"C"
		alias
			"inet_address_size"
		end;

	set_sock_family (address: POINTER; a_family: INTEGER) is
			-- Set the family in the address structure.
		external
			"C"
		alias
			"set_inet_sock_family"
		end;

	get_sock_family (address: POINTER): INTEGER is
			-- Get the family from the address structure.
		external
			"C"
		alias
			"get_inet_sock_family"
		end;

	set_sock_port (address: POINTER; a_port: INTEGER) is
			-- Set the port in the address structure.
		external
			"C"
		end;

	get_sock_port (address: POINTER): INTEGER is
			-- Get the port from the address structure.
		external
			"C"
		end;

	set_sock_addr_in (address: POINTER; a_addr_in: POINTER) is
			-- Set the host address in the address structure.
		external
			"C"
		end;

	get_sock_addr_in (address: POINTER): POINTER is
			-- Get the host address from the address structure.
		external
			"C"
		end;

	set_sock_zero (address: POINTER; a_zero: POINTER) is
			-- Set zero attribute in address structure.
		external
			"C"
		end;

	get_sock_zero (address: POINTER): POINTER is
			-- Get zero attribute from address structure.
		external
			"C"
		end;

	get_servent_port (name, proto: POINTER): INTEGER is
			-- Get the services entry using `name' and `proto'
		external
			"C"
		end

end -- class NETWORK_SOCKET_ADDRESS



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

