note
	description: "Object Represent a JWT Algorithm with Name RS384 and Digital Signature Algorithm  RSASSA-PKCS1-v1_5 using SHA-384 "
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ALG_RS384
inherit
	JWT_ALG

feature -- Access

	name: STRING = "RS384"

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		do
			Result := rsa384_signed_message (a_message, a_secret)
		end

feature {NONE} -- Implementation		

	rsa384_signed_message (s: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING_8
			-- Sign the message `s' with a secret key `a_secret' using RSA with SHA384.
		local
			rsa: SSL_RSA
			l_priv_key: SSL_RSA_PRIVATE_KEY
		do
				--| todo missing error handling.
			create rsa.make
			rsa.mark_pkcs1_padding
			create l_priv_key.make (a_secret)
			if attached rsa.sha384_signed_message (l_priv_key, s) as l_signed_base64 then
				Result := l_signed_base64
			else
			 	create Result.make_empty
			end
		end
end
