note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API

create
	make

feature {NONE} -- Creation

	make (cfg: ES_CLOUD_CONFIG)
		do
			config := cfg
			initialize
		end

	initialize
		do
			debug ("es_cloud")
				print (generator + ".initialize %N")
			end
			get_is_available
		end

feature -- Config change

	set_config (cfg: ES_CLOUD_CONFIG)
		do
			if not cfg.server_url.same_string (config.server_url) then
				endpoints_table.wipe_out
				endpoints_table_for_tokens.wipe_out
				config := cfg
			end
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is available?

	get_is_available
			-- Refresh `is_available`.
		do
			debug ("es_cloud")
				print (generator + ".get_is_available %N")
			end
				-- Update `is_available` value.
			is_available := True
			if
				attached new_http_client_session as sess and then
				attached response_get (sess, config.root_endpoint, Void) as resp
			then
				if has_error then
					is_available := False
				else
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
			debug ("es_cloud")
				print (generator + ".get_is_available -> "+ is_available.out +"%N")
			end
		end

feature -- Access

	config: ES_CLOUD_CONFIG

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
		end

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
					resp := response_post (sess, l_url, ctx, Void)
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
					resp := response_post (sess, l_url, ctx, Void)
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
					resp := response_post (sess, l_jwt_access_token_href, ctx, Void)
					if not has_error then
						Result := jwt_token_from_response (resp)
					end
				end
			end
		end

	account_magic_login_link (a_token: READABLE_STRING_8): detachable READABLE_STRING_8
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_new_magic_login_href: detachable READABLE_STRING_8
		do
			reset_api_call
			if attached new_http_client_session as sess then
				ctx := new_jwt_auth_context (a_token)
				l_new_magic_login_href := endpoint_for_token (a_token, "_links|jwt:new_magic_login|href")
				if l_new_magic_login_href = Void then
					l_new_magic_login_href := jwt_new_magic_login_endpoint (a_token, sess, ctx)
				end
				if l_new_magic_login_href /= Void then
					resp := response_get (sess, l_new_magic_login_href, ctx)
					if
						not has_error and then
						attached resp.string_8_item ("_links|jwt:magic_login|href") as lnk
					then
						Result := lnk
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
					resp := response_get (sess, l_account_href, ctx)
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

				resp := response_get (sess, config.root_endpoint, ctx)
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
					resp := response_post (sess, l_jwt_access_token_href, ctx, Void)
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
					resp := response_post (sess, l_jwt_access_token_href, ctx, Void)
					Result := not has_error
				end
			end
		end

	sign_out (a_token: READABLE_STRING_8; params: ES_CLOUD_API_SESSION_PARAMETERS)
		local
			b: BOOLEAN
		do
			reset_api_call
			end_session (a_token, params)
			b := discard_token (a_token)
			endpoints_table_for_tokens := Void
		end

feature -- Plan

	plan (a_token: READABLE_STRING_8): detachable ES_ACCOUNT_PLAN
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installation_href: READABLE_STRING_8
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				l_installation_href := es_account_installations_endpoint_for_token (a_token, sess)
				ctx := new_jwt_auth_context (a_token)
				if l_installation_href /= Void then
					resp := response_get (sess, l_installation_href, ctx)
					if not has_error then
						if attached installation_from_response (resp) as inst then
							Result := inst.associated_plan
						end
					end
				end
			end
		end

	account_licenses (a_token: READABLE_STRING_8): detachable LIST [ES_ACCOUNT_LICENSE]
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
					resp := response_get (sess, l_account_href, ctx)
					if
						not has_error and then
						attached account_licenses_from_response (resp) as lics
					then
						Result := lics
					end
				end
			end
		end

	account_installations (a_token: READABLE_STRING_8): detachable LIST [ES_ACCOUNT_INSTALLATION]
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: detachable READABLE_STRING_8
		do
			reset_api_call
			if attached new_http_client_session as sess then
				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx := new_jwt_auth_context (a_token)

						-- Get new JWT access token, using Basic authorization.
					resp := response_get (sess, l_installations_href, ctx)
					if
						not has_error and then
						attached account_installations_from_response (resp) as inst_lst
					then
						Result := inst_lst
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
					resp := response_post (sess, l_installations_href, ctx, Void)
					if not has_error then
						if attached resp.string_8_item ("_links|es:installation|href") as v then
							l_new_installation_href := v
							record_endpoint_for_token (a_token, "_links|es:installation|href;installation=" + a_installation.id, l_new_installation_href)
						end
					end
					if l_new_installation_href /= Void then
						ctx := new_jwt_auth_context (a_token)

						resp := response_get (sess, l_new_installation_href, ctx)
						if not has_error then
							Result := installation_from_response (resp)
						end
					end
				end
			end
		end

	update_installation (a_token: READABLE_STRING_8; a_installation: ES_ACCOUNT_INSTALLATION; a_lic: ES_ACCOUNT_LICENSE): ES_ACCOUNT_INSTALLATION
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href, l_new_installation_href: READABLE_STRING_8
		do
			reset_api_call
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)

				l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
				if l_installations_href /= Void then
					ctx.add_form_parameter ("installation_id", a_installation.id)
					ctx.add_form_parameter ("operation", "update_license")
					ctx.add_form_parameter ("license_id", a_lic.key)
					resp := response_post (sess, l_installations_href, ctx, Void)
					if not has_error then
						if attached resp.string_8_item ("_links|es:installation|href") as v then
							l_new_installation_href := v
							record_endpoint_for_token (a_token, "_links|es:installation|href;installation=" + a_installation.id, l_new_installation_href)
						end
					end
					if l_new_installation_href /= Void then
						ctx := new_jwt_auth_context (a_token)

						resp := response_get (sess, l_new_installation_href, ctx)
						if not has_error then
							Result := installation_from_response (resp)
						end
					end
				end
			end
		end

	begin_session (a_token: READABLE_STRING_8; params: ES_CLOUD_API_SESSION_PARAMETERS)
		local
			d: ES_CLOUD_PING_DATA
		do
			create d
			ping_installation (a_token, params, d)
		end

	end_session (a_token: READABLE_STRING_8; params: ES_CLOUD_API_SESSION_PARAMETERS)
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
					ctx.add_form_parameter ("installation_id", params.installation_id)
					ctx.add_form_parameter ("session_id", params.session_id)
					resp := response_post (sess, l_installations_href, ctx, Void)
					if has_error then
							-- Too bad, but not critical
						reset_error
					end
				end
			end
		end

	pause_session (a_token: READABLE_STRING_8; params: ES_CLOUD_API_SESSION_PARAMETERS)
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
					ctx.add_form_parameter ("installation_id", params.installation_id)
					ctx.add_form_parameter ("session_id", params.session_id)
					resp := response_post (sess, l_installations_href, ctx, Void)
					if has_error then
							-- Too bad, but not critical
						reset_error
					end
				end
			end
		end

	resume_session (a_token: READABLE_STRING_8; params: ES_CLOUD_API_SESSION_PARAMETERS)
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
					ctx.add_form_parameter ("installation_id", params.installation_id)
					ctx.add_form_parameter ("session_id", params.session_id)
					resp := response_post (sess, l_installations_href, ctx, Void)
					if has_error then
							-- Too bad, but not critical
						reset_error
					end
				end
			end
		end

	ping_installation (a_token: READABLE_STRING_8; params: ES_CLOUD_API_SESSION_PARAMETERS;
			a_output: detachable ES_CLOUD_PING_DATA)
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			l_installations_href: READABLE_STRING_8
			retried: BOOLEAN
		do
			if retried then
				reset_error
			else
				debug ("es_cloud")
					print (generator + ".ping_installation (...)%N")
				end
					-- reset previous call data
				reset_api_call
				if
					attached new_http_client_session as sess
				then
					ctx := new_jwt_auth_context (a_token)

					l_installations_href := es_account_installations_endpoint_for_token (a_token, sess)
					if l_installations_href /= Void then
						ctx.add_form_parameter ("operation", "ping")
						ctx.add_form_parameter ("installation_id", params.installation_id)
						ctx.add_form_parameter ("session_id", params.session_id)

						across
							params.items as ic
						loop
							ctx.add_form_parameter (ic.key, ic.item)
						end
						resp := response_post (sess, l_installations_href, ctx, Void)
						if resp.has_error and then resp.has_internal_error then
							if a_output /= Void then
								a_output.report_error (Void)
							end
								-- Too bad, but not critical
						else
							if attached resp.string_8_item ("_links|es:installation|href") as v then
								record_endpoint_for_token (a_token, {STRING_32} "_links|es:installation|href;installation=" + params.installation_id.as_string_32, v)
							end
							if attached resp.string_8_item ("_links|es:session|href") as v then
								record_endpoint_for_token (a_token, {STRING_32} "_links|es:session|href;session=" + params.session_id.as_string_32, v)
							end
							if a_output /= Void then
								if attached resp.error then
									check not_internal_error: not resp.has_internal_error end
									a_output.report_error (resp.error.message)
								end
								if resp.boolean_item_is_true ("es:license_missing") then
									a_output.license_missing := True
								end
								if resp.boolean_item_is_true ("es:license_invalid") then
									a_output.license_invalid := True
								end
								if
									resp.boolean_item_is_true ("es:license_expired")
									or resp.boolean_item_is_true ("es:plan_expired")
								then
									a_output.license_expired := True
								end
								if
									attached resp.string_32_item ("es:session_state") as l_sess_state and then
									not l_sess_state.is_case_insensitive_equal_general ("normal")
								then
									a_output.session_state_changed := True
									a_output.session_state := l_sess_state
								end
								if attached resp.integer_64_item ("es:session_heartbeat") as l_heartbeat then
									a_output.heartbeat := l_heartbeat.to_natural_32
								end
							end
						end
						reset_error
					end
				end
			end
		rescue
			retried := True
			retry
		end

	installation (a_token: READABLE_STRING_8; a_installation_id: READABLE_STRING_GENERAL): detachable ES_ACCOUNT_INSTALLATION
		local
			l_installation_href: READABLE_STRING_8
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
		do
			reset_api_call
			l_installation_href := endpoint_for_token (a_token, {STRING_32} "_links|es:installation|href;installation=" + a_installation_id.to_string_32)
			if l_installation_href /= Void then
				if
					attached new_http_client_session as sess
				then
					ctx := new_jwt_auth_context (a_token)
					resp := response_get (sess, l_installation_href, ctx)
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
				if Result /= Void then
					Result := updated_installation (a_token, Result)
				end
			end
		end

	updated_installation (a_token: READABLE_STRING_8; a_installation: ES_ACCOUNT_INSTALLATION): ES_ACCOUNT_INSTALLATION
		local
			l_installation_href: READABLE_STRING_8
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
		do
			reset_api_call
			l_installation_href := endpoint_for_token (a_token, "_links|es:installation|href;installation=" + a_installation.id)
			Result := a_installation
			if
				l_installation_href /= Void and then
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)
				resp := response_get (sess, l_installation_href, ctx)
				if not has_error then
					Result := installation_from_response (resp)
				end
			end
		end

	session (acc: ES_ACCOUNT; a_installation: ES_ACCOUNT_INSTALLATION; a_session_id: READABLE_STRING_32): detachable ES_ACCOUNT_SESSION
		local
			l_session_href: READABLE_STRING_8
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: like response
			u: URI
			params: ES_CLOUD_API_SESSION_PARAMETERS
		do
			reset_api_call
				-- Update endpoints ...
			if a_installation /= Void then
				create params.make (a_installation.id, a_session_id)
				ping_installation (acc.access_token.token, params, Void)
			end
			reset_api_call

			l_session_href := endpoint_for_token (acc.access_token.token, {STRING_32} "_links|es:session|href;session=" + a_session_id.as_string_32)
			if
				not attached l_session_href and then
				attached endpoint_for_token (acc.access_token.token, {STRING_32} "_links|es:installation|href;installation=" + a_installation.id.as_string_32) as l_installation_href
			then
				create u.make_from_string (l_installation_href + "/session/")
				u.add_unencoded_path_segment (a_session_id)
				l_session_href := u.string
			end
			if l_session_href /= Void then
				if
					attached new_http_client_session as sess
				then
					ctx := new_jwt_auth_context (acc.access_token.token)

					resp := response_get (sess, l_session_href, ctx)
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
					resp := response_get (sess, l_installations_href, ctx)
					if not has_error then
						if attached resp.table_item ("es:installations") as l_installations then
							create {ARRAYED_LIST [ES_ACCOUNT_INSTALLATION]} Result.make (l_installations.count)
							across
								l_installations as ic
							loop
								create inst.make_with_id (ic.key.to_string_8)
								if attached resp.string_8_item ("_links|" + inst.id + "|href") as h then
									record_endpoint_for_token (a_token, "_links|es:installation|href;installation=" + inst.id, h)
								end
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
				attached response_get (sess, config.root_endpoint, Void) as resp
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
			resp := response_get (sess, config.root_endpoint, ctx)
			if has_error then
				reset_api_call
			else
				if attached resp.string_8_item ("_links|jwt:access_token|href") as v then
					Result := v
				end
			end
		end

	jwt_new_magic_login_endpoint (a_token: READABLE_STRING_8; sess: HTTP_CLIENT_SESSION; ctx: HTTP_CLIENT_REQUEST_CONTEXT): detachable IMMUTABLE_STRING_8
		local
			resp: like response
		do
			reset_api_call
			resp := response_get (sess, config.root_endpoint, ctx)
			if has_error then
				reset_api_call
			else
				if attached resp.string_8_item ("_links|jwt:new_magic_login|href") as v then
					Result := v
					record_endpoint_for_token (a_token, "_links|jwt:new_magic_login|href", v)
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

				resp := response_get (sess, l_es_cloud_href, ctx)
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

--	es_account_licenses_endpoint_for_token (a_token: READABLE_STRING_8; sess: HTTP_CLIENT_SESSION): detachable IMMUTABLE_STRING_8
--		do
--			Result := endpoint_for_token (a_token, "_links|es:licenses|href")
--			if Result = Void then
--				get_es_account_endpoints_for_token (a_token, sess)
--				Result := endpoint_for_token (a_token, "_links|es:licenses|href")
--			end
--		end

feature {NONE} -- Implementation

	response (a_resp: HTTP_CLIENT_RESPONSE): ES_CLOUD_API_RESPONSE
		do
			if a_resp = Void or else a_resp.error_occurred then
				is_available := False
			end
			create Result.make (a_resp)
			last_error := Result.error
		end

	response_get (sess: like new_http_client_session; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): ES_CLOUD_API_RESPONSE
		local
			r: HTTP_CLIENT_RESPONSE
		do
			debug ("es_cloud")
				print (generator + " -> GET "+ sess.url (a_path, ctx) + "%N")
			end
			if is_available then
				if config.is_verbose (1) then
					log_get_query (sess.url (a_path, ctx))
				end
				r := sess.get (a_path, ctx)
				Result := response (r)
				if config.is_verbose (1) then
					log_response (r)
				end
			else
				Result := response (Void)
			end
		end

	response_post (sess: like new_http_client_session; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): ES_CLOUD_API_RESPONSE
		local
			r: HTTP_CLIENT_RESPONSE
		do
			debug ("es_cloud")
				print (generator + " -> POST "+ sess.url (a_path, ctx) + "%N")
			end
			if is_available then
				if config.is_verbose (1) then
					log_post_query (sess.url (a_path, ctx), data)
				end
				r := sess.post (a_path, ctx, data)
				Result := response (r)
				if config.is_verbose (2) then
					log_response (r)
				end
			else
				Result := response (Void)
			end
		end

	new_http_client_session: detachable HTTP_CLIENT_SESSION
		local
			cl: DEFAULT_HTTP_CLIENT
		do
			create cl
			if attached config.preferred_http_client as pref_cl then
				cl.force_default_client (pref_cl)
			end
			Result := cl.new_session (config.server_url)
			Result.add_header ("Accept", "application/json,text/html;q=0.9,*.*;q=0.8")
			if attached config.user_agent as ua then
				Result.add_header ({HTTP_HEADER_NAMES}.header_user_agent, ua)
			end
			Result.set_connect_timeout (config.connection_timeout)
			Result.set_timeout (config.timeout)
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
--				if
--					attached r.sub_item ("es:plan") as r_plan and then
--					attached plan_from_response (r_plan) as l_plan
--				then
--					Result.set_plan (l_plan)
--				end
			end
		end

	account_licenses_from_response (r: ES_CLOUD_API_RESPONSE): LIST [ES_ACCOUNT_LICENSE]
		do
			if
				attached r.table_item ("es:licenses") as r_licenses
			then
				create {ARRAYED_LIST [ES_ACCOUNT_LICENSE]} Result.make (r_licenses.count)
				across
					r_licenses as r_lic
				loop
					if attached license_from_response (r_lic.item) as lic then
						Result.force (lic)
					end
				end
			else
				create {ARRAYED_LIST [ES_ACCOUNT_LICENSE]} Result.make (0)
			end
		end

	account_installations_from_response (r: ES_CLOUD_API_RESPONSE): LIST [ES_ACCOUNT_INSTALLATION]
		local
			inst: ES_ACCOUNT_INSTALLATION
		do
			if
				attached r.table_item ("es:installations") as r_installations
			then
				create {ARRAYED_LIST [ES_ACCOUNT_INSTALLATION]} Result.make (r_installations.count)
				across
					r_installations as ic
				loop
					create inst.make_with_id ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (ic.key))
					Result.force (inst)
				end
			else
				create {ARRAYED_LIST [ES_ACCOUNT_INSTALLATION]} Result.make (0)
			end
		end

	plan_from_response (r: like response): detachable ES_ACCOUNT_PLAN
		do
			if attached r.string_8_item ("name") as l_plan_name then
				create Result.make (l_plan_name)
				if attached r.integer_64_item ("id") as l_pid then
					Result.set_plan_id (l_pid)
				elseif attached r.string_32_item ("id") as s_pid then
					Result.set_plan_id (s_pid.to_integer_64)
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

	license_from_response (r: like response): detachable ES_ACCOUNT_LICENSE
		do
			if attached r.string_8_item ("key") as l_key then
				create Result.make (l_key)

				if attached r.string_8_item ("plan") as l_plan_name then
					Result.set_plan_name (l_plan_name)
				end
				if attached r.integer_64_item ("plan_id") as l_pid then
					Result.set_plan_id (l_pid)
				elseif attached r.string_32_item ("plan_id") as s_pid then
					Result.set_plan_id (s_pid.to_integer_64)
				end
--				if r.boolean_item_is_true ("is_active") then
--				end				
				if r.boolean_item_is_true ("is_fallback") then
					Result.set_is_fallback (True)
				end
				if r.boolean_item_is_true ("is_suspended") then
					Result.set_is_suspended (True)
				end
				if attached r.integer_64_item ("days_remaining") as l_days_remaining then
					Result.set_days_remaining (l_days_remaining.to_integer_32)
				end
				if attached r.date_time_item ("creation") as l_creation then
					Result.set_creation_date (l_creation)
				end
				if attached r.date_time_item ("expiration") as l_expiration then
					Result.set_expiration_date (l_expiration)
				end
				if attached r.string_8_item ("plan_limitations") as lim then
					Result.set_plan_limitations_string (lim)
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
		local
			lics: ARRAYED_LIST [ES_ACCOUNT_LICENSE]
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
			if
				attached resp.sub_item ("es:license") as r_lic and then
				attached license_from_response (r_lic) as l_lic
			then
				Result.set_associated_license (l_lic)
			end
			if
				attached resp.sub_item ("es:plan") as r_plan and then
				attached plan_from_response (r_plan) as l_plan
			then
				Result.set_associated_plan (l_plan)
			end
			if
				attached resp.table_item ("es:adapted_licenses") as r_lics and then
				not r_lics.is_empty
--				 and then
--				attached license_from_response (r_lic) as l_lic
			then
				create lics.make (r_lics.count)
				across
					r_lics as ic
				loop
					if attached license_from_response (ic.item) as l_lic then
						lics.force (l_lic)
					end
				end
				Result.set_adapted_licenses (lics)
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

feature {NONE} -- Implementation

	log_prefix: IMMUTABLE_STRING_8 = "[LOG] "

	log_get_query (a_url: READABLE_STRING_8)
		do
			print (log_prefix)
			print ("GET "+ a_url + "%N")
		end

	log_post_query (a_url: READABLE_STRING_8; a_data: detachable READABLE_STRING_8)
		local
			s: STRING
		do
			io.error.put_string (log_prefix)
			io.error.put_string ("POST "+ a_url)
			if a_data = Void then
				io.error.put_string (" -- no data")
			else
				if config.is_verbose (2) then
					create s.make_from_string (a_data)
					io.error.put_string (log_prefix)
					io.error.put_string ("----DATA---%N")
					s.prepend (log_prefix)
					s.replace_substring_all ("%N", "%N" + log_prefix)
					io.error.put_string (s)
					io.error.put_new_line
					io.error.put_string (log_prefix)
					io.error.put_string ("----------")
				else
					io.error.put_string (" -- data (size=" + a_data.count.out + ")")
				end
			end
			io.error.put_new_line
		end

	log_response (r: HTTP_CLIENT_RESPONSE)
		local
			s: STRING
			pref: STRING
		do
			create pref.make_from_string (log_prefix)
			io.error.put_string (pref)
			if attached r.status_line as l_status_line then
				io.error.put_string (l_status_line)
			else
				io.error.put_string ("status:")
				io.error.put_string (r.status.out)
			end
			if attached r.body as l_body then
				if config.is_verbose (2) then
					io.error.put_string (pref)
					io.error.put_string ("----BODY---%N")
					create s.make_from_string (l_body)
					s.prepend (pref)
					s.replace_substring_all ("%N", "%N" + pref)
					io.error.put_string (s)
					io.error.put_new_line
					io.error.put_string (pref)
					io.error.put_string ("----------")
				else
					io.error.put_string (" -- body (size=" + l_body.count.out + ")")
				end
			else
				io.error.put_string (" -- no body")
			end
			io.error.put_new_line
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
