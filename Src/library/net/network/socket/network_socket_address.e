indexing

	description:
		"A network socket address .";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SOCKET_ADDRESS_NETWORK

inherit

	SOCKET_R
		undefine
			copy, is_equal
		end;

	SOCKET_ADDRESS
		rename
			make as socket_address_make
		redefine
			address_size, set_sock_family, get_sock_family
		end;

	SOCKET_ADDRESS
		redefine
			address_size, set_sock_family, get_sock_family,
			make
		select 
			make
		end;

creation

	make

feature 	-- Initalization

	make is
			-- create a network address object
		do
			socket_address_make;
			set_family (af_inet);
		end;

feature 	-- Status report

	port: INTEGER is
			-- Port number
		do
			Result := get_sock_port ($socket_address);
		end;	

	host_address: HOST_ADDRESS is
			-- host address of address
		do
			!!Result.make;
			Result.from_c (get_sock_addr_in ($socket_address));

		end;

feature 	-- Status setting

	set_port_from_name (a_name, protocol: STRING) is
			--  Set the port number using 'a_name' and 'protocol'
			-- to refer into the services file
		local
			ext1, ext: ANY;
			return: INTEGER;
		do
			ext1 := a_name.to_c;
			ext := protocol.to_c;
			return := get_servent_port ($ext1, $ext);
			set_port (return);
		end;

	set_port (p: INTEGER) is
			-- Set port to 'p'
		do
			set_sock_port ($socket_address, p);
		end;

	set_host_address (a_host_address: HOST_ADDRESS) is
			-- set the host address to 'a_host_address'
		local
			ext: ANY
		do
			ext := a_host_address.address_host;
			set_sock_addr_in ($socket_address, $ext);
		end;

	clear_zero is
		local
			null_pointer: POINTER
		do
			set_sock_zero ($socket_address, null_pointer);
		end;

feature {NONE} 	-- External

	address_size: INTEGER is
			-- size of address in bytes
		external
			"C"
		alias
			"inet_address_size"
		end;

	set_sock_family (address: ANY; a_family: INTEGER) is
			-- Set the family in the address structure
		external
			"C"
		alias
			"set_inet_sock_family"
		end;

	get_sock_family (address: ANY): INTEGER is
			-- Get the family from the address structure
		external
			"C"
		alias
			"get_inet_sock_family"
		end;

	set_sock_port (address: ANY; a_port: INTEGER) is
			-- Set the port in the address structure
		external
			"C"
		end;

	get_sock_port (address: ANY): INTEGER is
			-- Get the port from the address structure
		external
			"C"
		end;

	set_sock_addr_in (address: ANY; a_addr_in: ANY) is
			-- Set the host address in the address structure
		external
			"C"
		end;

	get_sock_addr_in (address: ANY): POINTER is
			-- Get the host address from the address structure
		external
			"C"
		end;

	set_sock_zero (address: ANY; a_zero: POINTER) is
			-- Set zero attribute in address structure
		external
			"C"
		end;

	get_sock_zero (address: ANY): POINTER is
			-- Get zero attribute from address structure
		external
			"C"
		end;

	get_servent_port (name, proto: ANY): INTEGER is
			-- Get the services entry using 'name' and 'proto'
		external
			"C"
		end;

end 	-- class SOCKET_ADDRESS_NETWORK

--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
