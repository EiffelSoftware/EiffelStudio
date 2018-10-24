note
	description: "Object representing an {SSL_RSA_PUBLIC_KEY}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_RSA_PUBLIC_KEY

create
	make

feature {NONE} -- Initialization

	make (a_key: READABLE_STRING_GENERAL)
		local
			l_key: C_STRING
		do
			create l_key.make (a_key)
			rsa := {SSL_CRYPTO_EXTERNALS}.c_set_rsapublickey (l_key.item)
		end

feature -- Access

	rsa: POINTER
		-- item rsa public key.

end
