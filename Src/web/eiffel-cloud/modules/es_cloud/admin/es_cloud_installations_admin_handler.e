note
	description: "Summary description for {ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			inst_nb, sess_nb: INTEGER
			l_installations: LIST [ES_CLOUD_INSTALLATION]
			l_user: detachable ES_CLOUD_USER
			inst: ES_CLOUD_INSTALLATION
			sess: ES_CLOUD_SESSION
			l_only_active: BOOLEAN
			d: INTEGER
		do
			if api.has_permission ("manage es accounts") then
				if
					attached {WSF_STRING} req.query_parameter ("user") as p_user and then
					attached api.user_api.user_by_id_or_name (p_user.value) as l_cms_user
				then
					create l_user.make (l_cms_user)
				end
				if l_user = Void then
					send_bad_request (req, res)
				else
					if
						attached {WSF_STRING} req.query_parameter ("installation") as p_installation
					then
						inst := es_cloud_api.installation (p_installation.value)
					end

					r := new_generic_response (req, res)
					add_primary_tabs (r)

					if inst /= Void then
						create s.make_from_string ("<h1>Installation %""+ html_encoded (inst.id) +"%" for user " + api.user_html_administration_link (l_user) + "</h1>")
						s.append ("Click for")
						s.append (" <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">any user</a> ")
						s.append (" | ")
						s.append (" <a href=%"" + req.script_url (req.percent_encoded_path_info) + "?user="+ l_user.id.out +"%">all installations</a>")
						s.append ("<p><strong>User:</strong> " + api.user_html_administration_link (l_user))
						l_only_active := attached {WSF_STRING} req.query_parameter ("only_active") as p and then p.is_case_insensitive_equal ("true")
						if l_only_active then
							s.append (" (<a href=%"" + req.script_url (req.percent_encoded_path_info) + "?user=" + l_user.id.out + "&installation="+ url_encoded (inst.id) +"&only_active=true%">active sessions</a>)")
						else
							s.append (" (<a href=%"" + req.script_url (req.percent_encoded_path_info) + "?user=" + l_user.id.out + "&installation="+ url_encoded (inst.id) +"%">all sessions</a>)")
						end
						s.append ("</p>")
						s.append ("<p><strong>Installation:</strong> " + html_encoded (inst.id) + "</p>")
						s.append ("<p><strong>Sessions:</strong><ul class=%"es-sessions%">")
						if attached inst.info as l_info and then not l_info.is_whitespace then
							s.append ("<p class=%"info%"><strong>Information:</strong><pre class=%"es-info%">")
							s.append (html_encoded (l_info))
							s.append ("</pre></p>%N")
						end
						if attached es_cloud_api.user_sessions (l_user, inst.id, l_only_active) as l_sessions then
							across
								l_sessions as sess_ic
							loop
								sess := sess_ic.item
								if sess.is_active then
									s.append ("<li class=%"active%">")
								else
									s.append ("<li class=%"expired%">")
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
						end
						s.append ("</ul></p>")
					else
						create s.make_from_string ("<h1>Installations for user " + api.user_html_administration_link (l_user) + "</h1>")
						s.append ("Click <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">for any user</a>.")
						s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Users</th><th>Installation</th><th>Session</th><th>Started</th><th>Last-used</th>")
			--			s.append ("<th>Action</th>")
						s.append ("</tr>")
						l_installations := es_cloud_api.user_installations (l_user)
						inst_nb := l_installations.count
						across
							l_installations as ic
						loop
							inst := ic.item
							s.append ("<tr>")
							s.append ("<td>" + api.user_html_administration_link (l_user) + "</td>")
							s.append ("<td><a href=%""+ req.script_url (req.percent_encoded_path_info) + "?user=" + l_user.id.out + "&installation="+ url_encoded (inst.id) +"%">" + html_encoded (inst.id) + "</a></td>")
							if
								attached es_cloud_api.user_sessions (l_user, inst.id, True) as l_sessions and then
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
								s.append ("<td>" + date_time_to_string (l_last_session.last_date) + "</td>")
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
					end

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
