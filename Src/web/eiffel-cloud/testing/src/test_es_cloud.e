note
	description: "[
			Enter class description here!
		]"

class
	TEST_ES_CLOUD

create
	make

feature {NONE} -- Initialization

	make
			-- Instantiate Current object.
		local
			cl: HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			resp: HTTP_CLIENT_RESPONSE
			j: like json
			l_access_token, l_refresh_key: detachable READABLE_STRING_8
			l_es_cloud_href: detachable READABLE_STRING_8
			l_jwt_access_token_href: detachable READABLE_STRING_8
		do
			create {DEFAULT_HTTP_CLIENT} cl
			sess := cl.new_session (service_url)
			sess.add_header ("Content-Type", "application/json")

			if False and attached loaded_data as d then
				l_access_token := d.access_token
				l_refresh_key := d.refresh_key
			end
			if l_access_token /= Void then
				ctx := new_ctx_jwt (l_access_token)
			else
				ctx := new_ctx_basic ("foo", "bar")
			end

			resp := get_request ("/es", sess, ctx)
			if not resp.error_occurred then
				j := json (resp.body)
				if attached {JSON_STRING} json_field (j, "_links|jwt:access_token|href") as v then
					l_jwt_access_token_href := v.unescaped_string_8
				end
				if attached {JSON_STRING} json_field (j, "_links|es:cloud|href") as v then
					l_es_cloud_href := v.unescaped_string_8
				end
			end

			if l_access_token = Void and then l_jwt_access_token_href /= Void then
				ctx.add_form_parameter ("applications", "eiffelstudio,testing")
				resp := post_request (l_jwt_access_token_href, sess, ctx, Void)
				if not resp.error_occurred then
					j := json (resp.body)
					if attached {JSON_STRING} json_field (j, "access_token") as j_access_token then
						l_access_token := j_access_token.unescaped_string_8
					end
					if attached {JSON_STRING} json_field (j, "refresh_key") as j_refresh_key then
						l_refresh_key := j_refresh_key.unescaped_string_8
					end
					if l_access_token /= Void then
						save (l_access_token, l_refresh_key)
						ctx := new_ctx_jwt (l_access_token)
					end
				end
			end
			if l_access_token /= Void and l_jwt_access_token_href /= Void then
					-- Display all jwt access tokens for user.
				resp := get_request (l_jwt_access_token_href, sess, ctx)
				if not resp.error_occurred then
					j := json (resp.body)
					if attached {JSON_ARRAY} json_field (j, "access_tokens") as j_arr then
						across
							j_arr as ic
						loop
							if attached {JSON_STRING} json_field (ic.item, "token") as js then
								print (js.unescaped_string_8)
								if attached {JSON_STRING} json_field (ic.item, "applications") as js_apps then
									print (" apps=" + js_apps.unescaped_string_8)
								end
								print ("%N")
							end
						end
					end
				end

				if l_es_cloud_href /= Void then
						-- Let's use the es cloud web API
					resp := get_request (l_es_cloud_href, sess, ctx)
					if not resp.error_occurred then
						j := json (resp.body)
						if attached {JSON_STRING} json_field (j, "_links|es:account|href") as j_es_account_href then
							resp := get_request (j_es_account_href.unescaped_string_8, sess, ctx)
							if not resp.error_occurred then
								j := json (resp.body)
								if
									attached {JSON_STRING} json_field (j, "es:plan|name") as j_plan and then
									attached {JSON_NUMBER} json_field (j, "es:plan|days_remaining") as j_days_remaining
								then
									print ("Plan: " + j_plan.unescaped_string_8 + "%N")
									print ("Days remaining: " + j_days_remaining.integer_64_item.out + "%N")
								end
								debug
									print (resp.url)
									print ("%N")
									print ("status code=" + resp.status.out + "%N")
									print (resp.raw_header)
									print (resp.body)
								end
							end
						end
					end
				end

				if l_jwt_access_token_href /= Void and l_access_token /= Void and l_refresh_key /= Void then
					refresh_token (l_jwt_access_token_href, l_access_token, l_refresh_key, sess, ctx)
					if attached loaded_data as d then
						l_access_token := d.access_token
						l_refresh_key := d.refresh_key
						if l_access_token /= Void then
							ctx := new_ctx_jwt (l_access_token)
						end
					end
					if l_access_token /= Void and l_refresh_key /= Void then
						refresh_token (l_jwt_access_token_href, l_access_token, l_refresh_key, sess, ctx)
					end
					if attached loaded_data as d then
						l_access_token := d.access_token
						l_refresh_key := d.refresh_key
						if l_access_token /= Void then
							ctx := new_ctx_jwt (l_access_token)
						end
					end
				end
			end
		end

	refresh_token (a_jwt_access_token_href: READABLE_STRING_8; a_access_token, a_refresh_key: READABLE_STRING_8; sess: HTTP_CLIENT_SESSION; ctx: HTTP_CLIENT_REQUEST_CONTEXT)
		local
			l_access_token, l_refresh_key: detachable READABLE_STRING_8
			resp: HTTP_CLIENT_RESPONSE
			j: like json
		do
			print ("Refreshing jwt token ...%N")
			ctx.add_form_parameter ("token", a_access_token)
			ctx.add_form_parameter ("refresh", a_refresh_key)
			resp := post_request (a_jwt_access_token_href, sess, ctx, Void)
			if not resp.error_occurred then
				j := json (resp.body)
				if attached {JSON_STRING} json_field (j, "access_token") as j_access_token then
					l_access_token := j_access_token.unescaped_string_8
				else
					l_access_token := Void
				end
				if attached {JSON_STRING} json_field (j, "refresh_key") as j_refresh_key then
					l_refresh_key := j_refresh_key.unescaped_string_8
				else
					l_refresh_key := Void
				end
				if l_access_token /= Void and l_refresh_key /= Void then
					print ("-> token=" + l_access_token + " refresh=" + l_refresh_key + "%N")
					save (l_access_token, l_refresh_key)
				else
					print ("-> Issue with refresh!%N")
				end
			end
		end

feature -- Request

	get_request (a_path: READABLE_STRING_8; a_session: HTTP_CLIENT_SESSION ; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		do
			print (">> GET (" + a_path + ", ctx) -> ")
			Result := a_session.get (a_path, ctx)
			print (Result.status.out)
			print ("%N")
			if attached Result.body as b then
				print ("-------------%N")
				print (b)
				print ("%N")
				print ("-------------%N")
			else
				print ("No Body!%N")
			end
		end

	post_request (a_path: READABLE_STRING_8; a_session: HTTP_CLIENT_SESSION ; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; a_data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			print (">> POST (" + a_path + ", ctx, a_data) -> ")
			Result := a_session.post (a_path, ctx, a_data)
			print (Result.status.out)
			print ("%N")
			if attached Result.body as b then
				print ("-------------%N")
				print (b)
				print ("%N")
				print ("-------------%N")
			else
				print ("No Body!%N")
			end
		end

feature -- Factory

	new_ctx_basic (u,p: READABLE_STRING_GENERAL): HTTP_CLIENT_REQUEST_CONTEXT
		local
			httpauth: HTTP_AUTHORIZATION
		do
			create Result.make
			create httpauth.make_basic_auth ("foo", "bar")
			if attached httpauth.http_authorization as l_auth then
				Result.add_header ("Authorization", l_auth)
			end
		end

	new_ctx_jwt (a_jw_token: READABLE_STRING_8): HTTP_CLIENT_REQUEST_CONTEXT
		do
			create Result.make
			Result.add_header ("Authorization", "Bearer " + a_jw_token)
		end

feature -- Constants		

	service_url: STRING = "http://localhost:9090"

feature -- Storage

	save (a_access_token: detachable READABLE_STRING_8; a_refresh_key: detachable READABLE_STRING_8)
		local
			j: JSON_OBJECT
			f: PLAIN_TEXT_FILE
		do
			create j.make_with_capacity (2)
			if attached a_access_token then
				j.put_string (a_access_token, "access_token")
			end
			if attached a_refresh_key then
				j.put_string (a_refresh_key, "refresh_key")
			end
			create f.make_with_name (".test-pref")
			f.create_read_write
			f.put_string (j.representation)
			f.put_new_line
			f.close
		end

	loaded_data: detachable TUPLE [access_token: detachable READABLE_STRING_8; refresh_key: detachable READABLE_STRING_8]
		local
			f: PLAIN_TEXT_FILE
			nb: INTEGER
		do
			create f.make_with_name (".test-pref")
			if f.exists then
				nb := f.count
				f.open_read
				f.read_stream (nb)
				f.close
				if
					attached json (f.last_string) as j and then
					attached {JSON_STRING} json_field (j, "access_token") as j_tok
				then
					if attached {JSON_STRING} json_field (j, "refresh_key") as j_key then
						Result := [j_tok.unescaped_string_8 , j_key.unescaped_string_8]
					else
						Result := [j_tok.unescaped_string_8 , Void]
					end
				end
			end
		end

feature -- Query

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
						exp.after or l_obj = Void
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

end
