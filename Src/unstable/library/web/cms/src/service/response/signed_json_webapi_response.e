note
	description: "Summary description for JSON {JSON_WEBAPI_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	SIGNED_JSON_WEBAPI_RESPONSE

inherit
	JSON_WEBAPI_RESPONSE
		rename
			make as make_response
		redefine
			process
		end

create
	make

feature {NONE} -- Initialization

	make (a_key: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api)
		do
			signature_key := a_key
			make_response (req, res, a_api)
		end

feature -- Access

	signature_key: READABLE_STRING_8

feature -- Execution

	process
		local
			m: WSF_PAGE_RESPONSE
			j: STRING_8
			hm: HMAC_SHA256
		do
			j := resource.representation
			create m.make_with_body (j)
			m.set_status_code (status_code)
			if attached redirection as loc then
				m.header.put_location (loc)
				m.set_status_code ({HTTP_STATUS_CODE}.temp_redirect)
			end
			m.header.put_content_type_with_charset ("application/json", "utf-8")
			create hm.make_ascii_key (signature_key)
			hm.update_from_string (j)
			m.header.put_header_key_value ("X-EWF-Roc-Sign", hm.base64_digest)
			response.send (m)
		end

invariant

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
