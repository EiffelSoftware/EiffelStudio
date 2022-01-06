note
	description: "Summary description for {CMS_ADMIN_USER_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_USER_VIEW_RESPONSE

inherit
	CMS_RESPONSE

create
	make

feature -- Query

	user_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- User id passed as path parameter for request `req'.
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Execution

	process
			-- Computed response message.
		local
			uid: INTEGER_64
			user_api : CMS_USER_API
		do
			user_api := api.user_api
			uid := user_id_path_parameter (request)
			if uid > 0 and then attached user_api.user_by_id (uid) as l_user then
				append_html_to_output (l_user, Current)
			else
				set_main_content ("Missing User")
			end
		end

	append_html_to_output (a_user: CMS_USER; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
			s: STRING
			l_role: CMS_USER_ROLE
			ago: DATE_TIME_AGO_CONVERTER
			f: CMS_FORM
		do
			a_response.set_value (a_user, "user")
			lnk := api.administration_link (a_response.translation ("View", Void), "user/" + a_user.id.out)
			lnk.set_is_active (True)
			lnk.set_weight (1)
			a_response.add_to_primary_tabs (lnk)
			lnk := api.administration_link (a_response.translation ("Edit", Void), "user/" + a_user.id.out  + "/edit")
			lnk.set_permission_arguments (<<"manage admin", "manage users", "manage own user">>)
			lnk.set_weight (2)
			a_response.add_to_primary_tabs (lnk)


			if a_user /= Void and then a_user.id > 0 then
				lnk := api.administration_link (a_response.translation ("Delete", Void), "user/" + a_user.id.out  + "/delete")
				lnk.set_weight (3)
				a_response.add_to_primary_tabs (lnk)
			end

			lnk := api.administration_link (a_response.translation ("<< Users", Void), "users")
			lnk.set_weight (10)
			a_response.add_to_primary_tabs (lnk)


				-- FIXME: [04/aug/2015] use a CMS_FORM rather than hardcoded html.
				-- So that other module may easily integrate them-selves to add information.
			create s.make_empty
			s.append ("<div class=%"info%"> ")
			s.append ("<h4>Account Information</h4>")
			s.append ("<p>Username: ")
			s.append (html_encoded (a_user.name))
			s.append ("</p>")
			if attached a_user.email as l_email then
				s.append ("<p>Email: ")
				s.append (l_email)
				s.append ("</p>")
			end
			if attached a_user.profile_name as l_prof_name then
				s.append ("<p>Profile name: ")
				s.append (html_encoded (l_prof_name))
				s.append ("</p>")
			end
			if attached a_user.last_login_date as dt then
				s.append ("<p>Last signed: ")
				create ago.make
				s.append (ago.smart_date_duration (dt))
				s.append ("</p>")
			end

			if
				attached {LIST [CMS_USER_ROLE]} api.user_api.user_roles (a_user) as l_roles and then
			   	not l_roles.is_empty
			then
				s.append ("<h4>Role(s):</h4>")
				s.append ("<ul class=%"user-roles%">")
				across l_roles as ic loop
					l_role := ic.item
					s.append ("<li>")
					s.append (link (l_role.name, api.administration_path_location ("role/" + l_role.id.out), Void))
					s.append ("</li>")
					if request.query_parameter ("debug") /= Void then
						s.append ("<h5>Permissions:</h5>")
						s.append ("<ul class=%"cms-permissions%">%N")
						across l_role.permissions as perms_ic loop
							s.append ("<li class=%"cms-permission%">" + perms_ic.item + "</li>%N")
						end
						s.append ("</ul>%N")
					end
				end
				s.append ("</ul>%N")
			end
			s.append ("</div>")
			create f.make (a_response.request.percent_encoded_path_info, {CMS_ADMIN_MODULE_ADMINISTRATION}.form_admin_user_view_id)
			f.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text ("user-id", a_user.id.out))
			api.hooks.invoke_form_alter (f, Void, Current)
			f.append_to_html (wsf_theme, s)
			a_response.set_title (a_user.name)
			a_response.set_main_content (s)
		end

end
