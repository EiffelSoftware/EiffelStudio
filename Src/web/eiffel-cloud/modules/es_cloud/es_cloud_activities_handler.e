note
	description: "Summary description for {ES_CLOUD_ACTIVITIES_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ACTIVITIES_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod_api: ES_CLOUD_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				process_get (req, res)
--			elseif req.is_post_request_method then
			else
				send_bad_request (req, res)
			end
		end

	process_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_user: ES_CLOUD_USER
			r: like new_generic_response
			s: STRING
			l_session: detachable ES_CLOUD_SESSION
			l_sessions: detachable LIST [ES_CLOUD_SESSION]
			inst: ES_CLOUD_INSTALLATION
			l_display_all: BOOLEAN
			k: READABLE_STRING_32
			ago: DATE_TIME_AGO_CONVERTER
			l_can_be_deleted: BOOLEAN
			l_license: detachable ES_CLOUD_LICENSE
			l_installations: LIST [ES_CLOUD_INSTALLATION]
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("EiffelStudio account")
			s := ""

			create ago.make

			if attached api.user as u then
				create l_user.make (u)
				s.append ("<p class=%"es-message%">User "+ api.html_encoded (api.real_user_display_name (u)) +"</p>")
					-- Plan
					-- Installation ...
				s.append ("<div class=%"es-installations%">")
				l_display_all := attached req.query_parameter ("display") as d and then d.is_case_insensitive_equal ("all")
				if attached {WSF_STRING} req.path_parameter ("license_key") as p_license_key then
					l_license := es_cloud_api.license_by_key (p_license_key.value)
					if l_license /= Void then
						l_installations := es_cloud_api.license_installations (l_license)
					end
				else
					l_installations := es_cloud_api.user_installations (l_user)
				end
				if
					l_installations /= Void and then
					not l_installations.is_empty
				then
					if l_license /= Void then
						s.append ("<p>EiffelStudio license " + html_encoded (l_license.key) + " is installed on " + l_installations.count.out + " devices: ")
					else
						s.append ("<p>EiffelStudio is installed on " + l_installations.count.out + " devices: ")
					end
					if l_display_all then
						s.append ("<a class=%"note%" href=%"" + req.percent_encoded_path_info + "%">only active sessions</a>")
					else
						s.append ("<a class=%"note%" href=%"" + req.percent_encoded_path_info +"?display=all%">include ended or expired</a>")
					end
					s.append ("<ul>")
					across
						l_installations as ic
					loop
						inst := ic.item
						l_sessions := es_cloud_api.user_sessions (l_user, inst.id, not l_display_all)
						s.append ("<li class=%"es-installation")
						-- FIXME: [2019-10-10]
						l_can_be_deleted := True
						if l_sessions = Void then
							s.append (" never")
						elseif across l_sessions as sess_ic all sess_ic.item.is_ended end then
							s.append (" closed")
						elseif across l_sessions as sess_ic all sess_ic.item.is_expired (es_cloud_api) end then
							s.append (" expired")
						elseif across l_sessions as sess_ic some not sess_ic.item.is_paused end then
							s.append (" active")
							l_can_be_deleted := False
						else
							s.append (" paused")
							l_can_be_deleted := False
						end
						if l_can_be_deleted and then api.has_permission ({ES_CLOUD_MODULE}.perm_discard_own_installations) then
							s.append (" discardable%" data-user-id=%""+ l_user.id.out +"%" data-installation-id=%""+ url_encoded (inst.id) +"%">")
						else
							s.append ("%">")
						end
						s.append (html_encoded (inst.id))
						if attached inst.creation_date as l_creation_date then
							s.append (" <span class=%"creation%" title=%"" + date_time_to_string (l_creation_date) + "%">")
							ago.append_date_to ("", l_creation_date, s)
--							s.append (date_time_to_string (l_creation_date))
							s.append ("</span>")
						end
						if l_sessions /= Void and then not l_sessions.is_empty then
							s.append ("<ul>")
							across
								l_sessions as sess_ic
							loop
								l_session := sess_ic.item
								if l_display_all or not (l_session.is_ended or l_session.is_expired (es_cloud_api)) then
									s.append ("<li class=%"session")
									if l_session.is_paused then
										k := "paused"
										s.append (" paused")
									elseif l_session.is_ended then
										k := "closed"
										s.append (" closed")
									elseif l_session.is_expired (es_cloud_api) then
										k := "expired"
										s.append (" expired")
									else
										k := "active"
										s.append (" active")
									end
									s.append ("%"")
									s.append (" data-session-id=%"" + html_encoded (l_session.id) + "%"")
									s.append (">")
									if attached l_session.title as l_session_title then
										s.append (html_encoded (l_session_title))
									else
										s.append (html_encoded (l_session.id))
									end
									s.append (" <em>")
									s.append (html_encoded (k))
									s.append ("</em>")

									s.append (" <span class=%"creation datetime_ago%" datetime=%""+ date_time_to_timestamp_string (l_session.first_date) +"%" title=%"" + date_time_to_string (l_session.first_date) + "%">")
									ago.append_date_to ("", l_session.first_date, s)
--									s.append (date_time_to_string (l_session.first_date))
									s.append ("</span>")
									s.append (" <span class=%"access datetime_ago%" datetime=%""+ date_time_to_timestamp_string (l_session.last_date) +"%" title=%"" + date_time_to_string (l_session.last_date) + "%">")
									ago.append_date_to ("", l_session.last_date, s)
--									s.append (date_time_to_string (l_session.last_date))
									s.append ("</span>")
									s.append ("</li>")
								end
							end
							s.append ("</ul>")
						end
						s.append ("</li>%N")
					end

					s.append ("</ul></p>")
				else
					if l_license /= Void then
						s.append ("<p>EiffelStudio license " + html_encoded (l_license.key) + " is not yet installed.</p>")
					else
						s.append ("<p>EiffelStudio is not yet installed.</p>")
					end
				end
				s.append ("</div>")
			else
				s.append ("<p>Please Login or Register...</p>")
			end
			r.set_main_content (s)
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

