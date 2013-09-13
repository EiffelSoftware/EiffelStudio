note
	description: "[
				Specific implementation of HTTP_CLIENT_REQUEST based on Eiffel cURL library
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBCURL_HTTP_CLIENT_REQUEST

inherit
	HTTP_CLIENT_REQUEST
		rename
			make as make_request
		redefine
			session
		end

create
	make

feature {NONE} -- Initialization

	make (a_url: READABLE_STRING_8; a_request_method: like request_method; a_session: like session; ctx: like context)
		do
			make_request (a_url, a_session, ctx)
			request_method := a_request_method
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

feature -- Access

	request_method: READABLE_STRING_8

feature -- Execution

	execute: HTTP_CLIENT_RESPONSE
		local
			l_result: INTEGER
			l_curl_string: detachable CURL_STRING
			l_url: READABLE_STRING_8
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
			l_form_data: detachable HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			l_upload_data: detachable READABLE_STRING_8
			l_upload_filename: detachable READABLE_STRING_GENERAL
			l_headers: like headers
		do
			if not retried then
				curl := session.curl
				curl_easy := session.curl_easy
				curl_handle := curl_easy.init
				curl.global_init

				ctx := context

				--| Configure cURL session
				initialize_curl_session (ctx, curl, curl_easy, curl_handle)

				--| URL
				l_url := url
				if ctx /= Void then
					append_parameters_to_url (ctx.query_parameters, l_url)
				end

				debug ("service")
					io.put_string ("SERVICE: " + l_url)
					io.put_new_line
				end
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_url)

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
					if ctx.has_form_data then
						l_form_data := ctx.form_parameters
						check non_empty_form_data: not l_form_data.is_empty end
						if l_upload_data = Void and l_upload_filename = Void then
							-- Send as form-urlencoded
							if
								l_headers.has_key ("Content-Type") and then
								attached l_headers.found_item as l_ct
							then
								if l_ct.starts_with ("application/x-www-form-urlencoded") then
									-- Content-Type is already application/x-www-form-urlencoded
									l_upload_data := ctx.form_parameters_to_url_encoded_string
								else
									-- Existing Content-Type and not application/x-www-form-urlencoded
								end
							else
								l_upload_data := ctx.form_parameters_to_url_encoded_string
							end
						else
							create l_form.make
							create l_last.make
							from
								l_form_data.start
							until
								l_form_data.after
							loop
								curl.formadd_string_string (l_form, l_last,
										{CURL_FORM_CONSTANTS}.curlform_copyname, l_form_data.key_for_iteration,
										{CURL_FORM_CONSTANTS}.curlform_copycontents, l_form_data.item_for_iteration,
										{CURL_FORM_CONSTANTS}.curlform_end
									)
								l_form_data.forth
							end
							l_last.release_item
							curl_easy.setopt_form (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httppost, l_form)
						end
					end

					if l_upload_data /= Void then
						check
							post_or_put_request_method:	request_method.is_case_insensitive_equal ("POST")
														or request_method.is_case_insensitive_equal ("PUT")
														or request_method.is_case_insensitive_equal ("PATCH")
						end

						curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, l_upload_data)
						curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfieldsize, l_upload_data.count)
					elseif l_upload_filename /= Void then
						check
							post_or_put_request_method:	request_method.is_case_insensitive_equal ("POST")
														or request_method.is_case_insensitive_equal ("PUT")
														or request_method.is_case_insensitive_equal ("PATCH")
						end

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
					else
						check no_upload_data: l_upload_data = Void and l_upload_filename = Void end
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

	new_write_data_to_file_agent (f: FILE; h: detachable STRING): PROCEDURE [ANY, TUPLE [READABLE_STRING_8]]
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

	new_write_content_data_to_file_agent (f: FILE; h: STRING): PROCEDURE [ANY, TUPLE [READABLE_STRING_8]]
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
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
