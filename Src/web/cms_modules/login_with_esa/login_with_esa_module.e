note
	description: "Summary description for {LOGIN_WITH_ESA_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_MODULE

inherit
	CMS_MODULE_WITH_SQL_STORAGE
		rename
			module_api as login_with_esa_api
		redefine
			permissions,
			initialize,
			install,
			filters,
			setup_hooks,
			login_with_esa_api
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

	CMS_WITH_WEBAPI

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.1"
			description := "Login with eiffel.com account"
			package := "auth"
			add_dependency ({CMS_AUTHENTICATION_MODULE})
		end

feature -- Access

	name: STRING = "login_with_esa"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_use_login_with_esa)
			Result.force (perm_register_with_esa)
		end

	perm_use_login_with_esa: STRING = "use login_with_esa"
	perm_register_with_esa: STRING = "register with esa"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_login_with_esa_api: like login_with_esa_api
		do
			Precursor (api)
			create l_login_with_esa_api.make (api)
			login_with_esa_api := l_login_with_esa_api
			api.user_api.register_credential_validation (create {LOGIN_WITH_ESA_CREDENTIAL_VALIDATION}.make (l_login_with_esa_api))
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
			Precursor (api)
			if
				is_installed (api) and then
				attached api.user_api.anonymous_user_role as ano
			then
				ano.add_permission (perm_use_login_with_esa)
				ano.add_permission (perm_register_with_esa)
				api.user_api.save_user_role (ano)
			end
		end

feature {CMS_EXECUTION} -- Administration

	webapi: LOGIN_WITH_ESA_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

	login_with_esa_api: detachable LOGIN_WITH_ESA_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached login_with_esa_api as l_esa_api then
				a_router.handle ("/" + register_location, create {LOGIN_WITH_ESA_REGISTER_HANDLER}.make (Current, l_esa_api), a_router.methods_get_post)

				a_router.handle ("/" + associate_location, create {WSF_URI_AGENT_HANDLER}.make (agent on_associate (?, ?, l_esa_api)), a_router.methods_get_post)
				a_router.handle ("/" + dissociate_location, create {WSF_URI_AGENT_HANDLER}.make (agent on_dissociate (?, ?, l_esa_api)), a_router.methods_get_post)
			end
		end

	register_location: STRING = "esa/register"
	associate_location: STRING = "auth/esa/associate"
	dissociate_location: STRING = "auth/esa/dissociate"

feature -- Access: routes

	on_associate (req: WSF_REQUEST; res: WSF_RESPONSE; api: LOGIN_WITH_ESA_API)
		local
			r: CMS_RESPONSE
			f: CMS_FORM
			f_pwd: WSF_FORM_PASSWORD_INPUT
			f_name: WSF_FORM_TEXT_INPUT
			txt: WSF_WIDGET_TEXT
			sub: WSF_FORM_SUBMIT_INPUT
			s: STRING_8
		do
			if attached api.cms_api.user as u then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api.cms_api)
				create s.make_empty
				if attached api.esa_account_for_user (u) as l_esa_account then
					s.append ("<p>Account already associated with an eiffel.com account!</p>")
				else
					create f.make (req.percent_encoded_path_info, "associate-form")
					f.set_method_post
					f.extend_html_text ("<p>Enter the username and password to associate your account with the Eiffel.com account.</p>")
					create f_name.make ("esa_username")
					f_name.set_placeholder ("username")
					f_name.set_label ("Username")
					f_name.set_description ("Enter your eiffel.com username")
					f.extend (f_name)

					create f_pwd.make ("esa_password")
					f_pwd.set_placeholder ("password")
					f_pwd.set_label ("Password")
					f_pwd.set_description ("Enter your eiffel.com password")
					f.extend (f_pwd)

					create sub.make_with_text ("op", "Associate")
					f.extend (sub)
					if req.is_post_request_method then
						f.process (r)
						if
							attached f.last_data as fd and then not fd.has_error and then
							attached fd.string_item ("esa_username") as l_esa_username and then
							attached fd.string_item ("esa_password") as l_esa_password
						then
							if attached api.user_for_esa_name (l_esa_username) as l_existing_user then
								s.append ("<p>ERROR: the eiffel.com %"" + html_encoded (l_esa_username) + "%" account is already associated with another account!</p>")
							elseif attached api.esa_account (l_esa_username, l_esa_password) as l_esa_acc then
								api.associate_esa_account (u, l_esa_acc)
								if attached api.esa_account_for_user (u) as l_esa_account then
									s.append ("<p>Account is now associated with the given eiffel.com account</p>")
								else
									s.append ("<p>ERROR: could not associate your account with the given eiffel.com account!</p>")
								end
							else
								create txt.make_with_text ("Invalid username or password!")
								f.prepend (txt)
								f.append_to_html (r.wsf_theme, s)
							end
						else
							f.append_to_html (r.wsf_theme, s)
						end
					else
						f.append_to_html (r.wsf_theme, s)
					end
				end
				s.append ("<p>")
				api.cms_api.append_cms_link_to_html (api.cms_api.local_link ("Back to your account page", {CMS_AUTHENTICATION_MODULE}.roc_account_location), Void, s)
				s.append ("</p>")
				r.set_main_content (s)
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api.cms_api)
				r.add_error_message ("No user connected!")
			end
			r.execute
		end

	on_dissociate (req: WSF_REQUEST; res: WSF_RESPONSE; api: LOGIN_WITH_ESA_API)
		local
			r: CMS_RESPONSE
			f: CMS_FORM
			sub: WSF_FORM_SUBMIT_INPUT
			s: STRING_8
		do
			create s.make_empty
			s.append ("<h1>Account eiffel.com association</h1>")

			if
				attached api.cms_api.user as u and then
				attached api.esa_account_for_user (u) as l_esa_account
			then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api.cms_api)
				create f.make (req.percent_encoded_path_info, "dissociate-form")
				f.set_method_post
				f.extend_html_text ("<p>The account " + html_encoded (api.cms_api.real_user_display_name (u))
						+ " will be dissociated from eiffel.com account.</p>")
				create sub.make_with_text ("confirm", "Confirm")
				f.extend (sub)
				if req.is_post_request_method then
					f.process (r)
					if
						attached f.last_data as fd and then not fd.has_error and then
						attached fd.string_item ("confirm") as s_confirm and then s_confirm.same_string ("Confirm")
					then
						api.dissociate_esa_account (u, l_esa_account)
						if api.esa_account_for_user (u) = Void then
							s.append ("<p>Account " + html_encoded (api.cms_api.real_user_display_name (u)) + " was dissociated from eiffel.com account.</p>")
						else
							s.append ("<p class=%"error%"><strong>ERROR</strong>: it was not possible to dissociate account " + html_encoded (api.cms_api.real_user_display_name (u)) + " from eiffel.com account (Please contact the webmaster).</p>")
						end
					else
						f.append_to_html (r.wsf_theme, s)
					end
				else
					f.append_to_html (r.wsf_theme, s)
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api.cms_api)
				r.add_error_message ("Can not find eiffel.com association!")
			end
			s.append ("<p>")
			api.cms_api.append_cms_link_to_html (api.cms_api.local_link ("Back to your account page", {CMS_AUTHENTICATION_MODULE}.roc_account_location), Void, s)
			s.append ("</p>")
			r.set_main_content (s)

			r.execute
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached login_with_esa_api as l_esa_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {LOGIN_WITH_ESA_FILTER}.make (a_api, l_esa_api))
			end
		end

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			Precursor (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"account">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("account") and then
				a_response.location.same_string ({CMS_AUTHENTICATION_MODULE}.roc_account_location)
			then
				if
					attached smarty_template_block (Current, "account_info", a_response.api) as l_tpl_block and then
					attached a_response.user as l_user
				then
					associate_account (l_user, a_response.values)
					l_tpl_block.set_weight (5)
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [resources_page]")
					end
				end
			end
		end

	associate_account (a_user: CMS_USER; a_value: CMS_VALUE_TABLE)
		local
			l_associated: LIST [STRING]
			l_not_associated: LIST [STRING]
		do
			if attached login_with_esa_api as l_api then
				if  attached l_api.esa_account_for_user (a_user) as l_acc then
					a_value.force (l_acc.username, "esa_name")
					a_value.force (l_acc.email, "esa_email")
				end
				a_value.force (associate_location, "esa_associate_location")
				a_value.force (dissociate_location, "esa_dissociate_location")
			end
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if not a_response.api.user_is_authenticated then
				create lnk.make ("Register", "/" + register_location)
				lnk.set_weight (99)
				a_menu_system.primary_menu.extend (lnk)
			end
		end

end
