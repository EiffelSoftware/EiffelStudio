note
	description: "Summary description for {CMS_ACCESS_TOKEN_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ACCESS_TOKEN_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("uid") as p_uid then
				l_uid := p_uid.value
				if req.is_post_request_method then
					post_access_token (l_uid, req, res)
				elseif req.is_get_request_method then
					get_access_token (l_uid, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_bad_request_error_response ("Missing {uid} parameter", req, res).execute
			end
		end

feature -- Helper

	user_by_uid (a_uid: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := api.user_api.user_by_id_or_name (a_uid)
		end

feature -- Request execution		

	get_access_token (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if u.same_as (l_user) and api.has_permission ("use access_token") then
						rep := new_access_token_response (l_user, user_access_token (l_user), req, res)
						if attached api.destination_location (req) as dest then
							rep.set_redirection (secured_url_content (dest))
						end
					else
							-- Only admin, or current user can see its access_token!
						rep := new_access_denied_error_response (Void, req, res)
					end
				else
					rep := new_access_denied_error_response (Void, req, res)
				end
			else
				rep := new_not_found_error_response ("User not found", req, res)
			end
			rep.execute
		end

	post_access_token (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_access_token: detachable READABLE_STRING_32
			rep: like new_response
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if
						u.same_as (l_user) and api.has_permission ("use access_token")
					then
						if attached req.path_parameter ("application") then

						end
						l_access_token := new_key (40)
						set_user_access_token (l_user, l_access_token)

						rep := new_access_token_response (l_user, l_access_token, req, res)
						if attached api.destination_location (req) as dest then
							rep.set_redirection (secured_url_content (dest))
						end
					else
							-- Only admin, or current user can create the user access_token!
						rep := new_access_denied_error_response (Void, req, res)
					end
				else
					rep := new_access_denied_error_response (Void, req, res)
				end
			else
				rep := new_not_found_error_response ("User not found", req, res)
			end
			rep.execute
		end

feature {NONE} -- Implementation

	user_access_token (a_user: CMS_USER): detachable READABLE_STRING_8
		do
			if
				attached api.user_api.user_profile_item ("access_token", a_user) as l_access_token and then
				not l_access_token.is_whitespace and then
				l_access_token.is_valid_as_string_8
			then
				Result := l_access_token.to_string_8
			else
--				Result := new_key (40)
			end
		end

	set_user_access_token (a_user: CMS_USER; a_access_token: READABLE_STRING_GENERAL)
		do
			api.user_api.save_user_profile_item (a_user, "access_token", a_access_token)
		end

	new_access_token_response (a_user: CMS_USER; a_access_token: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): like new_response
		local
			tb: STRING_TABLE [detachable ANY]
		do
			Result := new_response (req, res)
			if a_access_token /= Void then
				Result.add_string_field ("access_token", a_access_token)
			else
				Result.add_string_field ("access_token", "NONE")
				Result.add_link ("new_access_token", "user/" + a_user.id.out + "/access_token", req.percent_encoded_path_info)
			end
			create tb.make_equal (3)
			tb.force (a_user.name, "name")
			tb.force (a_user.id, "uid")
			Result.add_table_iterator_field ("user", tb)

--			Result.add_string_field ("username", a_user.name)
--			Result.add_integer_64_field ("uid", a_user.id)
			Result.add_self (req.percent_encoded_path_info)
			add_user_links_to (a_user, Result)
		end

	new_key (len: INTEGER): STRING_8
		local
			rand: RANDOM
			n: INTEGER
			v: NATURAL_32
		do
			rand := api.random_generator
			create Result.make (len)
			from
				n := 1
			until
				n = len
			loop
				rand.forth
				v := (rand.item \\ 16).to_natural_32
				check 0 <= v and v <= 15 end
				if v < 9 then
					Result.append_code (48 + v) -- 48 '0'
				else
					Result.append_code (97 + v - 9) -- 97 'a'
				end
				n := n + 1
			end
		end
note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
