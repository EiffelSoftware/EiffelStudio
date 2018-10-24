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

end
