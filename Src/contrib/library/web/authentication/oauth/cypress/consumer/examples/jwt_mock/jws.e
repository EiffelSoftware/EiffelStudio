note
	description: "JSON Web Signature (JWS)"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=JSON Web Signature", "src=https://tools.ietf.org/html/rfc7515", "protocol=uri"
	EIS: "name=JSON Web Token (JWT)", "src=https://tools.ietf.org/html/rfc7519", "protocol=uri"

class
	JWS
inherit
	ANY
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
			create claimset
			create header
			create algorithms
		end

	make_with_algorithm (alg: like algorithm)
		do
			default_create
		end

	make_with_claims (tb: STRING_TABLE [READABLE_STRING_GENERAL])
		do
			default_create
		end

	make_with_json_payload (a_json: READABLE_STRING_8)
		do
			default_create
		end

feature -- Access

	algorithms: JWT_ALGORITHMS

	header: JWT_HEADER

	claimset: JWT_CLAIMSET


	algorithm: READABLE_STRING_8
		do
			Result := ""
		end

feature -- Conversion

	encoded_string (a_secret: READABLE_STRING_8): STRING
		do
			Result := ""
		end

feature -- Element change

	set_algorithm (alg: detachable READABLE_STRING_8)
		do
		end

	set_algorithm_to_hs256
		do
		end

	set_algorithm_to_none
		do
		end

note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
