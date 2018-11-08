note
	description: "JSON Web Signature (JWS)"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=JSON Web Signature", "src=https://tools.ietf.org/html/rfc7515", "protocol=uri"
	EIS: "name=JSON Web Token (JWT)", "src=https://tools.ietf.org/html/rfc7519", "protocol=uri"

class
	JWS

inherit
	JWT
		redefine
			default_create
		end

	JWT_UTILITIES
		redefine
			default_create
		end

create
	default_create,
	make_with_algorithm,
	make_with_claims,
	make_with_json_payload

feature {NONE} -- Initialization

	default_create
		do
			Precursor {JWT}
			set_algorithm_to_hs256
		end

	make_with_algorithm (alg: like algorithm)
		do
			default_create
			set_algorithm (alg)
		end

	make_with_claims (tb: STRING_TABLE [READABLE_STRING_GENERAL])
		do
			default_create
			across
				tb as ic
			loop
				claimset.set_claim (ic.key, ic.item)
			end
		end

	make_with_json_payload (a_json: READABLE_STRING_8)
		do
			default_create
			claimset.import_json (a_json)
		end

feature -- Access

	algorithm: READABLE_STRING_8
		do
			Result := header.algorithm
		end

feature -- Conversion

	encoded_string (a_secret: READABLE_STRING_8): STRING
		local
			sign, alg_name: READABLE_STRING_8
			alg: JWT_ALG
			l_enc_payload, l_enc_header: READABLE_STRING_8
		do
			reset_error
			alg_name := header.algorithm
			alg := algorithms [alg_name]
			if alg = Void then
				report_unsupported_alg_error (alg_name)
				alg := algorithms.hs256 -- Default ...
			end
			l_enc_header := base64url_encode (header.string)
			l_enc_payload := base64url_encode (claimset.string)
			sign := signature (l_enc_header, l_enc_payload, a_secret, alg)

			create Result.make (l_enc_header.count + 1 + l_enc_payload.count + 1 + sign.count)
			Result.append (l_enc_header)
			Result.append_character ('.')
			Result.append (l_enc_payload)
			Result.append_character ('.')
			Result.append (sign)
		end

feature -- Element change

	set_algorithm (alg: detachable READABLE_STRING_8)
		do
			header.set_algorithm (alg)
		end

	set_algorithm_to_hs256
		do
			set_algorithm (algorithms.hs256.name)
		end

	set_algorithm_to_none
		do
			set_algorithm (algorithms.none.name)
		end

end
