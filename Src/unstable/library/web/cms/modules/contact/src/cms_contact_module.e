note
	description: "[
			Module that provide contact us web form functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CONTACT_MODULE

inherit
	CMS_MODULE
		rename
			module_api as contact_api
		redefine
			setup_hooks,
			install,
			initialize,
			contact_api
		end

	CMS_HOOK_BLOCK
		redefine
			setup_block
		end

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

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
			else
				create {CONTACT_STORAGE_NULL} contact_storage.make
			end

			create l_contact_api.make (api, contact_storage)
			contact_api := l_contact_api
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			retried: BOOLEAN
			d: DIRECTORY
		do
			if not retried then
				create d.make_with_path (file_system_storage_path (api))
				d.recursive_create_dir
				Precursor {CMS_MODULE}(api) -- Marked installed
			else
				api.report_error ("[" + name + "]: installation failed!", {STRING_32} "Could not create %""+ file_system_storage_path (api).name + "%"")
			end
		rescue
			retried := True
			retry
		end

	file_system_storage_path (api: CMS_API): PATH
			-- Location of eventual file system based storage for contact messages.
		do
			Result := api.site_location.extended ("db").extended (name).extended ("messages")
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

	contact_api: detachable CONTACT_API

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		local
			m: WSF_URI_MAPPING
		do
			create m.make_trailing_slash_ignored ("/contact", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contact (a_api, ?, ?)))
			a_router.map (m, a_router.methods_head_get)
			a_router.handle ("/contact", create {WSF_URI_AGENT_HANDLER}.make (agent handle_post_contact (a_api, ?, ?)), a_router.methods_put_post)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"?contact">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("contact") then
					-- "contact", "post_contact"
				if a_response.request.is_get_request_method then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
						l_tpl_block.set_value ("form-" + recaptcha_action, "form_id")
						if attached recaptcha_site_html ("form-" + recaptcha_action, a_response.api) as l_recaptcha_site_html then
							l_tpl_block.set_value (l_recaptcha_site_html, "recaptcha_site_html")
						end
						if
							attached recaptcha_config (a_response.api) as cfg and then
							attached cfg.site_key as l_recaptcha_site_key
						then
								-- Backward compatiblity
							l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
						end
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end

	setup_block (a_block: CMS_BLOCK; a_response: CMS_RESPONSE)
			-- Setup block `a_block` and perform additional setup on `a_response` if needed
			-- (such as linking with css, js, ...).
			--| To be redefined if needed.
		do
			if a_block.name.is_case_insensitive_equal_general ("contact") then
				a_response.add_style (a_response.module_resource_url (Current, "/files/css/contact.css", Void), Void)
			end
		end

	new_html_contact_form (a_response: CMS_RESPONSE; api: CMS_API): STRING
		local
			f: CMS_FORM
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/contact.css", Void), Void)
			if attached smarty_template_block (Current, "contact", api) as l_tpl_block then
				if attached recaptcha_site_html ("form-" + recaptcha_action, api) as l_recaptcha_site_html then
					l_tpl_block.set_value (l_recaptcha_site_html, "recaptcha_site_html")
				end
				if
					attached recaptcha_config (api) as cfg and then
					attached cfg.site_key as l_recaptcha_site_key
				then
						-- Backward compatiblity
					l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
				end
				l_tpl_block.set_value ("form-" + recaptcha_action, "form_id")
				across
					a_response.values as tb
				loop
					l_tpl_block.set_value (tb.item, tb.key)
				end
				Result := l_tpl_block.to_html (a_response.theme)
			else
				f := new_contact_form ("form-" + recaptcha_action, a_response, api)
				api.hooks.invoke_form_alter (f, f.last_data, a_response)

				Result := "<div class=%"contact-box%"><h1>Contact us!</h1>" + f.to_html (a_response.wsf_theme) + "<br/></div>"
			end
		end

	new_contact_form (a_form_id: READABLE_STRING_8; a_response: CMS_RESPONSE; api: CMS_API): CMS_FORM
		local
			f: CMS_FORM
			f_name: WSF_FORM_TEXT_INPUT
			f_email: WSF_FORM_EMAIL_INPUT
			f_msg: WSF_FORM_TEXTAREA
			f_submit: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_response.url ("contact", Void), a_form_id)
			create f_name.make ("name")
			f_name.set_label ("Name")
			f_name.set_is_required (True)
			f.extend (f_name)

			create f_email.make ("email")
			f_email.set_label ("Email Address")
			f_email.set_is_required (True)
			f.extend (f_email)

			create f_msg.make ("message")
			f_msg.set_label ("Message")
			f_msg.set_rows (5)
			f_msg.set_is_required (True)
			f.extend (f_msg)

			if attached recaptcha_site_html (a_form_id, api) as l_recaptcha_site_html then
				f.extend_html_text (l_recaptcha_site_html)
				f.extend_html_text ("<br/>")
			end

			create f_submit.make_with_text ("submit-op", "Send")
			f.extend (f_submit)

--			f.extend_html_text ("[
--					<p class="req-field-desc"><span class="required">*</span> indicates a required field</p>
--				]")

			Result := f
		end

	handle_contact (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
				-- FIXME: we should use WSF_FORM, and integrate the recaptcha using the form alter hook.
			write_debug_log (generator + ".handle_contact")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("contact", "contact")
			r.set_main_content (new_html_contact_form (r, api))
			r.execute
		end

	handle_post_contact (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			msg: CONTACT_MESSAGE
			l_params: CONTACT_EMAIL_SERVICE_PARAMETERS
			e: CMS_EMAIL
			vars: STRING_TABLE [READABLE_STRING_8]
			l_contact_email_address: READABLE_STRING_8
		do
			write_information_log (generator + ".handle_post_contact")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.add_style (r.module_resource_url (Current, "/files/css/contact.css", Void), Void)
			r.values.force (False, "has_error")

			create vars.make_caseless (5)
			vars.put (safe_html_encoded (api.setup.site_url), "siteurl")
			vars.put (safe_html_encoded (api.setup.site_name), "sitename")

			write_debug_log (generator + ".handle_post_contact {Form Parameters:" + form_parameters_as_string (req) + "}")
			if
				attached {WSF_STRING} req.form_parameter ("name") as l_name and then
				attached {WSF_STRING} req.form_parameter ("email") as l_email and then
				attached {WSF_STRING} req.form_parameter ("message") as l_message
			then
				if
					is_form_captcha_verified (req, api) and then
					l_email.value.is_valid_as_string_8
				then
					l_contact_email_address := l_email.value.to_string_8

					if attached contact_api as l_contact_api then
						create msg.make (l_name.value, l_message.value)
						msg.set_email (l_contact_email_address)

						l_contact_api.save_contact_message (msg)
					end

					create l_params.make (api, Current)

						-- Send internal email to admin.
					vars.put (html_encoded (l_name.value), "name")
					vars.put (html_encoded (l_contact_email_address), "email")
					vars.put (html_encoded (l_message.value), "message")

					write_debug_log (generator + ".handle_post_contact: send notification email")

					e := api.new_html_email (l_params.admin_email, "Contact message from " + html_encoded (l_name.value) + " (" + html_encoded (l_contact_email_address) + ")" , email_html_message ("notification", r, vars))
					e.set_from_address (l_params.admin_email)
					api.process_email (e)

					if not api.has_error then
							-- Send Contact email to the user
						write_information_log (generator + ".handle_post_contact: preparing the message.")
						e := api.new_html_email (l_contact_email_address, l_params.contact_subject_text, email_html_message ("message", r, vars))
						e.set_from_address (l_params.admin_email)
						write_debug_log (generator + ".handle_post_contact: send_contact_email")
						api.process_email (e)
					end

					if api.has_error then
						write_error_log (generator + ".handle_post_contact: error message:["+ html_encoded (api.string_representation_of_errors) +"]")
						r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
						r.values.force (True, "has_error")
						vars.put ("True", "has_error")
					end
					if attached smarty_template_block_with_values (Current, "post_contact", api, vars) as l_tpl_block then
						across
							r.values as tb
						loop
							l_tpl_block.set_value (tb.item, tb.key)
						end
						r.set_main_content (l_tpl_block.to_html (r.theme))
					else
						r.set_main_content ("Thank you for your message.")
					end
					r.execute
				else
						-- send a bad request status code and redisplay the form with the previous data loaded.	
					r.set_value (False, "error")
					r.set_status_code ({HTTP_STATUS_CODE}.bad_request)
					if attached smarty_template_block_with_values (Current, "contact", api, vars) as l_tpl_block then
						l_tpl_block.set_value (l_name.value, "name")
						l_tpl_block.set_value (l_contact_email_address, "email")
						l_tpl_block.set_value (l_message.value, "message")

						across
							r.values as tb
						loop
							l_tpl_block.set_value (tb.item, tb.key)
						end
						if
							attached recaptcha_config (api) as cfg and then
							attached cfg.site_key as l_recaptcha_site_key
						then
							l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
							l_tpl_block.set_value (<<"Missing Captcha", "Internal Server Error">>, "error_response")
						end
						l_tpl_block.set_value ("form-" + recaptcha_action, "form_id")
						if attached recaptcha_site_html ("form-" + recaptcha_action, api) as l_recaptcha_site_html then
							l_tpl_block.set_value (l_recaptcha_site_html, "recaptcha_site_html")
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
				if attached smarty_template_block_with_values (Current, "post_contact", api, vars) as l_tpl_block then
					across
						r.values as tb
					loop
						l_tpl_block.set_value (tb.item, tb.key)
					end
					r.set_main_content (l_tpl_block.to_html (r.theme))
				end
				r.execute
			end
		end

feature {NONE} -- Helpers

	form_parameters_as_string (req: WSF_REQUEST): STRING
		do
			create Result.make_empty
			across req.form_parameters as ic loop
				Result.append (utf_8_encoded (ic.item.key))
				Result.append_character ('=')
				Result.append_string (utf_8_encoded (ic.item.string_representation))
				Result.append_character ('%N')
			end
		end

feature {NONE} -- Contact Message

	email_html_message (a_message_id: READABLE_STRING_8; a_response: CMS_RESPONSE; a_html_encoded_values: STRING_TABLE [READABLE_STRING_8]): STRING
			-- html message related to `a_message_id'.
		local
			res: PATH
			p: detachable PATH
			tpl: CMS_SMARTY_TEMPLATE_BLOCK
			exp: CMS_STRING_EXPANDER [READABLE_STRING_8]
		do
			write_debug_log (generator + ".email_html_message for [" + a_message_id + " ]")

			create res.make_from_string ("templates")
			res := res.extended ("email_").appended (a_message_id).appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (Current, res)
			if p /= Void then
				if attached p.entry as e then
					create tpl.make (a_message_id, Void, p.parent, e)
					write_debug_log (generator + ".email_html_message from smarty template:" + tpl.out)
				else
					create tpl.make (a_message_id, Void, p.parent, p)
					write_debug_log (generator + ".email_html_message from smarty template:" + tpl.out)
				end
				across
					a_html_encoded_values as ic
				loop
					tpl.set_value (ic.item, ic.key)
				end
				Result := tpl.to_html (a_response.theme)
			else
				if a_message_id.is_case_insensitive_equal_general ("message") then
					create Result.make_from_string (contact_message_template)
				elseif a_message_id.is_case_insensitive_equal_general ("notification") then
					create Result.make_from_string (contact_notification_message_template)
				else
					create Result.make_from_string (a_message_id)
					across
						a_html_encoded_values as ic
					loop
						Result.append ("<li>")
						Result.append (html_encoded (ic.key))
						Result.append (": ")
						Result.append (ic.item) -- Already html encoded.
						Result.append ("</li>%N")
					end
				end

				create exp.make
				across
					a_html_encoded_values as ic
				loop
					exp.put (ic.item, ic.key)
				end
				exp.expand_string (Result)
				write_debug_log (generator + ".email_html_message using built-in message:" + Result)
			end
		end

	contact_message_template: STRING
		do
			Result := "[
						<p>Thank you for contacting $sitename.<br/>
						We will get back to you promptly on your contact request.
						</p>
					]"
					+ contact_notification_message_template
		end

	contact_notification_message_template: STRING = "[
						<h2>Contact information:</h2>  
						<div>
							<strong>Name<strong>: $name <br/>
							<strong>Email<strong>: $email <br/>
							<strong>Message<strong>: $message <br/>
						</div>
				]"

feature {NONE} -- Google recaptcha uri template

	recaptcha_action: STRING = "post_message"

	recaptcha_config (api: CMS_API): detachable RECAPTCHA_CONFIG
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if
					attached cfg.text_item ("recaptcha.version") as v and then
					not v.is_empty
				then
					create Result.make_with_version (api.utf_8_encoded (v))
				else
					create Result.make
				end
				if
					attached cfg.text_item ("recaptcha.secret_key") as k and then
					not k.is_empty
				then
					Result.set_secret_key (api.utf_8_encoded (k))
				end
				if
					attached cfg.text_item ("recaptcha.site_key") as k and then
					not k.is_empty
				then
					Result.set_site_key (api.utf_8_encoded (k))
				end
			end
		end

	recaptcha_site_html (a_form_id: READABLE_STRING_8; api: CMS_API): detachable READABLE_STRING_8
		local
			l_client: RECAPTCHA_CLIENT
		do
			if
				attached recaptcha_config (api) as cfg and then
				attached cfg.site_key as l_recaptcha_site_key
			then
				create l_client.make (cfg, l_recaptcha_site_key)
				Result := l_client.client_html (a_form_id, recaptcha_action)
			end
		end

	is_form_captcha_verified (req: WSF_REQUEST; api: CMS_API): BOOLEAN
		do
			if
				attached recaptcha_config (api) as cfg and then
				attached cfg.secret_key as l_secret_key
			then
				if attached {WSF_STRING} req.form_parameter ("g-recaptcha-response") as l_recaptcha_response then
					Result := is_captcha_verified (cfg, l_secret_key, l_recaptcha_response.value)
				else
						--| missing captcha
				end
			else
					--| reCaptcha is not setup, so no verification
				Result := True
			end
		end

	is_captcha_verified (cfg: RECAPTCHA_CONFIG; a_secret: READABLE_STRING_8; a_response: READABLE_STRING_GENERAL): BOOLEAN
		local
			api: RECAPTCHA_API
			l_errors: STRING
		do
			write_debug_log (generator + ".is_captcha_verified with response: [" + utf_8_encoded (a_response) + "]")
			create api.make (a_secret, a_response)
			if cfg.is_version_3 then
				Result := api.verify_score (0.5, recaptcha_action)
			else
				Result := api.verify
			end
			if
				not Result and then
				attached api.errors as l_api_errors
			then
				create l_errors.make_empty
				l_errors.append_character ('%N')
				across l_api_errors as ic loop
					l_errors.append (ic.item)
					l_errors.append_character ('%N')
				end
				write_error_log (generator + ".is_captcha_verified api_errors [" + l_errors + "]")
			end
		end

end
