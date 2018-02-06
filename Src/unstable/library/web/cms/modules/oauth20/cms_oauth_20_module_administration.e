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
			a_router.handle ("/oauth20/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_consumers (a_api, ?, ?)), a_router.methods_head_get_post)
			a_router.handle ("/oauth20/{consumer}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_admin_consumer (a_api, ?, ?)), a_router.methods_head_get_post)
		end

feature -- Handle

	handle_admin_consumers (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
			create s.make_empty
			s.append ("<h1>Consumers</h1>")
			if attached module.oauth20_api as l_oauth20_api then
				s.append ("<ul>")
				across
					l_oauth20_api.oauth2_consumers as ic
				loop
					s.append ("<li>")
					s.append ("<a href=%"" + a_api.url (a_api.administration_path ("oauth20/" + ic.item), Void) + "%">")
					s.append (ic.item)
					s.append ("</a>")
					s.append ("</li>")
				end
				s.append ("</ul>")
			end
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
		do
			if attached {WSF_STRING} req.path_parameter ("consumer") as p_consumer then
				if
					attached module.oauth20_api as l_oauth20_api and then
					attached l_oauth20_api.oauth_consumer_by_name (p_consumer.value) as cons
				then
					l_is_protect_predefined_fields := cons.has_id

					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
					r.add_to_primary_tabs (a_api.administration_link ("Consumers", "oauth20/"))
					create s.make_empty
					s.append ("<h1>Consumer %"" + a_api.html_encoded (cons.name) + "%"</h1>")
					create f.make (req.percent_encoded_path_info, "consumer")
					f.set_method_post
					create tf.make_with_text ("name", cons.name)
					tf.set_label ("Name"); tf.set_is_readonly (l_is_protect_predefined_fields); tf.set_size (70)
					f.extend (tf)

					create fset.make
					fset.set_legend ("Enter expected data")
					f.extend (fset)
					create tf.make_with_text ("api_key", cons.api_key)
					tf.set_label ("API key"); tf.set_size (70)
					fset.extend (tf)
					create tf.make_with_text ("api_secret", cons.api_secret)
					tf.set_label ("API secret")
					fset.extend (tf); tf.set_size (70)

					fset.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Submit"))

					create fset.make
					fset.set_legend ("Predefine settings (change with care)")
					f.extend (fset)

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


					if req.is_get_head_request_method then
						f.append_to_html (r.wsf_theme, s)
					else
						f.submit_actions.extend (agent (fd: WSF_FORM_DATA; i_cons: CMS_OAUTH_20_CONSUMER; i_oauth20_api: CMS_OAUTH_20_API; l_output: STRING)
								do
									if
										attached fd.string_item ("api_key") as l_api_key and then
										attached fd.string_item ("api_secret") as l_api_secret
									then
										i_cons.set_api_key (utf_8_encoded (l_api_key)) -- Key are usually ascii or utf-8 encoded.
										i_cons.set_api_secret (utf_8_encoded (l_api_secret)) -- API Secret are usually ascii or utf-8 encoded.
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
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
			end
			r.execute
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
