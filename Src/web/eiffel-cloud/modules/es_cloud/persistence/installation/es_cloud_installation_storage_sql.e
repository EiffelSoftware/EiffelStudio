note
	description: "Interface for accessing installation from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_INSTALLATION_STORAGE_SQL

inherit
	ES_CLOUD_INSTALLATION_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

feature -- Access: licenses

	user_licenses (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_USER_LICENSE]
		deferred
		end

feature -- Access: installations		

	installation (a_installation_id: READABLE_STRING_GENERAL; a_license_id: like {ES_CLOUD_LICENSE}.id): detachable ES_CLOUD_INSTALLATION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_installation_id, "iid")
			l_params.force (a_license_id, "lid")
			sql_query (sql_select_installation, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_installation
			end
			sql_finalize_query (sql_select_installation)
		end

	installations (a_installation_id: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_INSTALLATION]
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_installation_id, "iid")
			sql_query (sql_select_installations_by_iid, l_params)
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_installation as inst then
						Result.force (inst)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_installations_by_iid)
		end

	license_installations (a_license_id: like {ES_CLOUD_LICENSE}.id): LIST [ES_CLOUD_INSTALLATION]
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
			create l_params.make (1)
			l_params.force (a_license_id, "lid")
			sql_query (sql_select_installations, l_params)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_installation as inst then
						Result.force (inst)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_installations)
		end

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
			across
				user_licenses (a_user) as ic
			loop
				if attached license_installations (ic.item.license.id) as lst then
					Result.append (lst)
				end
			end
		end

	all_user_installations: LIST [ES_CLOUD_INSTALLATION]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
			sql_query (sql_select_all_installations, Void)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_installation as inst then
						Result.force (inst)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_all_installations)
		end

feature -- Access: sessions		

	last_user_session (a_user: ES_CLOUD_USER; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_SESSION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_user.id, "uid")
			if a_installation = Void then
				sql_query (sql_select_last_user_session, l_params)
				sql_start
				if not has_error and not sql_after then
					Result := fetch_user_session (a_user)
				end
				sql_finalize_query (sql_select_last_user_session)
			else
				l_params.force (a_installation.id, "iid")
				sql_query (sql_select_last_user_session_for_installation, l_params)
				sql_start
				if not has_error and not sql_after then
					Result := fetch_user_session (a_user)
				end
				sql_finalize_query (sql_select_last_user_session_for_installation)

			end
		end

	last_license_session (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_SESSION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license.id, "lid")
			sql_query (sql_select_last_user_session_by_license, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_user_session (Void)
			end
			sql_finalize_query (sql_select_last_user_session_by_license)
		end

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		local
			l_params: STRING_TABLE [detachable ANY]
			l_query: READABLE_STRING_8
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_SESSION]} Result.make (0)
			create l_params.make (1)
			if a_install_id /= Void then
				l_params.force (a_install_id, "iid")
			end
			l_params.force (a_user.id, "uid")
			if a_install_id /= Void then
				if a_only_active then
					l_query := sql_select_user_active_installation_sessions
				else
					l_query := sql_select_user_installation_sessions
				end
			else
				if a_only_active then
					l_query := sql_select_user_active_sessions
				else
					l_query := sql_select_user_sessions
				end
			end
			sql_query (l_query, l_params)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_user_session (a_user) as sess then
						Result.force (sess)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (l_query)
		end

	installation_sessions (a_install_id: READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		local
			l_params: STRING_TABLE [detachable ANY]
			l_query: READABLE_STRING_8
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_SESSION]} Result.make (0)
			create l_params.make (1)
			l_params.force (a_install_id, "iid")
			if a_only_active then
				l_query := sql_select_active_installation_sessions
			else
				l_query := sql_select_installation_sessions
			end
			sql_query (l_query, l_params)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_user_session (Void) as sess then
						Result.force (sess)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (l_query)
		end

	user_session (a_user: ES_CLOUD_USER; a_installation_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (3)
			l_params.force (a_session_id, "sid")
			l_params.force (a_installation_id, "iid")
			l_params.force (a_user.id, "uid")
			sql_query (sql_select_user_session, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_user_session (a_user)
			end
			sql_finalize_query (sql_select_user_session)
		end

	fetch_user_session (a_user: detachable ES_CLOUD_USER): detachable ES_CLOUD_SESSION
		local
			uid: INTEGER_64
			sid, iid: detachable READABLE_STRING_32
		do
			sid := sql_read_string_32 (1)
			iid := sql_read_string_32 (2)
			uid := sql_read_integer_64 (3)
			if
				iid /= Void and then
				sid /= Void and then not sid.is_whitespace and then
				attached sql_read_date_time (5) as dt_first
			then
				check same_uid: a_user /= Void implies sql_read_integer_64 (3) = a_user.id end
				if a_user = Void then
					create Result.make (create {CMS_PARTIAL_USER}.make_with_id (uid), iid, sid, dt_first)
				else
					create Result.make (a_user, iid, sid, dt_first)
				end
				Result.set_state (sql_read_integer_32 (4))
				Result.set_last_date (sql_read_date_time (6))
				Result.set_title (sql_read_string_32 (7))
				Result.set_data (sql_read_string_32 (8))
			end
		end

feature -- Change

	save_installation (inst: ES_CLOUD_INSTALLATION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := installation (inst.id, inst.license_id) = Void

			reset_error
			create l_params.make (10)
			l_params.force (inst.id, "iid")
			l_params.force (inst.license_id, "lid")
			l_params.force (inst.name, "name")
			l_params.force (inst.info, "info")
			l_params.force (1, "status")
			if attached inst.creation_date as dt then
				l_params.force (dt, "creation")
			else
				l_params.force (create {DATE_TIME}.make_now_utc, "creation")
			end

			if l_is_new then
				sql_insert (sql_insert_installation, l_params)
				sql_finalize_insert (sql_insert_installation)
			else
				sql_modify (sql_update_installation, l_params)
				sql_finalize_modify (sql_update_installation)
			end
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION; a_user: detachable ES_CLOUD_USER)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (inst.id, "iid")
			if a_user /= Void then
				l_params.force (a_user.id, "uid")
				sql_delete (sql_delete_installation_user_sessions, l_params)
				sql_finalize_delete (sql_delete_installation_user_sessions)
			else
				sql_delete (sql_delete_installation_sessions, l_params)
				sql_finalize_delete (sql_delete_installation_sessions)
			end

			if not has_error then
				create l_params.make (1)
				l_params.force (inst.id, "iid")
				l_params.force (inst.license_id, "lid")
				sql_delete (sql_delete_installation, l_params)
				sql_finalize_delete (sql_delete_installation)
			end
		end

	update_installation_license (inst: ES_CLOUD_INSTALLATION; a_lic: ES_CLOUD_LICENSE)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (3)
			l_params.force (inst.id, "iid")
			l_params.force (inst.license_id, "lid")
			l_params.force (a_lic.id, "nlid")

			sql_modify (sql_update_installation_license, l_params)
			sql_finalize_modify (sql_update_installation_license)
		end

	save_session (a_session: ES_CLOUD_SESSION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := user_session (a_session.user, a_session.installation_id, a_session.id) = Void

			reset_error
			create l_params.make (8)
			l_params.force (a_session.id, "sid")
			l_params.force (a_session.installation_id, "iid")
			l_params.force (a_session.user.id, "uid")
			l_params.force (a_session.state, "state")
			l_params.force (a_session.first_date, "first")
			l_params.force (a_session.last_date, "last")
			l_params.force (a_session.title, "title")
			l_params.force (a_session.data, "data")

			if l_is_new then
				sql_insert (sql_insert_session, l_params)
				sql_finalize_insert (sql_insert_session)
			else
				sql_modify (sql_update_session, l_params)
				sql_finalize_modify (sql_update_session)
			end
		end

	cleanup_sessions (dt: DATE_TIME)
			-- Cleanup sessions olde than `dt`
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			sql_begin_transaction

			create l_params.make (1)
			l_params.force (dt, "last")

			sql_insert (sql_archive_old_sessions, l_params)
			sql_finalize_insert (sql_archive_old_sessions)
			if not has_error then
				sql_delete (sql_delete_old_sessions, l_params)
				sql_finalize_delete (sql_delete_old_sessions)
			end
			if has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

feature {NONE} -- Fetcher

	fetch_installation: detachable ES_CLOUD_INSTALLATION
		local
			iid: READABLE_STRING_32
			lid: INTEGER_64
		do
			iid := sql_read_string_32 (1)
			lid := sql_read_integer_64 (2)
			if
				iid /= Void and then not iid.is_whitespace and then
				lid > 0
			then
				create Result.make_with_license_id (iid, lid)
				Result.set_name (sql_read_string_32 (3))
				Result.set_info (sql_read_string_32 (4))
				Result.set_status (sql_read_integer_32 (5))
				Result.set_creation_date (sql_read_date_time (6))
			else
				check valid_record: False end
			end
		end

feature {NONE} -- Queries: installations

	sql_select_installation: STRING = "SELECT iid, lid, name, info, status, creation FROM es_installations WHERE iid=:iid AND lid=:lid ;"

	sql_select_installations_by_iid: STRING = "SELECT iid, lid, name, info, status, creation FROM es_installations WHERE iid=:iid;"

	sql_select_installations: STRING = "SELECT iid, lid, name, info, status, creation FROM es_installations WHERE lid=:lid;"

	sql_select_all_installations: STRING = "SELECT iid, lid, name, info, status, creation FROM es_installations;"

	sql_insert_installation: STRING = "INSERT INTO es_installations (iid, lid, name, info, status, creation) VALUES (:iid, :lid, :name, :info, :status, :creation);"

	sql_update_installation: STRING = "UPDATE es_installations SET info=:info, name=:name, status=:status WHERE iid=:iid AND lid=:lid;"

	sql_update_installation_license: STRING = "UPDATE es_installations SET lid=:nlid WHERE iid=:iid AND lid=:lid;"

	sql_delete_installation: STRING = "DELETE FROM es_installations WHERE iid=:iid AND lid=:lid;"

feature {NONE} -- Sessions

	sql_delete_installation_user_sessions: STRING = "DELETE FROM es_sessions WHERE iid=:iid AND uid=:uid;"

	sql_delete_installation_sessions: STRING = "DELETE FROM es_sessions WHERE iid=:iid;"

	sql_archive_old_sessions: STRING = "INSERT INTO es_sessions_archive (sid, iid, uid, state, first, last, title, data) SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE last <= :last";

	sql_delete_old_sessions: STRING = "DELETE FROM es_sessions WHERE last <= :last;"

	sql_select_last_user_session: STRING = "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE uid=:uid ORDER BY last DESC LIMIT 1;"

	sql_select_last_user_session_for_installation: STRING = "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE iid=:iid AND uid=:uid ORDER BY last DESC LIMIT 1;"

	sql_select_last_user_session_by_license: STRING = "[
			SELECT 
				s.sid, s.iid, s.uid, s.state, s.first, s.last, s.title, s.data
			FROM es_sessions as s
			INNER JOIN es_installations ON es_installations.iid = s.iid
			WHERE es_installations.lid=:lid
			ORDER BY s.last DESC LIMIT 1
			;
		]"

	sql_select_user_session: STRING = "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE sid=:sid AND iid=:iid AND uid=:uid;"

	sql_select_user_sessions: STRING = "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE uid=:uid;"

	sql_select_user_active_sessions: STRING
		once
			Result := "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE uid=:uid AND state!=" + {ES_CLOUD_SESSION}.state_ended_id.out + ";"
		end

	sql_select_user_installation_sessions: STRING = "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE iid=:iid AND uid=:uid;"

	sql_select_user_active_installation_sessions: STRING
		once
			Result := "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE iid=:iid AND uid=:uid AND state!=" + {ES_CLOUD_SESSION}.state_ended_id.out + ";"
		end

	sql_select_installation_sessions: STRING = "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE iid=:iid;"
	sql_select_active_installation_sessions: STRING
		once
			Result := "SELECT sid, iid, uid, state, first, last, title, data FROM es_sessions WHERE iid=:iid AND state!=" + {ES_CLOUD_SESSION}.state_ended_id.out + ";"
		end

	sql_insert_session: STRING = "INSERT INTO es_sessions (sid, iid, uid, state, first, last, title, data) VALUES (:sid, :iid, :uid, :state, :first, :last, :title, :data);"

	sql_update_session: STRING = "UPDATE es_sessions SET state=:state, first=:first, last=:last, title=:title, data=:data WHERE sid=:sid AND iid=:iid AND uid=:uid;"

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
