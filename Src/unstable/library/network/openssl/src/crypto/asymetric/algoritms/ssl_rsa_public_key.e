note
	description: "Object representing an {SSL_RSA_PUBLIC_KEY}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_RSA_PUBLIC_KEY

create
	make,
	make_pkcs1

feature {NONE} -- Initialization

	make (a_key: READABLE_STRING_GENERAL)
			-- Create a public key with `a_key' using default PEM format.
			--
		local
			l_key: C_STRING
		do
			create l_key.make (a_key)
			rsa := {SSL_CRYPTO_EXTERNALS}.c_set_rsapubkey (l_key.item)
		end

	make_pkcs1 (a_key: READABLE_STRING_GENERAL)
			-- Create a public key with `a_key' using format PKCS#1.
		local
			l_key: C_STRING
		do
			create l_key.make (a_key)
			rsa := {SSL_CRYPTO_EXTERNALS}.c_set_rsapublickey (l_key.item)
		end

feature -- Access

	rsa: POINTER
		-- item rsa public key.

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
