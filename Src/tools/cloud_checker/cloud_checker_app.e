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

	SHARED_EXECUTION_ENVIRONMENT

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
			l_custom_server_url: READABLE_STRING_8
			acc: ES_ACCOUNT
			is_cloud_sign_in: BOOLEAN
			sign_in_retry_count: INTEGER
			l_tmp_location: PATH
		do
			l_tmp_location := execution_environment.temporary_directory_path.extended ("es_cloud_checker")
			execution_environment.put (l_tmp_location.name, {EIFFEL_CONSTANTS}.ise_app_data_env)
			set_eiffel_layout (create {CLOUD_CHECKER_EIFFEL_LAYOUT})
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
					elseif arg.same_string ("--sign-in") then
						is_cloud_sign_in := True
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
					elseif arg.same_string ("--server")  and i < n then
						i := i + 1
						v := argument (i)
						if v /= Void and then not v.is_whitespace and then v.is_valid_as_string_8 then
							l_custom_server_url := v.to_string_8
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
						print ("  --sign-in                    %N")
						print ("  --username a_username        %N")
						print ("  --password pwd               %N")
						print ("  --token access_token         %N")
						print ("  --connection_timeout nb_secs %N")
						print ("  --timeout nb_secs            %N")
						print ("  --server custom_url          %N")
						print ("       default:https://account.eiffel.com/api%N")
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
			if l_custom_server_url /= Void then
				cl := cloud_factory.new_es_cloud_at (l_custom_server_url)
			else
				cl := cloud_factory.new_es_cloud
			end
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
				if is_cloud_sign_in then
					if attached cl.new_cloud_sign_in_request ("CloudChecker v" + eiffel_layout.version_name) as rqst then
						print ("Sign in from your browser to continue ... %N")
						print ("Visit " + rqst.sign_in_url)
						print (" or copy the URL in a browser.%N")
						print ("Waiting for the approval ...")
						from
							sign_in_retry_count := 10 -- 10 * 6 seconds = 60 seconds
						until
							rqst.is_approved or rqst.has_error
						loop
							if not cl.is_available then
								cl.check_cloud_availability
							end
							cl.check_cloud_sign_in_request (rqst)
							if rqst.is_approved or rqst.has_error then
									-- Exit
							else
--								print ("%NCheck now if sign-in was approved")
--								io.read_line
								print (".")
								{EXECUTION_ENVIRONMENT}.sleep (5_000_000_000)
							end
						end
						if
							rqst.is_approved and cl.is_signed_in
						then
							acc := cl.active_account
							print ("%NYou are now connected as %"")
							print (acc.username)
							print ("%".%N")
						elseif rqst.has_error then
							print ("%NERROR occurred")
							if attached rqst.error_message as err then
								print (": ")
								print (err)
							end
							print ("%N")
						end
					else
						print ("%NError: could not request a new sign-in operation!%N")
					end
				elseif u = Void then
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
					if u /= Void then
						print ("- checking account [")
						print (u)
						if tok /= Void and then not tok.is_whitespace then
							print ("] , signing with given access token [" + tok + "] %N")
							cl.sign_in_with_access_token (u, tok)
						elseif is_cloud_sign_in then
							print ("] , Sign in from your browser to continue ... %N")
							if attached cl.new_cloud_sign_in_request ("CloudChecker v" + eiffel_layout.version_name) as rqst then
								print ("Visit " + rqst.sign_in_url)
								print (" or copy the URL in a browser.%N")
								print ("Waiting for the approuval  ...%N")
								from
									sign_in_retry_count := 10 -- 10 * 6 seconds = 60 seconds
								until
									cl.is_signed_in
								loop
									{EXECUTION_ENVIRONMENT}.sleep (6_000_000_000)
									cl.check_cloud_sign_in_request (rqst)
								end
							else
								print ("%N")
							end
						else
							print ("] , signing with credential ... %N")
							if p = Void then
								p := get_password_from_input ("> Enter your password: ")
								p.left_adjust; p.right_adjust
							end
							cl.sign_in_with_credential_as_client (u, p)
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
				end

				if acc /= Void then
					if attached cl.installation as l_curr_installation then
						print ("- Local installation:%N")
						print ("  id=")
						print_installation (l_curr_installation, False, "  ")
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
							print ("  |  ")
							if attached cl.account_installation (acc, inst.id) as l_installation then
								print_installation (l_installation, False, "  |    ")
							else
								print_installation (inst, True, " ")
								print ("%N")
							end
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

			safe_delete (l_tmp_location)
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

			create {CURL_HTTP_CLIENT} client
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

	get_password_from_input (s: READABLE_STRING_GENERAL): STRING_32
		local
		do
			io.put_string_32 (s)
			io.read_line
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (io.last_string)
			Result.left_adjust; Result.right_adjust
		end

feature -- Change

feature {NONE} -- Implementation

	print_installation (inst: ES_ACCOUNT_INSTALLATION; a_inline: BOOLEAN; a_sep: STRING)
		do
			print (inst.id)
			if a_inline then
				print (":")
			else
				print ("%N")
			end
			if attached inst.creation_date as l_creation_date then
				print (a_sep)
				print ("creation=" + l_creation_date.out)
				if not a_inline then
					print ("%N")
				end
			end
			if
				attached inst.info as l_info and then
				not l_info.is_whitespace and then
				not l_info.same_string ("{}")
			then
				print (a_sep)
				print ("info=" + l_info)
				if not a_inline then
					print ("%N")
				end
			end
			if attached inst.associated_plan as pl then
				print (a_sep)
				print ("plan=" + pl.name)
				if not a_inline then
					print ("%N")
				end
			end
			if attached inst.associated_license as lic then
				print (a_sep)
				print ("license=" + lic.key)
				if not lic.is_active then
					print (" INACTIVE")
				end
				if lic.is_fallback then
					print (" FALLBACK")
				end
--				print_license (lic)
				if not a_inline then
					print ("%N")
				end
			end
		end

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

	safe_delete (p: PATH)
		local
			d: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create d.make_with_path (p)
				if d.exists then
					d.recursive_delete
				end
			end
		rescue
			retried := True
			retry
		end

invariant
--	invariant_clause: True

end
