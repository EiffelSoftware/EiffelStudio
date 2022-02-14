note
	description: "Summary description for {CMS_USERS_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USERS_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				execute_get (req, res)
			elseif req.is_post_request_method then
				execute_post (req, res)
			else
				new_bad_request_error_response (Void, req, res).execute
			end
		end

	execute_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_user: detachable CMS_USER
			l_params: CMS_DATA_QUERY_PARAMETERS
			tb: STRING_TABLE [detachable ANY]
			arr: ARRAYED_LIST [STRING_TABLE [detachable ANY]]
			l_full: BOOLEAN
			nb: INTEGER
		do
			if api.has_permissions (<<{CMS_CORE_MODULE_WEBAPI}.perm_admin_users, {CMS_CORE_MODULE_WEBAPI}.perm_view_users>>) then
				if attached req.query_parameter ("full") as p and then p.is_case_insensitive_equal ("yes") then
					l_full := True
				end
				rep := new_response (req, res)
				nb := api.user_api.users_count
				rep.add_integer_64_field ("users_count", nb)
				create l_params.make (0, nb.to_natural_32)
				create arr.make (nb)
				across
					api.user_api.recent_users (l_params) as ic
				loop
					l_user := ic.item
					create tb.make_caseless (5)
					tb.force (api.webapi_path ("user/" + l_user.id.out), "href")
					tb.force (l_user.id.out, "uid")
					tb.force (l_user.name, "name")
					if attached l_user.profile_name as pn then
						tb.force (pn, "profile_name")
					end
					if not l_user.is_active then
						tb.force (False, "is_active")
					end
					if l_full then
						if l_user.has_email then
							tb.force (l_user.email, "email")
						end
						if attached l_user.creation_date as dt then
							tb.force (date_time_to_string (dt), "creation_date")
						end
						if attached l_user.last_login_date as dt then
							tb.force (date_time_to_string (dt), "last_login_date")
						end
					end
					arr.force (tb)
				end
				rep.add_iterator_field ("users", arr)
				rep.add_self (req.percent_encoded_path_info)
			else
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end

	execute_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_user: detachable CMS_USER
			f: WSF_FORM
			tf: WSF_FORM_TEXT_INPUT
			err: STRING_32
		do
			if api.has_permission ({CMS_CORE_MODULE_WEBAPI}.perm_admin_users) then
				create f.make (req.percent_encoded_path_info, "new-user")
				create tf.make ("username"); f.extend (tf)
				create tf.make ("password"); f.extend (tf)
				create tf.make ("email"); f.extend (tf)
				create tf.make ("profile_name"); f.extend (tf)

				f.process (req, Void, Void)
				if attached f.last_data as fd then
					create err.make_empty
					if not fd.has_error and then attached fd.string_item ("username") as l_name then
						if api.user_api.user_by_id_or_name (l_name) /= Void then
							err.append ("Username already used!%N")
							fd.report_invalid_field ("username", "Username already used!")
						else
							create l_user.make (l_name)
							if attached fd.string_item ("password") as l_passwd then
								l_user.set_password (l_passwd)
							else
								err.append ("Missing password!%N")
								fd.report_invalid_field ("username", "Missing password!")
							end
							if attached fd.string_item ("email") as l_email then
								if l_email.is_valid_as_string_8 then
									l_user.set_email (l_email.to_string_8)
								else
									err.append ("Invalid email address!%N")
								end
							end
							if attached fd.string_item ("profile_name") as l_profile_name then
								l_user.set_profile_name (l_profile_name)
							end
						end
					end
					if fd.has_error then
							-- Error !
						if attached fd.errors as lst then
							create err.make_empty
							across
								lst as ic
							loop
								if attached ic.item.field as l_field then
									err.append_string_general (l_field.name + ": ")
								end
								if attached ic.item.message as msg then
									err.append_string_general (msg)
								end
							end
						else
								-- Keep `err`.
						end
					elseif l_user = Void then
						err := "Invalid new user request!"
					else
						err := Void
						l_user.mark_active
						api.user_api.new_user (l_user)
						if api.user_api.has_error then
							err := "Could not create user!"
						end
					end
				end
				if l_user = Void or else err /= Void then
					rep := new_error_response (err, req, res)
				else
					rep := new_response (req, res)
					rep.add_string_field ("uid", l_user.id.out)
					add_user_links_to (l_user, rep)
				end
				rep.add_self (req.percent_encoded_path_info)
			else
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end


note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
