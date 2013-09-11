note
	description: "Summary description for {HMAC_SHA256}."
	date: "$Date$"
	revision: "$Revision$"
	quote: "The bureaucracy is expanding to meet the needs of an expanding bureaucracy."

class
	HMAC_SHA256

inherit
	HMAC [SHA256]

create
	make,
	make_ascii_key,
	make_hexadecimal_key

feature {NONE} -- Implementation

	new_message_hash: like message_hash
		do
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
