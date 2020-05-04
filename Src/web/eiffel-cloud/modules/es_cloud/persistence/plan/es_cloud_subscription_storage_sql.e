note
	description: "Interface for accessing plan from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_SUBSCRIPTION_STORAGE_SQL

inherit
	ES_CLOUD_SUBSCRIPTION_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

feature -- Access: plan

	plan (a_plan_id: INTEGER): detachable ES_CLOUD_PLAN
		deferred
		end

feature -- Access: plan		

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			create {ARRAYED_LIST [ES_CLOUD_PLAN_SUBSCRIPTION]} Result.make (10)
			Result.append (organization_subscriptions)
			Result.append (user_subscriptions)
		end

feature -- Access: subscriptions				

	plan_subscriptions_for (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_PLAN_SUBSCRIPTION]} Result.make (0)
			create l_params.make (1)
			l_params["pid"] := a_plan.id.out
			sql_query (sql_select_plan_subscriptions, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_plan_user_subscription (a_plan) as sub then
						Result.force (sub)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_plan_subscriptions)
		end

	user_subscriptions: LIST [ES_CLOUD_PLAN_USER_SUBSCRIPTION]
		local
			pl: ES_CLOUD_PLAN
			pid, uid: INTEGER
			sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION
			s: READABLE_STRING_8
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_PLAN_USER_SUBSCRIPTION]} Result.make (0)
			sql_query (sql_select_users_subscriptions, Void)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					pid := sql_read_integer_32 (1)
					s := sql_read_string (2)
					if s /= Void then
						create pl.make_with_id_and_name (pid, s)
					else
						create pl.make_with_id_and_name (pid, "plan#" + pid.out)
					end
					pl.set_title (sql_read_string_32 (3))
					pl.set_description (sql_read_string_32 (4))
					pl.set_data (sql_read_string_32 (5))

					uid := sql_read_integer_32 (6)
					create sub.make (create {ES_CLOUD_USER}.make (create {CMS_PARTIAL_USER}.make_with_id (uid)), pl)
					if attached sql_read_date_time (7) as dt then
						sub.set_creation_date (dt)
					else
						check has_creation_date: False end
					end
					sub.set_expiration_date (sql_read_date_time (8))
					sub.set_notes (sql_read_string_32 (9))
					Result.force (sub)
					sql_forth
				end
			end
			sql_finalize_query (sql_select_users_subscriptions)
		end

	user_plan_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_USER_SUBSCRIPTION
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			pl: ES_CLOUD_PLAN
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_user.id, "uid")
			sql_query (sql_select_user_subscription, l_params)
			sql_start
			if not has_error and not sql_after then
				pid := sql_read_integer_32 (1)
				create pl.make_with_id_and_name (pid, "_")
				check same_uid: sql_read_integer_64 (2) = a_user.id end
				create Result.make (a_user, pl)
				if attached sql_read_date_time (3) as dt then
					Result.set_creation_date (dt)
				else
					check has_creation_date: False end
				end
				Result.set_expiration_date (sql_read_date_time (4))
				Result.set_notes (sql_read_string_32 (5))
			end
			sql_finalize_query (sql_select_user_subscription)
			if Result /= Void then
				if pid > 0 and then attached plan (pid) as l_plan then
					Result.set_plan (l_plan)
				else
					check valid_record: False end
					Result := Void
				end
			end
		end

	organization_subscriptions: LIST [ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION]
		local
			pl: ES_CLOUD_PLAN
			pid, oid: INTEGER
			sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION
			org: ES_CLOUD_ORGANIZATION
			s: READABLE_STRING_8
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION]} Result.make (0)
			sql_query (sql_select_organizations_subscriptions, Void)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					pid := sql_read_integer_32 (1)
					s := sql_read_string (2)
					if s = Void then
						s := "plan#" + pid.out
					end
					create pl.make_with_id_and_name (pid, s)
					pl.set_title (sql_read_string_32 (3))
					pl.set_description (sql_read_string_32 (4))
					pl.set_data (sql_read_string_32 (5))

					oid := sql_read_integer_32 (6)
					s := sql_read_string (7)
					if s = Void then
						s := "org#" + oid.out
					end
					create org.make (oid, s)
					org.set_title (sql_read_string_32 (8))
					org.set_description (sql_read_string_32 (9))
					org.set_data (sql_read_string_32 (10))

					create sub.make (org, pl)
					if attached sql_read_date_time (11) as dt then
						sub.set_creation_date (dt)
					else
						check has_creation_date: False end
					end
					sub.set_expiration_date (sql_read_date_time (12))
					sub.set_notes (sql_read_string_32 (13))
					Result.force (sub)
					sql_forth
				end
			end
			sql_finalize_query (sql_select_organizations_subscriptions)
		end

	organization_plan_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			pl: ES_CLOUD_PLAN
		do
			reset_error
			create l_params.make (1)
			l_params.force (org.id, "oid")
			sql_query (sql_select_organization_subscription, l_params)
			sql_start
			if not has_error and not sql_after then
				create pl.make ("_")
				pid := sql_read_integer_32 (1)
				check same_uid: sql_read_integer_64 (2) = org.id end
				create Result.make (org, pl)
				if attached sql_read_date_time (3) as dt then
					Result.set_creation_date (dt)
				else
					check has_creation_date: False end
				end
				Result.set_expiration_date (sql_read_date_time (4))
				Result.set_notes (sql_read_string_32 (5))
			end
			sql_finalize_query (sql_select_organization_subscription)
			if Result /= Void then
				if pid > 0 and then attached plan (pid) as l_plan then
					Result.set_plan (l_plan)
				else
					check valid_record: False end
					Result := Void
				end
			end
		end

feature -- Change

	save_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := user_plan_subscription (sub.user) = Void

			reset_error
			create l_params.make (5)
			l_params.force (sub.plan.id, "pid")
			l_params.force (sub.user.id, "uid")
			l_params.force (sub.creation_date, "creation")
			l_params.force (sub.expiration_date, "expiration")
			l_params.force (sub.notes, "notes")
			if l_is_new then
				sql_insert (sql_insert_user_subscription, l_params)
				sql_finalize_insert (sql_insert_user_subscription)
			else
				sql_modify (sql_update_user_subscription, l_params)
				sql_finalize_modify (sql_update_user_subscription)
			end
		end

	discard_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (sub.plan.id, "pid")
			l_params.force (sub.user.id, "uid")
			sql_delete (sql_delete_user_subscription, l_params)
			sql_finalize_delete (sql_delete_user_subscription)
		end

	save_organization_subscription (sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := organization_plan_subscription (sub.organization) = Void

			reset_error
			create l_params.make (5)
			l_params.force (sub.plan.id, "pid")
			l_params.force (sub.organization.id, "oid")
			l_params.force (sub.creation_date, "creation")
			l_params.force (sub.expiration_date, "expiration")
			l_params.force (sub.notes, "notes")
			if l_is_new then
				sql_insert (sql_insert_organization_subscription, l_params)
				sql_finalize_insert (sql_insert_organization_subscription)
			else
				sql_modify (sql_update_organization_subscription, l_params)
				sql_finalize_modify (sql_update_organization_subscription)
			end
		end

	discard_organization_subscription (sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (sub.plan.id, "pid")
			l_params.force (sub.organization.id, "oid")
			sql_delete (sql_delete_organization_subscription, l_params)
			sql_finalize_delete (sql_delete_organization_subscription)
		end

feature {NONE} -- Fetcher

	fetch_plan_user_subscription (a_plan: ES_CLOUD_PLAN): detachable ES_CLOUD_PLAN_USER_SUBSCRIPTION
		local
			pid: INTEGER
			pl: ES_CLOUD_PLAN
			u: CMS_PARTIAL_USER
		do
				--	"SELECT pid, uid, creation, expiration, notes FROM es_plan_subscriptions WHERE pid=:pid;"
			pid := sql_read_integer_32 (1)
			check pid = a_plan.id end
			pl := a_plan
			pid := sql_read_integer_32 (1)
			create u.make_with_id (sql_read_integer_32 (2))
			create Result.make (create {ES_CLOUD_USER}.make (u), pl)
			if attached sql_read_date_time (3) as dt then
				Result.set_creation_date (dt)
			else
				check has_creation_date: False end
			end
			Result.set_expiration_date (sql_read_date_time (4))
			Result.set_notes (sql_read_string_32 (5))
		end

	fetch_plan_organization_subscription (a_plan: ES_CLOUD_PLAN): detachable ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION
		local
			pid: INTEGER
			pl: ES_CLOUD_PLAN
		do
				--	"SELECT pid, uid, creation, expiration, notes FROM es_plan_subscriptions WHERE pid=:pid;"
			pid := sql_read_integer_32 (1)
			check pid = a_plan.id end
			pl := a_plan
			pid := sql_read_integer_32 (1)
			create Result.make (create {ES_CLOUD_ORGANIZATION}.make_with_id (sql_read_integer_32 (2)), pl)
			if attached sql_read_date_time (3) as dt then
				Result.set_creation_date (dt)
			else
				check has_creation_date: False end
			end
			Result.set_expiration_date (sql_read_date_time (4))
			Result.set_notes (sql_read_string_32 (5))
		end

feature {NONE} -- Queries: subscriptions

	sql_select_plan_subscriptions: STRING = "SELECT pid, uid, creation, expiration, notes FROM es_plan_subscriptions WHERE pid=:pid;"

	sql_select_users_subscriptions: STRING = "[
			SELECT es_plan_subscriptions.pid, es_plans.name, es_plans.title, es_plans.description, es_plans.data, 
				   es_plan_subscriptions.uid, es_plan_subscriptions.creation, es_plan_subscriptions.expiration, es_plan_subscriptions.notes 
			FROM es_plan_subscriptions INNER JOIN es_plans ON es_plan_subscriptions.pid = es_plans.pid;
			]"

	sql_select_user_subscription: STRING = "SELECT pid, uid, creation, expiration, notes FROM es_plan_subscriptions WHERE uid=:uid;"

	sql_insert_user_subscription: STRING = "INSERT INTO es_plan_subscriptions (pid, uid, creation, expiration, notes) VALUES (:pid, :uid, :creation, :expiration, :notes);"

	sql_update_user_subscription: STRING = "UPDATE es_plan_subscriptions SET pid=:pid, creation=:creation, expiration=:expiration, notes=:notes WHERE uid=:uid;"

	sql_delete_user_subscription: STRING = "DELETE FROM es_plan_subscriptions WHERE pid=:pid AND uid=:uid;"


	sql_select_plan_organization_subscriptions: STRING = "SELECT pid, oid, creation, expiration, notes FROM es_plan_org_sub WHERE pid=:pid;"

	sql_select_organizations_subscriptions: STRING = "[
			SELECT es_plan_org_sub.pid, es_plans.name, es_plans.title, es_plans.description, es_plans.data, 
				   es_plan_org_sub.oid, es_orgs.name, es_orgs.title, es_orgs.description, es_orgs.data,
				   es_plan_org_sub.creation, es_plan_org_sub.expiration, es_plan_org_sub.notes
			FROM ((es_plan_org_sub 
				INNER JOIN es_plans ON es_plan_org_sub.pid = es_plans.pid)
				INNER JOIN es_orgs ON es_plan_org_sub.oid = es_orgs.oid);
			]"

	sql_select_organization_subscription: STRING = "SELECT pid, oid, creation, expiration, notes FROM es_plan_org_sub WHERE oid=:oid;"

	sql_insert_organization_subscription: STRING = "INSERT INTO es_plan_org_sub (pid, oid, creation, expiration, notes) VALUES (:pid, :oid, :creation, :expiration, :notes);"

	sql_update_organization_subscription: STRING = "UPDATE es_plan_org_sub SET pid=:pid, creation=:creation, expiration=:expiration, notes=:notes WHERE oid=:oid;"

	sql_delete_organization_subscription: STRING = "DELETE FROM es_plan_org_sub WHERE pid=:pid AND oid=:oid;"

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
