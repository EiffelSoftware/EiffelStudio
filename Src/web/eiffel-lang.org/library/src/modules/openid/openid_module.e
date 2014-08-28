note
	description: "Summary description for {OPENID_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPENID_MODULE

inherit
	CMS_MODULE

	CMS_HOOK_MENU_ALTER

	CMS_HOOK_FORM_ALTER

	CMS_HOOK_AUTO_REGISTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "openid"
			version := "1.0"
			description := "OpenID login support"
			package := "server"
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		do
			a_service.map_uri ("/openid/login", agent handle_login)

			a_service.add_menu_alter_hook (Current)
			service := a_service
		end

feature -- Hooks

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		local
			lnk: CMS_LOCAL_LINK
			req: WSF_REQUEST
		do
			req := a_execution.request
			if req.path_info.starts_with ("/user") then
				if a_execution.authenticated then
					create lnk.make ("Openid identities", "/openid/login")
				else
					create lnk.make ("Login with Openid", "/openid/login")
				end
	--			a_menu_system.management_menu.extend (lnk)
				a_menu_system.primary_tabs.extend (lnk)
			end
		end

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_execution: CMS_EXECUTION)
		local
			i: WSF_FORM_DIV
			fh: WSF_FORM_HIDDEN_INPUT
		do
			if a_form.id.same_string ("openid-login") then
				create i.make_with_text_and_css_id (
					"Login with " + a_execution.link ("OpenID", "/openid/login", Void)
							+ " , " + a_execution.link ("Google", "/openid/login?openid=https://www.google.com/accounts/o8/id", Void)
							+ " , " + a_execution.link ("Yahoo", "/openid/login?openid=https://me.yahoo.com/", Void)
							,
					"openid"
					)
				a_form.extend (i)
			elseif a_form.id.same_string ("user-login") then
				create i.make_with_text_and_css_id (
					"Login with " + a_execution.link ("OpenID", "/openid/login", Void)
							+ " , " + a_execution.link ("Google", "/openid/login?openid=https://www.google.com/accounts/o8/id", Void)
							+ " , " + a_execution.link ("Yahoo", "/openid/login?openid=https://me.yahoo.com/", Void)
							,
					"openid"
					)
				if attached a_form.items_by_type ({WSF_WIDGET_TEXT}) as lst and then not lst.is_empty then
					a_form.insert_before (i, lst.last)
				else
					a_form.extend (i)
				end
			elseif a_form.id.same_string ("user-register") then
				if attached {READABLE_STRING_GENERAL} a_execution.session_item ("openid.identity") as l_openid_identity then
					create fh.make_with_text ("openid-identity", l_openid_identity.to_string_32)
					a_execution.remove_session_item ("openid.identity")
					a_form.extend (fh)
					a_form.extend_html_text ("The new account will be associated with OpenID %""+ a_execution.html_encoded (l_openid_identity) +"%"")
					if attached {READABLE_STRING_GENERAL} a_execution.session_item ("openid.nickname") as l_openid_nickname then
						if attached a_form.fields_by_name ("username") as f_lst then
							across
								f_lst as c
							loop
								if attached {WSF_FORM_TEXT_INPUT} c.item as txt then
									txt.set_text_value (l_openid_nickname.to_string_32)
								end
							end
						end
						a_execution.remove_session_item ("openid.nickname")
					end
					if attached {READABLE_STRING_GENERAL} a_execution.session_item ("openid.email") as l_openid_email then
						if attached a_form.fields_by_name ("email") as f_lst then
							across
								f_lst as c
							loop
								if attached {WSF_FORM_TEXT_INPUT} c.item as txt then
									txt.set_text_value (l_openid_email.to_string_32)
								end
							end
						end
						a_execution.remove_session_item ("openid.email")
					end
					a_form.submit_actions.extend (agent openid_user_register_submitted)
				end
			end
		end

	openid_user_register_submitted (a_form_data: WSF_FORM_DATA)
		do

		end

feature -- Access

	handle_login (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached service as l_service then
				(create {OPENID_CMS_EXECUTION}.make (req, res, l_service)).execute
			else
				res.set_status_code ({HTTP_STATUS_CODE}.expectation_failed)
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
