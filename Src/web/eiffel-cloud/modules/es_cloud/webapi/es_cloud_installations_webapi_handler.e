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
			l_user: ES_CLOUD_USER
			l_inst_id: READABLE_STRING_GENERAL
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
					if attached {WSF_STRING} req.path_parameter ("installation_id") as iid then
						l_inst_id := iid.value
					elseif attached {WSF_STRING} req.form_parameter ("installation_id") as iid then
						l_inst_id := iid.value
					end
					if l_inst_id /= Void then
						handle_user_installation_post (a_version, l_user, l_inst_id, req, res)
					else
						report_missing_installation_id (a_version, l_user, req, res)
					end
				elseif req.is_put_request_method then
					if attached {WSF_STRING} req.path_parameter ("installation_id") as iid then
						l_inst_id := iid.value
					elseif attached {WSF_STRING} req.form_parameter ("installation_id") as iid then
						l_inst_id := iid.value
					end
					if l_inst_id /= Void then
						handle_user_installation_put (a_version, l_user, l_inst_id, req, res)
					else
						report_missing_installation_id (a_version, l_user, req, res)
					end
				elseif req.is_delete_request_method then
					handle_user_delete (a_version, l_user, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_not_found_error_response ("User not found", req, res).execute
			end
		end

	report_missing_installation_id (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER ; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_response
		do
			r := new_error_response ("Error: missing installation information", req, res)
			add_cloud_user_links_to (a_version, a_user, r)
			add_user_links_to (a_user, r)
			r.execute
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
			if a_user.same_as (api.user) or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
					l_include_sessions := req.percent_encoded_path_info.ends_with_general ("/session/")
					across
						lst as ic
					until
						inst /= Void
					loop
						inst := ic.item
						if not iid.same_string (inst.id) then
							inst := Void
						end
					end
					if inst /= Void then
						r := new_response (req, res)
						add_installation_to (a_version, a_user, inst, r)
						if l_include_sessions then
							if attached es_cloud_api.user_sessions (a_user, inst.id, False) as l_sessions then
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
						r.add_self (r.location)
							-- Added all adapted licenses ... the user should be able to change current licence
						if attached es_cloud_api.adapted_licenses (a_user, inst) as l_adapted_licenses then
								-- All valid licenses, so the user may pick from one of them.
							create tb.make (l_adapted_licenses.count)
							across
								l_adapted_licenses as ic
							loop
								if attached ic.item as lic then
									tb.force (license_to_table (lic), lic.key)
								end
							end
							r.add_table_iterator_field ("es:adapted_licenses", tb)
						end
					else
						r := new_error_response ("Installation not found", req, res)
					end
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

	add_installation_to (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; inst: ES_CLOUD_INSTALLATION; r: like new_response)
		local
			tb: STRING_TABLE [detachable ANY]
		do
			create tb.make (2)
			tb.force (inst.id, "id")
			if attached inst.product_id as l_pid then
				tb.force (l_pid, "product_id")
			end
			if attached inst.product_version as l_pv then
				tb.force (l_pv, "product_version")
			end
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

			if attached es_cloud_api.license (inst.license_id) as lic then
				r.add_table_iterator_field ("es:license", license_to_table (lic))
				r.add_link ("license", "license", cloud_user_license_link (a_version, a_user, lic.key))

				r.add_table_iterator_field ("es:plan", license_to_plan_table (lic))
				if attached es_cloud_api.license_limitations_string (lic) as lim then
					r.add_string_field ("plan_limitations", lim)
				end
--				r.add_table_iterator_field ("es:data", data_to_plan_table (lic))
			end

			r.add_link ("es:installation", "installation", cloud_user_installation_link (a_version, a_user, inst.id))
		end

	list_installations (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			tb_installations: STRING_TABLE [detachable ANY]
		do
			if a_user.same_as (api.user) or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
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
							tb_installations.force (tb, inst.id)
							r.add_link (url_encoded (inst.id), detachable_html_encoded (inst.name), r.api.absolute_url (r.location + "/" + url_encoded (inst.id), Void))
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
			l_inst_location: STRING
		do
			if a_user.same_as (api.user) or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
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
					create l_inst_location.make_from_string (r.location)
					remove_last_segment (l_inst_location, False)
					remove_last_segment (l_inst_location, False)
--					r.add_link ("es:installation", "installation", (api.absolute_url (l_inst_location, Void)))
				else
					r := new_error_response ("Session not found", req, res)
				end
				r.add_link ("es:installation", "installation", cloud_user_installation_link (a_version, a_user, iid))
				add_cloud_user_links_to (a_version, a_user, r)
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	handle_user_delete (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_response
			iid: READABLE_STRING_32
		do
				-- TODO: require license id!
			if
				(a_user.same_as (api.user) and then api.has_permission ({ES_CLOUD_MODULE}.perm_discard_own_installations))
				or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts)
			then
				if attached {WSF_STRING} req.path_parameter ("installation_id") as p_iid then
					iid := p_iid.value
				end
				if iid /= Void and then attached es_cloud_api.user_installations_for (a_user, iid) as l_installations then
					es_cloud_api.reset_error
					across
						l_installations as ic
					until
						es_cloud_api.has_error
					loop
						es_cloud_api.discard_installation (ic.item, a_user)
					end
					if es_cloud_api.has_error or else es_cloud_api.user_installations_for (a_user, iid) /= Void then
						r := new_error_response ("Can not discard installation", req, res)
					else
						r := new_response (req, res)
						r.add_boolean_field ("success", True)
						r.add_string_field ("message", "installation discarded")
						r.add_string_field ("installation_id", iid)
						r.add_link ("es:installation", "installation", cloud_user_installation_link (a_version, a_user, iid))
						add_cloud_user_links_to (a_version, a_user, r)
						add_user_links_to (a_user, r)
					end
				else
					r := new_not_found_error_response ("Installation not found", req, res)
				end
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	handle_user_installation_post (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; a_installation_id: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_post_request_method
		local
			r: like new_response
			f: CMS_FORM
			l_op: READABLE_STRING_GENERAL
			l_installation: ES_CLOUD_INSTALLATION
			lic, l_new_lic: ES_CLOUD_LICENSE
		do
			if a_user.same_as (api.user) then --or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
				r := new_response (req, res)
				f := handle_user_installation_form (req)
				f.process (r)
				if
					attached f.last_data as fd and then not fd.has_error
				then
					check
						same_installation_id: attached fd.string_item ("installation_id") as f_installation_id and then a_installation_id.same_string (f_installation_id)
					end
					if attached es_cloud_api.installations_for (a_installation_id) as lst then
						across
							lst as ic
						until
							l_installation /= Void
						loop
							l_installation := ic.item
							if l_installation /= Void then
								if es_cloud_api.user_has_license (a_user, l_installation.license_id) then
									lic := es_cloud_api.license (l_installation.license_id)
								else
									l_installation := Void
								end
							end
						end
					end
					if l_installation /= Void and lic /= Void then
						l_op := if attached {WSF_STRING} req.form_parameter ("operation") as p_op then p_op.value else {STRING_32} "ping" end
						if l_op.is_case_insensitive_equal ("update_license") then
							if attached {WSF_STRING} req.form_parameter ("license_id") as p_lic_id then
								l_new_lic := es_cloud_api.license_by_key (p_lic_id.value)
							end
							if l_new_lic /= Void and then not l_new_lic.key.same_string (lic.key) then
									-- Update license for `l_installation`
								es_cloud_api.update_installation_license (l_installation, l_new_lic)
								r := new_response (req, res)
								r.add_link ("es:installation", "installation", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (l_installation.id)))
								add_cloud_user_links_to (a_version, a_user, r)
								add_user_links_to (a_user, r)
								r.execute
							else
								r := new_error_response ("Error [update_license]: unexpected license", req, res)
								add_cloud_user_links_to (a_version, a_user, r)
								add_user_links_to (a_user, r)
								r.execute
							end
						else
							handle_installation_operation (a_version, a_user, l_installation, lic, l_op, fd, req, res)
						end
					else
							-- Check for installation limit!
						handle_new_installation (a_version, a_user, a_installation_id, fd.string_item ("info"), req, res)
					end
				else
					r := new_error_response ("Error", req, res)
					add_cloud_user_links_to (a_version, a_user, r)
					add_user_links_to (a_user, r)
					r.execute
				end
			else
				r := new_access_denied_error_response (Void, req, res)
				r.execute
			end
		end

	handle_user_installation_put (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; a_installation_id: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_post_request_method
		local
			r: like new_response
			f: CMS_FORM
			l_op: READABLE_STRING_GENERAL
			l_installation: ES_CLOUD_INSTALLATION
		do
			if a_user.same_as (api.user) or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
				r := new_response (req, res)
				f := handle_user_installation_form (req)
				f.process (r)
				if
					attached f.last_data as fd and then not fd.has_error
				then
					check
						same_installation_id: attached fd.string_item ("installation_id") as f_installation_id and then a_installation_id.same_string (f_installation_id)
					end
					if
						attached fd.string_item ("license_id") as f_license_id and then
						attached fd.string_item ("new_license_id") as f_new_license_id and then
						attached es_cloud_api.license_by_key (f_license_id) as lic and then
						attached es_cloud_api.installation (a_installation_id, lic.id) as inst and then
						attached es_cloud_api.license_by_key (f_new_license_id) as new_lic
					then
						es_cloud_api.update_installation_license (inst, new_lic)
						r.add_link ("es:installation", "installation", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (inst.id)))
						add_installation_to (a_version, a_user, inst, r)
						add_cloud_user_links_to (a_version, a_user, r)
						add_user_links_to (a_user, r)
						r.execute
					else
						r := new_bad_request_error_response ("Missing value to assign installation to new license", req, res)
						add_cloud_user_links_to (a_version, a_user, r)
						add_user_links_to (a_user, r)
						r.execute
					end
				else
					r := new_error_response ("Error", req, res)
					add_cloud_user_links_to (a_version, a_user, r)
					add_user_links_to (a_user, r)
					r.execute
				end
			else
				r := new_access_denied_error_response (Void, req, res)
				r.execute
			end
		end

	handle_user_installation_form (req: WSF_REQUEST): CMS_FORM
		do
			create Result.make (req.percent_encoded_path_info, "es-form")
			Result.extend_text_field ("installation_id", Void)
			Result.extend_text_field ("license_id", Void)
			Result.extend_text_field ("new_license_id", Void)
			Result.extend_text_field ("session_id", Void)
			Result.extend_text_field ("info", Void)
			Result.extend_text_field ("session_title", Void)
		end

feature {NONE} -- User installation post handling

	handle_installation_operation (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER;
			a_installation: ES_CLOUD_INSTALLATION; a_license: detachable ES_CLOUD_LICENSE;
			a_op: READABLE_STRING_GENERAL; a_form_data: WSF_FORM_DATA;
			req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			same_license: a_license /= Void implies a_license.id = a_installation.license_id
		local
			r: like new_response
			err: BOOLEAN
			l_session_id: READABLE_STRING_GENERAL
			l_active_sessions: detachable STRING_TABLE [LIST [ES_CLOUD_SESSION]]
			l_session: detachable ES_CLOUD_SESSION
--			l_user_plan: detachable ES_CLOUD_PLAN_SUBSCRIPTION
			l_plan: ES_CLOUD_PLAN
			n, l_sess_limit, l_heartbeat: NATURAL
			l_inst_location: STRING
			err_msg, l_expecting: STRING_32
		do
			if a_user.same_as (api.user) then
				a_installation.set_info (a_form_data.string_item ("info"))
				l_session_id := a_form_data.string_item ("session_id")
				if l_session_id = Void then
					r := new_error_response ("Error: missing session information", req, res)
				else
					l_session := es_cloud_api.user_session (a_user, a_installation.id, l_session_id)
					if a_license = Void or else not es_cloud_api.user_has_license (a_user, a_license.id) then
						-- ERROR: no associated valid license!
						r := new_error_response ("Error: no associated license!", req, res)
						r.add_boolean_field ("es:license_missing", True)
						r.add_boolean_field ("es:plan_expired", True) -- For backward compatibility
					elseif not a_license.is_valid (a_installation.platform, a_installation.product_version) then
						-- ERROR: invalid license!
						create err_msg.make_from_string_general ({STRING_32} "invalid license <"+ a_license.key +{STRING_32} ">")
						if a_license.is_expired then
							err_msg.append ({STRING_32} " EXPIRED")
						else
							if attached a_license.version as l_version then
								create l_expecting.make_from_string ({STRING_32} " version=" + l_version)
							end
							if attached a_license.platforms_as_csv_string as l_platforms then
								if l_expecting = Void then
									create l_expecting.make_empty
								end
								l_expecting.append ({STRING_32} " platforms=" + l_platforms)
							end
							if l_expecting /= Void then
								err_msg.append ({STRING_32} " (expecting " + l_expecting + ")")
							end
						end
						r := new_error_response (err_msg, req, res)
						if attached a_license.version as l_version then
							r.add_string_field ("es:version_limitation", l_version)
						end
						if attached a_license.platforms_as_csv_string as l_platforms then
							r.add_string_field ("es:platforms_limitation", l_platforms)
						end
						r.add_boolean_field ("es:license_invalid", True)
						r.add_boolean_field ("es:license_expired", True) -- For backward compatibility
						r.add_boolean_field ("es:plan_expired", True) -- For backward compatibility
					else
						if
							attached a_installation.platform as pf and then
							a_license.is_waiting_for_platform_value (pf)
						then
							a_license.accept_platform (pf)
							es_cloud_api.save_license (a_license)
						end
						l_plan := a_license.plan
							-- Valid license.
						if l_session /= Void then
							l_active_sessions := es_cloud_api.user_active_concurrent_sessions (a_user, a_installation.id, l_session)
						end
						if l_plan /= Void then
							l_sess_limit := a_license.concurrent_sessions_limit
							l_heartbeat := a_license.heartbeat
						else
							l_sess_limit := es_cloud_api.default_concurrent_sessions_limit
							l_heartbeat :=  es_cloud_api.default_heartbeat
						end
						if a_op.is_case_insensitive_equal ("ping") then
							if l_session = Void then
								create l_session.make (a_user, a_installation.id, l_session_id, Void)
								update_session_data (req, l_session)
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
								if n > 0 then
									update_session_data (req, l_session)
									es_cloud_api.pause_session (a_user, l_session)
								end
							else
								l_session.set_title (a_form_data.string_item ("session_title"))
								update_session_data (req, l_session)
								es_cloud_api.ping_installation (a_user, l_session)
							end
						elseif l_session /= Void then
							update_session_data (req, l_session)
							if a_op.is_case_insensitive_equal ("end_session") then
								es_cloud_api.end_session (a_user, l_session)
							elseif a_op.is_case_insensitive_equal ("pause_session") then
								es_cloud_api.pause_session (a_user, l_session)
							elseif a_op.is_case_insensitive_equal ("resume_session") then
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
							r := new_error_response ("Error", req, res)
						end
					end
					-- FIXME: err := es_cloud_api.has_error
				end
				if r /= Void then
						-- Response already has the error!
				elseif err then
					r := new_error_response ("Error", req, res)
				else
					r := new_response (req, res)
					if l_session_id /= Void then
						create l_inst_location.make_from_string (r.location)
						remove_last_segment (l_inst_location, False)
						remove_last_segment (l_inst_location, False)
						r.add_link ("es:installation", "installation", (api.absolute_url (l_inst_location, Void)))
					else
						r.add_link ("es:installation", "installation", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (a_installation.id)))
					end
					if l_session /= Void then
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

	update_session_data (req: WSF_REQUEST; a_session: ES_CLOUD_SESSION)
		local
			j: JSON_OBJECT
			vis: JSON_SERIALIZATION_VISITOR
			s: STRING_32
		do
			create j.make_empty
			j.put_string (req.remote_addr, "remote_addr")
			if attached req.remote_host as rhost then
				j.put_string (rhost, "remote_host")
			end
			if attached req.remote_ident as rident then
				j.put_string (rident, "remote_ident")
			end
			if attached req.remote_user as ruser then
				j.put_string (ruser, "remote_user")
			end
			if attached req.request_time as rtime then
				j.put_string (date_time_to_iso8601_string (rtime), "request_time")
			end
			create s.make (512)
			create vis.make (s)
			vis.visit_json_object (j)
			a_session.set_data (s)
		end

	handle_new_installation (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL; a_info: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Register new installation, and return the installation object.
		local
			r: like new_response
			lic: ES_CLOUD_LICENSE
			inst: ES_CLOUD_INSTALLATION
			l_has_valid_license: BOOLEAN
			l_inst_limit: NATURAL
			pl,ve: READABLE_STRING_GENERAL
			l_licenses: LIST [ES_CLOUD_USER_LICENSE]
			tb: STRING_TABLE [detachable ANY]
			l_valid_licenses: ARRAYED_LIST [ES_CLOUD_LICENSE]
		do
			if a_user.same_as (api.user) then
				r := new_response (req, res)

					-- REQUIRE: user, platform, version !
				create inst.make_with_license_id (a_install_id, 0)
				pl := inst.platform
				ve := inst.product_version
				inst := Void

				l_licenses := es_cloud_api.user_licenses (a_user)
				if l_licenses = Void or else l_licenses.is_empty then
					if attached es_cloud_api.user_subscription (a_user) as l_sub then
						lic := es_cloud_api.converted_license_from_user_subscription (l_sub, inst)
--						lic.set_platform (pl)
--						lic.set_version (ve)
--						es_cloud_api.update_license (lic, sub.user)
						l_licenses := es_cloud_api.user_licenses (a_user)
					end
				end
				if l_licenses /= Void and then not l_licenses.is_empty then
					create l_valid_licenses.make (l_licenses.count)
					across
						l_licenses as ic
					loop
						lic := ic.item.license
						if lic.is_valid (pl, ve) then
							l_has_valid_license := True

							l_inst_limit := lic.installations_limit
							if
								l_inst_limit = 0
								or else (
									attached es_cloud_api.license_installations (lic) as lst and then
									lst.count.to_natural_32 < l_inst_limit
								)
							then
								l_valid_licenses.force (lic)
							else
									-- Reached installation limit for this license!
								lic := Void
							end
						end
					end
					lic := Void
--					l_has_valid_license := not l_valid_licenses.is_empty
					across
						l_valid_licenses as ic
					until
						lic /= Void or inst /= Void
					loop
						lic := l_valid_licenses.first
						if lic /= Void then
								-- Found license
							if pl /= Void and then lic.is_waiting_for_platform_value (pl) then
									-- Assign platform.
								lic.set_platforms_restriction (pl)
							end
							es_cloud_api.register_installation (lic, a_install_id, a_info)
							inst := es_cloud_api.installation (a_install_id, lic.id)
						end
					end
				end
				if inst = Void then
					r := new_error_response ("Error: no license found for the installation", req, res)
					if l_has_valid_license then
						-- Has valid license, but probably reached installation limit!
						-- TODO: report error!
						r.add_boolean_field ("es:installation_limit_reached", True)
					end
				else
					add_installation_to (a_version, a_user, inst, r)
				end
				if l_valid_licenses /= Void and then not l_valid_licenses.is_empty then
						-- All valid licenses, so the user may pick from one of them.
					create tb.make (l_valid_licenses.count)
					across
						l_valid_licenses as ic
					loop
						lic := ic.item
						tb.force (license_to_table (lic), lic.key)
					end
					r.add_table_iterator_field ("es:adapted_licenses", tb)
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

