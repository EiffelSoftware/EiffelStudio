note
	description: "Summary description for {JWT_ALG_HS256}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ALG_HS256

inherit
	JWT_ALG

feature -- Access

	name: STRING = "hs256"

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		do
			Result := base64_hmacsha256 (a_message, a_secret)
		end

feature {NONE} -- Implementation		

	base64_hmacsha256 (s: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING_8
		local
			hs256: HMAC_SHA256
		do
			create hs256.make_ascii_key (a_secret)
			hs256.update_from_string (s)
			-- if Version >= EiffelStudio 18.01 then
			-- 	Result := hs256.base64_digest --lowercase_hexadecimal_string_digest
			-- else
			Result := base64_bytes_encoded_string (hs256.digest)
			-- end
		end

	base64_bytes_encoded_string (a_bytes: SPECIAL [NATURAL_8]): STRING_8
			-- Base64 string from `a_bytes`.
			--| Note: to be removed when 18.01 is not latest release anymore.
		local
			s: STRING
			i,n: INTEGER
		do
			from
				i := 1
				n := a_bytes.count
				create s.make (n)
			until
				i > n
			loop
				s.append_code (a_bytes[i - 1])
				i := i + 1
			end
			Result := (create {BASE64}).encoded_string (s)
		end

end
