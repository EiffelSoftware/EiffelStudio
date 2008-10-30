indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	INET6_ADDRESS

inherit

	INET_ADDRESS

	INET_PROPERTIES

create

	make_from_host_and_address, make_from_host_and_address_and_interface_name, make_from_host_and_address_and_scope

create {INET_ADDRESS_FACTORY}

	make_from_host_and_pointer

feature -- Constants

	INADDRSZ: INTEGER = 16


feature {INET_ADDRESS_FACTORY} -- Initialization

	make_from_host_and_address (a_hostname: STRING; an_address: ARRAY[INTEGER_8]) is
		do
			family := ipv6
			the_host_name := a_hostname
			the_address := an_address
		end

	make_from_host_and_address_and_interface_name (a_hostname: STRING; an_address: ARRAY[INTEGER_8]; an_iface_name: STRING) is
		do
			make_from_host_and_address_and_scope(a_hostname, an_address, 0)
		end

	make_from_host_and_address_and_scope (a_hostname: STRING; an_address: ARRAY[INTEGER_8]; a_scope_id: INTEGER) is
		do
			make_from_host_and_address (a_hostname, an_address)
			the_scope_id := a_scope_id
		end

	make_from_host_and_pointer (a_hostname: STRING; a_pointer: POINTER) is
		local
			ptr: POINTER
			addr: ARRAY[INTEGER_8]
			i: INTEGER
			scope: INTEGER_32
		do
			create addr.make (1, INADDRSZ)
			if a_pointer /= default_pointer then
				ptr := c_addrinfo_get_ipv6_address (a_pointer)
				from
					i := 1
				until
					i > INADDRSZ
				loop
					addr.put (c_get_addr_element (ptr, i-1), i)
					i := i + 1
				end
				scope := c_addrinfo_get_ipv6_address_scope (a_pointer)
			end
			make_from_host_and_address_and_scope (a_hostname, addr, scope)
		end

feature -- Access

    is_multicast_address: BOOLEAN is
    	do
			Result := ((the_address[1] & 0xff) = 0xff)
		end

    is_any_local_address: BOOLEAN is
    	local
    		test: INTEGER_8
    		i: INTEGER
    	do
			test := 0
			from
				i := 1
			until
				i > INADDRSZ
			loop
				test := test | the_address[i]
			end
			Result := (test = 0)
    	end

    is_loopback_address: BOOLEAN is
    	local
    		test: INTEGER_8
    		i: INTEGER
    	do
			test := 0
			from
				i := 1
			until
				i > 15
			loop
				test := test | the_address[i]
			end
			Result := (test = 0) and (the_address[16] = 1)
    	end

    is_link_local_address: BOOLEAN is
		do
			Result := ((the_address[1] & 0xff) = 0xfe and (the_address[2] & 0xc0) = 0x80)
    	end

    is_site_local_address: BOOLEAN is
		do
			Result := ((the_address[1] & 0xff) = 0xfe and (the_address[2] & 0xc0) = 0xc0)
    	end

    is_mc_global: BOOLEAN is
		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x0e)

 	    end

    is_mc_node_local: BOOLEAN is
    	do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x01)
    	end

    is_mc_link_local: BOOLEAN is
   		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x02)
    	end

    is_mc_site_local: BOOLEAN is
    	do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x05)
    	end

    is_mc_org_local: BOOLEAN is
    	do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x08)
    	end

	raw_address: ARRAY[INTEGER_8] is
		do
			Result := the_address.twin
		end

feature {NETWORK_SOCKET_ADDRESS}

	sockaddr (a_port: INTEGER): MANAGED_POINTER is
		local
			a: ANY
		do
			if is_ipv6_available then
				create Result.make (sockaddr_size)
				a := the_address.to_c
				fill_ipv6 (Result.item, $a, a_port, the_scope_id)
			end
		end

feature {NONE} -- Implementation

	the_address: ARRAY[INTEGER_8]

	the_scope_id: INTEGER

feature {NONE} -- Externals

	fill_ipv6 (data_ptr: POINTER; address: POINTER; port: INTEGER; scopeid: INTEGER) is
		external
			"C"
		alias
			"en_socket_address_fill_ipv6"
		end

	c_addrinfo_get_ipv6_address (a_pointer: POINTER): POINTER is
		external
			"C"
		alias
			"en_addrinfo_get_ipv6_address"
		end

	c_addrinfo_get_ipv6_address_scope (a_pointer: POINTER): INTEGER_32 is
		external
			"C"
		alias
			"en_addrinfo_get_ipv6_address_scope"
		end

	c_get_addr_element (ptr: POINTER; index: INTEGER): INTEGER_8 is
		external
			"C inline"
		alias
			"return ((unsigned char*)$ptr)[$index];"
		end

end
