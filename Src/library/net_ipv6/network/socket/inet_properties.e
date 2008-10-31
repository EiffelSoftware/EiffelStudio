indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	INET_PROPERTIES

feature -- Access

	frozen is_ipv6_available: BOOLEAN is
		external
			"C"
		alias
			"en_ipv6_available"
		end

	frozen is_ipv4_stack_preferred: BOOLEAN is
		external
			"C"
		alias
			"en_get_prefer_ipv4"
		end

	frozen set_ipv4_stack_preferred (preference: BOOLEAN) is
		external
			"C"
		alias
			"en_set_prefer_ipv4"
		end
end
