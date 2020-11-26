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
			l_active_user, l_license_user, l_user: ES_CLOUD_USER
			r: like new_generic_response
			s: STRING
			l_session: detachable ES_CLOUD_SESSION
			l_sessions: detachable LIST [ES_CLOUD_SESSION]
			inst: ES_CLOUD_INSTALLATION
			l_display_all: BOOLEAN
			ago: DATE_TIME_AGO_CONVERTER
			l_can_be_deleted: BOOLEAN
			l_license: detachable ES_CLOUD_LICENSE
			l_installations: LIST [ES_CLOUD_INSTALLATION]
			l_hide_sessions, l_own_data: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("Activity")
			s := ""

			create ago.make

			if attached api.user as u then
				create l_active_user.make (u)
			end
			if attached {WSF_STRING} req.path_parameter ("license_key") as p_license_key then
				l_license := es_cloud_api.license_by_key (p_license_key.value)
				if l_license /= Void then
					l_license_user := es_cloud_api.user_for_license (l_license)
					l_user := l_license_user
					if l_license_user /= Void and l_active_user /= Void then
						l_own_data := l_license_user.same_as (l_active_user)
					end
				end
			else
				l_user := l_active_user
				l_own_data := l_active_user /= Void
			end

			if api.has_permission ({ES_CLOUD_MODULE}.perm_view_any_es_activities) or l_own_data then
				if l_license /= Void then
					s.append ("<p class=%"es-message%">License <strong>" + html_encoded (l_license.plan.title_or_name) + "</strong> "+ api.html_encoded (l_license.key))
					if l_license_user /= Void then
						s.append ("<br/>(account "+ api.html_encoded (api.real_user_display_name (l_license_user)) + ")")
					end
					s.append ("</p>")
					l_installations := es_cloud_api.license_installations (l_license)
				elseif l_active_user /= Void then
					s.append ("<p class=%"es-message%">Account "+ api.html_encoded (api.real_user_display_name (l_active_user)) +"</p>")
					l_installations := es_cloud_api.user_installations (l_active_user)
				end
					-- Plan
					-- Installation ...
				s.append ("<div class=%"es-installations%">")
				l_display_all := attached req.query_parameter ("display") as d and then d.is_case_insensitive_equal ("all")
				if
					l_user /= Void and then
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
						l_session := Void
						if api.has_permission ({ES_CLOUD_MODULE}.perm_view_es_sessions) then
							l_sessions := es_cloud_api.user_sessions (l_user, inst.id, not l_display_all)
							l_hide_sessions := False
						else
							l_hide_sessions := True
							l_session := es_cloud_api.last_user_session (l_user, inst)
						end
						l_can_be_deleted := not l_hide_sessions

						s.append ("<li class=%"es-installation")
						-- FIXME: [2019-10-10]

						if l_session = Void or l_sessions = Void then
							s.append (" never")
						elseif not l_hide_sessions and l_sessions /= Void then
							if across l_sessions as sess_ic all sess_ic.item.is_ended end then
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
						if l_hide_sessions then
							if l_session /= Void then
								if l_display_all or not (l_session.is_ended or l_session.is_expired (es_cloud_api)) then
									s.append ("<ul>")
									append_session_to_html (Void, l_session, s, ago)
									s.append ("<li class=%"description%">Note: Only the last session is shown.</li>")
									s.append ("</ul>")
								end
							end
						elseif
							l_sessions /= Void and then
							not l_sessions.is_empty
						then
							s.append ("<ul>")
							across
								l_sessions as sess_ic
							loop
								l_session := sess_ic.item
								if l_display_all or not (l_session.is_ended or l_session.is_expired (es_cloud_api)) then
									append_session_to_html (Void, l_session, s, ago)
								end
							end
							s.append ("</ul>")
						end
						s.append ("</li>%N")
					end
					s.append ("</ul>")
					s.append ("</p>")
				else
					if l_license /= Void then
						s.append ("<p>EiffelStudio license " + html_encoded (l_license.key) + " is not yet installed.</p>")
					else
						s.append ("<p>EiffelStudio is not yet installed.</p>")
					end
				end
				s.append ("</div>")
				r.set_main_content (s)
				r.execute
			else
				api.response_api.send_access_denied (Void, req, res)
			end
		end

	append_session_to_html (a_title: detachable READABLE_STRING_GENERAL; a_session: ES_CLOUD_SESSION; a_html: STRING_8; ago: DATE_TIME_AGO_CONVERTER)
		local
			k: READABLE_STRING_GENERAL
			s: STRING
		do
			a_html.append ("<li class=%"session")
			if a_session.is_paused then
				k := "paused"
				a_html.append (" paused")
			elseif a_session.is_ended then
				k := "closed"
				a_html.append (" closed")
			elseif a_session.is_expired (es_cloud_api) then
				k := "expired"
				a_html.append (" expired")
			else
				k := "active"
				a_html.append (" active")
			end
			a_html.append ("%"")
			a_html.append (" data-session-id=%"" + html_encoded (a_session.id) + "%"")
			a_html.append (">")
			if a_title /= Void then
				s := html_encoded (a_title)
			elseif attached a_session.title as a_session_title then
				s := html_encoded (a_session_title)
			else
				s := html_encoded (a_session.id)
			end
			if s /= Void then
				s.replace_substring_all ("%N", "<br/>")
				a_html.append (s)
			end
			a_html.append (" <em>")
			a_html.append (html_encoded (k))
			a_html.append ("</em>")

			a_html.append (" <span class=%"creation datetime_ago%" datetime=%""+ date_time_to_timestamp_string (a_session.first_date) +"%" title=%"" + date_time_to_string (a_session.first_date) + "%">")
			ago.append_date_to ("", a_session.first_date, a_html)
--									a_html.append (date_time_to_string (a_session.first_date))
			a_html.append ("</span>")
			a_html.append (" <span class=%"access datetime_ago%" datetime=%""+ date_time_to_timestamp_string (a_session.last_date) +"%" title=%"" + date_time_to_string (a_session.last_date) + "%">")
			ago.append_date_to ("", a_session.last_date, a_html)
--									a_html.append (date_time_to_string (a_session.last_date))
			a_html.append ("</span>")
			a_html.append ("</li>")
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

