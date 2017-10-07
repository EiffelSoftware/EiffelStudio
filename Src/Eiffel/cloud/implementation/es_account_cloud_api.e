note
	description: "Summary description for {ES_ACCOUNT_CLOUD_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_CLOUD_API

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
				attached sess.get (root_endpoint, Void) as resp and then
				not resp.error_occurred
			then
				is_available := True
				if attached json (resp.body) as j then
					if attached {JSON_STRING} json_field (j, "_links|register|href") as v then
						record_endpoint ("roc:register", v.unescaped_string_8)
					end
					if attached {JSON_STRING} json_field (j, "_links|es:cloud|href") as v then
						record_endpoint ("es:cloud", v.unescaped_string_8)
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

feature -- Account: register

	register (a_username, a_password: READABLE_STRING_GENERAL; a_email: READABLE_STRING_8): detachable ES_ACCOUNT
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: HTTP_CLIENT_RESPONSE
		do
			if attached endpoint ("roc:register") as l_url then
				sess := new_http_client_session
				if sess /= Void then
					create ctx.make
					ctx.add_form_parameter ("name", a_username)
					ctx.add_form_parameter ("password", a_password)
					ctx.add_form_parameter ("email", a_email)
					ctx.add_form_parameter ("personal_information", "Registration submitted via API.")
					resp := sess.post (l_url, ctx, Void)
					if
						not resp.error_occurred and then
						attached json (resp.body) as j
					then
						if
							attached {JSON_STRING} json_field (j, "status") as j_status and then
							j_status.unescaped_string_32.same_string_general ("succeed")
						then
							create Result.make (a_username)
							if attached {JSON_STRING} json_field (j, "information") as j_info then
								print (j_info.unescaped_string_8)
							end
						end
					end
				end
			end
		end

feature -- ROC Account

	refresh_token (a_token: READABLE_STRING_8; a_refresh_key: READABLE_STRING_8; acc: ES_ACCOUNT)
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: HTTP_CLIENT_RESPONSE
			l_jwt_access_token_href: detachable READABLE_STRING_8
		do
			sess := new_http_client_session
			if sess /= Void then
				ctx := new_jwt_auth_context (a_token)
				ctx.set_credentials_required (True)

				l_jwt_access_token_href := jwt_access_token_endpoint (sess, ctx)
				if l_jwt_access_token_href /= Void then
						-- Get new JWT access token, using Basic authorization.
					ctx.add_form_parameter ("refresh", a_refresh_key)
					resp := sess.post (l_jwt_access_token_href, ctx, Void)
					if
						not resp.error_occurred and then
						attached json (resp.body) as j
					then
						update_account_with_jwt_access_token_from_json (acc, j)
					end
				end
			end
		end

	account (a_token: READABLE_STRING_8): detachable ES_ACCOUNT
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: HTTP_CLIENT_RESPONSE
			l_es_cloud_href,
			l_account_href: detachable READABLE_STRING_8
		do
			l_es_cloud_href := endpoint ("es:cloud")
			if l_es_cloud_href = Void then
				get_es_cloud_endpoint
				l_es_cloud_href := endpoint ("es:cloud")
			end
			if l_es_cloud_href /= Void then
				sess := new_http_client_session
				if sess /= Void then
					ctx := new_jwt_auth_context (a_token)
					ctx.set_credentials_required (True)

					resp := sess.get (l_es_cloud_href, ctx)
					if
						attached resp and then not resp.error_occurred and then
						attached json (resp.body) as j
					then
						if attached {JSON_STRING} json_field (j, "_links|es:account|href") as v then
							l_account_href := v.unescaped_string_8
						end
						if attached {JSON_STRING} json_field (j, "_links|es:installations|href") as v then
--							record_endpoint ("es:cloud", v.unescaped_string_8)
						end
					end
					if l_account_href /= Void then
							-- Get new JWT access token, using Basic authorization.
						resp := sess.get (l_account_href, ctx)
						if
							not resp.error_occurred and then
							attached json (resp.body) as j
						then
							if attached account_from_json (j) as acc then
								Result := acc
								Result.set_access_token (create {ES_ACCOUNT_ACCESS_TOKEN}.make (a_token))
							end
						end
					end
				end
			end
		end

	account_using_basic_authorization (a_username, a_password: READABLE_STRING_GENERAL): detachable ES_ACCOUNT
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			sess: like new_http_client_session
			resp: HTTP_CLIENT_RESPONSE
			l_jwt_access_token_href: detachable READABLE_STRING_8
		do
			sess := new_http_client_session
			if sess /= Void then
				ctx := new_basic_auth_context (a_username, a_password)
				ctx.set_credentials_required (True)

				resp := sess.get (root_endpoint, ctx)
				if
					attached resp and then not resp.error_occurred and then
					attached json (resp.body) as j
				then
					if attached {JSON_STRING} json_field (j, "_links|jwt:access_token|href") as v then
						l_jwt_access_token_href := v.unescaped_string_8
					end
					if attached {JSON_STRING} json_field (j, "_links|es:cloud|href") as v then
						record_endpoint ("es:cloud", v.unescaped_string_8)
					end
				end

				if l_jwt_access_token_href /= Void then
						-- Get new JWT access token, using Basic authorization.
					ctx.add_form_parameter ("applications", "es_account_api")
					resp := sess.post (l_jwt_access_token_href, ctx, Void)
					if
						not resp.error_occurred and then
						attached json (resp.body) as j
					then
						create Result.make (a_username)
						if attached {JSON_NUMBER} json_field (j, "user|uid") as j_uid then
							Result.set_user_id (j_uid.integer_64_item)
						elseif attached {JSON_STRING} json_field (j, "user|uid") as j_uid then
							Result.set_user_id (j_uid.item.to_integer_64)
						end
						update_account_with_jwt_access_token_from_json (Result, j)
						check Result.access_token /= Void end
					end
				end
			end
		end

feature -- Plan

	plan (a_token: READABLE_STRING_8): detachable ES_ACCOUNT_PLAN
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: HTTP_CLIENT_RESPONSE
			l_es_cloud_href: detachable READABLE_STRING_8
			l_account_href: READABLE_STRING_8
		do
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)
				ctx.set_credentials_required (True)

				l_es_cloud_href := endpoint ("es:cloud")
				if l_es_cloud_href = Void then
					get_es_cloud_endpoint
					l_es_cloud_href := endpoint ("es:cloud")
				end
				if l_es_cloud_href /= Void then
					resp := sess.get (l_es_cloud_href, ctx)
					if
						attached resp and then not resp.error_occurred and then
						attached json (resp.body) as j
					then
						if attached {JSON_STRING} json_field (j, "_links|es:account|href") as v then
							l_account_href := v.unescaped_string_8
						end
					end
					if l_account_href /= Void then
						resp := sess.get (l_account_href, ctx)
						if
							not resp.error_occurred and then
							attached json (resp.body) as j
						then
							if attached account_from_json (j) as acc then
								Result := acc.plan
							end
						end
					end
				end
			end
		end

feature -- Installation

	register_installation (a_token: READABLE_STRING_8; a_installation: ES_ACCOUNT_INSTALLATION): detachable ES_ACCOUNT_INSTALLATION
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: HTTP_CLIENT_RESPONSE
			l_es_cloud_href: detachable READABLE_STRING_8
			l_installations_href, l_new_installation_href: READABLE_STRING_8
			j_info: JSON_OBJECT
		do
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)
				ctx.set_credentials_required (True)

				l_es_cloud_href := endpoint ("es:cloud")
				if l_es_cloud_href = Void then
					get_es_cloud_endpoint
					l_es_cloud_href := endpoint ("es:cloud")
				end
				if l_es_cloud_href /= Void then
					resp := sess.get (l_es_cloud_href, ctx)
					if
						attached resp and then not resp.error_occurred and then
						attached json (resp.body) as j
					then
						if attached {JSON_STRING} json_field (j, "_links|es:installations|href") as v then
							l_installations_href := v.unescaped_string_8
						end
					end
					if l_installations_href /= Void then
						ctx.add_form_parameter ("installation_id", a_installation.id)
						create j_info.make_with_capacity (1)
						if attached a_installation.platform as pf then
							j_info.put_string (pf, "platform")
						end
						ctx.add_form_parameter ("info", j_info.representation)
						resp := sess.post (l_installations_href, ctx, Void)
						if
							not resp.error_occurred and then
							attached json (resp.body) as j
						then
							if attached {JSON_STRING} json_field (j, "_links|es:installation|href") as v then
								l_new_installation_href := v.unescaped_string_8
							end
						end
						if l_new_installation_href /= Void then
							ctx := new_jwt_auth_context (a_token)
							ctx.set_credentials_required (True)
							resp := sess.get (l_installations_href, ctx)
							if
								not resp.error_occurred and then
								attached json (resp.body) as j
							then
								if attached {JSON_STRING} json_field (j, "es:installation|id") as v then
									create Result.make_with_id (v.unescaped_string_8)
									if attached {JSON_STRING} json_field (j, "es:installation|is_active") as v_is_active and then v_is_active.unescaped_string_8.is_case_insensitive_equal_general ("no") then
										Result.mark_inactive
									else
										Result.mark_active
									end
									if attached {JSON_STRING} json_field (j, "es:installation|info") as v_info then
										Result.set_info (v_info.unescaped_string_8)
									end
									if attached {JSON_STRING} json_field (j, "es:installation|creation_date") as v_creation then
										Result.set_creation_date (date_time_from_string (v_creation.unescaped_string_32))
									end
								end
							end
						end
					end
				end
			end
		end

	installation (a_token: READABLE_STRING_8; a_installation_id: READABLE_STRING_GENERAL): detachable ES_ACCOUNT_INSTALLATION
		do
			if attached installations (a_token) as lst then
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

	installations (a_token: READABLE_STRING_8): detachable LIST [ES_ACCOUNT_INSTALLATION]
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			resp: HTTP_CLIENT_RESPONSE
			l_es_cloud_href: detachable READABLE_STRING_8
			l_installations_href: READABLE_STRING_8
			inst: ES_ACCOUNT_INSTALLATION
		do
			if
				attached new_http_client_session as sess
			then
				ctx := new_jwt_auth_context (a_token)
				ctx.set_credentials_required (True)

				l_es_cloud_href := endpoint ("es:cloud")
				if l_es_cloud_href = Void then
					get_es_cloud_endpoint
					l_es_cloud_href := endpoint ("es:cloud")
				end
				if l_es_cloud_href /= Void then
					resp := sess.get (l_es_cloud_href, ctx)
					if
						attached resp and then not resp.error_occurred and then
						attached json (resp.body) as j
					then
						if attached {JSON_STRING} json_field (j, "_links|es:installations|href") as v then
							l_installations_href := v.unescaped_string_8
						end
					end
					if l_installations_href /= Void then
						resp := sess.get (l_installations_href, ctx)
						if
							not resp.error_occurred and then
							attached json (resp.body) as j
						then
							if attached {JSON_OBJECT} json_field (j, "es:installations") as j_installations then
								create {ARRAYED_LIST [ES_ACCOUNT_INSTALLATION]} Result.make (j_installations.count)
								across
									j_installations as ic
								loop
									create inst.make_with_id (ic.key.unescaped_string_8)
									Result.force (inst)
								end
							end
						end
					end
				end
			end
		end

feature -- Endpoints

	endpoints_table: detachable STRING_TABLE [IMMUTABLE_STRING_8]

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

	endpoint (rel: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_8
		local
			tb: like endpoints_table
		do
			tb := endpoints_table
			if tb /= Void then
				Result := tb.item (rel)
			end
		end

	get_es_cloud_endpoint
		do
			-- Get `is_available` value.
			if
				attached new_http_client_session as sess and then
				attached sess.get (root_endpoint, Void) as resp and then
				not resp.error_occurred
			then
				if attached json (resp.body) as j then
					if attached {JSON_STRING} json_field (j, "_links|es:cloud|href") as v then
						record_endpoint ("es:cloud", v.unescaped_string_8)
					end
				end
			end
		end

	es_account_endpoint (sess: HTTP_CLIENT_SESSION; ctx: HTTP_CLIENT_REQUEST_CONTEXT): detachable IMMUTABLE_STRING_8
		local
			resp: HTTP_CLIENT_RESPONSE
			l_es_cloud_href: detachable READABLE_STRING_8
		do
			l_es_cloud_href := endpoint ("es:cloud")
			if l_es_cloud_href = Void then
				get_es_cloud_endpoint
				l_es_cloud_href := endpoint ("es:cloud")
			end
			if l_es_cloud_href /= Void then
				resp := sess.get (l_es_cloud_href, ctx)
				if
					attached resp and then not resp.error_occurred and then
					attached json (resp.body) as j
				then
					if attached {JSON_STRING} json_field (j, "_links|es:account|href") as v then
						Result := v.unescaped_string_8
					end
				end
			end
		end

	jwt_access_token_endpoint (sess: HTTP_CLIENT_SESSION; ctx: HTTP_CLIENT_REQUEST_CONTEXT): detachable IMMUTABLE_STRING_8
		local
			resp: HTTP_CLIENT_RESPONSE
		do
			resp := sess.get (root_endpoint, ctx)
			if
				attached resp and then not resp.error_occurred and then
				attached json (resp.body) as j
			then
				if attached {JSON_STRING} json_field (j, "_links|jwt:access_token|href") as v then
					Result := v.unescaped_string_8
				end
			end
		end

feature {NONE} -- Implementation

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
--			Result.set_credentials_required (True)
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
		end

feature {NONE} -- Json handling

	json (s: detachable READABLE_STRING_8): detachable JSON_VALUE
		local
			jp: JSON_PARSER
		do
			if s /= Void then
				create jp.make_with_string (s)
				jp.parse_content
				if not jp.has_error then
					Result := jp.parsed_json_value
				end
			end
		end

	json_field (j: detachable JSON_VALUE; a_fn: READABLE_STRING_GENERAL): detachable JSON_VALUE
		local
			exp: LIST [READABLE_STRING_GENERAL]
			l_obj: detachable JSON_OBJECT
			l_val: detachable JSON_VALUE
		do
			if j /= Void then
				if attached {JSON_OBJECT} j as jo then
					exp := a_fn.split ('|')
					from
						exp.start
						l_obj := jo
						l_val := l_obj
					until
						exp.after or l_obj = void
					loop
						l_val := l_obj.item (exp.item)
						if exp.islast then
								-- Result in `l_val`
						else
							if attached {JSON_OBJECT} l_val as o then
								l_obj := o
							end
							l_val := Void
						end
						exp.forth
					end
					Result := l_val
				end
			end
		end

	date_time_from_string (s: READABLE_STRING_GENERAL): detachable DATE_TIME
			-- Date time from string `s`, if valid.
		local
			hd: HTTP_DATE
		do
			create hd.make_from_string (s)
			check not hd.has_error end
			if not hd.has_error then
				Result := hd.date_time
			end
		end

	account_from_json (j: JSON_VALUE): detachable ES_ACCOUNT
		do
			if attached {JSON_STRING} json_field (j, "name") as j_name then
				create Result.make (j_name.unescaped_string_32)
				if attached {JSON_NUMBER} json_field (j, "uid") as j_uid then
					Result.set_user_id (j_uid.integer_64_item)
				elseif attached {JSON_STRING} json_field (j, "uid") as j_uid then
					Result.set_user_id (j_uid.item.to_integer_64)
				end
				if
					attached json_field (j, "es:plan") as j_plan and then
					attached plan_from_json (j_plan) as l_plan
				then
					Result.set_plan (l_plan)
				end
			end
		end

	plan_from_json (j: JSON_VALUE): detachable ES_ACCOUNT_PLAN
		do
			if attached {JSON_STRING} json_field (j, "name") as j_plan_name then
				create Result.make (j_plan_name.unescaped_string_8)
				if attached {JSON_NUMBER} json_field (j, "id") as j_uid then
					Result.set_plan_id (j_uid.integer_64_item)
				elseif attached {JSON_STRING} json_field (j, "id") as j_uid then
					Result.set_plan_id (j_uid.item.to_integer_64)
				end
				if attached {JSON_NUMBER} json_field (j, "days_remaining") as j_days_remaining then
					Result.set_days_remaining (j_days_remaining.integer_64_item.to_integer_32)
				end
				if attached {JSON_STRING} json_field (j, "creation") as j_creation then
					Result.set_creation_date (date_time_from_string (j_creation.unescaped_string_8))
				end
				if attached {JSON_STRING} json_field (j, "expiration") as j_expiration then
					Result.set_expiration_date (date_time_from_string (j_expiration.unescaped_string_8))
				end
			end
		end

	update_account_with_jwt_access_token_from_json (acc: ES_ACCOUNT; j: JSON_VALUE)
		local
			tok: ES_ACCOUNT_ACCESS_TOKEN
		do
			if attached {JSON_STRING} json_field (j, "access_token") as j_access_token then
				create tok.make (j_access_token.unescaped_string_8)
				acc.set_access_token (tok)
				if attached {JSON_STRING} json_field (j, "refresh_key") as j_refresh_key then
					tok.set_refresh_key (j_refresh_key.unescaped_string_8)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
