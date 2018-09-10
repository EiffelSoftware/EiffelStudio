note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_TWITTER_CONSUMER

create
	make

feature {NONE} -- Initialization

	user: READABLE_STRING_8
	password: READABLE_STRING_8

	consumer_key,
	consumer_secret,
	signing_key: READABLE_STRING_8
	token_secret: detachable READABLE_STRING_8

	make (u,p: READABLE_STRING_8; a_consumer_key: like consumer_key; a_consumer_secret: like consumer_secret)
			-- Initialize `Current'.
		do
			user := u
			password := p
			consumer_key := a_consumer_key
			consumer_secret := a_consumer_secret

			create http_client
			initialize
		end

	initialize
		local
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
--			p: JSON_PARSER
			l_url: detachable READABLE_STRING_8
			s: STRING_8
		do
			-- Get OAuth2 Token
			sess := http_client.new_session ("https://api.twitter.com/")

			s := (create {URL_ENCODER}).encoded_string (consumer_secret.to_string_32) + "&"
			if attached token_secret as ts then
				s.append ((create {URL_ENCODER}).encoded_string (ts.to_string_32))
			end
			signing_key := s


			create ctx.make
			ctx.add_query_parameter ("include_entities", "true")
			ctx.add_form_parameter ("status", "Hello Ladies + Gentlemen, a signed OAuth request!")
			l_url := "https://api.twitter.com/1.1/statuses/update.json"
			s := new_http_autorizaton_value ("POST", l_url, ctx, "370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb")

		end

	new_http_autorizaton_value (rqst_method: STRING; a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT;
			a_oauth_token: READABLE_STRING_8): STRING_8
		local
			l_nonce: like nonce
			l_timestamp: INTEGER_64
			l_version: STRING_8
		do
			l_nonce := nonce
			l_timestamp := timestamp
			l_version := "1.0"

			Result := "OAuth"
			Result.append_character (' ')
			Result.append ("oauth_consumer_key=%"" + consumer_key + "%"")
			Result.append_character (',')
			Result.append_character (' ')
			Result.append ("oauth_nonce=%"" + l_nonce + "%"")
			Result.append_character (',')
			Result.append_character (' ')
			Result.append ("oauth_signature=%"" + signature (rqst_method, a_url, ctx, consumer_key, l_nonce, l_timestamp, a_oauth_token, l_version) + "%"")
			Result.append_character (',')
			Result.append_character (' ')
			Result.append ("oauth_signature_method=%""+ signature_method +"%"")
			Result.append_character (',')
			Result.append_character (' ')
			Result.append ("oauth_timestamp=%"" + l_timestamp.out + "%"")
			Result.append_character (',')
			Result.append_character (' ')
			Result.append ("oauth_token=%"" + a_oauth_token+ "%"")
			Result.append_character (',')
			Result.append_character (' ')
			Result.append ("oauth_version=%""+ l_version +"%"")
		end

	signature_method: STRING_8
		do
			Result := signature_builder.signature_method
		end

	signature_builder: HMAC_SHA256_SIGNATURE_BUILDER
		once
			create Result.make
		end

	signature (rqst_method: STRING; a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT;
				a_consumer_key: STRING_8; a_nonce: STRING_8; a_timestamp: INTEGER_64;
				a_token: STRING_8; a_version: STRING_8): STRING_8
		local
			tb: HASH_TABLE [STRING_32, STRING_32]
			l_sig_builder: like signature_builder
		do
			l_sig_builder := signature_builder

			create tb.make (10)
			tb.force (a_consumer_key, "oauth_consumer_key")
			tb.force (a_nonce, "oauth_nonce")
			tb.force (l_sig_builder.signature_method, "oauth_signature_method")
			tb.force (a_timestamp.out, "oauth_timestamp")
			tb.force (a_token.out, "oauth_token")
			tb.force (a_version, "oauth_version")

			if ctx /= Void then
				across
					ctx.query_parameters as q
				loop
--					tb.force (q.item, q.key)
				end
				if not ctx.form_parameters.is_empty then
					check is_post: rqst_method.is_case_insensitive_equal ("POST") end
					across
						ctx.form_parameters as f
					loop
--						tb.force (f.item, f.key)
					end
				end
			end

			Result := l_sig_builder.signature ({ARRAY [READABLE_STRING_32]}<<rqst_method.as_upper, a_url.to_string_32>>, tb, signing_key)
		end

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

feature -- Basic operation

	get_url (a_url: READABLE_STRING_8)
		local
--			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			if
				attached session as sess and then
				attached sess.get (a_url, Void) as res
			then
				print ("%N--------------------------%N")
				print ("GET URL=" + sess.base_url + a_url + "%N")
				print ("Status: " + res.status.out + "%N")

				if res.error_occurred then
					print (res)
				else
					print (res.raw_header)
					print (res.body)
				end
			end
		end

	post_url (a_url: READABLE_STRING_8; a_data: READABLE_STRING_8)
		local
--			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			if
				attached session as sess and then
				attached sess.post (a_url, Void, a_data) as res
			then
				print ("%N--------------------------%N")
				print ("POST URL=" + sess.base_url + a_url + "%N")
				print ("Status: " + res.status.out + "%N")

				if res.error_occurred then
					print (res)
				else
					print (res.raw_header)
					print (res.body)
				end
			end
		end

 feature {NONE} -- Implementation

 	http_client: DEFAULT_HTTP_CLIENT

	session: detachable HTTP_CLIENT_SESSION

	token: detachable READABLE_STRING_8

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
