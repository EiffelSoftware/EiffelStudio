note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class

	INET_ADDRESS

feature -- Constants

    ipv4: INTEGER = 1

    ipv6: INTEGER = 2

feature

	family: INTEGER

feature

	is_equivalent (other: like Current): BOOLEAN
		do
			if other /= Void then
				Result :=
					(family = other.family and then raw_address.is_equal (other.raw_address))
					or else (is_any_local_address and then other.is_any_local_address)
					or else (is_loopback_address and then other.is_loopback_address)
			end
		end

	is_multicast_address: BOOLEAN
		deferred
		end

	is_any_local_address: BOOLEAN
		deferred
    	end

	is_loopback_address: BOOLEAN
		deferred
		end

	is_link_local_address: BOOLEAN
		deferred
		end

	is_site_local_address: BOOLEAN
		deferred
		end

	is_mc_global: BOOLEAN
		deferred
		end

	is_mc_link_local: BOOLEAN
		deferred
		end

	is_mc_site_local: BOOLEAN
		deferred
		end

	is_mc_org_local: BOOLEAN
		deferred
		end

	host_name: READABLE_STRING_8
		do
			Result := internal_host_name
			if Result = Void then
					-- TODO For now we provide just the textual representation of the IP address
				Result := host_address.twin
			end
		end

	host_address: STRING
		deferred
		end

	raw_address: ARRAY [NATURAL_8]
		deferred
		end

feature {NETWORK_SOCKET_ADDRESS}

	sockaddr (port: INTEGER): MANAGED_POINTER
		deferred
		end

feature {NONE} -- Implementation

    internal_host_name: detachable READABLE_STRING_8

feature {NONE} -- Externals

	sockaddr_size: INTEGER
		external
			"C"
		alias
			"en_socket_address_len"
		end

end
