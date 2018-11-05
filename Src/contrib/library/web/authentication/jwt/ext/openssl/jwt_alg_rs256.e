note
	description: "Object Represent a JWT Algorithm with Name RS256 and Digital Signature Algorithm  RSASSA-PKCS1-v1_5 using SHA-256 "
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ALG_RS256

inherit
	JWT_ALG

feature -- Access

	name: STRING = "RS256"

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		do
			Result := sign_rsa256 (a_message, a_secret)
		end

feature {NONE} -- Implementation		

	sign_rsa256 (s: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING_8
		local
			rs256: SSL_RSA
			l_priv_key: SSL_RSA_PRIVATE_KEY
			l_result: STRING_8
		do
				--| todo missing error handling.
			create rs256.make
			rs256.mark_pkcs1_padding
			create l_priv_key.make (a_secret)
			if attached rs256.sign_sha256 (l_priv_key, s) as l_signed_base64 then
				Result := l_signed_base64
			else
			 	create Result.make_empty
			end
		end
end
