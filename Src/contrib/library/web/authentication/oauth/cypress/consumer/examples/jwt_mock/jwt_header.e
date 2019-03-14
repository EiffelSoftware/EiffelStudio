note
	description: "[
			JOSE Header
			
			See https://tools.ietf.org/html/rfc7515
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=JOSE Header", "src=https://tools.ietf.org/html/rfc7519#section-5", "protocol=uri"

class
	JWT_HEADER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_from_json

convert
	string: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization

	default_create
		do
			type := "JWT"
			algorithm := "HS256"
		end

	make_from_json (a_json: READABLE_STRING_8)
		do
			default_create
		end

feature -- Access

	type: READABLE_STRING_8
			-- Token type (typ) - If present, it is recommended to set this to "JWT".

	content_type: detachable READABLE_STRING_8
			-- Content type (cty)
			-- If nested signing or encryption is employed, it is recommended to set this to JWT,
			-- otherwise omit this field.

	algorithm: READABLE_STRING_8
			-- Message authentication code algorithm (alg)
			-- The issuer can freely set an algorithm to verify the signature on the token.
			-- However, some supported algorithms are insecure.

	private_key_id: detachable READABLE_STRING_8
			-- For the kid field in the header, specify your service account's private key ID.
			-- You can find this value in the private_key_id field of your service account JSON file. 		

feature -- Conversion

	string: STRING
		do
			Result := ""
		end

feature -- Element change

	set_type (typ: READABLE_STRING_8)
		do
		end

	set_content_type (cty: detachable READABLE_STRING_8)
		do
		end

	set_algorithm (alg: detachable READABLE_STRING_8)
		do
		end

	set_private_key_id (a_id: detachable READABLE_STRING_8)
		do
		end

feature -- Element change

	import_json (a_json: READABLE_STRING_8)
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
