note
	description: "[
				Specific implementation of HTTP_CLIENT_REQUEST based on Eiffel cURL library

				WARNING: Do not forget to have the dynamic libraries libcurl (.dll or .so) 
				and related accessible to the executable (i.e in same directory, or in the PATH)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBCURL_HTTP_CLIENT_REQUEST

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
			apply_workaround
		end

	apply_workaround
			-- Due to issue with Eiffel cURL on Windows 32bits
			-- we need to do the following workaround
		once
			if attached (create {INET_ADDRESS_FACTORY}).create_localhost then
			end
		end

	session: LIBCURL_HTTP_CLIENT_SESSION

feature -- Execution

	response: HTTP_CLIENT_RESPONSE
			-- <Precursor>
		local
			l_result: INTEGER
			l_curl_string: detachable CURL_STRING
			l_url: READABLE_STRING_8
			l_use_curl_form: BOOLEAN
			l_form: detachable CURL_FORM
			l_last: CURL_FORM
			l_upload_file: detachable RAW_FILE
			l_custom_function: detachable LIBCURL_CUSTOM_FUNCTION
			curl: detachable CURL_EXTERNALS
			curl_easy: detachable CURL_EASY_EXTERNALS
			curl_handle: POINTER
			ctx: like context
			p_slist: POINTER
			retried: BOOLEAN
			l_upload_data: detachable READABLE_STRING_8
			l_upload_filename: detachable READABLE_STRING_GENERAL
			l_headers: like headers
			l_is_http_1_0: BOOLEAN
			l_uri: URI
		do
			if not retried then
				curl := session.curl
				curl_easy := session.curl_easy
				curl_handle := curl_easy.init
				curl.global_init

				ctx := context

				if ctx /= Void then
					l_is_http_1_0 := attached ctx.http_version as l_http_version and then l_http_version.same_string ("HTTP/1.0")
				end

				--| Configure cURL session
				initialize_curl_session (ctx, curl, curl_easy, curl_handle)

				--| URL
				l_url := url

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
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_url)
				if l_is_http_1_0 then
					curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_http_version, {CURL_OPT_CONSTANTS}.curl_http_version_1_0)
				else
					curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_http_version, {CURL_OPT_CONSTANTS}.curl_http_version_none)
				end
				l_headers := headers

				-- Context
				if ctx /= Void then
					--| Credential				
					if ctx.credentials_required then
						if attached credentials as l_credentials then
							inspect auth_type_id
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_none then
								curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpauth, {CURL_OPT_CONSTANTS}.curlauth_none)
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_basic then
								curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpauth, {CURL_OPT_CONSTANTS}.curlauth_basic)
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_digest then
								curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpauth, {CURL_OPT_CONSTANTS}.curlauth_digest)
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_any then
								curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpauth, {CURL_OPT_CONSTANTS}.curlauth_any)
							when {HTTP_CLIENT_CONSTANTS}.Auth_type_anysafe then
								curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpauth, {CURL_OPT_CONSTANTS}.curlauth_anysafe)
							else
							end

							curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_userpwd, l_credentials)
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

						curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, l_upload_data)
						curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfieldsize, l_upload_data.count)
					elseif l_upload_filename /= Void then
						check
							post_or_put_request_method:	request_method.is_case_insensitive_equal ("POST")
														or request_method.is_case_insensitive_equal ("PUT")
														or request_method.is_case_insensitive_equal ("PATCH")
						end
						check no_form_data: not ctx.has_form_data end

						create l_upload_file.make_with_name (l_upload_filename)
						if l_upload_file.exists and then l_upload_file.is_readable then
							curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_upload, 1)

							curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_infilesize, l_upload_file.count)
								-- specify callback read function for upload file
							if l_custom_function = Void then
								create l_custom_function.make
							end
							l_custom_function.set_file_to_read (l_upload_file)
							l_upload_file.open_read
							curl_easy.set_curl_function (l_custom_function)
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
							l_upload_data := ctx.form_parameters_to_x_www_form_url_encoded_string
						end
						if l_use_curl_form then
							create l_form.make
							create l_last.make
							across
								l_form_data as ic
							loop
								if attached {HTTP_CLIENT_REQUEST_STRING_PARAMETER} ic.item as strparam then
									curl.formadd_string_string (l_form, l_last,
											{CURL_FORM_CONSTANTS}.curlform_copyname, strparam.name,
											{CURL_FORM_CONSTANTS}.curlform_copycontents, strparam.value,
											{CURL_FORM_CONSTANTS}.curlform_end
										)
								elseif attached {HTTP_CLIENT_REQUEST_FILE_PARAMETER} ic.item as fileparam then
									curl.formadd_string_string (l_form, l_last,
											{CURL_FORM_CONSTANTS}.curlform_copyname, "file",
											{CURL_FORM_CONSTANTS}.curlform_file, fileparam.location.name,
											{CURL_FORM_CONSTANTS}.curlform_end
										)
								else
									check supported_parameter_type: False end
								end
							end
							l_last.release_item
							curl_easy.setopt_form (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httppost, l_form)
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
					p_slist := curl.slist_append (p_slist, curs.key + ": " + curs.item)
				end
				p_slist := curl.slist_append (p_slist, "Expect:")
				curl_easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpheader, p_slist)


				--| Execution
				curl_easy.set_read_function (curl_handle)
				curl_easy.set_write_function (curl_handle)
				if is_debug then
					curl_easy.set_debug_function (curl_handle)
					curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_verbose, 1)
				end

				--| Write options

				if ctx /= Void and then ctx.has_write_option then
					if l_custom_function = Void then
						create l_custom_function.make
					end
					if attached ctx.write_agent as l_write_agent then
						l_custom_function.set_write_procedure (l_write_agent)
					elseif attached ctx.output_content_file as l_output_content_file then
						create l_curl_string.make_empty
						l_custom_function.set_write_procedure (new_write_content_data_to_file_agent (l_output_content_file, l_curl_string))
						-- l_curl_string will contain the raw header, used to fill `Result'
					elseif attached ctx.output_file as l_output_file then
						create l_curl_string.make_empty
						l_custom_function.set_write_procedure (new_write_data_to_file_agent (l_output_file, l_curl_string))
						-- l_curl_string will contain the raw header, used to fill `Result'
					end
					curl_easy.set_curl_function (l_custom_function)
				else
					create l_curl_string.make_empty
					curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_curl_string)
				end

				create Result.make (l_url)
				l_result := curl_easy.perform (curl_handle)

				--| Result
				if l_result = {CURL_CODES}.curle_ok then
					Result.status := response_status_code (curl_easy, curl_handle)
					if l_curl_string /= Void then
						Result.set_response_message (l_curl_string.string, ctx)
						if session.is_header_received_verbose then
							io.error.put_string ("< Receiving:%N")
							io.error.put_string (Result.raw_header)
						end
					end
				else
					Result.set_error_message ("Error: cURL Error[" + l_result.out + "]")
					Result.status := response_status_code (curl_easy, curl_handle)
				end

				--| Cleaning

				curl.global_cleanup
				curl_easy.cleanup (curl_handle)
			else
				create Result.make (url)
				Result.set_error_message ("Error: internal error")
			end

			--| Remaining cleaning
			if l_form /= Void then
				l_form.dispose
			end
			if curl /= Void and then p_slist /= default_pointer then
				curl.slist_free_all (p_slist)
			end
			if l_upload_file /= Void and then not l_upload_file.is_closed then
				l_upload_file.close
			end
		rescue
			retried := True
			if curl /= Void then
				curl.global_cleanup
				curl := Void
			end
			if curl_easy /= Void and curl_handle /= default_pointer then
				curl_easy.cleanup (curl_handle)
				curl_easy := Void
			end
			retry
		end

	initialize_curl_session (ctx: like context; curl: CURL_EXTERNALS; curl_easy: CURL_EASY_EXTERNALS; curl_handle: POINTER)
		local
			l_proxy: like proxy
		do
			--| RESPONSE HEADERS
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_header, 1)

			--| PROXY ...

			if ctx /= Void then
				l_proxy := ctx.proxy
			end
			if l_proxy = Void then
				l_proxy := proxy
			end
			if l_proxy /= Void then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_proxyport, l_proxy.port)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_proxy, l_proxy.host)
			end

			--| Timeout
			if timeout > 0 then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_timeout, timeout)
			end
			--| Connect Timeout
			if connect_timeout > 0 then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_connecttimeout, timeout)
			end
			--| Redirection
			if max_redirects /= 0 then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_followlocation, 1)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_maxredirs, max_redirects)
			else
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_followlocation, 0)
			end

			--| SSL
			if is_insecure then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 0)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
			end

			--| Request method
			if request_method.is_case_insensitive_equal ("GET") then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpget, 1)
			elseif request_method.is_case_insensitive_equal ("POST") then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_post, 1)
			elseif request_method.is_case_insensitive_equal ("PUT") then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_put, 1)
			elseif request_method.is_case_insensitive_equal ("HEAD") then
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_nobody, 1)
			elseif request_method.is_case_insensitive_equal ("DELETE") then
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_customrequest, "DELETE")
			else
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_customrequest, request_method)
				--| ignored
			end
		end

feature {NONE} -- Implementation		

	response_status_code (curl_easy: CURL_EASY_EXTERNALS; curl_handle: POINTER): INTEGER
		local
			l_result: INTEGER
			a_data: CELL [detachable ANY]
		do
			create a_data.put (Void)
			l_result := curl_easy.getinfo (curl_handle, {CURL_INFO_CONSTANTS}.curlinfo_response_code, a_data)
			if l_result = 0 and then attached {INTEGER} a_data.item as l_http_status then
				Result := l_http_status
			else
				Result := 0
			end
		end

	new_write_data_to_file_agent (f: FILE; h: detachable STRING): PROCEDURE [READABLE_STRING_8]
			-- Write all downloaded header and content data into `f'
			-- and write raw header into `h' if attached.
		do
			Result := agent (s: READABLE_STRING_8; ia_header: detachable STRING; ia_file: FILE; ia_header_fetched: CELL [BOOLEAN])
							do
								ia_file.put_string (s)
								if ia_header /= Void and not ia_header_fetched.item then
									ia_header.append (s)
									if s.starts_with ("%R%N") then
										ia_header_fetched.replace (True)
									end
								end
							end (?, h, f, create {CELL [BOOLEAN]}.put (False))
		end

	new_write_content_data_to_file_agent (f: FILE; h: STRING): PROCEDURE [READABLE_STRING_8]
			-- Write all downloaded content data into `f' (without raw header)
			-- and write raw header into `h' if attached.
		do
			Result := agent (s: READABLE_STRING_8; ia_header: detachable STRING; ia_file: FILE; ia_header_fetched: CELL [BOOLEAN])
							do
								if ia_header_fetched.item then
									ia_file.put_string (s)
								else
									if ia_header /= Void then
										ia_header.append (s)
									end
									if s.starts_with ("%R%N") then
										ia_header_fetched.replace (True)
									end
								end
							end (?, h, f, create {CELL [BOOLEAN]}.put (False))
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
