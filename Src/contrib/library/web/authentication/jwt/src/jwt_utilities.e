note
	description: "Summary description for {JWT_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_UTILITIES

feature -- Constants

	alg_hs256: STRING = "HS256"
			-- HMAC SHA256.

	alg_none: STRING = "none"
			-- for unsecured token.

feature -- Encoding

	base64url_encode (s: READABLE_STRING_8): STRING_8
		local
			urlencoder: URL_ENCODER
			base64: BASE64
		do
			create urlencoder
			create base64
			Result := urlsafe_encode (base64.encoded_string (s))
		end

	urlsafe_encode (s: READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (s)
			Result.replace_substring_all ("=", "")
			Result.replace_substring_all ("+", "-")
			Result.replace_substring_all ("/", "_")
		end

	signature (a_enc_header, a_enc_payload: READABLE_STRING_8; a_secret: READABLE_STRING_8; alg: READABLE_STRING_8): STRING_8
		local
			s: STRING
		do
			if alg.is_case_insensitive_equal (alg_none) then
				create Result.make_empty
			else
				create s.make (a_enc_header.count + 1 + a_enc_payload.count)
				s.append (a_enc_header)
				s.append_character ('.')
				s.append (a_enc_payload)
				if alg.is_case_insensitive_equal (alg_hs256) then
					Result := base64_hmacsha256 (s, a_secret)
				else
					Result := base64_hmacsha256 (s, a_secret)
				end
				Result := urlsafe_encode (Result)
			end
		end

	base64_hmacsha256 (s: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING_8
		local
			hs256: HMAC_SHA256
		do
			create hs256.make_ascii_key (a_secret)
			hs256.update_from_string (s)
			Result := hs256.base64_digest --lowercase_hexadecimal_string_digest
		end

feature -- Decoding

	base64url_decode (s: READABLE_STRING_8): STRING_8
		local
			urlencoder: URL_ENCODER
			base64: BASE64
		do
			create urlencoder
			create base64
			Result := base64.decoded_string (urlsafe_decode (s))
		end

	urlsafe_decode (s: READABLE_STRING_8): STRING_8
		local
			i: INTEGER
		do
			create Result.make_from_string (s)
			Result.replace_substring_all ("-", "+")
			Result.replace_substring_all ("_", "/")
			from
				i := Result.count \\ 4
			until
				i = 0
			loop
				i := i - 1
				Result.extend ('=')
			end
		end

feature -- Signature

	supported_signature_algorithms: LIST [READABLE_STRING_8]
			-- Supported signature algorithm `alg`?	
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (2)
			Result.extend (alg_hs256)
			Result.extend (alg_none)
		end

	is_supporting_signature_algorithm (alg: READABLE_STRING_8): BOOLEAN
			-- Is supporting signature algorithm `alg`?	
		do
			Result := across supported_signature_algorithms as ic some alg.is_case_insensitive_equal (ic.item) end
		end

end
