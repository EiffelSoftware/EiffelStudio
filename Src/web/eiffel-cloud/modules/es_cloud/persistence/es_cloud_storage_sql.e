note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORAGE_SQL

inherit
	ES_CLOUD_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

create
	make

feature -- Access: plan

	plans: LIST [ES_CLOUD_PLAN]
		local
			pid: INTEGER
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
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
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

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			create {ARRAYED_LIST [ES_CLOUD_PLAN_SUBSCRIPTION]} Result.make (10)
			Result.append (organization_subscriptions)
			Result.append (user_subscriptions)
		end

feature -- Access: organization

	organizations: LIST [ES_CLOUD_ORGANIZATION]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_ORGANIZATION]} Result.make (0)
			sql_query (sql_select_organizations, Void)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_organization as org then
						Result.force (org)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_organizations)
		end

	organization (oid: like {ES_CLOUD_ORGANIZATION}.id): detachable ES_CLOUD_ORGANIZATION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (oid, "oid")

			sql_query (sql_select_organization_by_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_organization
			end
			sql_finalize_query (sql_select_organization_by_id)
		end

	user_organizations (a_user: ES_CLOUD_USER): detachable LIST [ES_CLOUD_ORGANIZATION]
		local
			l_params: STRING_TABLE [detachable ANY]
			lst: ARRAYED_LIST [like {ES_CLOUD_ORGANIZATION}.id]
		do
			reset_error

			create lst.make (1)
			create l_params.make (1)
			l_params["uid"] := a_user.id
			sql_query (sql_select_user_organizations, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					lst.force (sql_read_integer_64 (2))
					sql_forth
				end
			end
			sql_finalize_query (sql_select_user_organizations)
			if not lst.is_empty then
				create {ARRAYED_LIST [ES_CLOUD_ORGANIZATION]} Result.make (lst.count)
				across
					lst as ic
				loop
					if attached organization (ic.item) as org then
						Result.force (org)
					end
				end
			end
		end

	save_organization (org: ES_CLOUD_ORGANIZATION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_name: detachable READABLE_STRING_32
			l_is_new: BOOLEAN
		do
			l_is_new := not org.has_id

			reset_error
			if l_is_new then
				create l_params.make (4)
			else
				create l_params.make (5)
				l_params.force (org.id, "oid")
			end
			l_params.force (org.name, "name")
			l_params.force (org.title, "title")
			l_params.force (org.description, "description")
			l_params.force (org.data, "data")
			if l_is_new then
				sql_insert (sql_insert_organization, l_params)
				sql_finalize_insert (sql_insert_organization)
			else
				sql_modify (sql_update_organization, l_params)
				sql_finalize_modify (sql_update_organization)
			end
		end

	delete_organization (org: ES_CLOUD_ORGANIZATION)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (org.id, "oid")
			sql_delete (sql_delete_organization, l_params)
			sql_finalize_delete (sql_delete_organization)
		end

	organization_members (org: ES_CLOUD_ORGANIZATION; a_role: INTEGER): LIST [ES_CLOUD_USER]
		local
			l_params: STRING_TABLE [detachable ANY]
			oid,uid: INTEGER_64
			r: INTEGER
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_USER]} Result.make (0)
			create l_params.make (2)
			l_params["oid"] := org.id
			if a_role /= 0 then
				l_params["role"] := a_role
				sql_query (sql_select_members_with_role, l_params)
			else
				sql_query (sql_select_members, l_params)
			end

			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					uid := sql_read_integer_64 (1)
					oid := sql_read_integer_64 (2)
					r := sql_read_integer_32 (3)
					if a_role = 0 or else r = a_role then
						Result.force (create {ES_CLOUD_USER}.make (create {CMS_PARTIAL_USER}.make_with_id (uid)))
					end
					sql_forth
				end
			end
			if a_role /= 0 then
				sql_finalize_query (sql_select_members_with_role)
			else
				sql_finalize_query (sql_select_members)
			end
		end

	save_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_name: detachable READABLE_STRING_32
			l_exists: BOOLEAN
		do
			l_exists := has_membership (org, a_user)
			reset_error
			create l_params.make (3)
			l_params.force (a_user.id, "uid")
			l_params.force (org.id, "oid")
			l_params.force (a_role, "role")
			if a_role = {ES_CLOUD_ORGANIZATION}.role_none_id then
				if l_exists then
					sql_delete (sql_delete_member, l_params)
					sql_finalize_delete (sql_delete_member)
				end
			else
				if l_exists then
					sql_modify (sql_update_member, l_params)
					sql_finalize_modify (sql_update_member)
				else
					sql_insert (sql_insert_member, l_params)
					sql_finalize_insert (sql_insert_member)
				end
			end
		end

	has_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER): BOOLEAN
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_user.id, "uid")
			l_params.force (org.id, "oid")

			sql_query (sql_select_member_with_role, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := True
			end
			sql_finalize_query (sql_select_member_with_role)
		end

feature -- Access: subscriptions				

	plan_subscriptions (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
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
			sql_query (sql_select_user_subscriptions, Void)
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
			sql_finalize_query (sql_select_user_subscriptions)
		end

	user_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_USER_SUBSCRIPTION
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
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
			sql_query (sql_select_organization_subscriptions, Void)
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
			sql_finalize_query (sql_select_organization_subscriptions)
		end

	organization_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
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

feature -- Access: installations		

	user_installation (a_user: ES_CLOUD_USER; a_installation_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		local
			l_params: STRING_TABLE [detachable ANY]
			iid: detachable READABLE_STRING_32
			l_name: detachable READABLE_STRING_32
			l_session: ES_CLOUD_SESSION
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_installation_id, "iid")
			l_params.force (a_user.id, "uid")
			sql_query (sql_select_user_installation, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_installation (a_user)
			end
			sql_finalize_query (sql_select_user_installation)
		end

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		local
			id: READABLE_STRING_GENERAL
			uid: INTEGER_64
			l_session: ES_CLOUD_SESSION
			l_params: STRING_TABLE [detachable ANY]
			u: CMS_PARTIAL_USER
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
			create l_params.make (1)
			l_params.force (a_user.id, "uid")
			sql_query (sql_select_user_installations, l_params)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_installation (a_user) as inst then
						Result.force (inst)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_user_installations)
		end

	all_user_installations: LIST [ES_CLOUD_INSTALLATION]
		local
			id: READABLE_STRING_GENERAL
			uid: INTEGER_64
			u: CMS_PARTIAL_USER
			l_session: ES_CLOUD_SESSION
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
			sql_query (sql_select_installations, Void)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_installation (Void) as inst then
						Result.force (inst)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_installations)
		end

feature -- Access: sessions		

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		local
			sid, iid: READABLE_STRING_GENERAL
			uid: INTEGER_64
			l_session: ES_CLOUD_SESSION
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
					sid := sql_read_string_32 (1)
					iid := sql_read_string_32 (2)
					uid := sql_read_integer_64 (3)
					if
						iid /= Void and then
						sid /= Void and then uid > 0 and then
						attached sql_read_date_time (5) as dt_first
					then
						create l_session.make (a_user, iid, sid, dt_first)
						l_session.set_state (sql_read_integer_32 (4))
						l_session.set_last_date (sql_read_date_time (6))
						l_session.set_title (sql_read_string_32 (7))
						Result.force (l_session)
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
			sid, iid: detachable READABLE_STRING_32
			l_name: detachable READABLE_STRING_32
			l_session: ES_CLOUD_SESSION
		do
			reset_error
			create l_params.make (3)
			l_params.force (a_session_id, "sid")
			l_params.force (a_installation_id, "iid")
			l_params.force (a_user.id, "uid")
			sql_query (sql_select_user_session, l_params)
			sql_start
			if not has_error and not sql_after then
				sid := sql_read_string_32 (1)
				iid := sql_read_string_32 (2)
				if iid /= Void and then sid /= Void and then not sid.is_whitespace then
					check same_iid: iid.is_case_insensitive_equal_general (a_installation_id) end
					check same_uid: sql_read_integer_64 (3) = a_user.id end

					if attached sql_read_date_time (5) as dt_first then
						create Result.make (a_user, iid, sid, dt_first)
						Result.set_state (sql_read_integer_32 (4))
						Result.set_last_date (sql_read_date_time (6))
						Result.set_title (sql_read_string_32 (7))
					end
				end
			end
			sql_finalize_query (sql_select_user_session)
		end

feature -- Change

	save_plan (a_plan: ES_CLOUD_PLAN)
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
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

	save_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
			l_is_new: BOOLEAN
		do
			l_is_new := user_subscription (sub.user) = Void

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
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
			l_is_new: BOOLEAN
		do
			l_is_new := organization_subscription (sub.organization) = Void

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
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
			l_is_new: BOOLEAN
			l_is_org: BOOLEAN
		do
			reset_error
			create l_params.make (1)
			l_params.force (sub.plan.id, "pid")
			l_params.force (sub.organization.id, "oid")
			sql_delete (sql_delete_organization_subscription, l_params)
			sql_finalize_delete (sql_delete_organization_subscription)
		end

	save_installation (inst: ES_CLOUD_INSTALLATION)
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
			l_is_new: BOOLEAN
		do
			l_is_new := user_installation (inst.user, inst.installation_id) = Void

			reset_error
			create l_params.make (10)
			l_params.force (inst.installation_id, "iid")
			l_params.force (inst.user.id, "uid")
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

	discard_installation (inst: ES_CLOUD_INSTALLATION)
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
			l_is_new: BOOLEAN
		do
			reset_error

			create l_params.make (2)
			l_params.force (inst.installation_id, "iid")
			l_params.force (inst.user.id, "uid")
			sql_delete (sql_delete_installation_sessions, l_params)
			sql_finalize_delete (sql_delete_installation_sessions)

			if not has_error then
				create l_params.make (1)
				l_params.force (inst.installation_id, "iid")
				l_params.force (inst.user.id, "uid")
				sql_delete (sql_delete_installation, l_params)
				sql_finalize_delete (sql_delete_installation)
			end
		end

	save_session (a_session: ES_CLOUD_SESSION)
		local
			l_params: STRING_TABLE [detachable ANY]
			pid: INTEGER
			l_name: detachable READABLE_STRING_32
			pl: ES_CLOUD_PLAN
			l_is_new: BOOLEAN
		do
			l_is_new := user_session (a_session.user, a_session.installation_id, a_session.id) = Void

			reset_error
			create l_params.make (7)
			l_params.force (a_session.id, "sid")
			l_params.force (a_session.installation_id, "iid")
			l_params.force (a_session.user.id, "uid")
			l_params.force (a_session.state, "state")
			l_params.force (a_session.first_date, "first")
			l_params.force (a_session.last_date, "last")
			l_params.force (a_session.title, "title")

			if l_is_new then
				sql_insert (sql_insert_session, l_params)
				sql_finalize_insert (sql_insert_session)
			else
				sql_modify (sql_update_session, l_params)
				sql_finalize_modify (sql_update_session)
			end
		end

feature {NONE} -- Fetcher

	fetch_organization: detachable ES_CLOUD_ORGANIZATION
		local
			oid: INTEGER
			l_name: READABLE_STRING_32
		do
			oid := sql_read_integer_32 (1)
			l_name := sql_read_string_32 (2)
			if l_name = Void then
				l_name := "org#" + oid.out
			end
			create Result.make (oid, l_name)
			Result.set_title (sql_read_string_32 (3))
			Result.set_description (sql_read_string_32 (4))
			Result.set_data (sql_read_string_32 (5))
		end

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

	fetch_plan_user_subscription (a_plan: ES_CLOUD_PLAN): detachable ES_CLOUD_PLAN_USER_SUBSCRIPTION
		local
			pid: INTEGER
			l_name: READABLE_STRING_8
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
			l_name: READABLE_STRING_8
			pl: ES_CLOUD_PLAN
			u: CMS_PARTIAL_USER
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

	fetch_installation (a_user: detachable ES_CLOUD_USER): detachable ES_CLOUD_INSTALLATION
		local
			iid: READABLE_STRING_32
			uid: INTEGER_64
			l_user: ES_CLOUD_USER
		do
			iid := sql_read_string_32 (1)
			uid := sql_read_integer_64 (2)
			if
				iid /= Void and then not iid.is_whitespace and then
				(a_user /= Void or uid > 0)
			then
				if a_user /= Void then
					l_user := a_user
					check same_uid: uid = a_user.id end
				else
					create l_user.make (create {CMS_PARTIAL_USER}.make_with_id (uid))
				end
				create Result.make (iid, l_user)
				Result.set_name (sql_read_string_32 (3))
				Result.set_info (sql_read_string_32 (4))
				Result.set_status (sql_read_integer_32 (5))
				Result.set_creation_date (sql_read_date_time (6))
			else
				check valid_record: False end
			end
		end

feature {NONE} -- Queries: installations

	sql_select_user_installation: STRING = "SELECT iid, uid, name, info, status, creation FROM es_installations WHERE iid=:iid AND uid=:uid;"

	sql_select_user_installations: STRING = "SELECT iid, uid, name, info, status, creation FROM es_installations WHERE uid=:uid;"

	sql_select_installations: STRING = "SELECT iid, uid, name, info, status, creation FROM es_installations;"

	sql_insert_installation: STRING = "INSERT INTO es_installations (iid, uid, name, info, status, creation) VALUES (:iid, :uid, :name, :info, :status, :creation);"

	sql_update_installation: STRING = "UPDATE es_installations SET info=:info, name=:name, status=:status WHERE iid=:iid AND uid=:uid;"

	sql_delete_installation: STRING = "DELETE FROM es_installations WHERE iid=:iid AND uid=:uid;"

	sql_delete_installation_sessions: STRING = "DELETE FROM es_sessions WHERE iid=:iid AND uid=:uid;"

feature {NONE} -- Sessions

	sql_select_user_session: STRING = "SELECT sid, iid, uid, state, first, last, title FROM es_sessions WHERE sid=:sid AND iid=:iid AND uid=:uid;"

	sql_select_user_sessions: STRING = "SELECT sid, iid, uid, state, first, last, title FROM es_sessions WHERE uid=:uid;"

	sql_select_user_active_sessions: STRING
		once
			Result := "SELECT sid, iid, uid, state, first, last, title FROM es_sessions WHERE uid=:uid AND state!=" + {ES_CLOUD_SESSION}.state_ended_id.out + ";"
		end

	sql_select_user_installation_sessions: STRING = "SELECT sid, iid, uid, state, first, last, title FROM es_sessions WHERE iid=:iid AND uid=:uid;"

	sql_select_user_active_installation_sessions: STRING
		once
			Result := "SELECT sid, iid, uid, state, first, last, title FROM es_sessions WHERE iid=:iid AND uid=:uid AND state!=" + {ES_CLOUD_SESSION}.state_ended_id.out + ";"
		end

	sql_insert_session: STRING = "INSERT INTO es_sessions (sid, iid, uid, state, first, last, title) VALUES (:sid, :iid, :uid, :state, :first, :last, :title);"

	sql_update_session: STRING = "UPDATE es_sessions SET state=:state, first=:first, last=:last, title=:title WHERE sid=:sid AND iid=:iid AND uid=:uid;"

feature {NONE} -- Queries: plans	

	sql_select_plans: STRING = "SELECT pid, name, title, description, data FROM es_plans;"

	sql_select_plan_by_id: STRING = "SELECT pid, name, title, description, data FROM es_plans WHERE pid=:pid;"

	sql_insert_plan: STRING = "INSERT INTO es_plans (name, title, description, data) VALUES (:name, :title, :description, :data);"

	sql_update_plan: STRING = "UPDATE es_plans SET name=:name, title=:title, description=:description, data=:data WHERE pid=:pid;"

	sql_delete_plan: STRING = "DELETE FROM es_plans WHERE pid=:pid;"

feature {NONNE} -- organizations

	sql_select_organizations: STRING = "SELECT oid, name, title, description, data FROM es_orgs ;"

	sql_select_organization_by_id: STRING = "SELECT oid, name, title, description, data FROM es_orgs WHERE oid=:oid;"

	sql_insert_organization: STRING = "INSERT INTO es_orgs (name, title, description, data) VALUES (:name, :title, :description, :data);"

	sql_update_organization: STRING = "UPDATE es_orgs SET name=:name, title=:title, description=:description, data=:data WHERE oid=:oid;"

	sql_delete_organization: STRING = "DELETE FROM es_orgs WHERE oid=:oid;"

	sql_select_members: STRING = "SELECT uid, oid, role FROM es_members WHERE oid=:oid ;"

	sql_select_members_with_role: STRING = "SELECT uid, oid, role FROM es_members WHERE oid=:oid AND role=:role;"

	sql_select_member_with_role: STRING = "SELECT uid, oid, role FROM es_members WHERE oid=:oid AND uid=:uid;"

	sql_select_user_organizations: STRING = "SELECT uid, oid, role FROM es_members WHERE uid=:uid ;"

	sql_insert_member: STRING = "INSERT INTO es_members (uid, oid, role) VALUES (:uid, :oid, :role);"

	sql_update_member: STRING = "UPDATE es_members SET uid=:uid, oid=:oid, role=:role WHERE uid=:uid AND oid=:oid;"

	sql_delete_member: STRING = "DELETE FROM es_members WHERE uid=:uid AND oid=:oid;"

feature {NONE} -- Queries: subscriptions

	sql_select_plan_subscriptions: STRING = "SELECT pid, uid, creation, expiration, notes FROM es_plan_subscriptions WHERE pid=:pid;"

	sql_select_user_subscriptions: STRING = "[
			SELECT es_plan_subscriptions.pid, es_plans.name, es_plans.title, es_plans.description, es_plans.data, 
				   es_plan_subscriptions.uid, es_plan_subscriptions.creation, es_plan_subscriptions.expiration, es_plan_subscriptions.notes 
			FROM es_plan_subscriptions INNER JOIN es_plans ON es_plan_subscriptions.pid = es_plans.pid;
			]"

	sql_select_user_subscription: STRING = "SELECT pid, uid, creation, expiration, notes FROM es_plan_subscriptions WHERE uid=:uid;"

	sql_insert_user_subscription: STRING = "INSERT INTO es_plan_subscriptions (pid, uid, creation, expiration, notes) VALUES (:pid, :uid, :creation, :expiration, :notes);"

	sql_update_user_subscription: STRING = "UPDATE es_plan_subscriptions SET pid=:pid, creation=:creation, expiration=:expiration, notes=:notes WHERE uid=:uid;"

	sql_delete_user_subscription: STRING = "DELETE FROM es_plan_subscriptions WHERE pid=:pid AND uid=:uid;"


	sql_select_plan_organization_subscriptions: STRING = "SELECT pid, oid, creation, expiration, notes FROM es_plan_org_sub WHERE pid=:pid;"

	sql_select_organization_subscriptions: STRING = "[
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
