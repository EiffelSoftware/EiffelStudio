note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	INET_PROPERTIES

feature -- Access

	frozen is_ipv6_available: BOOLEAN
		external
			"C"
		alias
			"en_ipv6_available"
		end

	frozen is_ipv4_stack_preferred: BOOLEAN
		external
			"C"
		alias
			"en_get_prefer_ipv4"
		end

	frozen set_ipv4_stack_preferred (preference: BOOLEAN)
		external
			"C"
		alias
			"en_set_prefer_ipv4"
		end

invariant
	exclusive: is_ipv4_stack_preferred implies not is_ipv6_available

end
