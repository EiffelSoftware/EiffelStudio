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

feature -- Access: redeem tokens

	redeem_tokens (a_plan: ES_CLOUD_PLAN; a_version: detachable READABLE_STRING_GENERAL): LIST [ES_CLOUD_REDEEM_TOKEN]
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_plan.name, "plan")

			create {ARRAYED_LIST [ES_CLOUD_REDEEM_TOKEN]} Result.make (0)
			sql_query (sql_select_redeem_tokens, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_redeem_token as tok then
						if a_version = Void then
							Result.force (tok)
						elseif attached tok.version as v and then a_version.is_case_insensitive_equal (v) then
							Result.force (tok)
						end
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_redeem_tokens)
		end

	unused_redeem_tokens_count (a_plan: ES_CLOUD_PLAN): INTEGER
			-- Count of unused redeem tokens.
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_params.make (1)
			l_params.force (a_plan.name, "plan")
			sql_query (sql_select_unused_redeem_tokens_count, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := sql_read_integer_32 (1)
			end
			sql_finalize_query (sql_select_unused_redeem_tokens_count)
		end

	redeem_token (a_token_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_REDEEM_TOKEN
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_token_name.as_lower, "lowername")
			sql_query (sql_select_redeem_token_by_name, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_redeem_token
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_redeem_token_by_name)
		end

feature -- Change: redeem tokens

	create_redeem_token (a_token: ES_CLOUD_REDEEM_TOKEN)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (7)
			l_params.force (a_token.name, "name")
			l_params.force (a_token.plan_name, "plan")
			l_params.force (a_token.version, "version")
			l_params.force (a_token.origin, "origin")
			l_params.force (a_token.license_key, "license")
			l_params.force (a_token.redeem_date, "redeem_date")
			l_params.force (a_token.notes, "notes")

			sql_insert (sql_insert_redeem_token, l_params)
			sql_finalize_insert (sql_insert_redeem_token)
		end

	save_redeem_token (a_token: ES_CLOUD_REDEEM_TOKEN)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (8)
			l_params.force (a_token.name.as_lower, "lowername")
			l_params.force (a_token.name, "name")
			l_params.force (a_token.plan_name, "plan")
			l_params.force (a_token.version, "version")
			l_params.force (a_token.origin, "origin")
			l_params.force (a_token.license_key, "license")
			l_params.force (a_token.redeem_date, "redeem_date")
			l_params.force (a_token.notes, "notes")

			sql_modify (sql_update_redeem_token, l_params)
			sql_finalize_modify (sql_update_redeem_token)
		end

feature -- Access: License

	licenses: ARRAYED_LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER; email: detachable READABLE_STRING_8; org: detachable ES_CLOUD_ORGANIZATION]]
		local
			uid, oid: INTEGER_64
			u: ES_CLOUD_USER
			e: READABLE_STRING_8
			o: ES_CLOUD_ORGANIZATION
			lst: ARRAYED_LIST [TUPLE [license: ES_CLOUD_LICENSE; uid: INTEGER_64; email: detachable READABLE_STRING_8; oid: INTEGER_64]]
		do
			reset_error
			sql_query (sql_select_licenses, Void)
			sql_start
			if not has_error then
				create lst.make (30)
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_license (Void) as lic then
						-- then 13:es_licenses_users.uid, 14:es_licenses_emails.email, 15:es_licenses_orgs.oid
						uid := sql_read_integer_64 (13)
						e := sql_read_string_8 (14)
						oid := sql_read_integer_64 (15)
						lst.force ([lic, uid, e, oid])
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_licenses)
			if lst = Void then
				create Result.make (0)
			else
				create Result.make (lst.count)
				across
					lst as ic
				loop
					uid := ic.item.uid
					oid := ic.item.oid
					if uid /= 0 then
						u := create {CMS_PARTIAL_USER}.make_with_id (uid)
					else
						u := Void
					end
					if oid /= 0 then
						o := organization_by_id (oid)
					else
						o := Void
					end
					Result.force ([ic.item.license, u, ic.item.email, o])
				end
			end
		end

	licenses_for_plan (a_plan: ES_CLOUD_PLAN): like licenses
		local
			uid, oid: INTEGER_64
			u: ES_CLOUD_USER
			e: READABLE_STRING_8
			o: ES_CLOUD_ORGANIZATION
			lst: ARRAYED_LIST [TUPLE [license: ES_CLOUD_LICENSE; uid: INTEGER_64; email: detachable READABLE_STRING_8; oid: INTEGER_64]]
		do
			reset_error
			sql_query (sql_select_licenses_by_plan, sql_parameters (1, <<["pid", a_plan.id]>>))
			sql_start
			if not has_error then
				create lst.make (30)
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_license (a_plan) as lic then
						-- then 13:es_licenses_users.uid, 14:es_licenses_emails.email, 15:es_licenses_orgs.oid
						uid := sql_read_integer_64 (13)
						e := sql_read_string_8 (14)
						oid := sql_read_integer_64 (15)
						lst.force ([lic, uid, e, oid])
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_licenses_by_plan)
			if lst = Void then
				create Result.make (0)
			else
				create Result.make (lst.count)
				across
					lst as ic
				loop
					uid := ic.item.uid
					oid := ic.item.oid
					if uid /= 0 then
						u := create {CMS_PARTIAL_USER}.make_with_id (uid)
					else
						u := Void
					end
					if oid /= 0 then
						create o.make_with_id (oid)
					else
						o := Void
					end
					Result.force ([ic.item.license, u, ic.item.email, o])
				end
			end
		end

	license (a_license_id: INTEGER_64): detachable ES_CLOUD_LICENSE
		local
			l_params: STRING_TABLE [detachable ANY]
			sql: STRING_8
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

			if Result = Void then
					-- Search in archive
				reset_error
				create sql.make_from_string (sql_select_license_by_id)
				sql.replace_substring_all ("es_licenses", "es_licenses_archive")
				sql_query (sql, l_params)

				sql_start
				if not has_error and not sql_after then
					Result := fetch_license (Void)
					if Result /= Void then
						Result.set_is_archived (True)
					end
					check valid_record: Result /= Void end
				end
				sql_finalize_query (sql)
			end
		end

	license_by_key (a_license_key: READABLE_STRING_GENERAL): detachable ES_CLOUD_LICENSE
		local
			l_params: STRING_TABLE [detachable ANY]
			sql: STRING_8
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

			if Result = Void then
					-- Search in archive
				reset_error

				create sql.make_from_string (sql_select_license_by_key)
				sql.replace_substring_all ("es_licenses", "es_licenses_archive")
				sql_query (sql, l_params)
				sql_start
				if not has_error and not sql_after then
					Result := fetch_license (Void)
					if Result /= Void then
						Result.set_is_archived (True)
					end
					check valid_record: Result /= Void end
				end
				sql_finalize_query (sql)
			end
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

	subscribed_licenses (a_order_ref: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_LICENSE]
		local
			l_params: STRING_TABLE [detachable ANY]
			lst: ARRAYED_LIST [READABLE_STRING_32]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_order_ref.as_lower, "lower_ref")

			create lst.make (1)
			sql_query (sql_select_subscribed_licenses, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached sql_read_string_32 (1) as s then
						lst.force (s)
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_subscribed_licenses)
			if not lst.is_empty then
				create {ARRAYED_LIST [ES_CLOUD_LICENSE]} Result.make (0)
				across
					lst as ic
				loop
					if attached license_by_key (ic.item) as lic then
						Result.force (lic)
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

	license_subscription (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_LICENSE_SUBSCRIPTION
		local
			l_params: STRING_TABLE [detachable ANY]
			t,c: NATURAL_8
			l_interval: READABLE_STRING_8
			i: INTEGER
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_license.key.as_lower, "lowerkey")
			sql_query (sql_select_license_subscription, l_params)
			sql_start
			if not has_error and not sql_after then
				check same_license_key: attached sql_read_string_32 (1) as lic_key and then a_license.key.is_case_insensitive_equal_general (lic_key) end
				l_interval := sql_read_string (2)
				if l_interval /= Void and then not l_interval.is_whitespace then
					i := l_interval.index_of ('x', 1)
					if i > 0 then
						c := l_interval.head (i - 1).to_natural_8
						l_interval := l_interval.substring (i + 1, l_interval.count)
					else
						c := 1
					end
					if l_interval.is_case_insensitive_equal_general ("yearly") then
						t := {ES_CLOUD_LICENSE_SUBSCRIPTION}.yearly
					elseif l_interval.is_case_insensitive_equal_general ("monthly") then
						t := {ES_CLOUD_LICENSE_SUBSCRIPTION}.monthly
					elseif l_interval.is_case_insensitive_equal_general ("weekly") then
						t := {ES_CLOUD_LICENSE_SUBSCRIPTION}.weekly
					elseif l_interval.is_case_insensitive_equal_general ("daily") then
						t := {ES_CLOUD_LICENSE_SUBSCRIPTION}.daily
					elseif l_interval.is_case_insensitive_equal_general ("onetime") then
						t := {ES_CLOUD_LICENSE_SUBSCRIPTION}.onetime
					else
						check invalid_interval_type: False end
						t := {ES_CLOUD_LICENSE_SUBSCRIPTION}.undefined_interval
					end
				end
				create Result.make (a_license, t, c)

				if attached sql_read_string_32 (3) as ref then
					Result.set_subscription_reference (ref)
				end
				if attached sql_read_date_time (4) as dt then
					Result.set_cancellation_date (dt)
				end

				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_license_subscription)
		end

	save_license_subscription (a_sub: ES_CLOUD_LICENSE_SUBSCRIPTION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
			s: STRING
		do
			if attached license_subscription (a_sub.license) as sub then
					-- Updating ...
			else
				l_is_new := True
			end
			reset_error
			if l_is_new then
				create l_params.make (5)
				l_params.force (a_sub.license.key, "license_key")
			else
				create l_params.make (4)
			end
			create s.make (6)
			if a_sub.interval_count > 1 then
				s.append (a_sub.interval_count.out)
				s.append_character ('x')
			end
			if a_sub.is_yearly then
				s.append ("yearly")
			elseif a_sub.is_monthly then
				s.append ("monthly")
			elseif a_sub.is_weekly then
				s.append ("weekly")
			elseif a_sub.is_daily then
				s.append ("daily")
			elseif a_sub.is_onetime then
				s.append ("onetime")
			end
			l_params.force (s, "interval_type")
			l_params.force (a_sub.subscription_reference, "ref")
			l_params.force (a_sub.cancellation_date, "cancel_date")
			if l_is_new then
				sql_insert (sql_insert_license_subscription, l_params)
				sql_finalize_insert (sql_insert_license_subscription)
			else
				sql_modify (sql_update_license_subscription, l_params)
				sql_finalize_modify (sql_update_license_subscription)
			end
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
			a_license.has_id
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
			a_license.has_id
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

	archive_license (lic: ES_CLOUD_LICENSE)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			sql_begin_transaction

			create l_params.make (1)
			l_params.force (lic.id, "lid")
--			l_params.force (lic.plan.id, "pid")
--			l_params.force (lic.key.as_lower, "lowerkey")

			sql_insert (sql_archive_license, l_params)
			sql_finalize_insert (sql_archive_license)
			if not has_error then
				delete_license (lic)
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
				create l_params.make (5)
			else
				create l_params.make (6)
				l_params.force (a_plan.id, "pid")
			end
			l_params.force (a_plan.name, "name")
			l_params.force (a_plan.title, "title")
			l_params.force (a_plan.description, "description")
			l_params.force (a_plan.data, "data")
			l_params.force (a_plan.usage_limitations_data, "limitations")
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
			Result.set_usage_limitations_data (sql_read_string_8 (6))
		end

	fetch_redeem_token: detachable ES_CLOUD_REDEEM_TOKEN
		local
			l_name: READABLE_STRING_8
			l_plan: READABLE_STRING_8
			l_version: READABLE_STRING_8
		do
			l_name := sql_read_string_8 (1)
			l_plan := sql_read_string_8 (2)
			l_version := sql_read_string_8 (3)
			if l_name /= Void and l_plan /= Void then
				create Result.make (l_name, l_plan, l_version)
				Result.set_origin (sql_read_string_32 (4))
				Result.set_license_key (sql_read_string_32 (5), sql_read_date_time (6))
				Result.set_notes (sql_read_string_32 (7))
			end
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
				i := 6
			else
				l_plan_name := sql_read_string (4)
				if l_plan_name = Void then
					l_plan_name := "plan#" + pid.out
				end

				create l_plan.make_with_id_and_name (pid, l_plan_name)
				l_plan.set_data (sql_read_string_32 (5))
				l_plan.set_usage_limitations_data (sql_read_string_32 (6))

				i := 6
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

	sql_select_plans: STRING = "SELECT pid, name, title, description, data, limitations FROM es_plans;"

	sql_select_plan_by_id: STRING = "SELECT pid, name, title, description, data, limitations FROM es_plans WHERE pid=:pid;"

	sql_insert_plan: STRING = "INSERT INTO es_plans (name, title, description, data, limitations) VALUES (:name, :title, :description, :data, :limitations);"

	sql_update_plan: STRING = "UPDATE es_plans SET name=:name, title=:title, description=:description, data=:data, limitations=:limitations WHERE pid=:pid;"

	sql_delete_plan: STRING = "DELETE FROM es_plans WHERE pid=:pid;"

feature {NONE} -- Queries: redeem token

	sql_select_redeem_tokens: STRING = "SELECT name, plan, version, origin, license, redeem_date, notes FROM es_redeems WHERE plan = :plan;"

	sql_select_redeem_token_by_name: STRING = "SELECT name, plan, version, origin, license, redeem_date, notes FROM es_redeems WHERE lower(name) = :lowername;"

	sql_select_unused_redeem_tokens_count: STRING = "SELECT count(*) FROM es_redeems WHERE plan=:plan AND (license is null OR license = '');"

	sql_insert_redeem_token: STRING = "INSERT INTO es_redeems (name, plan, version,  origin, license, redeem_date, notes) VALUES (:name, :plan, :version, :origin, :license, :redeem_date, :notes);"

	sql_update_redeem_token: STRING = "UPDATE es_redeems SET name=:name, plan=:plan, version=:version, origin=:origin, license=:license, redeem_date=:redeem_date, notes=:notes  WHERE lower(name)=:lowername;"

--	sql_delete_plan: STRING = "DELETE FROM es_redeems WHERE lower(name)=:lowername;"

feature {NONE} -- Queries: licenses

	sql_last_inserted_license_id: STRING = "SELECT MAX(lid) FROM es_licenses;"

	sql_insert_license: STRING = "INSERT INTO es_licenses (pid, license_key, platform, version, status, creation, expiration, fallback) VALUES (:pid, :license_key, :platform, :version, :status, :creation, :expiration, :fallback);"

	sql_update_license: STRING = "UPDATE es_licenses SET pid=:pid, license_key=:license_key, platform=:platform, version=:version, status=:status, creation=:creation, expiration=:expiration, fallback=:fallback WHERE lid=:lid;"

	sql_delete_license: STRING = "DELETE FROM es_licenses WHERE lid=:lid;"

	sql_select_licenses: STRING = "[
			SELECT 
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data, es_plans.limitations,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback,
				es_licenses_users.uid, es_licenses_emails.email, es_licenses_orgs.oid
			FROM es_licenses AS lic 
			INNER JOIN es_plans ON lic.pid = es_plans.pid 
			LEFT JOIN es_licenses_users ON lic.lid = es_licenses_users.lid
			LEFT JOIN es_licenses_emails ON lic.lid = es_licenses_emails.lid
			LEFT JOIN es_licenses_orgs ON lic.lid = es_licenses_orgs.lid
			ORDER BY lic.creation DESC
			;
		]"

	sql_select_licenses_by_plan: STRING = "[
			SELECT
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data, es_plans.limitations,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback,
				es_licenses_users.uid, es_licenses_emails.email, es_licenses_orgs.oid
			FROM es_licenses AS lic
			LEFT JOIN es_plans ON lic.pid = es_plans.pid 
			LEFT JOIN es_licenses_users ON lic.lid = es_licenses_users.lid
			LEFT JOIN es_licenses_emails ON lic.lid = es_licenses_emails.lid
			LEFT JOIN es_licenses_orgs ON lic.lid = es_licenses_orgs.lid
			WHERE lic.pid=:pid
			ORDER BY lic.creation DESC
			;
		]"

	sql_select_license_by_id: STRING = "[
			SELECT
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data, es_plans.limitations,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback
			FROM es_licenses AS lic INNER JOIN es_plans ON lic.pid = es_plans.pid
			WHERE lic.lid=:lid
			;
		]"

	sql_select_license_by_key: STRING = "[
			SELECT
				lic.lid, lic.license_key, lic.pid, es_plans.name, es_plans.data, es_plans.limitations,
				lic.platform, lic.version, lic.status, lic.creation, lic.expiration, lic.fallback
			FROM es_licenses AS lic INNER JOIN es_plans ON lic.pid = es_plans.pid
			WHERE lower(lic.license_key)=:lowerkey
			;
		]"

	sql_select_subscribed_licenses: STRING = "SELECT license_key, interval_type, ref, cancel_date FROM es_license_subscriptions WHERE lower(ref)=:lower_ref ;"

	sql_select_license_subscription: STRING = "SELECT license_key, interval_type, ref, cancel_date FROM es_license_subscriptions WHERE lower(license_key)=:lowerkey ;"

	sql_insert_license_subscription: STRING = "INSERT INTO es_license_subscriptions (license_key, interval_type, ref, cancel_date) VALUES (:license_key, :interval_type, :ref, :cancel_date);"

	sql_update_license_subscription: STRING = "UPDATE es_license_subscriptions SET interval_type=:interval_type, ref=:ref, cancel_date=:cancel_date WHERE lower(license_key)=:lowerkey;"


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


	sql_archive_license: STRING = "INSERT INTO es_licenses_archive (lid, pid, license_key, platform, version, status, creation, expiration, fallback) SELECT lid, pid, license_key, platform, version, status, creation, expiration, fallback FROM es_licenses WHERE lid=:lid ;"
		-- or ..?  WHERE pid = :pid AND lower(license_key)=:lowerkey


note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
