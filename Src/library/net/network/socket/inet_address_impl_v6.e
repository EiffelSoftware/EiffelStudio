note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	INET_ADDRESS_IMPL_V6

inherit

	INET_ADDRESS_IMPL

feature -- Access

	local_host_name: STRING
		local
			data: MANAGED_POINTER
		do
			create data.make (256)
			get_local_host_name (data.item)
			create Result.make_from_c_pointer (data.item)
		end

	any_local_address: INET_ADDRESS
		once
			create {INET6_ADDRESS} Result.make_from_host_and_address("::",
			<<0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00>>);
		end

	loopback_address: INET_ADDRESS
		do
			create {INET6_ADDRESS} Result.make_from_host_and_address("localhost",
			<<0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01>>)
		end

feature {NONE} -- Externals

	get_local_host_name (data: POINTER)
		external
			"C"
		alias
			"en_local_host_name"
		end


end
