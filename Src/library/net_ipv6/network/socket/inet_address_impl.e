indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class

	INET_ADDRESS_IMPL

feature -- Access

	local_host_name: STRING is
		deferred
		end

	any_local_address: INET_ADDRESS is
		deferred
		end

	loopback_address: INET_ADDRESS is
		deferred
		end

--	host_by_address (an_address: ARRAY[NATURAL_8]): STRING is
--		deferred
--		end

--	is_reachable (addr: INET_ADDRESS; timeout: INTEGER; netif : NETWORK_INTERFACE; ttl: INTEGER): BOOLEAN is
--		deferred
--		end

end
