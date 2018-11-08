note
	description: "Summary description for {JWT_UTILITIES}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_UTILITIES

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

	signature (a_enc_header, a_enc_payload: READABLE_STRING_8; a_secret: READABLE_STRING_8; alg: JWT_ALG): STRING_8
		local
			s: STRING
		do
			if alg.is_none then
				create Result.make_empty
			else
				create s.make (a_enc_header.count + 1 + a_enc_payload.count)
				s.append (a_enc_header)
				s.append_character ('.')
				s.append (a_enc_payload)
				Result := urlsafe_encode (alg.encoded_string (s, a_secret))
			end
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

end
