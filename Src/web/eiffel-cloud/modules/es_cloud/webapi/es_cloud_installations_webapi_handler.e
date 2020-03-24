note
	description: "Summary description for {ES_CLOUD_INSTALLATIONS_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATIONS_WEBAPI_HANDLER

inherit
	ES_CLOUD_WEBAPI_HANDLER

create
	make

feature -- Execution

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
			l_user: ES_CLOUD_USER
		do
			if
				attached {WSF_STRING} req.path_parameter ("uid") as p_uid and then
				attached user_by_uid (p_uid.value) as l_cms_user
			then
				create l_user.make (l_cms_user)
				if req.is_get_request_method then
					if attached {WSF_STRING} req.path_parameter ("installation_id") as iid then
						if attached {WSF_STRING} req.path_parameter ("session_id") as sid then
							handle_installation_session (a_version, l_user, iid.value, sid.value, req, res)
						else
							handle_installation (a_version, l_user, iid.value, req, res)
						end
					else
						list_installations (a_version, l_user, req, res)
					end
				elseif req.is_post_request_method then
					handle_user_post (a_version, l_user, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_not_found_error_response ("User not found", req, res).execute
			end
		end

	handle_installation (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; iid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb,tb_sessions: STRING_TABLE [detachable ANY]
			inst: ES_CLOUD_INSTALLATION
			sess: ES_CLOUD_SESSION
			l_include_sessions: BOOLEAN
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es accounts") then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
					l_include_sessions := req.percent_encoded_path_info.ends_with_general ("/session/")
					across
						lst as ic
					until
						inst /= Void
					loop
						inst := ic.item
						if not iid.same_string (inst.installation_id) then
							inst := Void
						end
					end
					if inst /= Void then
						r := new_response (req, res)
						create tb.make (2)
						tb.force (inst.installation_id, "id")
						if attached inst.name as l_name then
							tb.force (l_name, "name")
						end
						tb.force (inst.info, "info")
						if attached inst.creation_date as dt then
							tb.force (date_time_to_string (dt), "creation_date")
						end
						if inst.is_active then
							tb.force ("yes", "is_active")
						else
							tb.force ("no", "is_active")
						end
						r.add_table_iterator_field ("es:installation", tb)
						if l_include_sessions then
							if attached es_cloud_api.user_sessions (a_user, inst.installation_id, False) as l_sessions then
								create tb_sessions.make (l_sessions.count)
								across
									l_sessions as ic
								loop
									sess := ic.item
									create tb.make (5)
									tb.force (sess.id, "id")
									if attached sess.title as l_title then
										tb.force (l_title, "title")
									end
									tb.force (session_state_name (sess), "state")
									if sess.is_expired (es_cloud_api) then
										tb.force (True, "is_expired")
									end
									tb.force (date_time_to_string (sess.first_date), "first_date")
									tb.force (date_time_to_string (sess.last_date), "last_date")
									tb_sessions.force (tb, sess.id)
									r.add_link (url_encoded (sess.id), detachable_html_encoded (sess.title), r.api.absolute_url (r.location + url_encoded (sess.id), Void))
								end
							else
								create tb_sessions.make (0)
							end
							r.add_table_iterator_field ("es:sessions", tb_sessions)
						else
							r.add_link ("sessions", "sessions", r.api.absolute_url (r.location + "/session/", Void))
						end
						r.add_link ("installation", "installation", cloud_user_installation_link (a_version, a_user, iid))
						r.add_self (r.location)
					else
						r := new_error_response ("Installation not found", req, res)
					end
					r.execute
				else
					r := new_error_response ("No installation found", req, res)
				end
				add_cloud_user_links_to (a_version, a_user, r)
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	list_installations (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			tb_installations: STRING_TABLE [detachable ANY]
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es accounts") then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
					create tb_installations.make (lst.count)
					across
						lst as ic
					loop
						if attached ic.item as inst then
							create tb.make (1)
							tb.force (inst.info, "info")
							if attached inst.name as l_name then
								tb.force (l_name, "name")
							end
							tb_installations.force (tb, inst.installation_id)
							r.add_link (url_encoded (inst.installation_id), detachable_html_encoded (inst.name), r.api.absolute_url (r.location + "/" + url_encoded (inst.installation_id), Void))
						end
					end
					r.add_table_iterator_field ("es:installations", tb_installations)
				end
				add_cloud_user_links_to (a_version, a_user, r)
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	handle_installation_session (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; iid, sid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			inst: ES_CLOUD_INSTALLATION
			l_inst_location: STRING
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es accounts") then
				r := new_response (req, res)
				if attached {ES_CLOUD_SESSION} es_cloud_api.user_session (a_user, iid, sid) as sess then
					r := new_response (req, res)
					create tb.make (2)
					tb.force (sess.installation_id, "installation_id")
					tb.force (sess.id, "id")
					tb.force (session_state_name (sess), "state")
					if sess.is_expired (es_cloud_api) then
						tb.force (True, "is_expired")
					end
					if attached sess.first_date as dt then
						tb.force (date_time_to_string (dt), "first_date")
					end
					if attached sess.last_date as dt then
						tb.force (date_time_to_string (dt), "last_date")
					end
					if attached sess.title as l_title then
						tb.force (l_title, "title")
					end
					r.add_table_iterator_field ("es:session", tb)
					r.add_self (r.location)
					l_inst_location := r.location.twin
					remove_last_segment (l_inst_location, False)
					remove_last_segment (l_inst_location, False)
					r.add_link ("es:installation", "installation", (api.absolute_url (l_inst_location, Void)))
				else
					r := new_error_response ("Session not found", req, res)
				end
				r.add_link ("installation", "installation", cloud_user_installation_link (a_version, a_user, iid))
				add_cloud_user_links_to (a_version, a_user, r)
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	handle_user_post (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_post_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			f: CMS_FORM
			l_user: ES_CLOUD_USER
			l_install_id, l_session_id, l_product_version: detachable READABLE_STRING_GENERAL
			l_installation: detachable ES_CLOUD_INSTALLATION
			l_active_sessions: detachable STRING_TABLE [LIST [ES_CLOUD_SESSION]]
			l_session: detachable ES_CLOUD_SESSION
			l_user_plan: detachable ES_CLOUD_PLAN_SUBSCRIPTION
			err: BOOLEAN
			n, l_sess_limit, l_heartbeat: NATURAL
			l_inst_location: STRING
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es accounts") then

				create f.make (req.percent_encoded_path_info, "es-form")
				f.extend_text_field ("installation_id", Void)
				f.extend_text_field ("session_id", Void)
				f.extend_text_field ("info", Void)
				f.extend_text_field ("session_title", Void)
				f.extend_text_field ("product_version", Void)
				r := new_response (req, res)
				f.process (r)
				if
					attached f.last_data as fd and then not fd.has_error
				then
					l_install_id := fd.string_item ("installation_id")
					l_session_id := fd.string_item ("session_id")
					if l_session_id /= Void and l_install_id /= Void then
						l_product_version := fd.string_item ("product_version")
						l_installation := es_cloud_api.user_installation (a_user, l_install_id)
						if l_installation /= Void then
							l_installation.set_info (fd.string_item ("info"))
							l_session := es_cloud_api.user_session (a_user, l_install_id, l_session_id)
							if l_session /= Void then
								l_active_sessions := es_cloud_api.user_active_concurrent_sessions (a_user, l_install_id, l_session)
							end
							if attached es_cloud_api.user_subscription (a_user) as l_plan then
								l_sess_limit := l_plan.concurrent_sessions_limit
								l_heartbeat :=  l_plan.heartbeat
							else
								l_sess_limit := es_cloud_api.default_concurrent_sessions_limit
								l_heartbeat :=  es_cloud_api.default_heartbeat
							end
							if attached {WSF_STRING} req.form_parameter ("operation") as l_op then
								if l_op.is_case_insensitive_equal ("ping") then
									if l_session = Void then
										create l_session.make (a_user, l_install_id, l_session_id, Void)
									end
									if
										l_sess_limit > 0 and then
									 	l_active_sessions /= Void and then
									 	l_active_sessions.count.to_natural_32 >= l_sess_limit
									then
											-- Pause expired sessions or current session!
										n := l_active_sessions.count.to_natural_32 - l_sess_limit + 1
										across
											-l_active_sessions.new_cursor as ic
										until
											n = 0
										loop
											across
												-ic.item.new_cursor as sess_ic
											loop
												if sess_ic.item.is_expired (es_cloud_api) then
													es_cloud_api.pause_session (a_user, sess_ic.item)
												end
											end
											n := n - 1
										end
--										from
--											l_active_sessions.finish
--										until
--											l_active_sessions.off or n = 0
--										loop
--											if l_active_sessions.item.is_expired (es_cloud_api) then
--												es_cloud_api.pause_session (a_user, l_active_sessions.item)
--												n := n - 1
--												l_active_sessions.remove
--											else
--												l_active_sessions.back
--											end
--										end
										if n > 0 then
											es_cloud_api.pause_session (a_user, l_session)
										end
									else
										l_session.set_title (fd.string_item ("session_title"))
										es_cloud_api.ping_installation (a_user, l_session)
									end
								elseif l_session /= Void then
									if l_op.is_case_insensitive_equal ("end_session") then
										es_cloud_api.end_session (a_user, l_session)
									elseif l_op.is_case_insensitive_equal ("pause_session") then
										es_cloud_api.pause_session (a_user, l_session)
									elseif l_op.is_case_insensitive_equal ("resume_session") then
										es_cloud_api.resume_session (a_user, l_session)
										if l_active_sessions /= Void then
											n := l_sess_limit
											across
												l_active_sessions as ic
											loop
													-- Keep first `l_sess_limit - 1` sessions active, and pause the others
												if n > 1 then
													n := n - 1
												else
													across
														-ic.item.new_cursor as sess_ic
													loop
														es_cloud_api.pause_session (a_user, sess_ic.item)
													end
												end
											end
										end
									else
											-- default or error?
										es_cloud_api.ping_installation (a_user, l_session)
									end
								else
									err := True
								end
							else
									-- default or error?
								err := True
							end
						else
								-- default or error?
								-- Check for installation limit!
							es_cloud_api.register_installation (a_user, l_install_id, fd.string_item ("info"))
						end
						err := es_cloud_api.has_error
					end
				else
					err := True
				end
				if l_install_id = Void or l_session_id = Void or err then
					r := new_error_response ("Error: missing installation information", req, res)
				else
					r := new_response (req, res)
					if l_install_id /= Void then
						--FIXME
						if l_session_id /= Void then
							l_inst_location := r.location.twin
							remove_last_segment (l_inst_location, False)
							remove_last_segment (l_inst_location, False)
							r.add_link ("es:installation", "installation", (api.absolute_url (l_inst_location, Void)))
						else
							r.add_link ("es:installation", "installation", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (l_install_id)))
						end
					end
					if l_installation /= Void and then l_session /= Void then
						r.add_string_field ("es:session_state", session_state_name (l_session))
						if l_session.is_expired (es_cloud_api) then
							r.add_boolean_field ("es:session_expired", True)
						end
						if l_heartbeat > 0 then
							r.add_integer_64_field ("es:session_heartbeat", l_heartbeat)
						end
						r.add_link ("es:session", "session", api.absolute_url (r.location, Void)
									+ "/" + api.url_encoded (l_session.installation_id)
									+ "/session/" + api.url_encoded (l_session.id)
								)
					end
				end
				add_cloud_user_links_to (a_version, a_user, r)
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
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
				Result := sess.state.out
			end
		end			

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

