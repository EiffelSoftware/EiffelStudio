note
	date: "$Date$"
	revision: "$Revision$"

class

	INET_ADDRESS_IMPL_V6

inherit

	INET_ADDRESS_IMPL

feature -- Access

	local_host_name: STRING_8
		local
			data: MANAGED_POINTER
		do
			create data.make (256)
			get_local_host_name (data.item)
			create Result.make_from_c (data.item)
		end

	any_local_address: INET_ADDRESS
		once
			create {INET6_ADDRESS} Result.make_from_host_and_address("::",
			{ARRAY [NATURAL_8]} <<0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00>>)
		end

	loopback_address: INET_ADDRESS
		do
			create {INET6_ADDRESS} Result.make_from_host_and_address("::1",
			{ARRAY [NATURAL_8]} <<0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01>>)
		end

feature {NONE} -- Externals

	get_local_host_name (data: POINTER)
		external
			"C"
		alias
			"en_local_host_name"
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
