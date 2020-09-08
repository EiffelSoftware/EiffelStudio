note
	description: "Interface for accessing plan from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_PLAN_STORAGE_SQL

inherit
	ES_CLOUD_PLAN_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

feature -- Access: plan

	plans: LIST [ES_CLOUD_PLAN]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_PLAN]} Result.make (0)
			sql_query (sql_select_plans, Void)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_plan as pl then
						Result.force (pl)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_plans)
		end

	plan (a_id: INTEGER): detachable ES_CLOUD_PLAN
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_id, "pid")
			sql_query (sql_select_plan_by_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_plan
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_plan_by_id)
		end

feature -- Access: License

	licenses: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER]]
		local
			uid: INTEGER_64
			u: ES_CLOUD_USER
		do
			reset_error
			create {ARRAYED_LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER]]} Result.make (0)
			sql_query (sql_select_licenses, Void)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_license (Void) as lic then
						uid := sql_read_integer_64 (12)
						if uid /= 0 then
							u := create {CMS_PARTIAL_USER}.make_with_id (uid)
						else
							u := Void
						end
						Result.force ([lic, u])
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_licenses)
		end

	licenses_for_plan (a_plan: ES_CLOUD_PLAN): like licenses
		local
			uid: INTEGER_64
			u: ES_CLOUD_USER
		do
			reset_error
			create {ARRAYED_LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER]]} Result.make (0)
			sql_query (sql_select_licenses_by_plan, sql_parameters (1, <<["pid", a_plan.id]>>))
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_license (a_plan) as lic then
						uid := sql_read_integer_64 (12)
						if uid /= 0 then
							u := create {CMS_PARTIAL_USER}.make_with_id (uid)
						else
							u := Void
						end
						Result.force ([lic, u])
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_licenses)
		end

	license (a_license_id: INTEGER_64): detachable ES_CLOUD_LICENSE
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license_id, "lid")
			sql_query (sql_select_license_by_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_license (Void)
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_license_by_id)
		end

	license_by_key (a_license_key: READABLE_STRING_GENERAL): detachable ES_CLOUD_LICENSE
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license_key.as_lower, "lowerkey")
			sql_query (sql_select_license_by_key, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_license (Void)
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_license_by_key)
		end

	user_id_for_license (a_license: ES_CLOUD_LICENSE): INTEGER_64
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license.id, "lid")
			sql_query (sql_select_user_with_license_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (sql_select_user_with_license_id)
		end

	user_has_license (a_user: ES_CLOUD_USER; a_license_id: INTEGER_64): BOOLEAN
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_user.id, "uid")
			l_params.force (a_license_id, "lid")
			sql_query (sql_select_user_license_by_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := True
			end
			sql_finalize_query (sql_select_user_license_by_id)
		end

	user_licenses (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_USER_LICENSE]
		local
			l_params: STRING_TABLE [detachable ANY]
			lst: ARRAYED_LIST [INTEGER_64]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_USER_LICENSE]} Result.make (0)
			create l_params.make (1)
			l_params.force (a_user.id, "uid")

			create lst.make (3)
			sql_query (sql_select_user_licenses, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					check same_uid: a_user.id = sql_read_integer_64 (2) end
					lst.force (sql_read_integer_64 (1))
					sql_forth
				end
			end
			sql_finalize_query (sql_select_user_licenses)
			across
				lst as ic
			loop
				if attached license (ic.item) as lic then
					Result.force (create {ES_CLOUD_USER_LICENSE}.make (a_user, lic))
				end
			end
		end

	email_for_license (a_license: ES_CLOUD_LICENSE): detachable READABLE_STRING_8
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license.id, "lid")
			sql_query (sql_select_email_with_license_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := sql_read_string_8 (1)
			end
			sql_finalize_query (sql_select_email_with_license_id)
		end

	email_licenses (a_email: READABLE_STRING_8): LIST [ES_CLOUD_EMAIL_LICENSE]
		local
			l_params: STRING_TABLE [detachable ANY]
			lst: ARRAYED_LIST [INTEGER_64]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_EMAIL_LICENSE]} Result.make (0)
			create l_params.make (1)
			l_params.force (a_email, "email")

			create lst.make (3)
			sql_query (sql_select_email_licenses, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					lst.force (sql_read_integer_64 (1))
					sql_forth
				end
			end
			sql_finalize_query (sql_select_email_licenses)
			across
				lst as ic
			loop
				if attached license (ic.item) as lic then
					Result.force (create {ES_CLOUD_EMAIL_LICENSE}.make (a_email, lic))
				end
			end
		end

feature -- Element change: license

	last_inserted_license_id: INTEGER_64
			-- Last insert node id.
		do
			error_handler.reset
			sql_query (sql_last_inserted_license_id, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_statement (sql_last_inserted_license_id)
		end

	save_license (a_license: ES_CLOUD_LICENSE)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := not a_license.has_id
			if l_is_new and then attached license_by_key (a_license.key) as l_existing_license then
					-- Prevent multiple license with same key !!!
				l_is_new := False
				a_license.update_id (l_existing_license.id)
			end
			reset_error
			if l_is_new then
				create l_params.make (8)
			else
				create l_params.make (9)
				l_params.force (a_license.id, "lid")
			end
			l_params.force (a_license.plan.id, "pid")
			l_params.force (a_license.key, "license_key")
			l_params.force (a_license.platforms_as_csv_string, "platform")
			l_params.force (a_license.version, "version")
			l_params.force (a_license.status, "status")
			l_params.force (a_license.creation_date, "creation")
			l_params.force (a_license.expiration_date, "expiration")
			l_params.force (a_license.fallback_date, "fallback")
			if l_is_new then
				sql_insert (sql_insert_license, l_params)
				sql_finalize_insert (sql_insert_license)
				a_license.update_id (last_inserted_license_id)
			else
				sql_modify (sql_update_license, l_params)
				sql_finalize_modify (sql_update_license)
			end
		end

	delete_license (a_license: ES_CLOUD_LICENSE)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license.id, "lid")
			sql_delete (sql_delete_license, l_params)
			sql_finalize_delete (sql_delete_license)
		end

	assign_license_to_user (a_license: ES_CLOUD_LICENSE; a_user: ES_CLOUD_USER)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_license.id, "lid")
			l_params.force (a_user.id, "uid")
			sql_insert (sql_insert_user_license, l_params)
			sql_finalize_insert (sql_insert_user_license)
		end

	unassign_license_from_user (a_license: ES_CLOUD_LICENSE; a_user: ES_CLOUD_USER)
		require
			user_has_license (a_user, a_license.id)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_license.id, "lid")
			l_params.force (a_user.id, "uid")
			sql_delete (sql_delete_user_license, l_params)
			sql_finalize_delete (sql_delete_user_license)
		end

	assign_license_to_email (a_license: ES_CLOUD_LICENSE; a_email: READABLE_STRING_8)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_license.id, "lid")
			l_params.force (a_email, "email")
			sql_insert (sql_insert_email_license, l_params)
			sql_finalize_insert (sql_insert_email_license)
		end

	unassign_license_from_email (a_license: ES_CLOUD_LICENSE; a_email: READABLE_STRING_8)
		require
--			email_has_license
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_license.id, "lid")
			l_params.force (a_email, "email")
			sql_delete (sql_delete_email_license, l_params)
			sql_finalize_delete (sql_delete_email_license)
		end

	move_email_license_to_user (a_email_license: ES_CLOUD_EMAIL_LICENSE; a_user: ES_CLOUD_USER)
		do
			sql_begin_transaction
			assign_license_to_user (a_email_license.license, a_user)
			if not has_error then
				unassign_license_from_email (a_email_license.license, a_email_license.email)
			end
			if has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

feature -- Change

	last_inserted_plan_id: INTEGER
			-- Last insert node id.
		do
			error_handler.reset
			sql_query (sql_last_inserted_plan_id, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_32 (1)
			end
			sql_finalize_statement (sql_last_inserted_plan_id)
		end

	save_plan (a_plan: ES_CLOUD_PLAN)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := not a_plan.has_id

			reset_error
			if l_is_new then
				create l_params.make (4)
			else
				create l_params.make (5)
				l_params.force (a_plan.id, "pid")
			end
			l_params.force (a_plan.name, "name")
			l_params.force (a_plan.title, "title")
			l_params.force (a_plan.description, "description")
			l_params.force (a_plan.data, "data")
			if l_is_new then
				sql_insert (sql_insert_plan, l_params)
				sql_finalize_insert (sql_insert_plan)
				a_plan.update_id (last_inserted_plan_id)
			else
				sql_modify (sql_update_plan, l_params)
				sql_finalize_modify (sql_update_plan)
			end
		end

	delete_plan (a_plan: ES_CLOUD_PLAN)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_plan.id, "pid")
			sql_delete (sql_delete_plan, l_params)
			sql_finalize_delete (sql_delete_plan)
		end

feature {NONE} -- Fetcher

	fetch_plan: detachable ES_CLOUD_PLAN
		local
			pid: INTEGER
			l_name: READABLE_STRING_8
		do
			pid := sql_read_integer_32 (1)
			l_name := sql_read_string (2)
			if l_name = Void then
				l_name := "plan#" + pid.out
			end
			create Result.make_with_id_and_name (pid, l_name)
			Result.set_title (sql_read_string_32 (3))
			Result.set_description (sql_read_string_32 (4))
			Result.set_data (sql_read_string_32 (5))
		end

	fetch_license (a_plan: detachable ES_CLOUD_PLAN): detachable ES_CLOUD_LICENSE
		local
			lid: INTEGER_64
			pid: INTEGER
			l_key: READABLE_STRING_32
			l_plan_name: READABLE_STRING_8
			l_plan: ES_CLOUD_PLAN
			i: INTEGER
		do
			lid := sql_read_integer_64 (1)
			l_key := sql_read_string_32 (2)

			pid := sql_read_integer_32 (3)

			if a_plan /= Void then
				l_plan := a_plan
				i := 3
			else
				l_plan_name := sql_read_string (4)
				if l_plan_name = Void then
					l_plan_name := "plan#" + pid.out
				end

				create l_plan.make_with_id_and_name (pid, l_plan_name)
				l_plan.set_data (sql_read_string_32 (5))

				i := 5
			end

			if l_key = Void then
				l_key := l_plan.name.to_string_32 + "_LIC_" + lid.out
			end
			create Result.make_with_id (lid, l_key, l_plan)
			if attached sql_read_string_32 (i + 1) as s then
				Result.set_platforms_restriction (s)
			end
			if attached sql_read_string_32 (i + 2) as s then
				Result.set_version (s)
			end
			if attached sql_read_integer_32 (i + 3) as st then
				Result.set_status (st)
			end

			if attached sql_read_date_time (i + 4) as dt then
				Result.set_creation_date (dt)
			end
			if attached sql_read_date_time (i + 5) as dt then
				Result.set_expiration_date (dt)
			end
			if attached sql_read_date_time (i + 6) as dt then
				Result.set_fallback_date (dt)
			end
		end

feature {NONE} -- Queries: plans	

	sql_last_inserted_plan_id: STRING = "SELECT MAX(pid) FROM es_plans;"

	sql_select_plans: STRING = "SELECT pid, name, title, description, data FROM es_plans;"

	sql_select_plan_by_id: STRING = "SELECT pid, name, title, description, data FROM es_plans WHERE pid=:pid;"

	sql_insert_plan: STRING = "INSERT INTO es_plans (name, title, description, data) VALUES (:name, :title, :description, :data);"

	sql_update_plan: STRING = "UPDATE es_plans SET name=:name, title=:title, description=:description, data=:data WHERE pid=:pid;"

	sql_delete_plan: STRING = "DELETE FROM es_plans WHERE pid=:pid;"

feature {NONE} -- Queries: licenses

	sql_last_inserted_license_id: STRING = "SELECT MAX(lid) FROM es_licenses;"

	sql_insert_license: STRING = "INSERT INTO es_licenses (pid, license_key, platform, version, status, creation, expiration, fallback) VALUES (:pid, :license_key, :platform, :version, :status, :creation, :expiration, :fallback);"

	sql_update_license: STRING = "UPDATE es_licenses SET pid=:pid, license_key=:license_key, platform=:platform, version=:version, status=:status, creation=:creation, expiration=:expiration, fallback=:fallback WHERE lid=:lid;"

	sql_delete_license: STRING = "DELETE FROM es_licenses WHERE lid=:lid;"

	sql_select_licenses: STRING = "[
			SELECT 
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback,
				es_licenses_users.uid
			FROM es_licenses AS lic 
			INNER JOIN es_plans ON lic.pid = es_plans.pid 
			LEFT JOIN es_licenses_users ON lic.lid = es_licenses_users.lid
			;
		]"

	sql_select_licenses_by_plan: STRING = "[
			SELECT
				lic.lid, lic.license_key, lic.pid,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback,
				es_licenses_users.uid
			FROM es_licenses AS lic
			INNER JOIN es_licenses_users ON lic.lid = es_licenses_users.lid
			WHERE lic.pid=:pid
			;
		]"

	sql_select_license_by_id: STRING = "[
			SELECT
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback
			FROM es_licenses AS lic INNER JOIN es_plans ON lic.pid = es_plans.pid
			WHERE lic.lid=:lid
			;
		]"

	sql_select_license_by_key: STRING = "[
			SELECT
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback
			FROM es_licenses AS lic INNER JOIN es_plans ON lic.pid = es_plans.pid
			WHERE lower(lic.license_key)=:lowerkey
			;
		]"

	sql_select_user_license_by_id: STRING = "SELECT lid, uid FROM es_licenses_users WHERE uid=:uid AND lid=:lid;"

	sql_select_user_with_license_id: STRING = "SELECT uid FROM es_licenses_users WHERE lid=:lid;"

	sql_select_users_licenses: STRING = "SELECT lid, uid FROM es_licenses_users ;"

	sql_select_user_licenses: STRING = "SELECT lid, uid FROM es_licenses_users WHERE uid=:uid;"

	sql_insert_user_license: STRING = "INSERT INTO es_licenses_users (lid, uid) VALUES (:lid, :uid);"

	sql_delete_user_license: STRING = "DELETE FROM es_licenses_users WHERE lid=:lid AND uid=:uid;"


	sql_select_emails_licenses: STRING = "SELECT lid, email FROM es_licenses_emails ;"

	sql_select_email_with_license_id: STRING = "SELECT email FROM es_licenses_emails WHERE lid=:lid;"

	sql_select_email_licenses: STRING = "SELECT lid, email FROM es_licenses_emails WHERE email=:email;"

	sql_insert_email_license: STRING = "INSERT INTO es_licenses_emails (lid, email) VALUES (:lid, :email);"

	sql_delete_email_license: STRING = "DELETE FROM es_licenses_emails WHERE lid=:lid AND email=:email;"

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
