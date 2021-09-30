note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CLOUD_CHECKER_APP

inherit
	ARGUMENTS_32

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			cloud_factory: ES_CLOUD_FACTORY
			cl: ES_CLOUD_S
			u,p: STRING_32
			tok: STRING_8
			i,n: INTEGER
			l_conn_timeout, l_timeout: INTEGER
			l_verbose: INTEGER
			l_check_connection: BOOLEAN
			v: READABLE_STRING_32
			acc: ES_ACCOUNT
		do
			set_eiffel_layout (create {EC_EIFFEL_LAYOUT})
			from
				i := 1
				n := argument_count
			until
				i > n
			loop
				if attached argument (i) as arg then
					if arg.same_string ("--token")  and i < n then
						i := i + 1
						v := argument (i)
						if v /= Void then
							tok := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (v)
							tok.left_adjust; tok.right_adjust
							if tok.is_empty then
								tok := Void
							end
						end
					elseif arg.same_string ("--username")  and i < n then
						i := i + 1
						u := argument (i)
						if u /= Void then
							u.left_adjust; u.right_adjust
							if u.is_empty then
								u := Void
							end
						end
					elseif arg.same_string ("--password")  and i < n then
						i := i + 1
						p := argument (i)
						if p /= Void then
							p.left_adjust; p.right_adjust
							if p.is_empty then
								p := Void
							end
						end
					elseif arg.same_string ("--connection_timeout")  and i < n then
						i := i + 1
						v := argument (i)
						if v /= Void and then v.is_integer  then
							l_conn_timeout := v.to_integer
						end
					elseif arg.same_string ("--timeout")  and i < n then
						i := i + 1
						v := argument (i)
						if v /= Void and then v.is_integer  then
							l_timeout := v.to_integer
						end
					elseif arg.same_string ("--check_http_clients") then
						l_check_connection := True
					elseif arg.same_string ("--verbose") or arg.same_string ("-v") then
						l_verbose := l_verbose + 1
					elseif arg.same_string ("--help") or arg.same_string ("-h") then
						print ("Usage:%N")
						print ("  --username a_username        %N")
						print ("  --password pwd               %N")
						print ("  --token access_token         %N")
						print ("  --connection_timeout nb_secs %N")
						print ("  --timeout nb_secs            %N")
						print ("  --check_http_clients        : check the http clients first%N")
						print ("  --verbose|-v                : verbose output%N")
						print ("  --help|-h                   : show this help%N")
						(create {EXCEPTIONS}).die (0)
					end
				end
				i := i + 1
			end

			if l_check_connection then
				check_http_connection
			end

			create cloud_factory
			cl := cloud_factory.new_es_cloud
			if l_conn_timeout > 0 then
				cl.set_connection_timeout (l_conn_timeout)
			end
			if l_timeout > 0 then
				cl.set_timeout (l_timeout)
			end
			if l_verbose > 0 then
				cl.set_verbose_level (l_verbose)
			end

			print ("Checking cloud service at " + cl.server_url + " ...%N")

			if cl.is_available then
				print ("- cloud service: available %N")
				if u = Void then
					from
					until
						u /= Void and then not u.is_whitespace
					loop
						io.put_string ("> Enter your username: ")
						io.read_line
						u := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (io.last_string)
						u.left_adjust; u.right_adjust
						if u.is_whitespace then
							u := Void
						end
					end
				end
				if u /= Void then
					print ("- checking account [")
					print (u)
					if tok /= Void and then not tok.is_whitespace then
						print ("] , signing with given access token [" + tok + "] %N")
						cl.sign_in_with_access_token (u, tok)
					else
						print ("] , signing with credential ... %N")
						if p = Void then
							io.put_string ("> Enter your password: ")
							io.read_line
							p := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (io.last_string)
							p.left_adjust; p.right_adjust
						end
						cl.sign_in_with_credential (u, p)
					end
				end
				acc := cl.active_account
				if cl.has_error then
					print ({STRING_32} "  ! ERROR occurred while trying to sign with username ["+ u +"]%N")
					print_error (cl)
				elseif acc /= Void then
					print ({STRING_32} "  : SUCCESS: signed in with username ["+ u +"]%N")
					tok := acc.access_token.token.to_string_8
					print ("  > - access token: ["+ tok +"]%N")
				else
					print ({STRING_32} "  ! ERROR: no account for username ["+ u +"] or wrong password !%N")
				end
				if acc /= Void then
					if attached cl.installation as l_curr_installation then
						print ("- Local installation:%N")
						print ("  id=" + l_curr_installation.id + "%N")
						if attached l_curr_installation.info as l_info then
							print ("  info=" + l_info + "%N")
						end
						if attached l_curr_installation.associated_plan as pl then
							print ("  plan=" + pl.name + "%N")
						end
						if attached l_curr_installation.associated_license as lic then
							print ("  license=")
							print_license (lic)
							print ("%N")
						end
					end

					print ("- checking licenses ... %N")
					if attached cl.account_licenses (acc) as lst then
						print ("  : SUCCESS: " + lst.count.out + " license(s):%N")
						across
							lst as lic
						loop
							print ("  |  ")
							print_license (lic)
							print ("%N")
						end
--						print ("  > SUCCESS: active license: "+ lic.key +"%N")
					else
						print ("  ! ERROR: no license found.%N")
						if cl.has_error then
							print_error (cl)
						end
					end

					print ("- checking installations ... %N")
					if attached cl.account_installations (acc) as lst then
						across
							lst as inst
						loop
							print ("  |  " + inst.id + ": ")
							print ("%N")
						end
					elseif cl.has_error then
						print_error (cl)
					end
				end
			else
				print ("- cloud service: NOT available %N")
				print_error (cl)

				check_http_connection
			end
		end

	check_http_connection
		local
			client: HTTP_CLIENT
			cl_err: CELL [BOOLEAN]
			b: BOOLEAN
			l_dft_is_libcurl: BOOLEAN
		do
			l_dft_is_libcurl := (create {DEFAULT_HTTP_CLIENT}).new_session ("http://www.eiffel.com").generating_type = {LIBCURL_HTTP_CLIENT_SESSION}
			if not l_dft_is_libcurl then
				print ("WARNING: this app may not be compiled with SSL support, so any https:// will return bad request or not available!%N")
			end
			create {DEFAULT_HTTP_CLIENT} client
			create cl_err.put (False)
			check_http_client (client, "account.eiffel.com", "/api", cl_err); b := b or cl_err.item

			if l_dft_is_libcurl then
				print ("WARNING: this app may not be compiled with SSL support, so any https:// will return bad request or not available!%N")
				create {NET_HTTP_CLIENT} client
			else
				create {LIBCURL_HTTP_CLIENT} client
			end
			cl_err.replace (False)
			check_http_client (client, "account.eiffel.com", "/api", cl_err); b := b or cl_err.item
		end

	check_http_client (client: HTTP_CLIENT; a_domain: READABLE_STRING_8; a_path: READABLE_STRING_8; cl_err: detachable CELL [BOOLEAN])
		local
			sess: HTTP_CLIENT_SESSION
			b: BOOLEAN
		do
			b := cl_err.item
			sess := client.new_session ("http://" + a_domain)
			if sess.is_available then
				check_http_url (sess, a_path, cl_err); b := b or cl_err.item
			else
				print ("- Unable to check connection to " + sess.url (a_path, Void) + " (using " + sess.generator + ") -> CLIENT NOT AVAILABLE%N")
				print ("%N")
				print ("%N")

				b := True
			end
			sess := client.new_session ("https://" + a_domain)
			if sess.is_available then
				check_http_url (sess, a_path, cl_err); b := b or cl_err.item
			else
				print ("- Unable to check connection to " + sess.url (a_path, Void) + " (using " + sess.generator + ") -> CLIENT NOT AVAILABLE%N")
				print ("%N")
				print ("%N")

				b := True
			end
			cl_err.replace (b)
		end

	check_http_url (sess: HTTP_CLIENT_SESSION; a_path: READABLE_STRING_8; cl_err: detachable CELL [BOOLEAN])
		local
			resp: HTTP_CLIENT_RESPONSE
		do
			sess.set_connect_timeout (300)
			sess.set_timeout (300)
			print ("- check connection to " + sess.url (a_path, Void) + " (using " + sess.generator + ")%N")
			resp := sess.get (a_path, Void)
			if resp.error_occurred then
				cl_err.put (True)
				print ("  ! ERROR: ")
				print (resp.error_message)
				print ("%N")
			else
				cl_err.put (False)
				print ("  | Success: ")
				print (resp.status_line)
				print ("%N")
			end
			if attached resp.body as l_body then
				print_indented_text (l_body, "  : ")
				print ("%N")
			end

			print ("%N")
			print ("%N")
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

	print_license (lic: ES_ACCOUNT_LICENSE)
		do
			print (lic.key + ": ")
			if attached lic.plan_name as pl then
				print (" plan=" + pl)
			end
			if lic.is_active then
				print (" ACTIVE")
				if attached lic.expiration_date as dt then
					print (" days_remaining=" + lic.days_remaining.out)
					print (" expiration_date=[" + (create {HTTP_DATE}.make_from_date_time (dt)).iso8601_string + "]")
				else
					print (" never-expires")
				end
			else
				print (" INACTIVE")
			end
			if lic.is_fallback then
				print (" FALLBACK")
			end
		end

	print_error (cl: ES_CLOUD_S)
		require
			cl.has_error
		do
			if attached cl.last_error_message as err then
				print ("Error message: ")
				print (err)
				print ("%N")
			end
		end

	print_indented_text (a_text: READABLE_STRING_8; a_indentation: READABLE_STRING_8)
		local
			s: STRING
		do
			create s.make_from_string (a_text)
			s.prepend (a_indentation)
			s.replace_substring_all ("%N", "%N" + a_indentation)
			print (s)
		end

invariant
--	invariant_clause: True

end
