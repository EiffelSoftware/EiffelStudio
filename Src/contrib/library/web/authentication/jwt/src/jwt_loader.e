note
	description: "Loader and verifier to JWT token."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Known Critical vulnerabilities in JWT libs", "protocol=URI", "src=https://auth0.com/blog/critical-vulnerabilities-in-json-web-token-libraries/"

class
	JWT_LOADER

inherit
	JWT_UTILITIES

feature -- Access

	token (a_token_input: READABLE_STRING_8; a_alg: detachable READABLE_STRING_8; a_verification_key: READABLE_STRING_8; ctx: detachable JWT_CONTEXT): detachable JWT
			-- Decoded token from `a_token_input` given the verification key `a_verification_key` and optional (but recommended) signature algorithm `a_alg`, and optional context `ctx`
			-- used to specify eventual issuer and various parameters.
			-- WARNING: passing Void for `a_alg` is not safe, as the server should know which alg he used for tokens,
			-- 			leaving the possibility to use the header alg is dangerous as client may use "none" and then bypass verification!
		require
			a_valid_alg: a_alg /= Void implies is_supporting_signature_algorithm (a_alg)
		local
			jws: JWS
			i,j,n: INTEGER
			alg, l_enc_payload, l_enc_header, l_signature: READABLE_STRING_8
		do
			n := a_token_input.count
			i := a_token_input.index_of ('.', 1)
			if i > 0 then
				j := a_token_input.index_of ('.', i + 1)
				if j > 0 then
					l_enc_header := a_token_input.substring (1, i - 1)
					l_enc_payload := a_token_input.substring (i + 1, j - 1)
					l_signature := a_token_input.substring (j + 1, n)
					create jws.make_with_json_payload (base64url_decode (l_enc_payload))
					alg := signature_algorithm_from_encoded_header (l_enc_header)
					if a_alg /= Void then
						if alg /= Void and then not alg.is_case_insensitive_equal_general (a_alg) then
							jws.report_mismatched_alg_error (a_alg, alg)
						else
							alg := a_alg
						end
					else
						if alg = Void then
								-- Use default
							alg := alg_hs256
						end
					end
					jws.set_algorithm (alg)
					check alg_set: alg /= Void end
					if ctx = Void or else not ctx.validation_ignored then
						if not is_supporting_signature_algorithm (alg) then
							jws.report_unsupported_alg_error (alg)
							alg := alg_hs256
						end
						if not l_signature.same_string (signature (l_enc_header, l_enc_payload, a_verification_key, alg)) then
							jws.report_unverified_token_error
						end
						if
							not jws.has_error and then
							ctx /= Void
						then
							check not ctx.validation_ignored end
							if jws.is_expired (ctx.time) then
								jws.report_claim_validation_error ("exp")
							end
							if not jws.is_nbf_validated (ctx.time) then
								jws.report_claim_validation_error ("nbf")
							end
							if
								not jws.is_iss_validated (ctx.issuer)
							then
								jws.report_claim_validation_error ("iss")
							end
							if
								not jws.is_aud_validated (ctx.audience)
							then
								jws.report_claim_validation_error ("aud")
							end

						end
					end
				else
					-- jws.report_invalid_token
				end
			else
				-- jws.report_invalid_token
			end
			Result := jws
		end

feature {NONE} -- Implementation

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

end
