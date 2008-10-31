indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	INET4_ADDRESS

inherit

	INET_ADDRESS

create

	make_from_host_and_address

create {INET_ADDRESS_FACTORY}

	make_from_host_and_pointer

feature -- Constants

	INADDRSZ: INTEGER = 4

feature {INET_ADDRESS_FACTORY} -- Initialization

	make_from_host_and_address (a_hostname: STRING; an_address: ARRAY[NATURAL_8]) is
		do
			the_host_name := a_hostname
			family := ipv4
			if an_address /= Void and then an_address.count = INADDRSZ then
				the_address := an_address[4].to_integer_32 & 0xFF
				the_address := the_address | ((an_address[3].to_integer_32 |<< 8) & 0xFF00)
				the_address := the_address | ((an_address[2].to_integer_32 |<< 16) & 0xFF0000)
				the_address := the_address | ((an_address[1].to_integer_32 |<< 24) & 0xFF000000)
			end
		end

	make_from_host_and_pointer (a_hostname: STRING; a_pointer: POINTER) is
		do
			the_host_name := a_hostname
			family := ipv4
			if a_pointer /= default_pointer then
				the_address := c_addrinfo_get_ipv4_address (a_pointer)
			end
		end

feature -- Access

	host_address: STRING is
		do
			Result := numeric_to_text(raw_address)
		end

    is_multicast_address: BOOLEAN is
    	do
			Result := (the_address & 0xf0000000) = 0xe0000000
		end

    is_any_local_address: BOOLEAN is
    	do
			Result := (the_address = 0)
    	end

    is_loopback_address: BOOLEAN is
    	do
			Result := (((the_address |>> 24) & 0xFF) = 127)
		end

    is_link_local_address: BOOLEAN is
		do
			Result := (((the_address |>> 24) & 0xFF)= 169) and (((the_address |>> 16) & 0xFF) = 254)
    	end

    is_site_local_address: BOOLEAN is
		do
			Result := (((the_address |>> 24) & 0xFF) = 10)
	    	or else ((((the_address |>> 24) & 0xFF) = 172)
			and (((the_address |>> 16) & 0xF0) = 16))
	    	or else ((((the_address |>> 24) & 0xFF) = 192)
			and (((the_address |>> 16) & 0xFF) = 168))
    	end

    is_mc_global: BOOLEAN is
    	local
    		byte_1, byte_2, byte_3: INTEGER_32
		do
    		byte_1 := ((the_address |>> 24) & 0xFF)
    		byte_2 := ((the_address |>> 16) & 0xFF)
    		byte_3 := ((the_address |>> 8) & 0xFF)
			Result := (byte_1 >= 224 and byte_1 <= 238 ) and
 	    	 not(byte_1 = 224 and byte_2 = 0 and byte_3 = 0)
 	    end

    is_mc_node_local: BOOLEAN is
    	do
			Result := false;
    	end

    is_mc_link_local: BOOLEAN is
   		do
			Result := (((the_address |>> 24) & 0xFF) = 224)
	    	and (((the_address |>> 16) & 0xFF) = 0)
	    	and (((the_address |>> 8) & 0xFF) = 0)
    	end

    is_mc_site_local: BOOLEAN is
    	do
			Result := (((the_address |>> 24) & 0xFF) = 239)
	    	and (((the_address |>> 16) & 0xFF) = 255);
    	end

    is_mc_org_local: BOOLEAN is
    	do
			Result := (((the_address |>> 24) & 0xFF) = 239)
	    	and (((the_address |>> 16) & 0xFF) >= 192)
	    	and (((the_address |>> 16) & 0xFF) <= 195);
    	end

	raw_address: ARRAY[NATURAL_8] is
		do
			create Result.make(1,INADDRSZ)
			Result.put (((the_address |>> 24) & 0xFF).to_natural_8, 1)
			Result.put (((the_address |>> 16) & 0xFF).to_natural_8, 2)
			Result.put (((the_address |>> 8) & 0xFF).to_natural_8, 3)
			Result.put ((the_address & 0xFF).to_natural_8, 4)
		end

feature {NETWORK_SOCKET_ADDRESS}

	sockaddr (a_port: INTEGER): MANAGED_POINTER is
		do
			create Result.make (sockaddr_size)
			fill_ipv4 (Result.item, the_address, a_port)
		end

feature {NONE} -- Implementation

	the_address: INTEGER_32

	numeric_to_text (addr: ARRAY[NATURAL_8]): STRING is
		require
			addr /= Void and then addr.count = INADDRSZ
		do
			create Result.make_empty
			Result.append_integer(addr[1])
			Result.append_character('.')
			Result.append_integer(addr[2])
			Result.append_character('.')
			Result.append_integer(addr[3])
			Result.append_character('.')
			Result.append_integer(addr[4])
		end

feature {NONE} -- Externals

	fill_ipv4 (data_ptr: POINTER; address: INTEGER; port: INTEGER) is
		external
			"C"
		alias
			"en_socket_address_fill_ipv4"
		end

	c_addrinfo_get_ipv4_address (a_pointer: POINTER): INTEGER_32 is
		external
			"C"
		alias
			"en_addrinfo_get_ipv4_address"
		end

end
