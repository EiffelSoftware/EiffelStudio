note
	description: "JSON Web Token encoder"
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ENCODER

feature -- Basic operations

	encoded_values (a_values: STRING_TABLE [READABLE_STRING_GENERAL]; a_secret: READABLE_STRING_8; a_algo: READABLE_STRING_8): STRING
		local
			j: JSON_OBJECT
		do
			create j.make_with_capacity (a_values.count)
			across
				a_values as ic
			loop
				j.put_string (ic.item, ic.key)
			end
			Result := encoded_json (j, a_secret, a_algo)
		end

	encoded_json (a_json: JSON_OBJECT; a_secret: READABLE_STRING_8; a_algo: READABLE_STRING_8): STRING
		local
			vis: JSON_PRETTY_STRING_VISITOR
			s: STRING
		do
			create s.make_empty
			create vis.make (s)
			vis.visit_json_object (a_json)
			Result := encoded_string (s, a_secret, a_algo)
		end

	encoded_string (a_payload: READABLE_STRING_8; a_secret: READABLE_STRING_8; a_algo: READABLE_STRING_8): STRING
		local
			alg, sign: STRING_8
			l_enc_payload, l_enc_header: READABLE_STRING_8
		do
			reset_error
			if a_algo.is_case_insensitive_equal_general (alg_hs256) then
				alg := alg_hs256
			elseif a_algo.is_case_insensitive_equal_general (alg_none) then
				alg := alg_none
			else
				report_unsupported_alg_error (a_algo)
				alg := alg_hs256 -- Default ...
			end
			l_enc_header := base64url_encode (header ("JWT", alg))
			l_enc_payload := base64url_encode (a_payload)
			sign := signature (l_enc_header, l_enc_payload, a_secret, alg)
			create Result.make (l_enc_header.count + 1 + l_enc_payload.count + 1 + sign.count)
			Result.append (l_enc_header)
			Result.append_character ('.')
			Result.append (l_enc_payload)
			Result.append_character ('.')
			Result.append (sign)
		end

	decoded_string (a_token: READABLE_STRING_8; a_secret: READABLE_STRING_8; a_algo: detachable READABLE_STRING_8): detachable STRING
		local
			i,j,n: INTEGER
			alg, l_enc_payload, l_enc_header, l_signature: READABLE_STRING_8
		do
			reset_error
			n := a_token.count
			i := a_token.index_of ('.', 1)
			if i > 0 then
				j := a_token.index_of ('.', i + 1)
				if j > 0 then
					l_enc_header := a_token.substring (1, i - 1)
					l_enc_payload := a_token.substring (i + 1, j - 1)
					l_signature := a_token.substring (j + 1, n)
					Result := base64url_decode (l_enc_payload)
					alg := a_algo
					if alg = Void then
						alg := signature_algorithm_from_encoded_header (l_enc_header)
						if alg = Void then
								-- Use default
							alg := alg_hs256
						end
					end
					check alg_set: alg /= Void end
					if alg.is_case_insensitive_equal (alg_hs256) then
						alg := alg_hs256
					elseif alg.is_case_insensitive_equal (alg_none) then
						alg := alg_none
					else
						alg := alg_hs256
						report_unsupported_alg_error (alg)
					end

					if not l_signature.same_string (signature (l_enc_header, l_enc_payload, a_secret, alg)) then
						report_unverified_token_error
					end
				else
					report_invalid_token
				end
			else
				report_invalid_token
			end
		end

feature -- Error status		

	error_code: INTEGER
			-- Last error, if any.

	has_error: BOOLEAN
			-- Last `encoded_string` reported an error?	
		do
			Result := error_code /= 0
		end

	has_unsupported_alg_error: BOOLEAN
		do
			Result := error_code = unsupported_alg_error
		end

	has_unverified_token_error: BOOLEAN
		do
			Result := error_code = unverified_token_error
		end

	has_invalid_token_error: BOOLEAN
		do
			Result := error_code = invalid_token_error
		end

feature {NONE} -- Error reporting

	reset_error
		do
			error_code := 0
		end

	report_unsupported_alg_error (alg: READABLE_STRING_8)
		do
			error_code := unsupported_alg_error
		end

	report_unverified_token_error
		do
			error_code := unverified_token_error
		end

	report_invalid_token
		do
			error_code := invalid_token_error
		end

feature {NONE} -- Constants

	unsupported_alg_error: INTEGER = -2

	unverified_token_error: INTEGER = -4

	invalid_token_error: INTEGER = -8

	alg_hs256: STRING = "HS256"
			-- HMAC SHA256.

	alg_none: STRING = "none"
			-- for unsecured token.

feature -- Conversion

	header (a_type: detachable READABLE_STRING_8; alg: READABLE_STRING_8): STRING
		do
			create Result.make_empty
			Result.append ("{%"typ%":%"")
			if a_type /= Void then
				Result.append (a_type)
			else
				Result.append ("JWT")
			end
			Result.append ("%",%"alg%":%"")
			Result.append (alg)
			Result.append ("%"}")
		end

feature {NONE} -- Conversion		

	signature_algorithm_from_encoded_header (a_enc_header: READABLE_STRING_8): detachable STRING_8
		local
			jp: JSON_PARSER
		do
			create jp.make_with_string (base64url_decode (a_enc_header))
			jp.parse_content
			if
				attached jp.parsed_json_object as jo and then
				attached {JSON_STRING} jo.item ("alg") as j_alg
			then
				Result := j_alg.unescaped_string_8
			end
		end

feature -- Base64

	base64url_encode (s: READABLE_STRING_8): STRING_8
		local
			urlencoder: URL_ENCODER
			base64: BASE64
		do
			create urlencoder
			create base64
			Result := urlsafe_encode (base64.encoded_string (s))
		end

feature {NONE} -- Implementation

	signature (a_enc_header, a_enc_payload: READABLE_STRING_8; a_secret: READABLE_STRING_8; alg: READABLE_STRING_8): STRING_8
		local
			s: STRING
		do
			if alg = alg_none then
				create Result.make_empty
			else
				create s.make (a_enc_header.count + 1 + a_enc_payload.count)
				s.append (a_enc_header)
				s.append_character ('.')
				s.append (a_enc_payload)
				if alg = alg_hs256 then
					Result := base64_hmacsha256 (s, a_secret)
				else
					Result := base64_hmacsha256 (s, a_secret)
				end
				Result := urlsafe_encode (Result)
			end
		end

	base64url_decode (s: READABLE_STRING_8): STRING_8
		local
			urlencoder: URL_ENCODER
			base64: BASE64
		do
			create urlencoder
			create base64
			Result := base64.decoded_string (urlsafe_decode (s))
		end

	urlsafe_encode (s: READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (s)
			Result.replace_substring_all ("=", "")
			Result.replace_substring_all ("+", "-")
			Result.replace_substring_all ("/", "_")
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

	base64_hmacsha256 (s: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING_8
		local
			hs256: HMAC_SHA256
		do
			create hs256.make_ascii_key (a_secret)
			hs256.update_from_string (s)
			Result := hs256.base64_digest --lowercase_hexadecimal_string_digest
		end

end
