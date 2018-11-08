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
			import_json (a_json)
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
			create Result.make_empty
			Result.append ("{%"typ%":%"")
			Result.append (type)
			Result.append ("%"")
			if attached content_type as cty then
				Result.append (",%"cty%":%"")
				Result.append (cty)
				Result.append ("%"")
			end
			Result.append (",%"alg%":%"")
			Result.append (algorithm)
			Result.append ("%"")
			if attached private_key_id as kid then
				Result.append (",%"kid%":%"")
				Result.append (kid)
				Result.append ("%"")
			end
			Result.append ("}")
		end

feature -- Element change

	set_type (typ: READABLE_STRING_8)
		do
			type := typ
		end

	set_content_type (cty: detachable READABLE_STRING_8)
		do
			content_type := cty
		end

	set_algorithm (alg: detachable READABLE_STRING_8)
		do
			if
				alg = Void or else
				alg.is_case_insensitive_equal ("none")
			then
				algorithm := "none"
			else
				algorithm := alg.as_upper
			end
		end

	set_private_key_id (a_id: detachable READABLE_STRING_8)
		do
			private_key_id := a_id
		end

feature -- Element change

	import_json (a_json: READABLE_STRING_8)
		local
			jp: JSON_PARSER
		do
			create jp.make_with_string (a_json)
			jp.parse_content
			if
				attached jp.parsed_json_object as jo
			then
				if attached {JSON_STRING} jo.item ("typ") as j_typ then
					set_type (j_typ.unescaped_string_8)
				end
				if attached {JSON_STRING} jo.item ("cty") as j_cty then
					set_content_type (j_cty.unescaped_string_8)
				end
				if attached {JSON_STRING} jo.item ("alg") as j_alg then
					set_algorithm (j_alg.unescaped_string_8)
				end
				if attached {JSON_STRING} jo.item ("kid") as j_kid then
					set_private_key_id (j_kid.unescaped_string_8)
				end
			end
		end

end
