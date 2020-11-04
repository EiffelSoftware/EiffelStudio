note
	description: "Summary description for {CMS_AUTHENTICATION_MODULE_ADMINISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_AUTHENTICATION_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_LOGGER

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin registration")
			Result.force ("account activate")
			Result.force ("account reject")
			Result.force ("account reactivate")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/" + pending_registrations_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_pending_registrations (?, ?, a_api)), a_router.methods_get)

			if attached module.auth_api as l_auth_api then
				a_router.handle ("/" + activate_user_location + "{token}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_activation (l_auth_api, ?, ?)), a_router.methods_head_get_post)
				a_router.handle ("/" + reject_user_location + "{token}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_reject (l_auth_api, ?, ?)), a_router.methods_head_get_post)
				a_router.handle ("/" + reactivate_user_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_reactivation (l_auth_api, ?, ?)), a_router.methods_get_post)
			end
		end

	pending_registrations_location: STRING = "pending-registrations/"

	activate_user_location: STRING = "account/activate/"
	reject_user_location: STRING = "account/reject/"
	reactivate_user_location: STRING = "account/reactivate"

feature -- Request handling

	handle_admin_pending_registrations (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			l_response: CMS_RESPONSE
			s: STRING
			u: CMS_TEMP_USER
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: INTEGER
			l_user_api: CMS_USER_API
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			if
				api.has_permission ("admin registration")
			then
				l_user_api := api.user_api

				l_count := l_user_api.temp_users_count

				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				create s.make_empty
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " pending Registrations")
				else
					l_response.set_title ("Listing " + l_count.out + " pending Registration")
				end

				create s_pager.make_empty
				create l_page_helper.make (api.administration_path_location (pending_registrations_location + "?page={page}&size={size}"), l_user_api.temp_users_count.as_natural_64, 25) -- FIXME: Make this default page size a global CMS settings
				l_page_helper.get_setting_from_request (req)
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (l_response, s_pager)
					if l_page_helper.page_size > 25 then
						s.append (s_pager)
					end
				end

				if attached l_user_api.temp_recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size)) as lst then
					s.append ("<ul class=%"cms-temp-users%">%N")
					across
						lst as ic
					loop
						u := ic.item
						s.append ("<li class=%"cms_temp_user%">")
						s.append ("User:" + html_encoded (u.name))
						s.append ("<ul class=%"cms_temp_user_details%">")
						if attached u.email as l_email then
							s.append ("<li class=%"cms_temp_user_detail_email%">Email: ")
							s.append (l_email)
							s.append ("</li>%N")
						end
						if attached u.creation_date as dt then
							s.append ("<li class=%"cms_temp_user_detail_date%">Date: ")
							s.append (api.date_time_to_string (dt))
							s.append ("</li>%N")
						end
						if attached u.personal_information as l_information then
							s.append ("<li class=%"cms_temp_user_detail_information%">Information: <em>")
							s.append (html_encoded (l_information))
							s.append ("</em></li>%N")
						end
						if attached l_user_api.token_by_temp_user_id (u.id) as l_token then
							s.append ("<li>")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url (api.administration_path ("/" + activate_user_location + l_token)))

							s.append ("%">")
							s.append (html_encoded ("Activate"))
							s.append ("</a>")
							s.append (" or <a href=%"")
							s.append (req.absolute_script_url (api.administration_path ("/" + reject_user_location + l_token)))
							s.append ("%">")
							s.append (html_encoded ("Reject"))
							s.append ("</a>")
							s.append ("</li>%N")
						end
						s.append ("</ul>%N")
						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end
					-- Again the pager at the bottom, if needed
				s.append (s_pager)

				l_response.set_main_content (s)
				l_response.execute
			else
				api.response_api.send_access_denied (Void, req, res)
			end
		end

	handle_activation (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			f_submit: WSF_FORM_SUBMIT_INPUT
			l_user_api: CMS_USER_API
		do
			if a_auth_api.cms_api.has_permission ("account activate") then
				if attached {WSF_STRING} req.path_parameter ("token") as l_token then
					l_user_api := a_auth_api.cms_api.user_api
					if attached {CMS_TEMP_USER} l_user_api.temp_user_by_activation_token (l_token.value) as l_temp_user then
						if req.is_post_request_method then
							create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
							a_auth_api.activate_user (l_temp_user, l_token.value)
							if
								not a_auth_api.has_error and then
								attached l_user_api.user_by_name (l_temp_user.name) as l_new_user
							then
								r.set_main_content ("<p> The account <i>" + a_auth_api.cms_api.user_html_link (l_new_user) + "</i> has been activated</p>")
							else
									-- Failure!!!
								r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
								r.set_main_content ("<p>ERROR: User activation failed for <i>" + html_encoded (l_temp_user.name) + "</i>!</p>")
								if attached l_user_api.error_handler.as_single_error as err then
									r.add_error_message (html_encoded (err.string_representation))
								end
							end
						else
							create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
							create f.make (req.percent_encoded_path_info, "activate-temp-user")
							f.set_method_post
							f.extend_html_text ("<p>Activation of user " + html_encoded (a_auth_api.cms_api.user_display_name (l_temp_user)))
							if attached l_temp_user.email as l_email then
								f.extend_html_text (" (email: " + html_encoded (l_email) + ")")
							end
							f.extend_html_text (" .</p>")
							if attached l_temp_user.personal_information as l_perso_info then
								f.extend_html_text ("<p>Information:<br/><blockquote>" + html_encoded (l_perso_info) + "</blockquote></p>%N")
							end
							f.extend_html_text ("<br/>")
							create f_submit.make_with_text ("Activate", "Activate")
							f.extend (f_submit)
							create s.make_empty
							f.append_to_html (r.wsf_theme, s)
							r.set_main_content (s)
							r.set_title ("Approve user")
						end
						r.add_to_primary_tabs (a_auth_api.cms_api.local_link ("Registration", a_auth_api.cms_api.administration_path_location (pending_registrations_location)))
						r.execute
					else
							-- the token does not exist, or it was already used.
						a_auth_api.cms_api.response_api.send_bad_request ("<p>The activation token <i>" + html_encoded (l_token.value) + "</i> is not valid " + a_auth_api.cms_api.link ("Reactivate Account", "account/reactivate", Void) + "</p>", req, res)
					end
				else
					a_auth_api.cms_api.response_api.send_bad_request ("Missing required token value", req, res)
				end
			else
				a_auth_api.cms_api.response_api.send_access_denied (Void, req, res)
			end
		end

	handle_reject (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_ir: INTERNAL_SERVER_ERROR_CMS_RESPONSE
			l_user_api: CMS_USER_API
			f: CMS_FORM
			f_submit: WSF_FORM_SUBMIT_INPUT
			l_reason: detachable READABLE_STRING_GENERAL
			tf: WSF_FORM_TEXT_INPUT
			s: STRING_8
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
			if r.has_permission ("account reject") then
				if attached {WSF_STRING} req.path_parameter ("token") as l_token then
					l_user_api := a_auth_api.cms_api.user_api
					if attached {CMS_TEMP_USER} l_user_api.temp_user_by_activation_token (l_token.value) as l_temp_user then
						if req.is_post_request_method then
							l_user_api.delete_temp_user (l_temp_user)
							r.set_main_content ("<p> The temporal account for <i>" + html_encoded (l_temp_user.name) + "</i> has been removed</p>")
								-- Send Email
							if attached {WSF_STRING} req.form_parameter ("reason") as p_reason then
								l_reason := p_reason.value
							end
							if attached l_temp_user.email as l_email then
								create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (a_auth_api.cms_api))
								write_debug_log (generator + ".handle register: send_contact_activation_reject_email")
								es.send_contact_activation_reject_email (l_email, l_temp_user, req.absolute_script_url (""), l_reason)
							end
						else
							create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
							r.set_title ("User rejection")
							create f.make (req.percent_encoded_path_info, "reject-temp-user")
							f.set_method_post
							f.extend_html_text ("<p>Rejection of user " + html_encoded (a_auth_api.cms_api.user_display_name (l_temp_user)))
							if attached l_temp_user.email as l_email then
								f.extend_html_text (" (email: " + html_encoded (l_email) + ")")
							end
							f.extend_html_text (" .</p>")
							if attached l_temp_user.personal_information as l_perso_info then
								f.extend_html_text ("<p>Information:<br/><blockquote>" + html_encoded (l_perso_info) + "</blockquote></p>%N")
							end

							create tf.make ("reason")
							tf.set_placeholder ("Reason to decline...")
							f.extend (tf)
							create f_submit.make_with_text ("Reject", "Reject")
							f.extend_html_text ("<br/>")
							f.extend (f_submit)
							create s.make_empty
							f.append_to_html (r.wsf_theme, s)
							r.set_main_content (s)
							r.set_title ("Reject user")
						end
						r.add_to_primary_tabs (a_auth_api.cms_api.local_link ("Registration", a_auth_api.cms_api.administration_path_location ("pending-registrations")))
						r.execute
					else
							-- the token does not exist, or it was already used.
						a_auth_api.cms_api.response_api.send_bad_request ("<p>The activation token <i>" + html_encoded (l_token.value) + "</i> is not valid " + a_auth_api.cms_api.link ("Reactivate Account", "account/reactivate", Void) + "</p>", req, res)

					end
				else
					create l_ir.make (req, res, a_auth_api.cms_api)
					l_ir.execute
				end
			else
				a_auth_api.cms_api.response_api.send_access_denied (Void, req, res)
			end
		end

	handle_reactivation (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_user_api: CMS_USER_API
			l_token: STRING
			l_url_activate: STRING
			l_url_reject: STRING
			l_email: READABLE_STRING_8
		do
			if a_auth_api.cms_api.has_permission ("account reactivate") then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
				if req.is_post_request_method then
					if attached {WSF_STRING} req.form_parameter ("email") as p_email then
						if p_email.value.is_valid_as_string_8 then
							l_email := p_email.value.to_string_8
							l_user_api := a_auth_api.cms_api.user_api
							if attached {CMS_TEMP_USER} l_user_api.temp_user_by_email (l_email) as l_user then
									-- User exist create a new token and send a new email.
								if l_user.is_active then
									r.set_value ("The asociated user to the given email " + l_email + " , is already active", "is_active")
									r.set_status_code ({HTTP_CONSTANTS}.bad_request)
								else
									l_token := a_auth_api.new_token
									l_user_api.new_activation (l_token, l_user.id)
									l_url_activate := req.absolute_script_url (a_auth_api.cms_api.administration_path ("/" + activate_user_location + l_token))
									l_url_reject := req.absolute_script_url (a_auth_api.cms_api.administration_path ("/" + reject_user_location + l_token))
											-- Send Email to webmaster
									if attached l_user.personal_information as l_personal_information then
										create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (a_auth_api.cms_api))
										write_debug_log (generator + ".handle register: send_register_email")
										es.send_admin_account_evaluation (l_user, l_personal_information, l_url_activate, l_url_reject, req.absolute_script_url (""))
									end
								end
							else
								r.set_value ("The email does not exist !", "error_email")
								r.set_value (l_email, "email")
								r.set_status_code ({HTTP_CONSTANTS}.bad_request)
							end
						else
							r.set_value ("The email is not valid!", "error_email")
							r.set_value (p_email.value, "email")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						end
					end
				end
				r.execute
			else
				a_auth_api.cms_api.response_api.send_access_denied (Void, req, res)
			end
		end


feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)

			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (module)
			a_hooks.subscribe_to_value_table_alter_hook (module)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
				 -- Add the link to the taxonomy to the main menu
			if a_response.has_permission ("admin registration") then
				create lnk.make ("User registrations", a_response.api.administration_path_location (pending_registrations_location))
				a_menu_system.management_menu.extend_into (lnk, "Admin", a_response.api.administration_path_location (""))
			end
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			if a_response.is_administration_mode then
				a_response.add_style (a_response.module_resource_url (Current, "/files/css/admin_auth.css", Void), Void)
			end
		end

end
