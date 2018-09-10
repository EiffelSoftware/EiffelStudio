note
	description : "seehttps://code.google.com/apis/console ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"
	EIS: "name=Google OAuth Playground", "protocol=URI", "src=https://developers.google.com/oauthplayground/"
	EIS: "name=Google API", "protocol=URI", "src=https://developers.google.com"
	EIS: "name=Google+ API", "protocol=URI", "src=https://developers.google.com/+/api/latest/"



class
	TEST_GOOGLE_CONSUMER
inherit
	JSON_PARSER_ACCESS

create
	make

feature {NONE} -- Initialization

	client_id,
	client_secret,
	redirect_uri: READABLE_STRING_8

	make (p: TEST_GOOGLE_PARAMETERS)
			-- Initialize `Current'.
		do
			client_id := p.client_id
			client_secret := p.client_secret
			redirect_uri := p.redirect_uri

			create http_client
			initialize (p)
		end

	initialize (params: TEST_GOOGLE_PARAMETERS)
		local
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			p: JSON_PARSER
			e: EXECUTION_ENVIRONMENT
			f: RAW_FILE
			l_code: detachable READABLE_STRING_8
			l_refresh_token, l_access_token, l_token_type: detachable READABLE_STRING_8
		do
			-- Get OAuth2 Token
			sess := http_client.new_session ("https://accounts.google.com/o/oauth2")
			sess.set_is_insecure (True)

			create ctx.make
			ctx.add_query_parameter ("scope", "https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile")
			ctx.add_query_parameter ("redirect_uri", redirect_uri)
			ctx.add_query_parameter ("response_type", "code")
			ctx.add_query_parameter ("client_id", client_id)


			l_code := params.code

			if l_code = Void then
				if attached sess.url ("/auth", ctx) as u then
					create f.make_create_read_write ("tmp-test_google_consumer.html")
					f.put_string ("<a href=%"" + u + "%">Visit this page</a>")
					f.close
					create e
					e.system ("explorer %"" + f.path.name + "%"")
					io.put_string ("Enter the code:")
					io.read_line
					l_code := io.last_string
					f.delete

				end
			end
			if l_code /= Void then
				if params.code /= l_code then
					params.set_code (l_code)
					params.save
				end
				create ctx.make
				ctx.add_form_parameter ("code", l_code)
				ctx.add_form_parameter ("client_id", client_id)
				ctx.add_form_parameter ("client_secret", client_secret)
				ctx.add_form_parameter ("redirect_uri", redirect_uri)
				ctx.add_form_parameter ("grant_type", "authorization_code")

				l_access_token := params.access_token
				l_refresh_token := params.refresh_token
				l_token_type := params.token_type

				if l_access_token = Void then
					if attached sess.post ("/token", ctx, Void) as res and then attached res.body as l_body then
						create p.make_with_string (l_body)
						if attached {JSON_OBJECT} p.next_parsed_json_value as j then
							if attached {JSON_STRING} j.item ("access_token") as j_access_token then
								l_access_token := j_access_token.item
							end
							if attached {JSON_NUMBER} j.item ("expires_in") as j_expires_in then
							end
							if attached {JSON_STRING} j.item ("token_type") as j_token_type then
								l_token_type := j_token_type.item
							end
							if attached {JSON_STRING}j.item ("id_token") as j_id_token then

							end
							if attached {JSON_STRING} j.item ("refresh_token") as j_refresh_token then
								l_refresh_token := j_refresh_token.item
							end
						end
					end
				end

				if l_access_token /= Void then
					if params.access_token /= l_access_token then
						params.set_access_token (l_access_token)
						if params.refresh_token /= l_refresh_token then
							params.set_refresh_token (l_refresh_token)
						end
						if params.token_type /= l_token_type then
							params.set_access_token (l_token_type)
						end
						params.save
					end
					create ctx.make

					sess := http_client.new_session ("https://www.googleapis.com/oauth2")
					sess.set_is_insecure (True)
					if l_token_type /= Void then
						sess.add_header ("Authorization", l_token_type + " " + l_access_token)
					else
						ctx.add_query_parameter ("access_token", l_access_token)
					end

					if attached sess.get ("/v1/userinfo", ctx) as res then
						print (res.body)
					end
				end

			end
		end

--	new_http_autorizaton_value (rqst_method: STRING; a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT;
--			a_oauth_token: READABLE_STRING_8): STRING_8
--		local
--			l_nonce: like nonce
--			l_timestamp: INTEGER_64
--			l_version: STRING_8
--		do
--			l_nonce := nonce
--			l_timestamp := timestamp
--			l_version := "1.0"

--			Result := "OAuth"
--			Result.append_character (' ')
--			Result.append ("oauth_consumer_key=%"" + consumer_key + "%"")
--			Result.append_character (',')
--			Result.append_character (' ')
--			Result.append ("oauth_nonce=%"" + l_nonce + "%"")
--			Result.append_character (',')
--			Result.append_character (' ')
--			Result.append ("oauth_signature=%"" + signature (rqst_method, a_url, ctx, consumer_key, l_nonce, l_timestamp, a_oauth_token, l_version) + "%"")
--			Result.append_character (',')
--			Result.append_character (' ')
--			Result.append ("oauth_signature_method=%""+ signature_method +"%"")
--			Result.append_character (',')
--			Result.append_character (' ')
--			Result.append ("oauth_timestamp=%"" + l_timestamp.out + "%"")
--			Result.append_character (',')
--			Result.append_character (' ')
--			Result.append ("oauth_token=%"" + a_oauth_token+ "%"")
--			Result.append_character (',')
--			Result.append_character (' ')
--			Result.append ("oauth_version=%""+ l_version +"%"")
--		end

--	signature_method: STRING_8
--		do
--			Result := signature_builder.signature_method
--		end

--	signature_builder: HMAC_SHA256_SIGNATURE_BUILDER
--		once
--			create Result.make
--		end

--	signature (rqst_method: STRING; a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT;
--				a_consumer_key: STRING_8; a_nonce: STRING_8; a_timestamp: INTEGER_64;
--				a_token: STRING_8; a_version: STRING_8): STRING_8
--		local
--			tb: HASH_TABLE [STRING_32, STRING_32]
--			l_sig_builder: like signature_builder
--		do
--			l_sig_builder := signature_builder

--			create tb.make (10)
--			tb.force (a_consumer_key, "oauth_consumer_key")
--			tb.force (a_nonce, "oauth_nonce")
--			tb.force (l_sig_builder.signature_method, "oauth_signature_method")
--			tb.force (a_timestamp.out, "oauth_timestamp")
--			tb.force (a_token.out, "oauth_token")
--			tb.force (a_version, "oauth_version")

--			if ctx /= Void then
--				across
--					ctx.query_parameters as q
--				loop
--					tb.force (q.item, q.key)
--				end
--				if not ctx.form_parameters.is_empty then
--					check is_post: rqst_method.is_case_insensitive_equal ("POST") end
--					across
--						ctx.form_parameters as f
--					loop
--						tb.force (f.item, f.key)
--					end
--				end
--			end

--			Result := l_sig_builder.signature (<<rqst_method.as_upper, a_url>>, tb, signing_key)
--		end

	nonce: STRING_8
		do
			Result := (create {NONCE_GENERATOR}).new_nonce (42)
		end

	timestamp: INTEGER_64
		do
			Result := (create {TIMESTAMP_HELPER}).timestamp_now_utc
		end

feature -- Execution

	execute
		do
		end

feature {NONE} -- Implementation

 	http_client: DEFAULT_HTTP_CLIENT

	session: detachable HTTP_CLIENT_SESSION

feature -- API

	api_contacts: STRING = "https://www.google.com/m8/feeds/"
	api_docs: STRING = "https://docs.google.com/feeds/"
	api_drive: STRING = "https://www.googleapis.com/auth/drive"
	api_drive_file: STRING = "https://www.googleapis.com/auth/drive.file"
	api_gmail: STRING = "https://mail.google.com/mail/feed/atom"
	api_plus: STRING = "https://www.googleapis.com/auth/plus.me"
	api_urlshortener: STRING = "https://www.googleapis.com/auth/urlshortener"
	api_userinfo_email: STRING = "https://www.googleapis.com/auth/userinfo.email"
	api_userinfo_profile: STRING = "https://www.googleapis.com/auth/userinfo.profile"

invariant
--	invariant_clause: True

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
