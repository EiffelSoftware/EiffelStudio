note
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_OAUTH_20_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.extend (perm_admin_oauth2)
		end

	perm_admin_oauth2: STRING = "admin oauth2"

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		do
			a_router.handle ("/oauth20/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_consumers (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/oauth20/{consumer}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_admin_consumer (a_api, ?, ?)), a_router.methods_head_get_post)
			a_router.handle ("/oauth20/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_consumer (a_api, ?, ?)), a_router.methods_post)
		end

feature -- Handle

	handle_admin_consumers (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			fut: FILE_UTILITIES
			cons: CMS_OAUTH_20_CONSUMER
			l_existing_cons: STRING_TABLE [READABLE_STRING_GENERAL]
			p: PATH
		do
			if a_api.has_permission (perm_admin_oauth2) then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
				create s.make_empty
				s.append ("<h2>Existing consumers</h2>")
				create l_existing_cons.make_caseless (0)
				if attached module.oauth20_api as l_oauth20_api then
					s.append ("<ul>")
					across
						l_oauth20_api.oauth2_consumers as ic
					loop
						l_existing_cons.force (ic.item, ic.item + ".ini")
						s.append ("<li>")
						s.append ("<a href=%"" + a_api.url (a_api.administration_path ("oauth20/" + ic.item), Void) + "%">")
						s.append (ic.item)
						s.append ("</a>")
						s.append ("</li>")
					end
					s.append ("</ul>")
				end
				if
					attached a_api.module_resource_location (module, create {PATH}.make_from_string ("data")) as dir_p and then
					attached fut.file_names (dir_p.name) as lst
				then
					s.append ("<h2>Setup predefined consumers</h2>")

					s.append ("<ul>")
					across
						lst as ic
					loop
						create p.make_from_string (ic.item)
						if
							not ic.item.starts_with (".") and then
							attached p.extension as ext and then ext.is_case_insensitive_equal_general ("ini") and then
							not l_existing_cons.has (ic.item)
						then
							cons := predefined_consumer_from_path (dir_p.extended_path (p), a_api)
							if cons /= Void then
--								s.append ("<hr/><h2>setup "+  html_encoded (cons.name) +"</h2>")
--								f := new_consumer_form (req.percent_encoded_path_info, req, cons)
--								f.append_to_html (r.wsf_theme, s)
								s.append ("<li><a href=%"" + a_api.url (a_api.administration_path ("oauth20/" + url_encoded (cons.name)), Void) + "%">")
								s.append (html_encoded (cons.name))
								s.append ("</a></li>")
							end
						end
					end
					s.append ("</ul>")
				end
				s.append ("<h2>New consumer</h2>")
				f := new_consumer_form (req.percent_encoded_path_info, req, create {CMS_OAUTH_20_CONSUMER}, a_api)
				f.append_to_html (r.wsf_theme, s)
				r.set_main_content (s)
				r.execute
			else
				a_api.response_api.send_access_denied (Void, req, res)
			end
		end

	predefined_consumer (a_consumer_name: READABLE_STRING_GENERAL; api: CMS_API): detachable CMS_OAUTH_20_CONSUMER
		local
			p: PATH
		do
			p := api.module_resource_location (module, (create {PATH}.make_from_string ("data")).extended (a_consumer_name).appended_with_extension ("ini"))
			Result := predefined_consumer_from_path (p, api)
		end

	predefined_consumer_from_path (a_path: PATH; api: CMS_API): detachable CMS_OAUTH_20_CONSUMER
		local
			cfg: INI_CONFIG
			v: READABLE_STRING_8
			v32: READABLE_STRING_32
		do
			create cfg.make_from_file (a_path)
			if not cfg.has_error then
				create Result
				v32 := cfg.text_item ("name")
				if v32 /= Void then
					Result.set_name (v32)
				end
				v := cfg.utf_8_text_item ("scope")
				if v /= Void then
					Result.set_scope (v)
				end
				v := cfg.utf_8_text_item ("authorize_url")
				if v /= Void then
					Result.set_authorize_url (v)
				end
				v := cfg.utf_8_text_item ("callback_name")
				if v /= Void then
					Result.set_callback_name (v)
				end
				v := cfg.utf_8_text_item ("endpoint")
				if v /= Void then
					Result.set_endpoint (v)
				end
				v := cfg.utf_8_text_item ("extractor")
				if v /= Void then
					Result.set_extractor (v)
				end
				v := cfg.utf_8_text_item ("protected_resource_url")
				if v /= Void then
					Result.set_protected_resource_url (v)
				end
			end
		end

	handle_admin_consumer (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			fset: WSF_FORM_FIELD_SET
			tf: WSF_FORM_TEXT_INPUT
			l_is_protect_predefined_fields: BOOLEAN
			l_consumer_name: detachable READABLE_STRING_32
			cons: detachable CMS_OAUTH_20_CONSUMER
			l_oauth20_api: CMS_OAUTH_20_API
		do
			if a_api.has_permission (perm_admin_oauth2) then
				l_oauth20_api := module.oauth20_api
				if l_oauth20_api = Void then
					create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
				else
					if attached {WSF_STRING} req.path_parameter ("consumer") as p_consumer then
						l_consumer_name := p_consumer.value
					elseif attached {WSF_STRING} req.form_parameter ("consumer") as p_consumer then
						check is_put_request_method: req.is_put_request_method end
						l_consumer_name := p_consumer.value
					end
					if l_consumer_name /= Void then
						if l_oauth20_api /= Void and then attached l_oauth20_api.oauth_consumer_by_name (l_consumer_name) as l_existing_cons then
							cons := l_existing_cons
						elseif attached predefined_consumer (l_consumer_name, a_api) as l_pred_cons then
							cons := l_pred_cons
						else
							create cons
							cons.set_name (l_consumer_name)
						end
					else
						create cons
						check not_possible: False end
					end
					if cons /= Void then
						l_is_protect_predefined_fields := cons.has_id

						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
						r.add_to_primary_tabs (a_api.administration_link ("Consumers", "oauth20/"))
						create s.make_empty
						if l_is_protect_predefined_fields then
							s.append ("<h2>Update consumer %"" + a_api.html_encoded (cons.name) + "%"</h2>")
						else
							s.append ("<h2>Setup new consumer %"" + a_api.html_encoded (cons.name) + "%"</h2>")
						end
						f := new_consumer_form (req.percent_encoded_path_info, req, cons, a_api)
						create fset.make
						fset.set_legend ("Information")
						f.extend (fset)
						create tf.make_with_text ("ignore-url",a_api.absolute_url ({CMS_OAUTH_20_MODULE}.oauth_callback_path + cons.callback_name, Void) )
						tf.set_label ("Authorization callback URL"); tf.set_size (70); tf.set_is_readonly (True)
						tf.set_description ("This value may be needed to setup OAuth "+ html_encoded (cons.name) +" authorization.")
						fset.extend (tf)

						if l_is_protect_predefined_fields then
							f.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Delete"))
						end

						if req.is_get_head_request_method then
							f.append_to_html (r.wsf_theme, s)
						else
							f.submit_actions.extend (agent (fd: WSF_FORM_DATA; i_cons: CMS_OAUTH_20_CONSUMER; i_oauth20_api: CMS_OAUTH_20_API; l_output: STRING)
									do
										if
											attached fd.string_item ("name") as l_name and then
											attached fd.string_item ("api_key") as l_api_key and then
											attached fd.string_item ("api_secret") as l_api_secret
										then
											i_cons.set_name (l_name)
											i_cons.set_api_key (utf_8_encoded (l_api_key)) -- Key are usually ascii or utf-8 encoded.
											i_cons.set_api_secret (utf_8_encoded (l_api_secret)) -- API Secret are usually ascii or utf-8 encoded.

											if attached fd.string_item ("authorize_url") as l_authorize_url then
												i_cons.set_authorize_url (utf_8_encoded (l_authorize_url))
											end
											if attached fd.string_item ("callback_name") as l_callback_name then
												i_cons.set_callback_name (utf_8_encoded (l_callback_name))
											end

											if attached fd.string_item ("endpoint") as l_endpoint then
												i_cons.set_endpoint (utf_8_encoded (l_endpoint))
											end

											if attached fd.string_item ("extractor") as l_extractor then
												i_cons.set_extractor (utf_8_encoded (l_extractor))
											end

											if attached fd.string_item ("protected_resource_url") as l_protected_resource_url then
												i_cons.set_protected_resource_url (utf_8_encoded (l_protected_resource_url))
											end
											if attached fd.string_item ("scope") as l_scope then
												i_cons.set_scope (utf_8_encoded (l_scope))
											end
											if attached fd.string_item ("op") as l_op and then l_op.same_string ("Confirm Delete") then
												i_oauth20_api.delete_oauth_consumer (i_cons)
											elseif attached fd.string_item ("op") as l_op and then l_op.same_string ("Delete") then
												fd.form.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Confirm Delete"))
											else
												i_oauth20_api.save_oauth_consumer (i_cons)
												l_output.append ("<p>Consumer "+ html_encoded (i_cons.name) + " saved...</p>")
											end
										end
									end(?, cons, l_oauth20_api, s)
								);
							f.process (r)
							f.append_to_html (r.wsf_theme, s)
						end
						r.set_main_content (s)
					else
						create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
					end
				end
				r.execute
			else
				a_api.response_api.send_access_denied (Void, req, res)
			end
		end

	new_consumer_form (a_action: READABLE_STRING_8; req: WSF_REQUEST; cons: CMS_OAUTH_20_CONSUMER; a_api: CMS_API): CMS_FORM
		local
			fset: WSF_FORM_FIELD_SET
			tf: WSF_FORM_TEXT_INPUT
			l_is_protect_predefined_fields: BOOLEAN
		do
			create Result.make (a_action, "consumer")
			Result.set_method_post
			create tf.make_with_text ("name", cons.name)
			tf.set_label ("Name"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			Result.extend (tf)

			create fset.make
			fset.set_legend ("Enter expected data")
			Result.extend (fset)
			create tf.make_with_text ("api_key", cons.api_key)
			tf.set_label ("API key"); tf.set_size (70)
			fset.extend (tf)
			create tf.make_with_text ("api_secret", cons.api_secret)
			tf.set_label ("API secret")
			fset.extend (tf); tf.set_size (70)

			fset.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Submit"))

			create fset.make
			fset.set_legend ("Predefined settings (change with care)")
			Result.extend (fset)

			create tf.make_with_text ("authorize_url", cons.authorize_url)
			tf.set_label ("Authorize URL"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			fset.extend (tf)
			create tf.make_with_text ("callback_name", cons.callback_name)
			tf.set_label ("Callback Name"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			fset.extend (tf)
			create tf.make_with_text ("endpoint", cons.endpoint)
			tf.set_label ("Endpoint"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			fset.extend (tf)
			create tf.make_with_text ("extractor", cons.extractor)
			tf.set_label ("Extractor"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			fset.extend (tf)
			create tf.make_with_text ("protected_resource_url", cons.protected_resource_url)
			tf.set_label ("Protected Resource URL"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			fset.extend (tf)
			create tf.make_with_text ("scope", cons.scope)
			tf.set_label ("Scope"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
			fset.extend (tf)
		end

feature -- Hook

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			if a_response.is_authenticated then
				a_menu_system.navigation_menu.extend (create {CMS_LOCAL_LINK}.make ("OAuth20", a_response.api.administration_path_location ("oauth20/")))
			end
		end

end
