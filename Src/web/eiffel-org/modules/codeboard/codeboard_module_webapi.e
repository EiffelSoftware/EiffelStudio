note
	description: "Summary description for {CODEBOARD_MODULE_WEBAPI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODEBOARD_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [CODEBOARD_MODULE]
		redefine
			permissions
		end

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
		end

feature -- Router/webapi

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached module.codeboard_api as l_codeboard_api then
				a_router.handle ("/" + codeboard_code_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_codeboard_code (l_codeboard_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + codeboard_code_location + "{code_id}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_codeboard_code (l_codeboard_api, ?, ?)), a_router.methods_head_get)
--				a_router.handle ("/" + codeboard_code_location, create {CMS_USER_REGISTER_WEBAPI_HANDLER}.make_with_auth_api (l_auth_api), a_router.methods_post)
			end
		end

	codeboard_code_location: STRING = "codeboard/code/"

feature -- Handlers	

	handle_codeboard_code (a_codeboard_api: CODEBOARD_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: JSON_WEBAPI_RESPONSE
			l_code_count, l_code_id: INTEGER_32
		do
			create r.make (req, res, a_codeboard_api.cms_api)
			l_code_count := a_codeboard_api.code_count
			if
				attached {WSF_STRING} req.path_parameter ("code_id") as p_code_id and then
				p_code_id.is_integer
			then
				l_code_id := p_code_id.integer_value
				r.add_integer_64_field ("id", l_code_id)
				if attached a_codeboard_api.code (l_code_id) as l_code then
					r.add_self (req.percent_encoded_path_info)
					if attached l_code.lang as l_lang then
						r.add_string_field ("lang", l_lang)
					else
						r.add_string_field ("lang", "eiffel") -- Default
					end
					if attached l_code.description as l_desc then
						r.add_string_field ("description", l_desc)
					end
					r.add_string_field ("code", l_code.text)
					if l_code_id = l_code_count then
						l_code_id := 0
					end
					if l_code_id < l_code_count then
						r.add_link ("next", "code#" + (l_code_id + 1).out, a_codeboard_api.cms_api.webapi_path (codeboard_code_location + (l_code_id + 1).out))
					else
						r.add_link ("next", "code#1", a_codeboard_api.cms_api.webapi_path (codeboard_code_location + "1"))
					end
				else
					r.add_string_field ("code", "Code #" + l_code_id.out + ": not found!")
					r.add_link ("next", "code#" + (l_code_id + 1).out, a_codeboard_api.cms_api.webapi_path (codeboard_code_location + "1"))
				end
			else
				r.add_integer_64_field ("available_code_count", l_code_count)
				if l_code_count > 0 then
					r.add_link ("first", "code#1", a_codeboard_api.cms_api.webapi_path (codeboard_code_location + "1"))
				end

			end
			r.execute
		end

end
