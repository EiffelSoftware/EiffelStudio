note
	description: "Objects that represents an IP V6 address."
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

	make_from_host_and_address (a_hostname: detachable READABLE_STRING_8; an_address: ARRAY [NATURAL_8])
		require
			an_address_count_valid: an_address.count = inaddrsz
		do
			family := ipv6
			internal_host_name := a_hostname
			the_address := an_address
		end

	make_from_host_and_address_and_interface_name (a_hostname: detachable READABLE_STRING_8; an_address: ARRAY [NATURAL_8]; an_iface_name: READABLE_STRING_8)
		require
			an_address_count_valid: an_address.count = inaddrsz
		do
			-- TODO Implement scope check
			the_scope_ifname := an_iface_name
			make_from_host_and_address_and_scope(a_hostname, an_address, 0)
		end

	make_from_host_and_address_and_scope (a_hostname: detachable READABLE_STRING_8; an_address: ARRAY [NATURAL_8]; a_scope_id: INTEGER)
		require
			an_address_count_valid: an_address.count = inaddrsz
		do
			make_from_host_and_address (a_hostname, an_address)
			if a_scope_id >= 0 then
				the_scope_id := a_scope_id
				is_scope_id_set := True
			end
		end

	make_from_host_and_pointer (a_hostname: detachable READABLE_STRING_8; a_pointer: POINTER)
		local
			ptr: POINTER
			addr: ARRAY [NATURAL_8]
			i: INTEGER
			scope: INTEGER
		do
			create addr.make_filled ({NATURAL_8} 0, 1, inaddrsz)
			if a_pointer /= default_pointer then
				ptr := c_sockaddr_get_ipv6_address (a_pointer)
				from
					i := 1
				until
					i > inaddrsz
				loop
					addr.put (c_get_addr_element (ptr, i-1), i)
					i := i + 1
				end
				scope := c_sockaddr_get_ipv6_address_scope (a_pointer)
			end
			make_from_host_and_address_and_scope (a_hostname, addr, scope)
		end

feature -- Access

	host_address: STRING_8
		local
			l_scope_ifname: like the_scope_ifname
		do
			Result := numeric_to_text (the_address)
			l_scope_ifname := the_scope_ifname
			if l_scope_ifname /= Void then -- must check this first
				Result.append_character ('%%')
				Result.append_string(l_scope_ifname)
			elseif is_scope_id_set and then the_scope_id > 0 then
				Result.append_character ('%%')
				Result.append_integer (the_scope_id)
			end
		end

	is_multicast_address: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xff)
		end

	is_any_local_address: BOOLEAN
		local
			test: NATURAL_8
			i: INTEGER
		do
			test := 0
			from
				i := 1
			until
				i > inaddrsz
			loop
				test := test | the_address[i]
				i := i + 1
			end
			Result := (test = 0)
		end

	is_loopback_address: BOOLEAN
		local
			test: NATURAL_8
			i: INTEGER
		do
			test := 0
			from
				i := 1
			until
				i > 15
			loop
				test := test | the_address[i]
				i := i + 1
			end
			Result := (test = 0) and (the_address[16] = 1)
		end

	is_link_local_address: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xfe and (the_address[2] & 0xc0) = 0x80)
		end

	is_site_local_address: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xfe and (the_address[2] & 0xc0) = 0xc0)
		end

	is_mc_global: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x0e)
		end

	is_mc_node_local: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x01)
		end

	is_mc_link_local: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x02)
		end

	is_mc_site_local: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x05)
		end

	is_mc_org_local: BOOLEAN
		do
			Result := ((the_address[1] & 0xff) = 0xff and (the_address[2] & 0x0f) = 0x08)
		end

	raw_address: ARRAY [NATURAL_8]
		do
			Result := the_address.twin
		end

feature {NETWORK_SOCKET_ADDRESS}

	sockaddr (a_port: INTEGER): MANAGED_POINTER
		local
			a: MANAGED_POINTER
		do
			create Result.make (sockaddr_size)
			create a.make_from_array (the_address)
			fill_ipv6 (Result.item, a.item, a_port, the_scope_id)
		end

feature {NONE} -- Implementation

	the_address: ARRAY [NATURAL_8]

	the_scope_id: INTEGER

	the_scope_ifname: detachable READABLE_STRING_8

	is_scope_ifname_set: BOOLEAN
			-- This will be set to true if the object is constructed with a scoped
			-- interface instead of a numeric scope id.
		do
			Result := the_scope_ifname /= Void
		end

	is_scope_id_set: BOOLEAN
			-- This will be set to true when the scope_id field contains a valid
			-- integer scope_id.

	numeric_to_text (addr: ARRAY [NATURAL_8]): STRING_8
		require
			addr /= Void and then addr.count = inaddrsz
		local
			i: INTEGER
			e: NATURAL_16
		do
			create Result.make_empty
			from
				i := 1
			until
				i >= inaddrsz
			loop
				e := ((( addr.item (i).as_natural_16 |<< 8 ) & 0xff00) | (addr.item (i+1).as_natural_16 & 0xff)).as_natural_16
				Result.append_string_general(e.to_hex_string)
				if i < inaddrsz - 1 then
					Result.append_character(':')
				end
				i := i + 2
			end
		end

feature {NONE} -- Externals

	fill_ipv6 (data_ptr: POINTER; address: POINTER; port: INTEGER; scopeid: INTEGER)
		external
			"C"
		alias
			"en_socket_address_fill_ipv6"
		end

	c_sockaddr_get_ipv6_address (a_pointer: POINTER): POINTER
		external
			"C"
		alias
			"en_sockaddr_get_ipv6_address"
		end

	c_sockaddr_get_ipv6_address_scope (a_pointer: POINTER): INTEGER
		external
			"C"
		alias
			"en_sockaddr_get_ipv6_address_scope"
		end

	c_get_addr_element (ptr: POINTER; index: INTEGER): NATURAL_8
		external
			"C inline"
		alias
			"((unsigned char*)$ptr)[$index]"
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
