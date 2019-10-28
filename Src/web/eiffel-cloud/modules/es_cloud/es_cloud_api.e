note
	description: "API to handle ES Cloud api."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
				-- Config (TODO: use config file)
			create config

				-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {ES_CLOUD_STORAGE_SQL} es_cloud_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {ES_CLOUD_STORAGE_NULL} es_cloud_storage
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	es_cloud_storage: ES_CLOUD_STORAGE_I

feature -- Settings

	config: ES_CLOUD_CONFIG

feature -- Access

	plans: LIST [ES_CLOUD_PLAN]
		do
			Result := es_cloud_storage.plans
		end

	sorted_plans: LIST [ES_CLOUD_PLAN]
		do
			Result := plans
			plans_sorter.sort (Result)
		end

	plans_sorter: SORTER [ES_CLOUD_PLAN]
		local
			comp: AGENT_EQUALITY_TESTER [ES_CLOUD_PLAN]
		do
			create comp.make (agent (u,v: ES_CLOUD_PLAN): BOOLEAN
					do
						if u.weight /= v.weight then
							Result := u.weight < v.weight
						elseif attached u.name as u_name then
							if attached v.name as v_name then
								Result := u_name < v_name
							else
								Result := True
							end
						else
							Result := u.id < v.id
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_PLAN]} Result.make (comp)
		end

	default_plan: detachable ES_CLOUD_PLAN
		do
			if attached sorted_plans as lst and then not lst.is_empty then
				Result := lst.first
			end
		end

	plan (a_plan_id: INTEGER): detachable ES_CLOUD_PLAN
		do
			Result := es_cloud_storage.plan (a_plan_id)
		end

	plan_by_name (a_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_PLAN
		do
			across
				plans as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

	plan_subscriptions (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			Result := es_cloud_storage.plan_subscriptions (a_plan)
		end

feature -- Access: organizations

	organizations: LIST [ES_CLOUD_ORGANIZATION]
		do
			Result := es_cloud_storage.organizations
		end

	organization (a_id_or_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_ORGANIZATION
		local
			l_id: INTEGER_64
		do
			if a_id_or_name.is_integer_64 then
				l_id := a_id_or_name.to_integer_64
			end
			across
				organizations as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if l_id /= 0 and then Result.id = l_id then
						-- Found by id
				elseif Result.name.is_case_insensitive_equal_general (a_id_or_name) then
						-- Found by name
				else
					Result := Void
				end
			end
		end

	user_organizations (a_user: ES_CLOUD_USER): detachable LIST [ES_CLOUD_ORGANIZATION]
		do
			Result := es_cloud_storage.user_organizations (a_user)
		end

	save_organization (org: ES_CLOUD_ORGANIZATION)
		do
			es_cloud_storage.save_organization (org)
		end

	delete_organization (org: ES_CLOUD_ORGANIZATION)
		do
			es_cloud_storage.delete_organization (org)
		end

	is_current_user_organization_owner_of (org: ES_CLOUD_ORGANIZATION): BOOLEAN
		local
			l_user: ES_CLOUD_USER
		do
			if attached cms_api.user as u then
				create l_user.make (u)
				Result := has_organization_role (l_user, {ES_CLOUD_ORGANIZATION}.role_owner_id, org)
			end
		end

	is_current_user_organization_manager_of (org: ES_CLOUD_ORGANIZATION): BOOLEAN
		local
			l_user: ES_CLOUD_USER
		do
			if attached cms_api.user as u then
				create l_user.make (u)
				Result := is_organization_manager (l_user, org)
			end
		end

	is_organization_manager (a_user: ES_CLOUD_USER; org: ES_CLOUD_ORGANIZATION): BOOLEAN
		do
			Result := has_organization_role (a_user, {ES_CLOUD_ORGANIZATION}.role_owner_id, org)
				or else has_organization_role (a_user, {ES_CLOUD_ORGANIZATION}.role_manager_id, org)
		end

	has_organization_role (a_user: ES_CLOUD_USER; a_role: INTEGER; org: ES_CLOUD_ORGANIZATION): BOOLEAN
		do
			across
				es_cloud_storage.organization_members (org, a_role) as ic
			until
				Result
			loop
				if a_user.same_as (ic.item) then
					Result := True
				end
			end
		end

	organization_owners (org: ES_CLOUD_ORGANIZATION): LIST [ES_CLOUD_USER]
		do
			Result := es_cloud_storage.organization_members (org, {ES_CLOUD_ORGANIZATION}.role_owner_id)
		end

	organization_managers (org: ES_CLOUD_ORGANIZATION): LIST [ES_CLOUD_USER]
		do
			Result := es_cloud_storage.organization_members (org, {ES_CLOUD_ORGANIZATION}.role_manager_id)
			Result.append (organization_owners (org))
		end

	organization_members (org: ES_CLOUD_ORGANIZATION): LIST [ES_CLOUD_USER]
		do
			Result := es_cloud_storage.organization_members (org, {ES_CLOUD_ORGANIZATION}.role_member_id)
			Result.append (organization_managers (org))
		end

	new_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		do
			es_cloud_storage.save_membership (org, a_user, a_role)
		end

	update_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		do
			es_cloud_storage.save_membership (org, a_user, a_role)
		end

	discard_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		do
			es_cloud_storage.discard_membership (org, a_user, a_role)
		end

feature -- Access: users

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			Result := es_cloud_storage.subscriptions
		end

	user_concurrent_sessions_limit (a_user: ES_CLOUD_USER): NATURAL
		do
			if attached user_subscription (a_user) as l_plan_subs then
				Result := l_plan_subs.concurrent_sessions_limit
			else
				Result := 1 -- Default, a unique concurrent session!
			end
		end

	user_direct_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.user_subscription (a_user)
		end

	user_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		local
			sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.user_subscription (a_user)
			if Result = Void or else Result.is_expired then
				if attached user_organizations (a_user) as orgs then
					across
						orgs as ic
					until
						sub /= Void
					loop
						sub := organization_subscription (ic.item)
					end
					if sub /= Void and then sub.is_active then
						Result := sub
					end
				end
			end
			if Result = Void then
					-- Subscribe to default plan
				if attached default_plan as dft then
					create {ES_CLOUD_PLAN_USER_SUBSCRIPTION} Result.make (a_user, dft)
						-- Set default plan!
					es_cloud_storage.save_subscription (Result)
				end
			end
		end

	organization_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.organization_subscription (org)
		end

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.user_installations (a_user)
			user_installations_sorter.reverse_sort (Result)
		end

	user_installation (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		do
			Result := es_cloud_storage.user_installation (a_user, a_install_id)
		end

	user_installations_sorter: SORTER [ES_CLOUD_INSTALLATION]
		local
			comp: AGENT_EQUALITY_TESTER [ES_CLOUD_INSTALLATION]
		do
			create comp.make (agent (u,v: ES_CLOUD_INSTALLATION): BOOLEAN
					do
						if attached u.creation_date as u_cd then
							if attached v.creation_date as v_cd then
								Result := u_cd < v_cd
							else
								Result := u.installation_id < v.installation_id
							end
						elseif v.creation_date /= Void then
							Result := True
						else
							Result := u.installation_id < v.installation_id
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_INSTALLATION]} Result.make (comp)
		end

	user_session (a_user: ES_CLOUD_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		do
			Result := es_cloud_storage.user_session (a_user, a_install_id, a_session_id)
		end

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		do
			Result := es_cloud_storage.user_sessions (a_user, a_install_id, a_only_active)
			if Result /= Void then
				user_session_sorter.reverse_sort (Result)
			end
		end

	user_active_concurrent_sessions (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL; a_current_session: ES_CLOUD_SESSION): detachable LIST [ES_CLOUD_SESSION]
		local
			l_session: ES_CLOUD_SESSION
		do
			Result := user_sessions (a_user, Void, True)
			if Result /= Void then
				from
					Result.start
				until
					Result.off
				loop
					l_session := Result.item
					if
						l_session.is_paused or else
						a_current_session.same_as (l_session) or else
						a_current_session.installation_id.same_string (l_session.installation_id)
					then
						Result.remove
					else
						Result.forth
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		ensure
			only_concurrent_sessions: Result /= Void implies across Result as ic all not a_current_session.same_as (ic.item) end
			not_empty: Result /= Void implies Result.count > 0
		end

	user_session_sorter: SORTER [ES_CLOUD_SESSION]
		local
			comp: AGENT_EQUALITY_TESTER [ES_CLOUD_SESSION]
		do
			create comp.make (agent (u_sess,v_sess: ES_CLOUD_SESSION): BOOLEAN
					do
						if u_sess.is_active then
							if v_sess.is_active then
								Result := u_sess.last_date < v_sess.last_date
							else
								Result := False
							end
						elseif v_sess.is_active then
							Result := True
						else
							Result := u_sess.last_date < v_sess.last_date
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_SESSION]} Result.make (comp)
		end

feature -- Change	

	save_plan (a_plan: ES_CLOUD_PLAN)
		do
			es_cloud_storage.save_plan (a_plan)
		end

	delete_plan (a_plan: ES_CLOUD_PLAN)
		do
			es_cloud_storage.delete_plan (a_plan)
		end

	subscribe_user_to_plan (a_user: ES_CLOUD_USER; a_plan: ES_CLOUD_PLAN; nb_days: INTEGER)
		require
			a_plan.has_id
		local
			sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION
			l_date: DATE
			y,mo: INTEGER
		do
			create sub.make (a_user, a_plan)
			l_date := sub.creation_date.date.twin
			l_date.day_add (nb_days)
			if nb_days /= 0 then
				sub.set_expiration_date (create {DATE_TIME}.make_by_date_time (l_date, sub.creation_date.time))
			end
			es_cloud_storage.save_user_subscription (sub)
		end

	subscribe_organization_to_plan (org: ES_CLOUD_ORGANIZATION; a_plan: ES_CLOUD_PLAN; nb_days: INTEGER)
		require
			a_plan.has_id
		local
			sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION
			l_date: DATE
			y,mo: INTEGER
		do
			create sub.make (org, a_plan)
			l_date := sub.creation_date.date.twin
			l_date.day_add (nb_days)
			if nb_days /= 0 then
				sub.set_expiration_date (create {DATE_TIME}.make_by_date_time (l_date, sub.creation_date.time))
			end
			es_cloud_storage.save_organization_subscription (sub)
		end

	ping_installation (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			a_session.set_last_date (create {DATE_TIME}.make_now_utc)
			es_cloud_storage.save_session (a_session)
		end

	end_session (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			a_session.stop
			es_cloud_storage.save_session (a_session)
		end

	pause_session (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			if
				not a_session.is_paused
			then
				a_session.pause
				es_cloud_storage.save_session (a_session)
			end
		end

	resume_session (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			if
				a_session.is_paused or a_session.is_ended
			then
				a_session.resume
				es_cloud_storage.save_session (a_session)
			end
		end

	register_installation (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL; a_info: detachable READABLE_STRING_GENERAL)
		local
			ins: ES_CLOUD_INSTALLATION
		do
			create ins.make (a_install_id, a_user)
			ins.set_info (a_info)
			es_cloud_storage.save_installation (ins)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

