note
	description: "Summary description for {ES_CLOUD_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API

create
	make

feature {NONE} -- Creation

	make (a_webapi_url: READABLE_STRING_8)
		local
			uri: URI
		do
			create uri.make_from_string (a_webapi_url)
			create root_endpoint.make_from_string (uri.path)
			uri.set_path ("")
			create server_url.make_from_string (uri.string)
			initialize
		end

	initialize
		do
				-- Get `is_available` value.
			is_available := False
			if
				attached new_http_client_session as sess and then
				attached response (sess.get (root_endpoint, Void)) as resp
			then
				if not has_error then
					is_available := True
					if attached resp.string_8_item ("_links|register|href") as v then
						record_endpoint ("roc:register", v)
					end
					if attached resp.string_8_item ("_links|es:cloud|href") as v then
						record_endpoint ("es:cloud", v)
					end
					if attached resp.string_8_item ("_links|esa:register|href") as v then
						record_endpoint ("esa:register", v)
					end

				end
			end
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is available?

	get_is_available
			-- Refresh `is_available`.
		do
			is_available := False
			initialize
		end

feature -- Access

	root_endpoint: IMMUTABLE_STRING_8

	server_url: IMMUTABLE_STRING_8

feature -- Errors

	reset_error
		do
			last_error := Void
		ensure
			no_error: not has_error
		end

	has_error: BOOLEAN
		do
			Result := last_error /= Void
		end

	last_error: detachable ES_CLOUD_API_ERROR

feature -- Access from last api call.

	reset_api_call
		do
			reset_error
			session_state_changed := False
		end

	session_state_changed: BOOLEAN

feature -- Account: register

	register (a_username, a_password: READABLE_STRING_GENERAL; a_email: READABLE_STRING_8; a_additional_values: detachable TABLE_ITERABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]): detachable ES_ACCOUNT
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: like response
		do
			reset_api_call
			if attached endpoint ("esa:register") as l_url then
					-- Using Eiffel support system.
				sess := new_http_client_session
				if sess /= Void then
					create ctx.make
					ctx.add_form_parameter ("user_name", a_username)
					ctx.add_form_parameter ("password", a_password)
					ctx.add_form_parameter ("email", a_email)
					ctx.add_form_parameter ("personal_information", "Registration submitted via API.")
					if attached a_additional_values as tb then
						across
							tb as ic
						loop
							if not ctx.form_parameters.has (ic.key) then
								ctx.add_form_parameter (ic.key, ic.item)
							end
						end
					end
					resp := response (sess.post (l_url, ctx, Void))
					if not has_error then
						if
							attached resp.string_32_item ("status") as l_status and then
							l_status.same_string_general ("succeed")
						then
							create Result.make (a_username)
							if attached resp.string_8_item ("information") as l_info then
								debug ("es_cloud")
									print (l_info)
								end
							end
						end
					end
				end
			elseif attached endpoint ("roc:register") as l_url then
					-- Using ROC CMS system.
				sess := new_http_client_session
				if sess /= Void then
					create ctx.make
					ctx.add_form_parameter ("name", a_username)
					ctx.add_form_parameter ("password", a_password)
					ctx.add_form_parameter ("email", a_email)
					ctx.add_form_parameter ("personal_information", "Registration submitted via API.")
					resp := response (sess.post (l_url, ctx, Void))
					if not has_error then
						if
							attached resp.string_32_item ("status") as l_status and then
							l_status.same_string_general ("succeed")
						then
							create Result.make (a_username)
							if attached resp.string_8_item ("information") as l_info then
								debug ("es_cloud")
									print (l_info)
								end
							end
						end
					end
				end
			end
		end

feature -- ROC Account

	refreshing_token (a_token: READABLE_STRING_8; a_refresh_key: READABLE_STRING_8): detachable ES_ACCOUNT_ACCESS_TOKEN
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: like response
		do
			reset_api_call
			sess := new_http_client_session
			if sess /= Void then
				ctx := new_jwt_auth_context (a_token)

				if attached jwt_access_token_endpoint (sess, ctx) as l_jwt_access_token_href then
						-- Get new JWT access token, using Basic authorization.
					ctx.add_form_parameter ("token", a_token)
					ctx.add_form_parameter ("refresh", a_refresh_key)
					resp := response (sess.post (l_jwt_access_token_href, ctx, Void))
					if not has_error then
						Result := jwt_token_from_response (resp)
					end
				end
			end
		end

	account (a_token: READABLE_STRING_8): detachable ES_ACCOUNT
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_account_href: detachable READABLE_STRING_8
		do
			reset_api_call
			if attached new_http_client_session as sess then
				l_account_href := es_account_endpoint_for_token (a_token, sess)
				if l_account_href /= Void then
					ctx := new_jwt_auth_context (a_token)

						-- Get new JWT access token, using Basic authorization.
					resp := response (sess.get (l_account_href, ctx))
					if
						not has_error and then
						attached account_from_response (resp) as acc
					then
						Result := acc
						Result.set_access_token (create {ES_ACCOUNT_ACCESS_TOKEN}.make (a_token))
					end
				end
			end
		end

	account_using_basic_authorization (a_username, a_password: READABLE_STRING_GENERAL): detachable ES_ACCOUNT
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: like response
			l_jwt_access_token_href: detachable READABLE_STRING_8
		do
			reset_api_call
			sess := new_http_client_session
			if sess /= Void then
				ctx := new_basic_auth_context (a_username, a_password)

				resp := response (sess.get (root_endpoint, ctx))
				if not has_error then
					if attached resp.string_8_item ("_links|jwt:access_token|href") as v then
						l_jwt_access_token_href := v
					end
					if attached resp.string_8_item ("_links|es:cloud|href") as v then
						record_endpoint ("es:cloud", v)
					end
				end

				if l_jwt_access_token_href /= Void then
						-- Get new JWT access token, using Basic authorization.
					ctx.add_form_parameter ("applications", "es_account_api")
					resp := response (sess.post (l_jwt_access_token_href, ctx, Void))
					if not has_error then
						create Result.make (a_username)
						if attached resp.integer_64_item ("user|uid") as l_uid then
							Result.set_user_id (l_uid)
						elseif attached resp.string_32_item ("user|uid") as s_uid then
							Result.set_user_id (s_uid.to_integer_64)
						end
						if attached jwt_token_from_response (resp) as tok then
							Result.set_access_token (tok)
						end
						check Result.access_token /= Void end
					end
				end
			end
		end

	discard_token (a_token: READABLE_STRING_8): BOOLEAN
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: like response
		do
			reset_api_call
			sess := new_http_client_session
			if sess /= Void then
				ctx := new_jwt_auth_context (a_token)
				if attached jwt_access_token_endpoint (sess, ctx) as l_jwt_access_token_href then
						-- Discard JWT access token
					ctx.add_form_parameter ("token", a_token)
					ctx.add_form_parameter ("op", "discard")
					resp := response (sess.post (l_jwt_access_token_href, ctx, Void))
					Result := not has_error
				end
			end
		end

	logout (a_token: READABLE_STRING_8; a_installation_id, a_session_id: READABLE_STRING_GENERAL)
		local
			b: BOOLEAN
		do
			reset_api_call
			end_session (a_token, a_installation_id, a_session_id)
			b := discard_token (a_token)
			endpoints_table_for_tokens := Void
		end

feature -- Plan

	plan (a_token: READABLE_STRING_8): detachable ES_ACCOUNT_PLAN
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_account_href: READABLE_STRING_8
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				l_account_href := es_account_endpoint_for_token (a_token, sess)
				ctx := new_jwt_auth_context (a_token)
				if l_account_href /= Void then
					resp := response (sess.get (l_account_href, ctx))
					if not has_error then
						if attached account_from_response (resp) as acc then
							Result := acc.plan
						end
					end
				end
			end
		end

feature -- Installation

	register_installation (a_token: READABLE_STRING_8; a_installation: ES_ACCOUNT_INSTALLATION): detachable ES_ACCOUNT_INSTALLATION
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href, l_new_installation_href: READABLE_STRING_8
			j_info: JSON_OBJECT
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)

				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx.add_form_parameter ("installation_id", a_installation.id)
					create j_info.make_with_capacity (1)
					if attached a_installation.platform as pf then
						j_info.put_string (pf, "platform")
					end
					ctx.add_form_parameter ("info", j_info.representation)
					resp := response (sess.post (l_installations_href, ctx, Void))
					if not has_error then
						if attached resp.string_8_item ("_links|es:installation|href") as v then
							l_new_installation_href := v
							record_endpoint_for_token (a_token, {STRING_32} "_links|es:installation|href;installation=" + a_installation.id, l_new_installation_href)
						end
					end
					if l_new_installation_href /= Void then
						ctx := new_jwt_auth_context (a_token)

						resp := response (sess.get (l_new_installation_href, ctx))
						if not has_error then
							Result := installation_from_response (resp)
						end
					end
				end
			end
		end

	begin_session (a_token: READABLE_STRING_8; a_installation_id, a_session_id: READABLE_STRING_8)
		do
			ping_installation (a_token, a_installation_id, a_session_id, Void)
		end

	end_session (a_token: READABLE_STRING_8; a_installation_id, a_session_id: READABLE_STRING_GENERAL)
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: READABLE_STRING_8
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)

				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx.add_form_parameter ("operation", "end_session")
					ctx.add_form_parameter ("installation_id", a_installation_id)
					ctx.add_form_parameter ("session_id", a_session_id)
					resp := response (sess.post (l_installations_href, ctx, Void))
					if has_error then
							-- Too bad, but not critical
						reset_error
					end
				end
			end
		end

	pause_session (a_token: READABLE_STRING_8; a_installation_id, a_session_id: READABLE_STRING_GENERAL)
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: READABLE_STRING_8
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)

				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx.add_form_parameter ("operation", "pause_session")
					ctx.add_form_parameter ("installation_id", a_installation_id)
					ctx.add_form_parameter ("session_id", a_session_id)
					resp := response (sess.post (l_installations_href, ctx, Void))
					if has_error then
							-- Too bad, but not critical
						reset_error
					end
				end
			end
		end

	resume_session (a_token: READABLE_STRING_8; a_installation_id, a_session_id: READABLE_STRING_GENERAL)
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: READABLE_STRING_8
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)

				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx.add_form_parameter ("operation", "resume_session")
					ctx.add_form_parameter ("installation_id", a_installation_id)
					ctx.add_form_parameter ("session_id", a_session_id)
					resp := response (sess.post (l_installations_href, ctx, Void))
					if has_error then
							-- Too bad, but not critical
						reset_error
					end
				end
			end
		end

	ping_installation (a_token: READABLE_STRING_8; a_installation_id, a_session_id: READABLE_STRING_GENERAL; a_opts: detachable STRING_TABLE [READABLE_STRING_GENERAL])
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: READABLE_STRING_8
		do
				-- reset previous call data
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)

				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx.add_form_parameter ("operation", "ping")
					ctx.add_form_parameter ("installation_id", a_installation_id)
					ctx.add_form_parameter ("session_id", a_session_id)
					if a_opts /= Void then
						across
							a_opts as ic
						loop
							ctx.add_form_parameter (ic.key, ic.item)
						end
					end
					resp := response (sess.post (l_installations_href, ctx, Void))
					if resp.has_error then
							-- Too bad, but not critical
						reset_error
					else
						if attached resp.string_8_item ("_links|es:installation|href") as v then
							record_endpoint_for_token (a_token, {STRING_32} "_links|es:installation|href;installation=" + a_installation_id.as_string_32, v)
						end
						if attached resp.string_8_item ("_links|es:session|href") as v then
							record_endpoint_for_token (a_token, {STRING_32} "_links|es:session|href;session=" + a_session_id.as_string_32, v)
						end
						if attached resp.string_32_item ("es:session_state") as l_sess_state then
							debug ("es_cloud")
								print ("session.state="+ l_sess_state + "%N")
							end
							if not l_sess_state.is_case_insensitive_equal_general ("normal") then
								session_state_changed := True
							end
						end
					end
				end
			end
		rescue
			reset_error
		end

	installation (a_token: READABLE_STRING_8; a_installation_id: READABLE_STRING_GENERAL): detachable ES_ACCOUNT_INSTALLATION
		local
			l_installation_href: READABLE_STRING_8
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
		do
			reset_api_call
			l_installation_href := endpoint_for_token (a_token, {STRING_32} "_links|es:installation|href;installation=" + a_installation_id.as_string_32)
			if l_installation_href /= Void then
				if
					attached new_http_client_session as sess
				then
					ctx := new_jwt_auth_context (a_token)

					resp := response (sess.get (l_installation_href, ctx))
					if not has_error then
						Result := installation_from_response (resp)
					end
				end
			elseif attached installations (a_token) as lst then
				across
					lst as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if not a_installation_id.same_string (Result.id) then
						Result := Void
					end
				end
			end
		end

	session (acc: ES_ACCOUNT; a_session_id: READABLE_STRING_GENERAL): detachable ES_ACCOUNT_SESSION
		local
			l_installation_href, l_session_href: READABLE_STRING_8
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
		do
			reset_api_call
				-- Update endpoints ...
			ping_installation (acc.access_token.token, acc.installation.id, a_session_id, Void)
			reset_api_call

			l_session_href := endpoint_for_token (acc.access_token.token, {STRING_32} "_links|es:session|href;session=" + a_session_id.as_string_32)
			if l_session_href = Void then
				l_installation_href := endpoint_for_token (acc.access_token.token, {STRING_32} "_links|es:installation|href;installation=" + acc.installation.id.as_string_32)
				if l_installation_href /= Void then
					l_session_href := l_installation_href + "/session/" + a_session_id
				end
			end
			if l_session_href /= Void then
				if
					attached new_http_client_session as sess
				then
					ctx := new_jwt_auth_context (acc.access_token.token)

					resp := response (sess.get (l_session_href, ctx))
					if not has_error then
						Result := session_from_response (acc, resp)
					end
				end
			end
		end

	installations (a_token: READABLE_STRING_8): detachable LIST [ES_ACCOUNT_INSTALLATION]
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: READABLE_STRING_8
			inst: ES_ACCOUNT_INSTALLATION
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)
				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					resp := response (sess.get (l_installations_href, ctx))
					if not has_error then
						if attached resp.table_item ("es:installations") as l_installations then
							create {ARRAYED_LIST [ES_ACCOUNT_INSTALLATION]} Result.make (l_installations.count)
							across
								l_installations as ic
							loop
								create inst.make_with_id (ic.key.as_string_8)
								Result.force (inst)
							end
						end
					end
				end
			end
		end

feature {NONE} -- Endpoints

	endpoints_table: detachable STRING_TABLE [IMMUTABLE_STRING_8]

	endpoint (rel: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_8
		do
			if attached endpoints_table as tb then
				Result := tb.item (rel)
			end
		end

	record_endpoint (rel: READABLE_STRING_GENERAL; a_href: IMMUTABLE_STRING_8)
		local
			tb: like endpoints_table
		do
			tb := endpoints_table
			if tb = Void then
				create tb.make_caseless (1)
				endpoints_table := tb
			end
			tb.force (a_href, rel)
		end

	get_es_cloud_endpoint (sess: attached like new_http_client_session)
		do
			-- Get `is_available` value.
			if
				attached response (sess.get (root_endpoint, Void)) as resp
			then
				if has_error then
					reset_error
				else
					if attached resp.string_8_item ("_links|es:cloud|href") as v then
						record_endpoint ("es:cloud", v)
					end
				end
			end
		end

	es_cloud_endpoint (sess: attached like new_http_client_session): detachable IMMUTABLE_STRING_8
		do
			reset_api_call
			Result := endpoint ("es:cloud")
			if Result = Void then
				get_es_cloud_endpoint (sess)
				Result := endpoint ("es:cloud")
			end
		end

feature {NONE} -- JWT endpoints

	jwt_access_token_endpoint (sess: HTTP_CLIENT_SESSION; ctx: HTTP_CLIENT_REQUEST_CONTEXT): detachable IMMUTABLE_STRING_8
		local
			resp: like response
		do
			reset_api_call
			resp := response (sess.get (root_endpoint, ctx))
			if has_error then
				reset_api_call
			else
				if attached resp.string_8_item ("_links|jwt:access_token|href") as v then
					Result := v
				end
			end
		end

feature {NONE} -- Endpoints for token		

	endpoints_table_for_tokens: detachable STRING_TABLE [attached like endpoints_table]
			-- endpoints table indexed by token.

	wipe_endpoints_for_token (a_token: READABLE_STRING_8)
		local
			tbtoks: like endpoints_table_for_tokens
		do
			tbtoks := endpoints_table_for_tokens
			if tbtoks /= Void then
				tbtoks.remove (a_token)
				if tbtoks.is_empty then
					endpoints_table_for_tokens := Void
				end
			end
		end

	record_endpoint_for_token (a_token: READABLE_STRING_8; rel: READABLE_STRING_GENERAL; a_href: IMMUTABLE_STRING_8)
			-- Record endpoint associated with `a_token`.
		local
			tbtoks: like endpoints_table_for_tokens
			tb: like endpoints_table
		do
			tbtoks := endpoints_table_for_tokens
			if tbtoks = Void then
				create tbtoks.make_caseless (1)
				endpoints_table_for_tokens := tbtoks
			end
			tb := tbtoks.item (a_token)
			if tb = Void then
				create tb.make_caseless (1)
				tbtoks.force (tb, a_token)
			end
			tb.force (a_href, rel)
		end

	endpoint_for_token (a_token: READABLE_STRING_8; rel: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_8
		do
			if
				attached endpoints_table_for_tokens as tbtoks and then
				attached tbtoks.item (a_token) as tb
			then
				Result := tb.item (rel)
			end
		end

	get_es_account_endpoints_for_token (a_token: READABLE_STRING_8; sess: attached like new_http_client_session)
		local
			resp: like response
			l_es_cloud_href, l_account_href, l_installation_href: detachable READABLE_STRING_8
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			reset_api_call
			l_es_cloud_href := endpoint ("es:cloud")
			if l_es_cloud_href = Void then
				get_es_cloud_endpoint (sess)
				l_es_cloud_href := endpoint ("es:cloud")
			end
			if l_es_cloud_href /= Void then
				ctx := new_jwt_auth_context (a_token)

				resp := response (sess.get (l_es_cloud_href, ctx))
				if has_error then
					reset_error
				else
					if attached resp.string_8_item ("_links|es:account|href") as v then
						l_account_href := v
						record_endpoint_for_token (a_token, "_links|es:account|href", l_account_href)
					end
					if attached resp.string_8_item ("_links|es:installations|href") as v then
						l_installation_href := v
						record_endpoint_for_token (a_token, "_links|es:installations|href", l_installation_href)
					end
				end
			end
		end

	es_account_endpoint_for_token (a_token: READABLE_STRING_8; sess: HTTP_CLIENT_SESSION): detachable IMMUTABLE_STRING_8
		do
			Result := endpoint_for_token (a_token, "_links|es:account|href")
			if Result = Void then
				get_es_account_endpoints_for_token (a_token, sess)
				Result := endpoint_for_token (a_token, "_links|es:account|href")
			end
		end

	es_account_installations_endpoint_for_token (a_token: READABLE_STRING_8; sess: HTTP_CLIENT_SESSION): detachable IMMUTABLE_STRING_8
		do
			Result := endpoint_for_token (a_token, "_links|es:installations|href")
			if Result = Void then
				get_es_account_endpoints_for_token (a_token, sess)
				Result := endpoint_for_token (a_token, "_links|es:installations|href")
			end
		end

feature {NONE} -- Implementation

	response (a_resp: HTTP_CLIENT_RESPONSE): ES_CLOUD_API_RESPONSE
		do
			create Result.make (a_resp)
			last_error := Result.error
		end

	new_http_client_session: detachable HTTP_CLIENT_SESSION
		local
			cl: DEFAULT_HTTP_CLIENT
		do
			create cl
			Result := cl.new_session (server_url)
			Result.add_header ("Accept", "application/json,text/html;q=0.9,*.*;q=0.8")
			Result.set_is_insecure (True) -- For now api.eiffel.com has no valid SSL certificate.
			if not Result.is_available then
				Result := Void
			end
		ensure
			Result /= Void implies Result.is_available
		end

	new_basic_auth_context (u,p: READABLE_STRING_GENERAL): HTTP_CLIENT_REQUEST_CONTEXT
		do
			create Result.make
			Result.set_credentials_required (True)
			if attached (create {HTTP_AUTHORIZATION}.make_basic_auth (u.as_string_32, p.as_string_32)).http_authorization as l_auth then
				Result.add_header ("Authorization", l_auth)
			else
				check has_basic_auth: False end
			end
		end

	new_jwt_auth_context (tok: READABLE_STRING_8): HTTP_CLIENT_REQUEST_CONTEXT
		do
			create Result.make
			Result.add_header ("Authorization", "Bearer " + tok)
			Result.set_credentials_required (True)
		end

feature {NONE} -- Json handling

	account_from_response (r: ES_CLOUD_API_RESPONSE): detachable ES_ACCOUNT
		do
			if attached r.string_32_item ("name") as l_name then
				create Result.make (l_name)
				if attached r.integer_64_item ("uid") as l_uid and then l_uid > 0 then
					Result.set_user_id (l_uid)
				elseif attached r.string_32_item ("uid") as s_uid then
					Result.set_user_id (s_uid.to_integer_64)
				end
				if
					attached r.sub_item ("es:plan") as r_plan and then
					attached plan_from_response (r_plan) as l_plan
				then
					Result.set_plan (l_plan)
				end
			end
		end

	plan_from_response (r: like response): detachable ES_ACCOUNT_PLAN
		do
			if attached r.string_8_item ("name") as l_plan_name then
				create Result.make (l_plan_name)
				if attached r.integer_64_item ("id") as l_uid then
					Result.set_plan_id (l_uid)
				elseif attached r.string_32_item ("id") as s_uid then
					Result.set_plan_id (s_uid.to_integer_64)
				end
--				if r.boolean_item_is_true ("is_active") then
--				end
				if attached r.integer_64_item ("days_remaining") as l_days_remaining then
					Result.set_days_remaining (l_days_remaining.to_integer_32)
				end
				if attached r.date_time_item ("creation") as l_creation then
					Result.set_creation_date (l_creation)
				end
				if attached r.date_time_item ("expiration") as l_expiration then
					Result.set_expiration_date (l_expiration)
				end
			end
		end

	jwt_token_from_response (resp: like response): detachable ES_ACCOUNT_ACCESS_TOKEN
		do
			if attached resp.string_8_item ("access_token") as l_access_token then
				create Result.make (l_access_token)
				if attached resp.string_8_item ("refresh_key") as l_refresh_key then
					Result.set_refresh_key (l_refresh_key)
				end
			end
		end

	installation_from_response (resp: like response): detachable ES_ACCOUNT_INSTALLATION
		require
			no_error: not has_error
		do
			if attached resp.string_8_item ("es:installation|id") as v then
				create Result.make_with_id (v)
				if resp.string_item_same_caseless_as ("es:installation|is_active", "no") then
					Result.mark_inactive
				else
					Result.mark_active
				end
				if attached resp.string_8_item ("es:installation|info") as v_info then
					Result.set_info (v_info)
				end
				if attached resp.date_time_item ("es:installation|creation_date") as v_creation then
					Result.set_creation_date (v_creation)
				end
			end
		end

	session_from_response (acc: ES_ACCOUNT; resp: like response): detachable ES_ACCOUNT_SESSION
		require
			no_error: not has_error
		do
			if attached resp.string_8_item ("es:session|id") as v then
				create Result.make (acc, v)
				if
					attached resp.string_32_item ("es:session|state") as l_state and then
					l_state.is_case_insensitive_equal_general ("paused")
				then
					Result.set_is_paused (True)
				end
				if attached resp.string_32_item ("es:session|title") as l_title then
					Result.set_title (l_title)
				end
--				if attached resp.date_time_item ("es:session|first_date") as dt then
--					Result.set_first_date (dt)
--				end
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
