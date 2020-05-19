note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class

	INET_ADDRESS_IMPL

feature -- Access

	local_host_name: STRING_8
		deferred
		end

	any_local_address: INET_ADDRESS
		deferred
		end

	loopback_address: INET_ADDRESS
		deferred
		end

--	host_by_address (an_address: ARRAY [NATURAL_8]): STRING
--		deferred
--		end

--	is_reachable (addr: INET_ADDRESS; timeout: INTEGER; netif : NETWORK_INTERFACE; ttl: INTEGER): BOOLEAN
--		deferred
--		end

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
