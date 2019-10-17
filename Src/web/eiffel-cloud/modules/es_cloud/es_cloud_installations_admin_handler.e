note
	description: "Summary description for {ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_handler
		end

	WSF_URI_HANDLER

create
	make

feature {NONE} -- Creation

	make (a_es_cloud_api: ES_CLOUD_API)
		do
			es_cloud_api := a_es_cloud_api
			make_handler (a_es_cloud_api.cms_api)
		end

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			inst_nb, sess_nb: INTEGER
			l_installations: LIST [ES_CLOUD_INSTALLATION]
			l_user: detachable CMS_USER
			inst: ES_CLOUD_INSTALLATION
		do
			if api.has_permission ("manage es accounts") then
				if attached {WSF_STRING} req.query_parameter ("user") as p_user then
					l_user := api.user_api.user_by_id_or_name (p_user.value)
				end
				if l_user = Void then
					send_bad_request (req, res)
				else
					r := new_generic_response (req, res)
					r.add_to_primary_tabs (api.administration_link ("Available plans", "/cloud/plans/"))
					r.add_to_primary_tabs (api.administration_link ("ES Subscriptions", "/cloud/subscriptions/"))
					create s.make_from_string ("<h1>Installations for user " + api.user_html_link (l_user) + "</h1>")
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
						s.append ("<td>" + api.user_html_link (l_user) + "</td>")
						s.append ("<td>" + inst.installation_id + "</td>")
						if
							attached es_cloud_api.user_sessions (l_user, inst.installation_id, True) as l_sessions and then
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

					r.set_main_content (s)
					r.execute

				end
			else
				send_access_denied (req, res)
			end
		end

end
