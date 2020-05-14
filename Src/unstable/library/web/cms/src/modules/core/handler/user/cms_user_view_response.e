note
	description: "Summary description for {CMS_USER_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_VIEW_RESPONSE

inherit
	CMS_RESPONSE

create
	make_with_user

feature {NONE} -- Initialization

	make_with_user (u: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api)
		do
			make (req, res, a_api)
			associated_user := u
		end

feature -- Access

	associated_user: CMS_USER

feature -- Query

	user_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- User id passed as path parameter for request `req'.
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("uid") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Process

	process
			-- Computed response message.
		local
			b: STRING_8
			f: CMS_FORM
		do
			create b.make_empty
			if
				attached associated_user as l_user
			then
				if
					api.has_permission ("view users")
					or l_user.same_as (user) -- Same user
				then
					f := new_view_form (l_user, request.request_uri, "view-user")
					api.hooks.invoke_form_alter (f, Void, Current)
					f.append_to_html (wsf_theme, b)
				else
					b.append ("You don't have the permission to view this user!")
				end
			else
				b.append ("User not found!")
			end
			set_main_content (b)
		end

feature -- Process Edit

	view_user_form_id: STRING = "view-user"

	new_view_form (a_user: detachable CMS_USER; a_url: READABLE_STRING_8; a_name: STRING): CMS_FORM
			-- Create a web form named `a_name' for user `a_user' (if set), using form action url `a_url'.
		local
			th: WSF_FORM_HIDDEN_INPUT
		do
			create Result.make (a_url, a_name)
			create th.make ("user-id")
			if a_user /= Void then
				th.set_text_value (a_user.id.out)
			else
				th.set_text_value ("0")
			end
			Result.extend (th)

			populate_form (Result, a_user)
		end

	populate_form (a_form: CMS_FORM; a_user: detachable CMS_USER)
			-- Fill the web form `a_form' with data from `a_node' if set,
			-- and apply this to content type `a_content_type'.
		local
			ti: WSF_FORM_TEXT_INPUT
			fs: WSF_FORM_FIELD_SET
			l_new_access_token_form: WSF_FORM
			l_access_token: detachable READABLE_STRING_32
		do
			if a_user /= Void then
				create fs.make
				fs.set_legend ("User Information")
				if not a_user.same_as (api.user) and then api.has_permission ("admin users") then
					fs.extend_html_text ("<p>Administration: <a href=%"" + api.administration_path ("user/" + a_user.id.out) + "%">manage user " + html_encoded (api.real_user_display_name (a_user)) + "</a> ...</p>%N")
				end
				create ti.make_with_text ("profile_name", a_user.name)
				if attached a_user.profile_name as l_profile_name then
					ti.set_text_value (l_profile_name)
				end
				ti.set_label ("Profile name")
				ti.set_is_readonly (True)
				fs.extend (ti)
				a_form.extend (fs)
				if api.setup.webapi_enabled then
					create fs.make
					fs.set_legend ("Web API")
					l_access_token := api.user_api.user_profile_item ("access_token", a_user)
					if l_access_token /= Void then
						create ti.make_with_text ("api_access_token", a_user.name)
						ti.set_text_value (l_access_token)
						ti.set_label ("Access Token")
						ti.set_is_readonly (True)
						fs.extend (ti)
					end
					if api.user_has_permission (a_user, "use access_token") then
						create l_new_access_token_form.make (api.webapi_path ("access_token"), Void)
						l_new_access_token_form.set_method_post
						if l_access_token /= Void then
							l_new_access_token_form.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("access_token_op", "Refresh Access Token"))
						else
							l_new_access_token_form.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("access_token_op", "Create Access Token"))
						end
						l_new_access_token_form.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text ("destination", request.percent_encoded_path_info))
						a_form.put_widget_after_form (l_new_access_token_form)
						a_form.extend (fs)
					end
				end
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
