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
							handle_installation_session (l_user, iid.value, sid.value, req, res)
						else
							handle_installation (l_user, iid.value, req, res)
						end
					else
						list_installations (l_user, req, res)
					end
				elseif req.is_post_request_method then
					handle_user_post (l_user, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_not_found_error_response ("User not found", req, res).execute
			end
		end

	handle_installation (a_user: ES_CLOUD_USER; iid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			inst: ES_CLOUD_INSTALLATION
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es acounts") then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
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
						tb.force (inst.info, "info")
						if attached inst.creation_date as dt then
							tb.force (dt, "creation_date")
						end
						if inst.is_active then
							tb.force ("yes", "is_active")
						else
							tb.force ("no", "is_active")
						end
						r.add_table_iterator_field ("es:installation", tb)
						r.add_self (r.location)
					else
						r := new_error_response ("Installation not found", req, res)
					end
					r.execute
				else
					r := new_error_response ("No installation found", req, res)
				end
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	list_installations (a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es acounts") then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
					create tb.make (lst.count)
					across
						lst as ic
					loop
						if attached ic.item as inst then
							tb.force (ic.item.info, ic.item.installation_id)
						end
					end
					r.add_table_iterator_field ("es:installations", tb)
				end
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	handle_installation_session (a_user: ES_CLOUD_USER; iid, sid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			inst: ES_CLOUD_INSTALLATION
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es acounts") then
				r := new_response (req, res)
				if attached {ES_CLOUD_SESSION} es_cloud_api.user_session (a_user, iid, sid) as sess then
					r := new_response (req, res)
					create tb.make (2)
					tb.force (sess.installation_id, "installation_id")
					tb.force (sess.id, "id")
					inspect
						sess.state
					when {ES_CLOUD_SESSION}.state_normal_id then
						tb.force ("normal", "state")
					when {ES_CLOUD_SESSION}.state_paused_id then
						tb.force ("paused", "state")
					when {ES_CLOUD_SESSION}.state_ended_id then
						tb.force ("ended", "state")
					else
						tb.force (sess.state.out, "state")
					end
					if attached sess.first_date as dt then
						tb.force (dt, "first_date")
					end
					if attached sess.last_date as dt then
						tb.force (dt, "last_date")
					end
					if attached sess.title as l_title then
						tb.force (l_title, "title")
					end
					r.add_table_iterator_field ("es:session", tb)
					r.add_self (r.location)
					r.add_link ("es:installation", "installation", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (sess.installation_id)))
				else
					r := new_error_response ("Session not found", req, res)
				end
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	handle_user_post (a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_post_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			f: CMS_FORM
			l_user: ES_CLOUD_USER
			l_install_id, l_session_id: detachable READABLE_STRING_GENERAL
			l_installation: detachable ES_CLOUD_INSTALLATION
			l_active_sessions: detachable LIST [ES_CLOUD_SESSION]
			l_session: detachable ES_CLOUD_SESSION
			l_user_plan: detachable ES_CLOUD_PLAN_SUBSCRIPTION
			err: BOOLEAN
			n, l_sess_limit, l_heartbeat: NATURAL
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es accounts") then

				create f.make (req.percent_encoded_path_info, "es-form")
				f.extend_text_field ("installation_id", Void)
				f.extend_text_field ("session_id", Void)
				f.extend_text_field ("info", Void)
				f.extend_text_field ("session_title", Void)
				r := new_response (req, res)
				f.process (r)
				if
					attached f.last_data as fd and then not fd.has_error
				then
					l_install_id := fd.string_item ("installation_id")
					l_session_id := fd.string_item ("session_id")
					if l_session_id /= Void and l_install_id /= Void then
						l_installation := es_cloud_api.user_installation (a_user, l_install_id)
						if l_installation /= Void then
							l_installation.set_info (fd.string_item ("info"))
							l_session := es_cloud_api.user_session (a_user, l_install_id, l_session_id)
							if l_session /= Void then
								l_active_sessions := es_cloud_api.user_active_concurrent_sessions (a_user, l_install_id, l_session)
								if attached es_cloud_api.user_subscription (a_user) as l_plan then
									l_sess_limit := l_plan.concurrent_sessions_limit
									l_heartbeat :=  l_plan.heartbeat
								else
									l_sess_limit := es_cloud_api.default_concurrent_sessions_limit
									l_heartbeat :=  es_cloud_api.default_heartbeat
								end
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
										from
											l_active_sessions.finish
										until
											l_active_sessions.off or n = 0
										loop
											if l_active_sessions.item.is_expired (es_cloud_api) then
												es_cloud_api.pause_session (a_user, l_active_sessions.item)
												n := n - 1
												l_active_sessions.remove
											else
												l_active_sessions.back
											end
										end
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
													es_cloud_api.pause_session (a_user, ic.item)
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
						r.add_link ("es:installation", "installation", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (l_install_id)))
					end
					if l_installation /= Void and then l_session /= Void then
						inspect
							l_session.state
						when {ES_CLOUD_SESSION}.state_normal_id then
							r.add_string_field ("es:session_state", "normal")
						when {ES_CLOUD_SESSION}.state_paused_id then
							r.add_string_field ("es:session_state", "paused")
						when {ES_CLOUD_SESSION}.state_ended_id then
							r.add_string_field ("es:session_state", "ended")
						else
							r.add_string_field ("es:session_state", "state#" + l_session.state.out)
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
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

