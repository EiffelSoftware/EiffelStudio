note
	description: "Summary description for {SSL_AEAD_ENCRYPTION_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_AEAD_ENCRYPTION_CONTEXT

inherit

	SSL_AEAD_CIPHER_CONTEXT
		rename
			tag as tag_value
		end

	SSL_AEAD_ENCRYPTION_CONTEXT_I

create
	make

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
