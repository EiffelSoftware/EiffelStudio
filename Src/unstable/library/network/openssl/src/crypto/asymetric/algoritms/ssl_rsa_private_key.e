note
	description: "Object Representing an {SSL_RSA_PRIVATE_KEY}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_RSA_PRIVATE_KEY

create
	make

feature {NONE} -- Initialization

	make (a_key: READABLE_STRING_GENERAL)
		local
			l_key: C_STRING
		do
			create l_key.make (a_key)
			rsa := {SSL_CRYPTO_EXTERNALS}.c_set_rsaprivatekey (l_key.item)
		end

feature -- Access

	rsa: POINTER
		-- item rsa private key.

;note
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
