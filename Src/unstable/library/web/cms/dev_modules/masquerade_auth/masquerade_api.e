note
	description: "API to manage CMS User session authentication"
	date: "$Date$"
	revision: "$Revision$"

class
	MASQUERADE_API

inherit
	CMS_AUTH_API_I

	REFACTORING_HELPER

create {MASQUERADE_AUTH_MODULE}
	make_with_session_api

feature {NONE} -- Initialization

	make_with_session_api (a_api: CMS_API; a_session_api: CMS_SESSION_API)
		do
			session_api := a_session_api
			make (a_api)
		end

feature -- Access

	session_api: CMS_SESSION_API

feature -- Status report

	has_permission_to_masquerade (a_user: detachable CMS_USER): BOOLEAN
		local
			v: STRING
		do
			if attached cms_api.setup.string_8_item_or_default ("dev.masquerade", "permission") as s then
				v := s.to_string_8
				v.left_adjust
				v.right_adjust
				if v.is_case_insensitive_equal_general ("none") then
				elseif v.is_case_insensitive_equal_general ("all") then
					Result := True
				elseif v.is_case_insensitive_equal_general ("permission") then
					Result := cms_api.user_has_permission (a_user, "masquerade")
				else
						-- no!
				end
			end
		end

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
		do
			if
				a_response.is_authenticated and then
				attached a_response.request.cookie (session_api.session_token)
			then
				Result := True
			end
		end

feature -- Basic operation

	process_user_login (a_user: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			session_api.process_user_login (a_user, req, res)
		end

	process_user_logout (a_user: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			session_api.process_user_logout (a_user, req, res)
		end

feature -- Access

--	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
--			-- Retrieve user by token `a_token', if any.
--		do
--			Result := session_auth_storage.user_by_session_token (a_token)
--		end

--	has_user_token (a_user: CMS_USER): BOOLEAN
--			-- Has the user `a_user' and associated session token?
--		do
--			Result := session_auth_storage.has_user_token (a_user)
--		end


end
