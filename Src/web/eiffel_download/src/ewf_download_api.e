note
	description: "[
		application service
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DOWNLOAD_API

inherit

	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	WSF_ROUTED_SERVICE

	WSF_URI_HELPER_FOR_ROUTED_SERVICE

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

	APPLICATION_LAUNCHER

	SHARED_EXECUTION_ENVIRONMENT

	REFACTORING_HELPER

	ARGUMENTS

	SHARED_LOGGER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("download.ini")
			setup_config
			initialize_router
		end

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
			doc: WSF_ROUTER_SELF_DOCUMENTATION_HANDLER
		do

				-- HTML uri/uri templates.
			map_uri_agent_with_request_methods ("/", agent handle_home, router.methods_get)
			map_uri_agent_with_request_methods ("", agent handle_home, router.methods_get)
			map_uri_agent_with_request_methods ("/download", agent handle_download, router.methods_post)
			map_uri_agent_with_request_methods ("/confirm_download", agent handle_confirm_download, router.methods_get)
			create doc.make (router)

			create fhdl.make_hidden_with_path (layout.www_path)
			fhdl.disable_index
			router.handle_with_request_methods ("/", fhdl, router.methods_GET)

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
			--In our database (or somewhere else), we have a few things to check:
			--email is already associated to a membership user, we simply add a new interaction stating he downloaded EiffelStudio
			--email is not already associated to a membership user, but there is a Contact entry, we do like the above and add a new interaction
			--email is not in our database, we create a Contact user and add the interaction
			--Once this is done, we associated a unique URL to the Contact and send that link to the user. In this Eiffel, we will also have links to Eiffel resources such as videos, documentation, etc (ex: How to install video, How to create your first Eiffel application ….)
		local
			l_form: DOWNLOAD_FORM
			l_token: STRING
		do
			l_form := extract_data_form (req)
			l_token := (create {SECURITY_PROVIDER}).token
			if attached database_service as l_service then
					-- The email exist (membership or contact).
				if l_service.is_membership (l_form.email) or else l_service.is_contact (l_form.email) then
					if l_form.newsletter then
						l_service.register_newsletter (l_form.email)
					end
					l_service.initialize_download (l_form.email, l_token, l_form.platform )
				else
					   -- The email does not exist in the database.
					check
						l_service.is_new_contact (l_form.email)
					end
						l_service.add_temporary_contact (l_form.first_name, l_form.last_name, l_form.email, l_form.newsletter.to_integer)
						l_service.initialize_download (l_form.email, l_token, l_form.platform )
				end
				send_email (req, l_form, l_token, req.absolute_script_url (""))
				compute_response_redirect (req, res, "https://www.eiffel.com/forms/thank_you")
			else
				if attached read_file ("500.html") as l_output then
					compute_response_500 (req, res, l_output)
				end
			end
		end


	process_workflow (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- /download?email=&token=&platform=
			--In our database (or somewhere else), we have a few things to check:
			--email is already associated to a membership user, we simply add a new interaction stating he downloaded EiffelStudio
			--email is not already associated to a membership user, but there is a Contact entry, we do like the above and add a new interaction
			--email is not in our database, we create a Contact user and add the interaction
			--Once this is done, we associated a unique URL to the Contact and send that link to the user. In this Eiffel, we will also have links to Eiffel resources such as videos, documentation, etc (ex: How to install video, How to create your first Eiffel application ….)
		do
			if attached database_service as l_service then
				if
					attached {WSF_STRING} req.query_parameter ("email") as l_email and then
					attached {WSF_STRING} req.query_parameter ("token") as l_token and then
					attached {WSF_STRING} req.query_parameter ("platform") as l_platform and then
					attached {WSF_STRING} req.query_parameter ("link") as l_link
				then
					if l_service.is_membership (l_email.value) then
						log.write_debug (generator + "process_workflow:" + l_email.value +  " Membership")
						if 	l_service.is_download_active (l_email.value, l_token.value) then
							log.write_debug (generator + "process_workflow:" + l_email.value +  " Download active")
							l_service.add_download_interaction_membership (l_email.value, "EiffelStudio", l_platform.value, "", l_token.value)
							enterprise_download_options (req, res, l_link.value)
						else
							log.write_debug (generator + "process_workflow:" + l_email.value +  " Download not active using token:" + l_token.value )
							bad_request (req, res, "")
						end
					elseif l_service.is_contact (l_email.value) then
						log.write_debug (generator + "process_workflow:" + l_email.value +  " Contact")
						if 	l_service.is_download_active (l_email.value, l_token.value) then
							log.write_debug (generator + "process_workflow:" + l_email.value +  " Download active")
							l_service.add_download_interaction_contact (l_email.value, "EiffelStudio", l_platform.value, "", l_token.value)
							enterprise_download_options (req, res, l_link.value)
						else
							log.write_debug (generator + "process_workflow:" + l_email.value +  " Download not active using token:" + l_token.value )
							bad_request (req, res, "")
						end
					else
						check
							l_service.is_new_contact (l_email.value)
						end
						log.write_debug (generator + "process_workflow:" + l_email.value +  " New Contact")
						if 	l_service.is_download_active (l_email.value, l_token.value ) then
							log.write_debug (generator + "process_workflow:" + l_email.value +  " Download active")
							l_service.validate_contact (l_email.value) --(add a new contact, remove temporary contact)
							l_service.add_download_interaction_contact (l_email.value, "EiffelStudio", l_platform.value, "", l_token.value)
							enterprise_download_options (req, res, l_link.value)
						else
							log.write_debug (generator + "process_workflow:" + l_email.value +  " Download not active using token:" + l_token.value )
							bad_request (req, res, "")
						end
					end
				else
					bad_request (req, res, "")
				end
			else
				internal_server_error (req, res, "")
			end
		end

feature -- Response

	enterprise_download_options (req: WSF_REQUEST; res: WSF_RESPONSE; a_link: STRING)
		do
			compute_download (req, res, a_link)
		end


	bad_request (req: WSF_REQUEST; res: WSF_RESPONSE; a_description: STRING)
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

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_description: STRING)
		local
			l_hp: HTML_500
		do
			if attached req.http_host as l_host then
				create l_hp.make (layout.html_template_path, req.absolute_script_url (""))
				if attached l_hp.representation as l_html_500 then
					compute_response_500 (req, res, l_html_500)
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


	compute_response_500 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; a_location: READABLE_STRING_32)
			-- Redirect to `a_location'
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_current_date
			h.put_location (a_location)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end


	compute_download  (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
			--Simple response to download content
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_disposition ("attachment; filename", output)
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_location (output)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

feature {NONE} -- Implementation

	extract_data_form (req: WSF_REQUEST): DOWNLOAD_FORM
			-- Extract request form data and build a object
			-- register view.
		do
			create Result
			if attached {WSF_STRING} req.form_parameter ("first_name") as l_first_name then
				Result.set_first_name (l_first_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("last_name") as l_last_name then
				Result.set_last_name (l_last_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("email") as l_user_email then
				Result.set_email (l_user_email.value)
			end
			if attached {WSF_STRING} req.form_parameter ("platform") as l_platform then
				Result.set_platform (l_platform.value)
			end
			if attached req.form_parameter ("newsletter") then
				Result.set_newsletter (True)
			end
		end

feature -- Services

	email_service: detachable EMAIL_SERVICE
			-- Email service.

	database_service: detachable DATABASE_SERVICE
			-- Database service.

	download_service: detachable DOWNLOAD_SERVICE
			-- Download service.

	layout: APPLICATION_LAYOUT
			--Application layout.		

feature -- Configuration

	setup_config
			-- Configure API.
		local
			l_path: PATH
			l_database: DATABASE_CONNECTION
		do
			if attached separate_character_option_value ('d') as l_dir then
				create layout.make_with_path (create {PATH}.make_from_string (l_dir))
			else
				create layout.make_default
			end

			create email_service.make ((create {JSON_CONFIGURATION}).new_smtp_configuration (layout.application_config_path))
			if attached (create {JSON_CONFIGURATION}).new_database_configuration (layout.application_config_path) as l_database_config then
				create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string)
				create database_service.make (l_database)
			end
			create download_service.make ((create {DOWNLOAD_JSON_CONFIGURATION}).new_download_configuration (layout.config_path.extended ("downloads_configuration.json")))
		end

feature -- Send Email		

	send_email (req: WSF_REQUEST; a_form: DOWNLOAD_FORM; a_token: READABLE_STRING_32; a_host: READABLE_STRING_32)
 			-- Send mail to start download with additional information.
		local
			l_hp: EMAIL_DOWNLOAD_OPTIONS
		do

			if attached email_service as l_email_service and then
				attached download_service as l_service then
					create l_hp.make (layout.html_template_path, req.absolute_script_url (""), a_form,a_token, l_service)
					if attached l_hp.representation as l_html_download_options then
						l_email_service.send_download_email (a_form.email,l_html_download_options, a_host)
					else
						l_email_service.send_download_email (a_form.email,"Internal Server Error", a_host)
					end

			end
		end


feature -- Read file

	read_file (a_file: READABLE_STRING_32): detachable READABLE_STRING_32
		local
			f: RAW_FILE
		do
			create f.make_open_read ("www/" + a_file)
			if f.exists and then f.is_readable then
				f.read_stream (f.count)
				f.close
				Result := f.last_string
			end
		end
end
