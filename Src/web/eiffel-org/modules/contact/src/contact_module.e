note
	description: "[
			Module that provide contact us web form functionality.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_MODULE

inherit

	CMS_MODULE
		rename
			module_api as contact_api
		redefine
			setup_hooks,
			is_installed,
			install,
			initialize,
			contact_api
		end

	SHARED_HTML_ENCODER

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Contact form module"
			package := "messaging"
		end


feature -- Access

	name: STRING = "contact"
			-- <Precursor>

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_contact_api: like contact_api
			ut: FILE_UTILITIES
			p: PATH
			contact_storage: CONTACT_STORAGE_I
		do
			Precursor (api)
			p := file_system_storage_path (api)
			if ut.directory_path_exists (p) then
				create {CONTACT_STORAGE_FS} contact_storage.make (p, api)
--			elseif attached {CMS_STORAGE_SQL_I} storage as l_storage_sql then
--				create {CONTACT_STORAGE_SQL} contact_storage.make (l_storage_sql)
			else
				create {CONTACT_STORAGE_NULL} contact_storage.make
			end

			create l_contact_api.make (api, contact_storage)
			contact_api := l_contact_api
		end

feature {CMS_API} -- Module management

	is_installed (api: CMS_API): BOOLEAN
			-- Is Current module installed?
		local
			ut: FILE_UTILITIES
		do
			Result := ut.directory_path_exists (file_system_storage_path (api))
		end

	install (api: CMS_API)
		local
			retried: BOOLEAN
			d: DIRECTORY
		do
			if not retried then
				create d.make_with_path (file_system_storage_path (api))
				d.recursive_create_dir
			end
		rescue
			retried := True
			retry
		end

	file_system_storage_path (api: CMS_API): PATH
			-- Location of eventual file system based storage for contact messages.
		do
			Result := api.site_location.extended ("db").extended ("contact_messages")
		end

feature {CMS_API} -- Access: API

	contact_api: detachable CONTACT_API

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
			a_router.handle ("/contact", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contact (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/contact", create {WSF_URI_AGENT_HANDLER}.make (agent handle_post_contact (a_api, ?, ?)), a_router.methods_put_post)
		end

feature -- Recaptcha

	recaptcha_secret_key (api: CMS_API): detachable READABLE_STRING_8
			-- Get recaptcha security key.
		local
			utf: UTF_CONVERTER
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if
					attached cfg.text_item ("recaptcha.secret_key") as l_recaptcha_key and then
					not l_recaptcha_key.is_empty
				then
					Result := utf.utf_32_string_to_utf_8_string_8 (l_recaptcha_key)
				end
			end
		end

	recaptcha_site_key (api: CMS_API): detachable READABLE_STRING_8
			-- Get recaptcha security key.
		local
			utf: UTF_CONVERTER
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if
					attached cfg.text_item ("recaptcha.site_key") as l_recaptcha_key and then
					not l_recaptcha_key.is_empty
				then
					Result := utf.utf_32_string_to_utf_8_string_8 (l_recaptcha_key)
				end
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			debug ("refactor_fixme")
				fixme ("add contact to menu")
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"contact", "post_contact">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			l_path_info: READABLE_STRING_8
		do
			l_path_info := a_response.request.percent_encoded_path_info

				-- "contact", "post_contact"
			if
				a_block_id.is_case_insensitive_equal_general ("contact") and then
				l_path_info.starts_with ("/contact") and then
				a_response.request.is_get_request_method
			then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					if attached recaptcha_site_key (a_response.api) as l_recaptcha_site_key then
						l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
					end

					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif
				a_block_id.is_case_insensitive_equal_general ("post_contact") and then
				l_path_info.starts_with ("/contact")
			then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
--					l_tpl_block.set_value (a_response.values.item ("has_error"), "has_error")
--					a_response.add_block (l_tpl_block, "content")
--					write_debug_log (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			end
		end

	handle_contact (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
				-- FIXME: we should use WSF_FORM, and integrate the recaptcha using the form alter hook.
			write_debug_log (generator + ".handle_contact")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("contact", "contact")
			r.execute
		end

	handle_post_contact (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			m: STRING
			um: STRING
			l_captcha_passed: BOOLEAN
			msg: CONTACT_MESSAGE
			l_params: CONTACT_EMAIL_SERVICE_PARAMETERS
			e: CMS_EMAIL
		do
			write_information_log (generator + ".handle_post_contact")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force (False, "has_error")

			write_debug_log (generator + ".handle_post_contact {Form Parameters:" + print_form_parameters (req) +"}")
			if
				attached {WSF_STRING} req.form_parameter ("name") as l_name and then
				attached {WSF_STRING} req.form_parameter ("email") as l_email and then
				attached {WSF_STRING} req.form_parameter ("message") as l_message
			then
				if attached recaptcha_secret_key (api) as l_recaptcha_key then
					if
						attached {WSF_STRING} req.form_parameter ("g-recaptcha-response") as l_recaptcha_response and then
						is_captcha_verified (l_recaptcha_key, l_recaptcha_response.value)
					then
						l_captcha_passed := True
					else
							--| Bad or missing captcha
						l_captcha_passed := False
					end
				else
						--| reCaptcha is not setup, so no verification
					l_captcha_passed := True
				end

				if l_captcha_passed then
					if attached contact_api as l_contact_api then
						create msg.make (l_name.value, l_message.value)
						msg.set_email (l_email.value.as_string_8)

						l_contact_api.save_contact_message (msg)
					end

					create l_params.make (api, Current)

						-- Send internal email to admin.
					create um.make_from_string (user_contact)
					um.replace_substring_all ("$name", html_encoded (l_name.value))
					um.replace_substring_all ("$email", html_encoded (l_email.value))
					um.replace_substring_all ("$message", html_encoded (l_message.value))
					write_debug_log (generator + ".handle_post_contact: send_internal_email")

					e := api.new_email (l_params.admin_email, "Notification Contact", um)
					e.set_from_address (l_params.admin_email)
					e.add_header_line ("MIME-Version:1.0")
					e.add_header_line ("Content-Type: text/html; charset=utf-8")
					api.process_email (e)
--					es.send_internal_email (um)

					if not api.has_error then

							-- Send Contact email to the user
						create m.make_from_string (email_template ("email", r))
						write_information_log (generator + ".handle_post_contact: preparing the message:" + html_encoded (contact_message (r)))
						e := api.new_email (l_email.value, l_params.contact_subject_text, m)
						e.set_from_address (l_params.admin_email)
						e.add_header_line ("MIME-Version:1.0")
						e.add_header_line ("Content-Type: text/html; charset=utf-8")
						write_debug_log (generator + ".handle_post_contact: send_contact_email")
						api.process_email (e)
					end

					if api.has_error then
						write_error_log (generator + ".handle_post_contact: error message:["+ api.string_representation_of_errors +"]")
						r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
						r.values.force (True, "has_error")
						if attached template_block (Current, "post_contact", r) as l_tpl_block then
							l_tpl_block.set_value (r.values.item ("has_error"), "has_error")
							r.set_main_content (l_tpl_block.to_html(r.theme))
						end
					else
						if attached template_block (Current, "post_contact", r) as l_tpl_block then
							r.set_main_content (l_tpl_block.to_html (r.theme))
						end
					end
					r.execute
				else
						-- send a bad request status code and redisplay the form with the previous data loaded.	
					r.set_value (False, "error")
					r.set_status_code ({HTTP_STATUS_CODE}.bad_request)
					if attached template_block (Current, "contact", r) as l_tpl_block then
						l_tpl_block.set_value (l_name.value, "name")
						l_tpl_block.set_value (l_email.value, "email")
						l_tpl_block.set_value (l_message.value, "message")

						if attached recaptcha_site_key (api) as l_recaptcha_site_key then
							l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
							l_tpl_block.set_value (<<"Missing Captcha", "Internal Server Error">>, "error_response")
						end

						r.set_main_content (l_tpl_block.to_html (r.theme))
					else
						debug ("cms")
							r.add_warning_message ("Error with block [contact]")
						end
					end
					r.execute
				end
			else
					-- Internal server error
				write_error_log (generator + ".handle_post_contact:  Internal Server error")
				r.values.force (True, "has_error")
				r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
				if attached template_block (Current, "post_contact", r) as l_tpl_block then
					l_tpl_block.set_value (r.values.item ("has_error"), "has_error")
					r.set_main_content (l_tpl_block.to_html (r.theme))
				end
				r.execute
			end
		end

feature {NONE} -- Helpers

	print_form_parameters (req: WSF_REQUEST): STRING
		do
			create Result.make_empty
			across req.form_parameters as ic loop
				Result.append (ic.item.key)
				Result.append_character ('=')
				if attached {WSF_STRING} req.form_parameter (ic.item.key) as l_value then
					Result.append_string (l_value.value)
				elseif attached {WSF_MULTIPLE_STRING} req.form_parameter (ic.item.key) as l_value then
					Result.append_character ('[')
					Result.append_string (l_value.string_representation)
					Result.append_character (']')
				end
				Result.append_character ('%N')
			end
		end

feature {NONE} -- HTML ENCODING.

	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Contact Message

	email_template (a_template: READABLE_STRING_8; a_response: CMS_RESPONSE): STRING
			-- Smarty email template.
		local
			res: PATH
			p: detachable PATH
			l_block: CMS_SMARTY_TEMPLATE_BLOCK
		do
			write_debug_log (generator + ".email_template with template [" + a_template + " ]")
			create res.make_from_string ("templates")
			res := res.extended ("email_").appended (a_template).appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (Current, res)
			if p /= Void then
				if attached p.entry as e then
					create l_block.make (a_template, Void, p.parent, e)
					write_debug_log (generator + ".email_template with template_block:" + l_block.out)
				else
					create l_block.make (a_template, Void, p.parent, p)
					write_debug_log (generator + ".email_template with template_block:" + l_block.out)
				end
				Result := l_block.to_html (a_response.theme)
			else
				Result := contact_message (a_response)
				write_debug_log (generator + ".email_template without template_block:" + Result)
			end
		end

	contact_message (a_response: CMS_RESPONSE): STRING
		do
			Result := "<p>Thank you for contacting " + html_encoded (a_response.api.setup.site_name) + ".<br/>We will get back to you promptly on your contact request.</p>"
		end

	user_contact: STRING = "[
			                        <h2> Notification contact form</h2>  
									<div>
										<strong>Name<strong>: $name <br/>
										<strong>Email<strong>: $email <br/>
										<strong>Message<strong>: $message <br/>
									</div> <br/>
		]"


feature {NONE} -- Google recaptcha uri template

	uri_recaptcha_template: STRING_8 = "https://www.google.com/recaptcha/api/siteverify?secret=$secret_key&response=$g-recaptcha-response"
			-- Url to check if google has verified the user.
			-- GET request to URI https://www.google.com/recaptcha/api/siteverify
			-- secret(required) : Secret key for the site
			-- response(required) The value of 'g-recaptcha-response'.
			-- remoteip: The end user's ip address.


	is_captcha_verified (a_secret, a_response: READABLE_STRING_8): BOOLEAN
		local
			api: RECAPTCHA_API
			l_errors: STRING
		do
			write_debug_log (generator + ".is_captcha_verified with response: [" + a_response + "]")
			create api.make (a_secret, a_response)
			Result := api.verify
			if not Result and then attached api.errors as l_api_errors then
				create l_errors.make_empty
				l_errors.append_character ('%N')
				across l_api_errors as ic loop
					l_errors.append ( ic.item )
					l_errors.append_character ('%N')
				end
				write_error_log (generator + ".is_captcha_verified api_errors [" + l_errors + "]")
			end
		end

end
