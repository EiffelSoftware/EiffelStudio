indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class

	INET_ADDRESS

feature -- Constants

    ipv4: INTEGER is 1

    ipv6: INTEGER is 2

feature

	family: INTEGER

feature

	is_equivalent (other: like Current): BOOLEAN is
		do
			if other /= Void then
				Result :=
					(family = other.family and then raw_address.is_equal (other.raw_address))
					or else (is_any_local_address and then other.is_any_local_address)
					or else (is_loopback_address and then other.is_loopback_address)
			end
		end

	is_multicast_address: BOOLEAN is
		deferred
		end

	is_any_local_address: BOOLEAN is
		deferred
    	end

	is_loopback_address: BOOLEAN is
		deferred
		end

	is_link_local_address: BOOLEAN is
		deferred
		end

	is_site_local_address: BOOLEAN is
		deferred
		end

	is_mc_global: BOOLEAN is
		deferred
		end

	is_mc_link_local: BOOLEAN is
		deferred
		end

	is_mc_site_local: BOOLEAN is
		deferred
		end

	is_mc_org_local: BOOLEAN is
		deferred
		end

	host_name: STRING is
		do
			Result := get_host_name
		end

	host_address: STRING is
		deferred
		end

	raw_address: ARRAY [NATURAL_8] is
		deferred
		end

feature {NETWORK_SOCKET_ADDRESS}

	sockaddr (port: INTEGER): MANAGED_POINTER is
		deferred
		end

feature {NONE} -- Implementation

    the_host_name: STRING

    get_host_name: STRING is
		do
			if the_host_name = Void then
				-- TODO For now we provide just the textual representation of the IP address
				the_host_name := host_address.twin
			end
		end

feature {NONE} -- Externals

	sockaddr_size: INTEGER is
		external
			"C"
		alias
			"en_socket_address_len"
		end

end
