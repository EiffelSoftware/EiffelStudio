note
	description: "[
				Specific implementation of HTTP_CLIENT_REQUEST based on the curl executable
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_HTTP_CLIENT_REQUEST

inherit
	HTTP_CLIENT_REQUEST
		redefine
			make,
			session
		end

create
	make

feature {NONE} -- Initialization

	make (a_url: READABLE_STRING_8; a_request_method: like request_method; a_session: like session; ctx: like context)
		do
			Precursor (a_url, a_request_method, a_session, ctx)
		end

	session: CURL_HTTP_CLIENT_SESSION

feature -- Execution

	response: HTTP_CLIENT_RESPONSE
			-- <Precursor>
		local
			l_url: READABLE_STRING_8
			l_use_curl_form: BOOLEAN
			l_form: detachable CURL_FORM
			l_last: CURL_FORM
			l_upload_file: detachable RAW_FILE
			ctx: like context
			retried: BOOLEAN
			l_upload_data: detachable READABLE_STRING_8
			l_upload_filename: detachable READABLE_STRING_GENERAL
			l_headers: like headers
			l_is_http_1_0: BOOLEAN
			l_uri: URI
			cmd: STRING_32
			cwd: PATH
			procmisc: PROCESS_MISC
		do
			if not retried then
				ctx := context

				create cmd.make_from_string (session.curl_command_name)

				if ctx /= Void then
					l_is_http_1_0 := attached ctx.http_version as l_http_version and then l_http_version.same_string ("HTTP/1.0")
				end

				--| Configure cURL session
				initialize_curl_session (ctx, cmd)

				--| Condigure cURL secure session
				if attached {HTTP_CLIENT_SECURE_CONFIG} session.secure_config as l_config then
					initialize_curl_security_session (cmd, l_config)
				end

				--| URL
				l_url := url

				cmd.append_string_general (" --url ")
				cmd.append_string_general (l_url)


				if session.is_header_sent_verbose then
					io.error.put_string ("> Sending:%N")
					create l_uri.make_from_string (l_url)
					io.error.put_string ("> ")
					io.error.put_string (request_method + " " + l_uri.path)
					if attached l_uri.query as q then
						io.error.put_string (q)
					end
					if l_is_http_1_0 then
						io.error.put_string (" HTTP/1.0")
					else
						io.error.put_string (" HTTP/1.1")
					end
					io.error.put_new_line
					if attached l_uri.host as l_host then
						io.error.put_string ("> ")
						io.error.put_string ("Host: " + l_host)
						io.error.put_new_line
					end
					across
						headers as ic
					loop
						io.error.put_string ("> ")
						io.error.put_string (ic.key)
						io.error.put_string (": ")
						io.error.put_string (ic.item)
						io.error.put_new_line
					end
					io.error.put_string ("> ... ")
					io.error.put_new_line
				end

				debug ("service")
					io.put_string ("SERVICE: " + l_url)
					io.put_new_line
				end

				if l_is_http_1_0 then
					cmd.append_string_general (" --http1.0")
				else
					check not cmd.has_substring ("--http1.0") end
				end
				l_headers := headers

				-- Context
				if ctx /= Void then
					--| Credential				
					if ctx.credentials_required then
						if attached credentials as l_credentials then
							inspect auth_type_id
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_none then
								-- None
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_basic then
								cmd.append_string_general (" --basic")
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_digest then
								cmd.append_string_general (" --digest")
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_any then
								cmd.append_string_general (" --anyauth")
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_anysafe then
								-- TODO: check ...
								cmd.append_string_general (" --anyauth")
							else
							end

							cmd.append_string_general (" --user %"")
							cmd.append_string_general (l_credentials)
							cmd.append_character ('%"')
						else
							--| Credentials not provided ...
						end
					end
					if ctx.has_upload_data then
						l_upload_data := ctx.upload_data
					end
					if ctx.has_upload_filename then
						l_upload_filename := ctx.upload_filename
					end
					if l_upload_data /= Void then
						check
							post_or_put_request_method:	request_method.is_case_insensitive_equal ("POST")
														or request_method.is_case_insensitive_equal ("PUT")
														or request_method.is_case_insensitive_equal ("PATCH")
						end
						check no_form_data: not ctx.has_form_data end

						cmd.append_string_general (" --data %"")
						cmd.append_string_general (l_upload_data)
						cmd.append_character ('%"')
					elseif l_upload_filename /= Void then
						check
							post_or_put_request_method:	request_method.is_case_insensitive_equal ("POST")
														or request_method.is_case_insensitive_equal ("PUT")
														or request_method.is_case_insensitive_equal ("PATCH")
						end
						check no_form_data: not ctx.has_form_data end

						create l_upload_file.make_with_name (l_upload_filename)
						if l_upload_file.exists and then l_upload_file.is_readable then
							cmd.append_string_general (" --upload-file %"")
							cmd.append (l_upload_filename)
							cmd.append_character ('%"')
						end
					elseif
						ctx.has_form_data and
						attached ctx.form_parameters as l_form_data
					then
						check non_empty_form_data: not l_form_data.is_empty end
						-- Send as form-urlencoded
						if
							attached l_headers.item ("Content-Type") as l_ct
						then
							if l_ct.starts_with ("application/x-www-form-urlencoded") then
								-- Content-Type is already application/x-www-form-urlencoded
								l_upload_data := ctx.form_parameters_to_x_www_form_url_encoded_string
							elseif l_ct.starts_with ("multipart/form-data") or l_form_data.has_file_parameter then
								l_use_curl_form := True
							else
									-- Not supported, use libcurl form.
								l_use_curl_form := True
							end
						else
							l_headers.force ("application/x-www-form-urlencoded", "Content-Type")
							l_upload_data := ctx.form_parameters_to_x_www_form_url_encoded_string
							cmd.append_string_general (" --form-string %"")
							cmd.append_string_general (l_upload_data)
							cmd.append_character ('%"')
						end
						if l_use_curl_form then
							create l_form.make
							create l_last.make
							across
								l_form_data as ic
							loop
								if attached {HTTP_CLIENT_REQUEST_STRING_PARAMETER} ic.item as strparam then
									cmd.append_string_general (" --form %"")
									cmd.append (strparam.name)
									cmd.append_character ('=')
									cmd.append (strparam.value)
									cmd.append_character ('%"')
								elseif attached {HTTP_CLIENT_REQUEST_FILE_PARAMETER} ic.item as fileparam then
									cmd.append_string_general (" --form-escape ")
									cmd.append ("file")
									cmd.append_string_general ("=%"")
									cmd.append (fileparam.location.name)
									cmd.append_character ('%"')
								else
									check supported_parameter_type: False end
								end
							end
						end
					else
							-- No form, or upload data to send!
						check no_data: not (ctx.has_upload_data or ctx.has_upload_filename or ctx.has_form_data) end
					end
				end -- ctx /= Void

					--| Header
				across
					l_headers as curs
				loop
					cmd.append_string_general (" --header %"")
					cmd.append_string_general (curs.key)
					cmd.append_character(':')
					cmd.append_string_general (curs.item)
					cmd.append_character ('%"')
				end

				--| Write options

				if ctx /= Void and then ctx.has_write_option then
					if attached ctx.output_content_file as l_output_content_file then
						cmd.append_string_general (" --output %"")
						cmd.append (l_output_content_file.path.name)
						cmd.append_character ('%"')
					elseif attached ctx.output_file as l_output_file then
						cmd.append_string_general (" --include") -- Include HEADER in the output
						cmd.append_string_general (" --output %"")
						cmd.append (l_output_file.path.name)
						cmd.append_character ('%"')
					end
					cmd.append (" --suppress-connect-header")
				else
					-- TODO
				end

				--| Execution
				create procmisc
				create Result.make (l_url)
				cwd := {EXECUTION_ENVIRONMENT}.current_working_path

				if attached procmisc.command_execution (cmd, Void, True) as cmd_res then
					Result.status := response_status_code (cmd_res)
--					s_out := cmd_res.output
--					s_err := cmd_res.error_output
					Result.set_response_message (cmd_res.output, ctx)
					if session.is_header_received_verbose then
						io.error.put_string ("< Receiving:%N")
						io.error.put_string (Result.raw_header)
					end
				else
					Result.set_error_message ("Error: cURL issue...")
				end

				--| Result
--				if l_result = {CURL_CODES}.curle_ok then
--					Result.status := response_status_code (curl_easy, curl_handle)
--					if l_curl_string /= Void then
--						Result.set_response_message (l_curl_string.string, ctx)
--						if session.is_header_received_verbose then
--							io.error.put_string ("< Receiving:%N")
--							io.error.put_string (Result.raw_header)
--						end
--					end
--				else
--					if attached curl.error_message (l_result) as err_msg then
--						Result.set_error_message ("Error: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (err_msg))
--					else
--						Result.set_error_message ("Error: cURL Error[" + l_result.out + "]")
--					end
--					Result.status := response_status_code (curl_easy, curl_handle)
--				end

				--| Cleaning

			else
				create Result.make (url)
				Result.set_error_message ("Error: internal error")
			end

			--| Remaining cleaning
			if l_upload_file /= Void and then not l_upload_file.is_closed then
				l_upload_file.close
			end
		rescue
			retried := True
			retry
		end

	new_temporary_file: RAW_FILE
		local
			temp: PATH
		do
			temp := {EXECUTION_ENVIRONMENT}.temporary_directory_path
			if temp = Void then
				temp := {EXECUTION_ENVIRONMENT}.current_working_path
			end
			create Result.make_open_temporary_with_prefix (temp.extended (".eifhttpclient-").name)
		end

	file_content (f: FILE): STRING
		local
			pos: INTEGER
		do
			pos := f.position
			create Result.make (f.count)
			f.start
			from

			until
				f.exhausted or f.end_of_file
			loop
				f.read_stream (1024)
				Result.append (f.last_string)
			end
			f.go (pos)
		end

	initialize_curl_session (ctx: like context; cmd: STRING_32)
		local
			l_proxy: like proxy
		do
			cmd.append_string_general (" --no-progress-meter") -- TODO: check !
			--| RESPONSE HEADERS
			cmd.append_string_general (" --include") -- TODO: check !

			--| PROXY ...
			if ctx /= Void then
				l_proxy := ctx.proxy
			end
			if l_proxy = Void then
				l_proxy := proxy
			end
			if l_proxy /= Void then
				cmd.append_string_general (" --proxy ")
				cmd.append_string_general (l_proxy.host)
				cmd.append_character (':')
				cmd.append_integer (l_proxy.port)
			end

			--| Timeout
			if timeout > 0 then
				-- FIXME: Not supported
			end
			--| Connect Timeout
			if connect_timeout > 0 then
				cmd.append (" --connect-timeout ")
				cmd.append_integer (connect_timeout)
			end
			--| Redirection
			if max_redirects /= 0 then
				cmd.append_string_general (" --location")
				cmd.append_string_general (" --max-redirs ")
				cmd.append_integer (max_redirects)
			else
				cmd.append_string_general (" --max-redirs 0") -- TODO: useless?
			end

			--| SSL
			if is_insecure then
				cmd.append_string_general (" --insecure")
				cmd.append_string_general (" --proxy-insecure") -- TODO: check this setting ...
			end

			--| Cipher List
			if attached session.ciphers_setting as c_list then
				cmd.append_string_general (" --ciphers ")
				cmd.append_string_general (c_list)
			end

			--| Request method
			if request_method.is_case_insensitive_equal ("GET") then
				-- GET is already inferred:
				-- cmd.append_string_general (" --request GET")
			else
				cmd.append_string_general (" --request ")
				if request_method.is_case_insensitive_equal ("POST") then
					cmd.append_string_general ("POST")
				elseif request_method.is_case_insensitive_equal ("PUT") then
					cmd.append_string_general ("PUT")
				elseif request_method.is_case_insensitive_equal ("HEAD") then
					cmd.append_string_general ("HEAD")
				elseif request_method.is_case_insensitive_equal ("DELETE") then
					cmd.append_string_general ("DELETE")
				else
					cmd.append_string_general (request_method)
				end
			end
		end


	initialize_curl_security_session (cmd: STRING_32; a_config: HTTP_CLIENT_SECURE_CONFIG)
		do
			--| TLS version.
			if a_config.is_valid_tls_verion (a_config.tls_version) then
				if a_config.is_tls_1_2 then
						-- ask libcurl to use TLS version 1.2 or later */
					cmd.append_string_general (" --tlsv1.2")
				end
				if a_config.is_tls_1_3 then
						-- ask libcurl to use TLS version 1.3 or later */
					cmd.append_string_general (" --tlsv1.3")
				end
			end

			--| Cert Type
			if attached a_config.certificate_type as cert_type then
					-- Format P12, PEM
				cmd.append_string_general (" --cert-type ")
				cmd.append_string_general (cert_type)
			end

			--| set the passphrase (if the key has one...)
			if attached a_config.passphrase as passphrase then
				cmd.append_string_general (" --pass %"")
				cmd.append (passphrase)
				cmd.append_character ('%"')
			end

			--| set the cert for client authentication
			if attached a_config.client_certificate as client_certificate then
				cmd.append (" --cert %"")
				cmd.append (client_certificate)
				cmd.append_character ('%"')
			end

			--| set the file with the certs vaildating the server
			if attached a_config.certificate_authority as certificate_authority then
				cmd.append (" --cacert %"")
				cmd.append (certificate_authority)
				cmd.append_character ('%"')
			end

			--| Verify the peer's SSL certificate
			if a_config.verify_peer then
				-- if the verification fails to prove that the certificate is authentic, the connection fails.
				cmd.append_string_general (" --cert-status")
			end

			--| Verify the certificate's name against host
			if a_config.verify_host then
				-- checking the server's certificate's claimed identity.
				-- TODO
			end

		end

feature {NONE} -- Implementation		

	response_status_code (cmd_res: PROCESS_COMMAND_RESULT): INTEGER
		local
			s: STRING
			i,j: INTEGER
		do
			if cmd_res.exit_code = 0 then
				s := cmd_res.output
				i := s.index_of ('%N', 1)
				if i > 0 then
					s := s.head (i - 1)
					i := s.index_of (' ', 1)
					if i > 0 then
						j := s.index_of (' ', i + 1)
						if j = 0 then
							j := s.count + 1
						end
						s := s.substring (i + 1, j - 1)
						Result := s.to_integer
					end
				end
			else
				-- TODO
			end
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
