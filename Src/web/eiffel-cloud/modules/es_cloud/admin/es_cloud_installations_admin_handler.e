note
	description: "Summary description for {ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER
		rename
			make as make_admin_handler
		end

	WSF_URI_HANDLER

create
	make

feature {NONE} -- Creation

	make (a_es_cloud_api: ES_CLOUD_API; a_admin_module: ES_CLOUD_MODULE_ADMINISTRATION)
		do
			admin_module := a_admin_module
			make_admin_handler (a_es_cloud_api)
		end

feature -- Access

	admin_module: ES_CLOUD_MODULE_ADMINISTRATION

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			inst_nb, sess_nb: INTEGER
			l_installations: LIST [ES_CLOUD_INSTALLATION]
			l_user: detachable ES_CLOUD_USER
			l_sessions: LIST [ES_CLOUD_SESSION]
			inst: ES_CLOUD_INSTALLATION
			sess: ES_CLOUD_SESSION
			l_only_active: BOOLEAN
			l_url: STRING_8
			d: INTEGER
		do
			if api.has_permission ("manage es accounts") then
				if
					attached {WSF_STRING} req.query_parameter ("user") as p_user and then
					attached api.user_api.user_by_id_or_name (p_user.value) as l_cms_user
				then
					create l_user.make (l_cms_user)
				end
				if attached {WSF_STRING} req.query_parameter ("installation") as p_installation then
					if l_user /= Void then
						inst := es_cloud_api.user_installation (l_user, p_installation.value)
					elseif attached es_cloud_api.installations_for (p_installation.value) as lst and then not lst.is_empty then
						inst := lst.first
					end
					if inst /= Void then
						r := new_generic_response (req, res)
						r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
						r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)

						add_primary_tabs (r)

						if l_user /= Void then
							create s.make_from_string ("<h1>Installation %""+ html_encoded (inst.id) +"%" for user " + api.user_html_administration_link (l_user) + "</h1>")
							s.append ("Click for")
							s.append (" <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">any user</a> ")
							s.append (" | ")
							s.append (" <a href=%"" + req.script_url (req.percent_encoded_path_info) + "?user="+ l_user.id.out +"%">all installations</a>")
							s.append ("<p><strong>User:</strong> " + api.user_html_administration_link (l_user))
							s.append ("</p>%N")
						else
							create s.make_from_string ("<h1>Installation %""+ html_encoded (inst.id) +"%"</h1>%N")
						end

						l_only_active := attached {WSF_STRING} req.query_parameter ("only_active") as p and then p.is_case_insensitive_equal ("true")
						l_url := req.script_url (req.percent_encoded_path_info) + "?installation="+ url_encoded (inst.id)
						if l_user /= Void then
							l_url.append ("&user=" + l_user.id.out)
						end
						if l_only_active then
							s.append (" (<a href=%"" + l_url + "&only_active=true%">active sessions</a>)")
						else
							s.append (" (<a href=%"" + l_url +"%">all sessions</a>)")
						end

						s.append ("<div class=%"es-installation%"><strong>Installation:</strong> " + html_encoded (inst.id) + "%N")
						if
							attached inst.license_id as lic_id and then
							attached es_cloud_api.license (lic_id) as lic and then
							attached es_cloud_api.user_for_license (lic) as lic_user
						then
							s.append ("<div class=%"license%"><strong>License:</strong>")
							es_cloud_api.append_one_line_license_view_to_html (lic, lic_user, admin_module.module, s)
							s.append ("</div>%N")
							if attached es_cloud_api.adapted_licenses (lic_user, inst) as l_adapted_licenses then
								s.append ("<div class=%"es-adapted-licenses%"><strong>Available license(s):</strong><ul>")
									-- All valid licenses, so the user may pick from one of them.
								across
									l_adapted_licenses as ic
								loop
									if attached ic.item as l_other_lic then
										s.append ("<li class=%"available%""
														+" data-user-id=%""+ lic_user.id.out +"%" data-installation-id=%""+percent_encoded (inst.id)+"%""
														+" data-license-id=%""+ percent_encoded (lic.key) +"%""
														+" data-new-license-id=%""+ percent_encoded (l_other_lic.key) +"%""
														+">")
										es_cloud_api.append_one_line_license_view_to_html (l_other_lic, lic_user, admin_module.module, s)
										s.append ("</li>%N")
									end
								end
							end
							s.append ("</ul></div>%N")
						end
						if attached inst.info as l_info and then not l_info.is_whitespace and then not l_info.is_case_insensitive_equal_general ("{}") then
							s.append ("<p class=%"info%"><strong>Information:</strong><pre class=%"es-info%">")
							s.append (html_encoded (l_info))
							s.append ("</pre></p>%N")
						end
						if l_user /= Void then
							l_sessions := es_cloud_api.user_sessions (l_user, inst.id, l_only_active)
						else
							l_sessions := es_cloud_api.installation_sessions (inst.id, l_only_active)
						end
						if l_sessions /= Void then
							s.append ("<p><strong>Sessions:</strong><ul class=%"es-sessions%">")
							across
								l_sessions as sess_ic
							loop
								sess := sess_ic.item
								if sess.is_active then
									s.append ("<li class=%"active%">")
								else
									s.append ("<li class=%"expired%">")
								end
								if l_user = Void and then attached sess.user as u then
									s.append (api.user_html_administration_link (u))
									s.append (" ")
								end
								s.append ("#" + html_encoded (sess.id))
								if attached sess.last_date.relative_duration (sess.first_date) as l_duration then
									s.append (" <span class=%"duration%">")
									d := (l_duration.seconds_count / 60 / 60 / 24).truncated_to_integer
									if d > 0 then
										s.append (d.out + " days ")
									end
									if l_duration.hour > 0 then
										s.append (l_duration.hour.out + " h ")
									end
									if l_duration.minute > 0 then
										s.append (l_duration.minute.out + " min ")
									end
									if l_duration.second > 0 then
										s.append (l_duration.second.out + " sec ")
									end
									s.append ("</span>")
								end
								s.append ("<br/>")
								s.append (date_time_to_string (sess.first_date))
								s.append (" -&gt; ")
								s.append (date_time_to_string (sess.last_date))
								if not sess.is_active then
									s.append (" (expired)")
								end
								s.append ("<span class=%"state%">")
								s.append (html_encoded (session_state_name (sess)))
								s.append ("</span>")
								if attached sess.title as l_title then
									s.append (" <span class=%"title%">")
									s.append (html_encoded (l_title))
									s.append ("</span>")
								end

								s.append ("</li>")
							end
							s.append ("</ul></p>")
						else
							s.append ("<p>No session information</p>")
						end
						s.append ("</div><!-- end of installation "+ url_encoded (inst.id) +"-->%N")
						r.set_main_content (s)
						r.execute

					else
						send_bad_request (req, res)
					end
				else
					r := new_generic_response (req, res)
					add_primary_tabs (r)

					if l_user /= Void then
						create s.make_from_string ("<h1>Installations for user " + api.user_html_administration_link (l_user) + "</h1>")
						s.append ("Click <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">for any user</a>.")
						s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Users</th><th>Installation</th><th>Session</th><th>Started</th><th>Last-used</th>")
			--			s.append ("<th>Action</th>")
						s.append ("</tr>")
						l_installations := es_cloud_api.user_installations (l_user)
					else
						create s.make_from_string ("<h1>All installations</h1>")
						s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Users</th><th>Installation</th><th>Session</th><th>Started</th><th>Last-used</th>")
			--			s.append ("<th>Action</th>")
						s.append ("</tr>")
						l_installations := es_cloud_api.all_user_installations
					end

					inst_nb := l_installations.count
					across
						l_installations as ic
					loop
						inst := ic.item
						s.append ("<tr>")
						if l_user /= Void then
							s.append ("<td>" + api.user_html_administration_link (l_user) + "</td>")
							s.append ("<td><a href=%""+ req.script_url (req.percent_encoded_path_info) + "?user=" + l_user.id.out + "&installation="+ url_encoded (inst.id) +"%">" + html_encoded (inst.id) + "</a></td>")
						else
							s.append ("<td>N/A</td>")
							s.append ("<td><a href=%""+ req.script_url (req.percent_encoded_path_info) + "?installation="+ url_encoded (inst.id) +"%">" + html_encoded (inst.id) + "</a></td>")
						end
						if l_user /= Void then
							l_sessions := es_cloud_api.user_sessions (l_user, inst.id, True)
						else
							l_sessions := es_cloud_api.installation_sessions (inst.id, True)
						end
						if
							l_sessions /= Void and then
							not l_sessions.is_empty and then
							attached l_sessions.first as l_last_session
						then
							across
								l_sessions as sess_ic
							loop
								if sess_ic.item.is_active then
									sess_nb := sess_nb + 1
								end
							end
							s.append ("<td>" + sess_nb.out + " active session(s) (" + sess_nb.out + "/" + l_sessions.count.out + ")</td>")
							s.append ("<td>" + date_time_to_string (l_last_session.first_date) + "</td>")
							s.append ("<td>")
							s.append (date_time_to_string (l_last_session.last_date))
							if l_user = Void and then attached l_last_session.user as u then
								s.append (" (")
								s.append (api.user_html_administration_link (u))
								s.append (")")
							end
							s.append ("</td>")
						else
							s.append ("<td>...</td>")
							s.append ("<td>...</td>")
							s.append ("<td>...</td>")
						end
--						if attached inst.session as sess then
--							inspect
--								sess.state
--							when {ES_CLOUD_SESSION}.state_normal_id then
--								s.append ("<td>Active</td>")
--							when {ES_CLOUD_SESSION}.state_paused_id then
--								s.append ("<td>Paused</td>")
--							when {ES_CLOUD_SESSION}.state_ended_id then
--								s.append ("<td>Ended</td>")
--							else
--								s.append ("<td>" + sess.state.out + "</td>")
--							end
--							s.append ("<td>" + date_time_to_string (sess.begin_date) + "</td>")
--							s.append ("<td>" + date_time_to_string (sess.access_date) + "</td>")
--						else
--							s.append ("<td>...</td>")
--							s.append ("<td>...</td>")
--							s.append ("<td>never</td>")
--						end
						s.append ("</tr>")
					end
					s.append ("</table>%N")

					r.set_main_content (s)
					r.execute
				end
			else
				send_access_denied (req, res)
			end
		end

feature {NONE} -- Implementation: Helpers

	session_state_name (sess: ES_CLOUD_SESSION): STRING_8
		do
			inspect
				sess.state
			when {ES_CLOUD_SESSION}.state_paused_id then
				Result := "paused"
			when {ES_CLOUD_SESSION}.state_ended_id then
				Result := "ended"
			when {ES_CLOUD_SESSION}.state_normal_id then
				Result := "normal"
			else
				Result := "#" + sess.state.out
			end
		end


end
