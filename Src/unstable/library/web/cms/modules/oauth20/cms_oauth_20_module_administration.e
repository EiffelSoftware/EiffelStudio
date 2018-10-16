note
	description: "Summary description for {CMS_OAUTH_20_MODULE_ADMINISTRATION}."
	author: ""
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
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		do
			a_router.handle ("/oauth20/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_consumers (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/oauth20/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_consumer (a_api, ?, ?)), a_router.methods_post)
			a_router.handle ("/oauth20/{consumer}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_admin_consumer (a_api, ?, ?)), a_router.methods_head_get_post)
		end

feature -- Handle

	handle_admin_consumers (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			fut: FILE_UTILITIES
			cfg: INI_CONFIG
			cons: CMS_OAUTH_20_CONSUMER
			l_existing_cons: STRING_TABLE [READABLE_STRING_GENERAL]
			v: detachable READABLE_STRING_8
			v32: detachable READABLE_STRING_32
			p: PATH
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
			create s.make_empty
			s.append ("<h1>Consumers</h1>")
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
				across
					lst as ic
				loop
					create p.make_from_string (ic.item)
					if
						not ic.item.starts_with (".") and then
						attached p.extension as ext and then ext.is_case_insensitive_equal_general ("ini") and then
						not l_existing_cons.has (ic.item)
					then
						create cfg.make_from_file (dir_p.extended_path (p))
						if not cfg.has_error then
							create cons.default_create
							v32 := cfg.text_item ("name")
							if v32 /= Void then
								cons.set_name (v32)
							end
							v := cfg.utf_8_text_item ("scope")
							if v /= Void then
								cons.set_scope (v)
							end
							v := cfg.utf_8_text_item ("authorize_url")
							if v /= Void then
								cons.set_authorize_url (v)
							end
							v := cfg.utf_8_text_item ("callback_name")
							if v /= Void then
								cons.set_callback_name (v)
							end
							v := cfg.utf_8_text_item ("endpoint")
							if v /= Void then
								cons.set_endpoint (v)
							end
							v := cfg.utf_8_text_item ("extractor")
							if v /= Void then
								cons.set_extractor (v)
							end
							v := cfg.utf_8_text_item ("protected_resource_url")
							if v /= Void then
								cons.set_protected_resource_url (v)
							end
							s.append ("<h1>setup "+  html_encoded (cons.name) +"</h1>")
							f := new_consumer_form (req.percent_encoded_path_info, req, cons)
							f.append_to_html (r.wsf_theme, s)
						end
					end
				end
			end
			s.append ("<h1>New consumer</h1>")
			f := new_consumer_form (req.percent_encoded_path_info, req, create {CMS_OAUTH_20_CONSUMER})
			f.append_to_html (r.wsf_theme, s)
			r.set_main_content (s)
			r.execute
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
			l_oauth20_api := module.oauth20_api
			if l_oauth20_api = Void then
				create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
			else
				if attached {WSF_STRING} req.path_parameter ("consumer") as p_consumer then
					l_consumer_name := p_consumer.value
				end
				if
					l_consumer_name /= Void and then
					l_oauth20_api /= Void
				then
					cons := l_oauth20_api.oauth_consumer_by_name (l_consumer_name)
				else
					create cons
				end
				if cons /= Void then
					l_is_protect_predefined_fields := cons.has_id

					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
					r.add_to_primary_tabs (a_api.administration_link ("Consumers", "oauth20/"))
					create s.make_empty
					s.append ("<h1>Consumer %"" + a_api.html_encoded (cons.name) + "%"</h1>")
					f := new_consumer_form (req.percent_encoded_path_info, req, cons)

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
										i_oauth20_api.save_oauth_consumer (i_cons)
										l_output.append ("<p>Consumer saved...</p>")
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
		end

	new_consumer_form (a_action: READABLE_STRING_8; req: WSF_REQUEST; cons: CMS_OAUTH_20_CONSUMER): CMS_FORM
		local
			s: STRING
			f: CMS_FORM
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
			fset.set_legend ("Predefine settings (change with care)")
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
--				if a_response.has_permission (permission__manage_feed_aggregator) then
--					a_menu_system.management_menu.extend_into (a_response.api.administration_link ("Feeds (admin)", "feed_aggregator/"), "Admin", "admin")
--				end
			end
		end


end
