note
	description: "Summary description for {EWF_DOWNLOAD_API_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DOWNLOAD_API_EXECUTION

inherit
	WSF_ROUTED_SKELETON_EXECUTION
		rename
			make as make_execution
		undefine
			requires_proxy
		end

	WSF_NO_PROXY_POLICY

	WSF_URI_HELPER_FOR_ROUTED_EXECUTION

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_EXECUTION

	SHARED_EXECUTION_ENVIRONMENT

	REFACTORING_HELPER

	ARGUMENTS

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make (a_config: EWF_DOWNLOAD_CONFIGURATION; a_server: EWF_DOWNLOAD_SERVICE_EXECUTION)
		do
			config := a_config
			server := a_server
			layout := config.layout
			data_service := config.data_service
			email_service := config.email_service
			enterprise_download_service := config.enterprise_download_service
			standard_download_service := config.standard_download_service
			make_from_execution  (a_server)
		end

	config: EWF_DOWNLOAD_CONFIGURATION

	server: EWF_DOWNLOAD_SERVICE_EXECUTION

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do

				-- HTML uri/uri templates.
			map_uri_agent ("/", agent handle_home, router.methods_get)
			map_uri_agent ("", agent handle_home, router.methods_get)
			map_uri_agent ("/download", agent handle_download, router.methods_post)
			map_uri_agent ("/confirm_download", agent handle_confirm_download, router.methods_get)

			create fhdl.make_hidden_with_path (layout.www_path)
			fhdl.disable_index
			fhdl.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
			router.handle ("/", fhdl, router.methods_GET)

		end

feature -- Handle HTML pages


	handle_download (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			start_workflow (req, res)
		end

	handle_confirm_download (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			process_workflow (req, res)
		end

	handle_home (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_hp: HTML_HOME
		do
			if attached req.http_host as l_host then
				create l_hp.make (layout.html_template_path, req.absolute_script_url (""))
				if attached l_hp.representation as l_home_page then
					compute_response_get (req, res, l_home_page)
				end
			end
		end

feature -- Workflow

	start_workflow (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- /download
			-- In our database (or somewhere else), we have a few things to check:
			-- email is already associated to a membership user, we simply add a new interaction stating he downloaded EiffelStudio
			-- email is not already associated to a membership user, but there is a Contact entry, we do like the above and add a new interaction
			-- email is not in our database, we create a Contact user and add the interaction
			-- Once this is done, we associated a unique URL to the Contact and send that link to the user.
			-- In this Eiffel, we will also have links to Eiffel resources such as videos, documentation, etc (ex: How to install video, How to create your first Eiffel application ….)
		local
			l_form: DOWNLOAD_FORM
			l_token: STRING
			l_security: SECURITY_PROVIDER
			l_encode: URL_ENCODER
			l_wsf_debug: WSF_DEBUG_INFORMATION
			l_message: STRING
		do
			l_form := extract_data_form (req)
			create l_security
			l_token := l_security.token
			create l_encode
			from until l_token.same_string (l_encode.encoded_string (l_token)) loop
				-- Loop ensure that we have a security token that does not contain characters that need encoding.
			    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
				-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end

			if
				attached data_service as l_service
			then
				if l_service.is_available then
						-- The email exist (membership or contact).
					if l_service.is_membership (l_form.email) or else l_service.is_contact (l_form.email) then
						if l_form.newsletter then
							l_service.register_newsletter (l_form.email)
						end
						l_service.initialize_download (l_token, l_form)
					else
						   -- The email does not exist in the database.
						check
							l_service.is_new_contact (l_form.email)
						end
						l_service.add_temporary_contact (l_form.first_name, l_form.last_name, l_form.email, l_form.newsletter.to_integer)
						l_service.initialize_download (l_token, l_form)
					end
							-- If the title is Student or Porfessor, they will not receive an email.
					if l_form.title.same_string ("student") or else l_form.title.same_string ("professor") then
						-- FIXME:JFIAT
							-- Download standard version.
						process_standard_download (req, res, l_form, l_token)
					elseif
						attached l_form.product as l_prod and then
						(
							l_prod.is_case_insensitive_equal_general ("eiffelstudio_standard")
							or l_prod.is_case_insensitive_equal_general ("standard")
						)
					then
						process_standard_download (req, res, l_form, l_token)
					else
						send_enterprise_download_email (req, l_form, l_token, req.absolute_script_url (""))
						if
							attached email_service as l_email_service and then
							attached l_email_service.last_error as l_error
						then
							create l_message.make_from_string ("Database service unavailable%N%N")
							create l_wsf_debug.make
							l_wsf_debug.append_information_to (req, res, l_message)
							send_mail_internal_server_error (l_message)
							internal_server_error (req, res, {HTTP_STATUS_CODE}.service_unavailable)
						else
							compute_response_redirect (req, res, "https://www.eiffel.com/forms/thank_you")
						end
					end
				else
					create l_message.make_from_string ("Database service unavailable%N%N")
					create l_wsf_debug.make
					l_wsf_debug.append_information_to (req, res, l_message)
					send_mail_internal_server_error (l_message)
					internal_server_error (req, res, {HTTP_STATUS_CODE}.service_unavailable)
				end
			else
				create l_message.make_from_string ("Unknown error%N%N")
				create l_wsf_debug.make
				l_wsf_debug.append_information_to (req, res, l_message)
				send_mail_internal_server_error (l_message)
				internal_server_error (req, res, {HTTP_STATUS_CODE}.internal_server_error)
			end
		end

	process_workflow (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- /download?email=&token=&platform=
			--In our database (or somewhere else), we have a few things to check:
			--email is already associated to a membership user, we simply add a new interaction stating he downloaded EiffelStudio
			--email is not already associated to a membership user, but there is a Contact entry, we do like the above and add a new interaction
			--email is not in our database, we create a Contact user and add the interaction
			--Once this is done, we associated a unique URL to the Contact and send that link to the user. In this Eiffel, we will also have links to Eiffel resources such as videos, documentation, etc (ex: How to install video, How to create your first Eiffel application ….)
		local
			l_error_message: STRING
			l_wsf_debug: WSF_DEBUG_INFORMATION
			l_safe_redir_confirm_page: BOOLEAN
			p_token: WSF_STRING
		do
			if
				attached data_service as l_service and then
				l_service.is_available
			then
				if attached {WSF_STRING} req.query_parameter ("token") as p then
					p_token := p
				end
				if
					p_token /= Void and then
					attached {DOWNLOAD_INFORMATION} l_service.retrieve_download_details (p_token.value) as l_info and then
					attached l_info.email  as email and then
					attached l_info.platform as platform and then
					attached enterprise_downloaded_file (platform) as l_dl_file
				then
					l_safe_redir_confirm_page := attached {WSF_STRING} req.query_parameter ("safe")
					l_info.set_platform (platform)
					l_info.set_product ("EiffelStudio enterprise")
					l_info.set_filename (l_dl_file)
					l_info.set_download_date (create {DATE_TIME}.make_now_utc)
					if l_service.is_membership (email) then
						log.write_debug (generator + ".process_workflow:" + email +  " Membership")
						if l_service.is_download_active (p_token.value) then
							log.write_debug (generator + ".process_workflow:" + email +  " Download active")
							l_service.add_download_interaction_membership (email, "EiffelStudio", platform, l_dl_file, p_token.value)
							enterprise_download_options (req, res, enterprise_direct_download_link (platform), l_safe_redir_confirm_page)
							send_email_download_notification (l_info)
						else
							log.write_debug (generator + ".process_workflow:" + email  +  " Download not active using token:" + p_token.url_encoded_value)
							generate_new_token (req, res, l_info)
						end
					elseif l_service.is_contact (email) then
						log.write_debug (generator + ".process_workflow:" + email +  " Contact")
						if l_service.is_download_active (p_token.value) then
							log.write_debug (generator + ".process_workflow:" + email +  " Download active")
							l_service.add_download_interaction_contact (email, "EiffelStudio", platform, l_dl_file, p_token.value)
							enterprise_download_options (req, res, enterprise_direct_download_link (platform), l_safe_redir_confirm_page)
							send_email_download_notification (l_info)
						else
							log.write_debug (generator + ".process_workflow:" + email  +  " Download not active using token:" + p_token.url_encoded_value )
							generate_new_token (req, res, l_info)
						end
					else
						check
							l_service.is_new_contact (email)
						end
						log.write_debug (generator + ".process_workflow:" + email +  " New Contact")
						if l_service.is_download_active (p_token.value) then
							log.write_debug (generator + ".process_workflow:" + email +  " Download active")
							l_service.validate_contact (email) --(add a new contact, remove temporary contact)
							l_service.add_download_interaction_contact (email, "EiffelStudio", platform, l_dl_file, p_token.value)
							enterprise_download_options (req, res, enterprise_direct_download_link (platform), l_safe_redir_confirm_page)
							send_email_download_notification (l_info)
						else
						  	log.write_debug (generator + ".process_workflow:" + email  +  " Download not active using token:" + p_token.url_encoded_value )
							generate_new_token (req, res, l_info)
						end
					end
				elseif l_service.is_available then
					create l_error_message.make_from_string ("process_workflow: The request was invalid " + req.request_uri )
					if p_token /= Void then
						l_error_message.append ("%N The given token: "  + p_token.url_encoded_value +  " does not exist or is not available anymore.%N")
					else
						l_error_message.append ("%N Missing token.%N")
					end
						-- debug information
					create l_wsf_debug.make
					l_wsf_debug.append_information_to (req, res, l_error_message)
					log.write_debug (generator + "." + l_error_message)
					send_mail_bad_request (generator + "." + l_error_message)
					bad_request (req, res, "")
				else
					create l_error_message.make_from_string ("The database service is unavailable%N")
					create l_wsf_debug.make
					l_wsf_debug.append_information_to (req, res, l_error_message)
					log.write_debug (generator + ".process_workflow " + l_error_message)
					send_mail_internal_server_error (l_error_message)
					internal_server_error (req, res, {HTTP_STATUS_CODE}.service_unavailable)
				end
			else
				create l_error_message.make_from_string ("The database service is unavailable%N")
				create l_wsf_debug.make
				l_wsf_debug.append_information_to (req, res, l_error_message)
				log.write_debug (generator + ".process_workflow " + l_error_message)
				send_mail_internal_server_error (l_error_message)
				internal_server_error (req, res, {HTTP_STATUS_CODE}.internal_server_error)
			end
		end


feature {NONE} -- Implementation

	generate_new_token (req: WSF_REQUEST; res: WSF_RESPONSE; a_info: DOWNLOAD_INFORMATION)
			-- Generate a new token and send an email.
		local
			l_form: DOWNLOAD_FORM
			l_token: STRING
			l_security: SECURITY_PROVIDER
			l_encode: URL_ENCODER
			l_error_message: STRING
			l_wsf_debug: WSF_DEBUG_INFORMATION
		do
			if
				attached data_service as l_service and then
				l_service.is_available  and then
				attached a_info.first_name as l_fn and then
				attached a_info.last_name as l_ln and then
				attached a_info.email as l_email and then
				attached a_info.platform as l_platform
			then

				create l_security
				l_token := l_security.token
				create l_encode
				from until l_token.same_string (l_encode.encoded_string (l_token)) loop
					-- Loop ensure that we have a security token that does not contain characters that need encoding.
				    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
					-- but the user will need to use an unencoded token if activation has to be done manually.
					l_token := l_security.token
				end

				log.write_debug (generator + ".generate_new_token:" + l_email +  " using token:" + l_token )

					-- Fill form
				create l_form
				l_form.set_product (a_info.product)
				l_form.set_first_name (l_fn)
				l_form.set_last_name (l_ln)
				l_form.set_email (l_email)
				l_form.set_platform (l_platform)

				l_service.initialize_download (l_token, l_form)
				send_enterprise_download_email (req, l_form, l_token, req.absolute_script_url (""))
				not_active_request (req, res, "")
			else
				log.write_debug (generator + ".generate_new_token The database service is unavailable")
				create l_error_message.make_from_string ("The database service is unavailable%N")
				create l_wsf_debug.make
				l_wsf_debug.append_information_to (req, res, l_error_message)
				send_mail_internal_server_error (l_error_message)
				internal_server_error (req, res, {HTTP_STATUS_CODE}.service_unavailable)
			end
		end

	process_standard_download (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: DOWNLOAD_FORM; a_token: READABLE_STRING_32)
			-- Process standard download.
		local
			l_link: STRING
			l_error_message: STRING
			l_wsf_debug: WSF_DEBUG_INFORMATION
		do
			if attached data_service as l_service then
				log.write_debug (generator + ".process_standard_download Start process standard download.")
				if
					attached standard_download_service as l_download_service and then
					attached l_download_service.mirror as l_mirror and then
					attached l_download_service.first_product as l_product and then
					attached {DOWNLOAD_PRODUCT_OPTIONS} selected_platform (l_product.downloads, a_form.platform) as l_options and then
					attached l_options.filename  as l_filename
				then
					if l_service.is_membership (a_form.email) then
						log.write_debug (generator + ".process_standard_download process " + a_form.email +  " Membership")
						l_service.add_download_interaction_membership (a_form.email, "EiffelStudio", a_form.platform, l_filename, a_token)
					elseif l_service.is_contact (a_form.email) then
						log.write_debug (generator + ".process_standard_download process " + a_form.email +  " Contact")
						l_service.add_download_interaction_contact (a_form.email, "EiffelStudio", a_form.platform, l_filename, a_token)
					else
						check
							l_service.is_new_contact (a_form.email)
						end
						log.write_debug (generator + ".process_standard_download process " + a_form.email +  " New Contact")
						l_service.validate_contact (a_form.email) --(add a new contact, remove temporary contact)
						l_service.add_download_interaction_contact (a_form.email, "EiffelStudio", a_form.platform, l_filename, a_token)
					end

					if attached {DOWNLOAD_INFORMATION} l_service.retrieve_download_details (a_token) as l_info then
						l_info.set_platform (a_form.platform)
						l_info.set_product ("EiffelStudio")
						l_info.set_filename (l_filename)
						l_info.set_download_date (create {DATE_TIME}.make_now_utc)
						send_email_standard_download_notification (l_info)
					end
						-- Build Link
					create l_link.make_from_string (l_mirror)
					l_link.append (l_filename.to_string_8) -- FIXME !!! it is ok as we control the file name, and they are full ascii, but it should be fixed.
					--compute_response_redirect (req, res, l_link)
					direct_download (req, res, l_link, l_filename, l_options.size)
				else
					log.write_debug (generator + ".process_standard_download ")
					create l_error_message.make_from_string ("Error processing: Standard download use case.%N")
					create l_wsf_debug.make
					l_wsf_debug.append_information_to (req, res, l_error_message)
					send_mail_internal_server_error (l_error_message)
					internal_server_error (req, res, {HTTP_STATUS_CODE}.service_unavailable)
				end
			else
				log.write_debug (generator + ".process_standard_download: The database service is unavailable")
				create l_error_message.make_from_string ("Database service unavailable.%N")
				create l_wsf_debug.make
				l_wsf_debug.append_information_to (req, res, l_error_message)
				send_mail_internal_server_error (l_error_message)
				internal_server_error (req, res, {HTTP_STATUS_CODE}.internal_server_error)
			end
		end

feature -- Response

	enterprise_download_options (req: WSF_REQUEST; res: WSF_RESPONSE; a_link: READABLE_STRING_8; a_is_safe_redir_confirmation_page: BOOLEAN)
		do
			compute_download (req, res, a_link, a_is_safe_redir_confirmation_page)
		end

	bad_request (req: WSF_REQUEST; res: WSF_RESPONSE; a_description: STRING)
			-- Send a bad request response with description `a_description'.
		local
			l_hp: HTML_400
		do
			if attached req.http_host as l_host then
				create l_hp.make (layout.html_template_path, req.absolute_script_url (""))
				if attached l_hp.representation as l_html_400 then
					compute_response_400 (req, res, l_html_400)
				end
			end
		end

	not_active_request (req: WSF_REQUEST; res: WSF_RESPONSE; a_description: STRING)
			-- Send a not active request response with description `a_description'.
		local
			l_hp: HTML_NOT_ACTIVE
		do
			if attached req.http_host as l_host then
				create l_hp.make (layout.html_template_path, req.absolute_script_url (""))
				if attached l_hp.representation as l_html_400 then
					compute_response_400 (req, res, l_html_400)
				end
			end
		end

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_status: INTEGER)
			-- Send a internal server error response with status `a_status'
		local
			l_hp: HTML_500
		do
			if attached req.http_host as l_host then
				create l_hp.make (layout.html_template_path, req.absolute_script_url (""), a_status)
				if attached l_hp.representation as l_html_500 then
					compute_response_500 (req, res, l_html_500, a_status)
				end
			end
		end

	compute_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	compute_response_400 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.bad_gateway)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end


	compute_response_500 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING; a_status:INTEGER)
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code (a_status)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; a_location: READABLE_STRING_32)
			-- Redirect to `a_location'
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_current_date
			h.put_location (a_location.to_string_8)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

	compute_download  (req: WSF_REQUEST; res: WSF_RESPONSE; a_link: READABLE_STRING_8; a_is_safe_redir_confirmation_page: BOOLEAN)
			-- Simple response to download content
		local
			h: HTTP_HEADER
			msg: HTML_RESPONSE_MESSAGE

			i,j,k: INTEGER
			u,p: READABLE_STRING_8
			lnk: READABLE_STRING_8
			b: detachable STRING_8
			l_html: HTML_SAFE_REDIRECTION
			l_safe_url: STRING
		do
			if config.is_using_safe_redirection then
				i := a_link.substring_index ("://", 1)
				if i > 0 then
					i := i + 3
					j := a_link.index_of ('@', i)
					if j > 0 then
						k := a_link.index_of (':', i)
						if k > 0 then
							u := a_link.substring (i, k - 1)
							p := a_link.substring (k + 1, j - 1)
							lnk := a_link.substring (1, i - 1) + a_link.substring (j + 1, a_link.count)

							if a_is_safe_redir_confirmation_page then
								create l_html.make_safe (layout.html_template_path, a_link, u, p, lnk)
							else
								l_safe_url := req.absolute_script_url (req.percent_encoded_path_info)
								if attached req.query_string as l_qs and then not l_qs.is_empty then
									l_safe_url := l_safe_url + "?" + l_qs + "&safe=true"
								else
									l_safe_url := l_safe_url + "?safe=true"
								end
								create l_html.make (layout.html_template_path, l_safe_url, a_link, u, p, lnk)
							end

							b := l_html.to_html
						end
					end
				end
			end
			if b /= Void then
				create msg.make (b)
--				msg.header.put_location (a_url)
--				msg.set_status_code ({HTTP_STATUS_CODE}.temp_redirect)
				res.send (msg)
			else
				res.redirect_now (a_link)
				create h.make
				h.put_current_date
				h.put_location (a_link)
				res.set_status_code ({HTTP_STATUS_CODE}.see_other)
				res.put_header_text (h.string)
			end
		end

	direct_download (req: WSF_REQUEST; res: WSF_RESPONSE; a_url: READABLE_STRING_8; filename: READABLE_STRING_32; size: INTEGER_64)
			--Simple response to download content
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_cache_control ("no-store, no-cache")
			h.put_location (a_url)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

feature {NONE} -- Implementation

	extract_data_form (req: WSF_REQUEST): DOWNLOAD_FORM
			-- Extract request form data and build a object
			-- register view.
		do
			create Result
			if attached {WSF_STRING} req.form_parameter ("product") as l_product then
				Result.set_product ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_product.value))
			end
			if attached {WSF_STRING} req.form_parameter ("first_name") as l_first_name then
				Result.set_first_name (l_first_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("last_name") as l_last_name then
				Result.set_last_name (l_last_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("email") as l_user_email then
				Result.set_email ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_user_email.value))
			end
			if attached {WSF_STRING} req.form_parameter ("company") as l_user_company then
				Result.set_company (l_user_company.value)
			end
			if attached {WSF_STRING} req.form_parameter ("title") as l_user_title then
				Result.set_title (l_user_title.value)
			end
			if attached {WSF_STRING} req.form_parameter ("platform") as l_platform then
				Result.set_platform ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_platform.value))
			end
			if attached req.form_parameter ("newsletter") then
				Result.set_newsletter (True)
			end
		end

feature -- Services

	email_service: detachable EMAIL_SERVICE
			-- Email service.

	data_service: detachable DATA_SERVICE
			-- Database service.

	enterprise_download_service: detachable DOWNLOAD_SERVICE
			-- Download service.

	standard_download_service: detachable DOWNLOAD_SERVICE
			-- Download service.

	layout: APPLICATION_LAYOUT
			--Application layout.		


feature -- Send Email		

	send_enterprise_download_email (req: WSF_REQUEST; a_form: DOWNLOAD_FORM; a_token: READABLE_STRING_32; a_host: READABLE_STRING_8)
 			-- Send mail to start download with additional information.
		local
			l_hp: EMAIL_DOWNLOAD_OPTIONS
			l_html: EMAIL_HTML_RESOURCE
			e: EXECUTION_ENVIRONMENT
		do
			if
				attached email_service as l_email_service and then
				attached enterprise_download_service as l_ent_download_service
			then
				create l_hp.make (layout.html_template_path, req.absolute_script_url (""), a_form,a_token, l_ent_download_service)
				if attached l_hp.representation as l_html_download_options then
					if
						attached l_ent_download_service.first_product as l_product and then
						attached l_product.number as l_number
					then
						l_email_service.send_download_email (a_form.email, l_html_download_options, a_host, l_number.out)
					else
						l_email_service.send_download_email (a_form.email, l_html_download_options, a_host, "")
					end

						-- Wait 5 seconds before to send the video resource emails
					create e
					e.sleep (1_000_000_000 * 5)
					create l_html.make (layout.html_template_path)
					if attached l_html.representation as l_html_resource then
						l_email_service.send_email_resources (a_form.email.to_string_8, l_html_resource)
					else
						l_email_service.send_email_internal_server_error ("Internal server error sending video resource email")
					end

				else
					l_email_service.send_download_email (a_form.email, "Internal Server Error", a_host, "")
				end
			end
		end

	send_email_download_notification (a_download_information: DOWNLOAD_INFORMATION)
		local
			l_hp: EMAIL_NOTIFICATION_DOWNLOAD
		do
			if
				attached email_service as l_email_service
			then
				create l_hp.make (layout.html_template_path, a_download_information)
				if attached l_hp.representation as l_html_download_info then
					l_email_service.send_email_download_notification (l_html_download_info)
				else
					l_email_service.send_email_download_notification ("Internal Server Error")
				end
			end
		end

	send_email_standard_download_notification (a_download_information: DOWNLOAD_INFORMATION)
		local
			l_hp: EMAIL_NOTIFICATION_DOWNLOAD
		do
			if attached email_service as l_email_service then
				create l_hp.make (layout.html_template_path, a_download_information)
				if attached l_hp.representation as l_html_download_info then
					l_email_service.send_email_download_notification (l_html_download_info)
				else
					l_email_service.send_email_download_notification ("Internal Server Error")
				end
			end
		end

	send_mail_internal_server_error (a_description: READABLE_STRING_8)
			-- Send mail regarding to an internal server error
		do
			if attached email_service as l_email_service then
				l_email_service.send_email_internal_server_error (a_description)
			end
		end

	send_mail_bad_request (a_description: READABLE_STRING_8)
			-- Send mail regarding to a bad request.
		do
			if attached email_service as l_email_service then
				l_email_service.send_email_bad_request_error (a_description)
			end
		end

feature {NONE} -- Implementation

	enterprise_direct_download_link (a_platform: READABLE_STRING_8): READABLE_STRING_8
		 	-- link={$mirror/}{$directory/}/{$selected_platform.filename/}		
		local
			l_result: STRING_32
			uri: URI
		do
			create l_result.make_empty
			if
				attached enterprise_download_service as l_ent_download_service and then
				attached l_ent_download_service.mirror as l_mirror
			then
				create uri.make_from_string (l_mirror)
				if
					attached l_ent_download_service.first_product as l_product and then
					attached l_product.sub_directory as l_directory
				then
					uri.add_unencoded_path_segment (l_directory)
					if
						attached selected_platform (l_product.downloads, a_platform) as l_options and then
						attached l_options.filename as l_filename
					then
						uri.add_unencoded_path_segment (l_filename)
					end
				end
				Result := uri.string
			else
				Result := ""
			end
		end

	enterprise_downloaded_file (a_platform: READABLE_STRING_8): detachable READABLE_STRING_32
			-- Name of the downloaded file, or empty string.
		do
			if
				attached enterprise_download_service as l_ent_download_service and then
				attached l_ent_download_service.first_product as l_product
			then
				if
					attached selected_platform (l_product.downloads, a_platform) as l_options  and then
					attached l_options.filename as l_filename
				then
					Result := l_filename
				end
			end
		end

	selected_platform (a_downloads: detachable LIST [DOWNLOAD_PRODUCT_OPTIONS]; a_platform: READABLE_STRING_8): detachable DOWNLOAD_PRODUCT_OPTIONS
			-- Search information related to the selected platform by the user.
		do
			if
				attached a_downloads
			then
				from
					a_downloads.start
				until
					a_downloads.after or Result /= Void
				loop
					if attached a_downloads.item.platform as pf and then a_platform.same_string (pf) then
						Result := a_downloads.item
					end
					a_downloads.forth
				end
			end
		end
end
