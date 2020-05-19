note
	description: "Objects that represents an IP V4 address."
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

	inaddrsz: INTEGER = 4

feature {INET_ADDRESS_FACTORY} -- Initialization

	make_from_host_and_address (a_hostname: detachable READABLE_STRING_8; an_address: detachable ARRAY [NATURAL_8])
		require
			an_address_count_valid: an_address /= Void implies an_address.count = inaddrsz
		do
			internal_host_name := a_hostname
			family := ipv4
			if an_address /= Void and then an_address.count = inaddrsz then
				the_address := an_address.item(4).to_integer_32 & 0xFF
				the_address := the_address | ((an_address.item(3).to_integer_32 |<< 8) & 0xFF00)
				the_address := the_address | ((an_address.item(2).to_integer_32 |<< 16) & 0xFF0000)
				the_address := the_address | ((an_address.item(1).to_integer_32 |<< 24) & 0xFF000000)
			end
		end

	make_from_host_and_pointer (a_hostname: detachable READABLE_STRING_8; a_pointer: POINTER)
		do
			internal_host_name := a_hostname
			family := ipv4
			if a_pointer /= default_pointer then
				the_address := c_sockaddr_get_ipv4_address (a_pointer)
			end
		end

feature -- Access

	host_address: STRING_8
		do
			Result := numeric_to_text (raw_address)
		end

    is_multicast_address: BOOLEAN
    	do
			Result := (the_address & 0xf0000000) = 0xe0000000
		end

    is_any_local_address: BOOLEAN
    	do
			Result := (the_address = 0)
    	end

    is_loopback_address: BOOLEAN
    	do
			Result := (((the_address |>> 24) & 0xFF) = 127)
		end

    is_link_local_address: BOOLEAN
		do
			Result := (((the_address |>> 24) & 0xFF)= 169) and (((the_address |>> 16) & 0xFF) = 254)
    	end

    is_site_local_address: BOOLEAN
		do
			Result := (((the_address |>> 24) & 0xFF) = 10)
	    	or else ((((the_address |>> 24) & 0xFF) = 172)
			and (((the_address |>> 16) & 0xF0) = 16))
	    	or else ((((the_address |>> 24) & 0xFF) = 192)
			and (((the_address |>> 16) & 0xFF) = 168))
    	end

    is_mc_global: BOOLEAN
    	local
    		byte_1, byte_2, byte_3: INTEGER
		do
    		byte_1 := ((the_address |>> 24) & 0xFF)
    		byte_2 := ((the_address |>> 16) & 0xFF)
    		byte_3 := ((the_address |>> 8) & 0xFF)
			Result := (byte_1 >= 224 and byte_1 <= 238 ) and
 	    	 not(byte_1 = 224 and byte_2 = 0 and byte_3 = 0)
 	    end

    is_mc_node_local: BOOLEAN
    	do
			Result := False
    	end

    is_mc_link_local: BOOLEAN
   		do
			Result := (((the_address |>> 24) & 0xFF) = 224)
	    	and (((the_address |>> 16) & 0xFF) = 0)
	    	and (((the_address |>> 8) & 0xFF) = 0)
    	end

    is_mc_site_local: BOOLEAN
    	do
			Result := (((the_address |>> 24) & 0xFF) = 239)
	    	and (((the_address |>> 16) & 0xFF) = 255);
    	end

    is_mc_org_local: BOOLEAN
    	do
			Result := (((the_address |>> 24) & 0xFF) = 239)
	    	and (((the_address |>> 16) & 0xFF) >= 192)
	    	and (((the_address |>> 16) & 0xFF) <= 195);
    	end

	raw_address: ARRAY [NATURAL_8]
		do
			create Result.make_filled ({NATURAL_8}0, 1, inaddrsz)
			Result.put (((the_address |>> 24) & 0xFF).to_natural_8, 1)
			Result.put (((the_address |>> 16) & 0xFF).to_natural_8, 2)
			Result.put (((the_address |>> 8) & 0xFF).to_natural_8, 3)
			Result.put ((the_address & 0xFF).to_natural_8, 4)
		end

feature {NETWORK_SOCKET_ADDRESS}

	sockaddr (a_port: INTEGER): MANAGED_POINTER
		do
			create Result.make (sockaddr_size)
			fill_ipv4 (Result.item, the_address, a_port)
		end

feature {NONE} -- Implementation

	the_address: INTEGER

	numeric_to_text (addr: ARRAY [NATURAL_8]): STRING_8
		require
			addr /= Void and then addr.count = inaddrsz
		do
			create Result.make_empty
			Result.append_integer(addr.item (1))
			Result.append_character('.')
			Result.append_integer(addr.item (2))
			Result.append_character('.')
			Result.append_integer(addr.item (3))
			Result.append_character('.')
			Result.append_integer(addr.item (4))
		end

feature {NONE} -- Externals

	fill_ipv4 (data_ptr: POINTER; address: INTEGER; port: INTEGER)
		external
			"C"
		alias
			"en_socket_address_fill_ipv4"
		end

	c_sockaddr_get_ipv4_address (a_pointer: POINTER): INTEGER
		external
			"C"
		alias
			"en_sockaddr_get_ipv4_address"
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
