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

feature -- Access: users

	user_concurrent_sessions_limit (a_user: CMS_USER): NATURAL
		do
			if attached user_subscription (a_user) as l_plan_subs then
				Result := l_plan_subs.concurrent_sessions_limit
			else
				Result := 1 -- Default, a unique concurrent session!
			end
		end

	user_subscription (a_user: CMS_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.user_subscription (a_user)
			if Result = Void then
					-- Subscribe to default plan
				if attached plans as lst and then not lst.is_empty then
					create Result.make (a_user, lst.first)
						-- Set default plan!
					es_cloud_storage.save_subscription (Result)
				end
			end
		end

	user_installations (a_user: CMS_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.user_installations (a_user)
			user_installations_sorter.reverse_sort (Result)
		end

	user_installation (a_user: CMS_USER; a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
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

	user_session (a_user: CMS_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		do
			Result := es_cloud_storage.user_session (a_user, a_install_id, a_session_id)
		end

	user_sessions (a_user: CMS_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		do
			Result := es_cloud_storage.user_sessions (a_user, a_install_id, a_only_active)
			if Result /= Void then
				user_session_sorter.reverse_sort (Result)
			end
		end

	user_active_concurrent_sessions (a_user: CMS_USER; a_install_id: READABLE_STRING_GENERAL; a_current_session: ES_CLOUD_SESSION): detachable LIST [ES_CLOUD_SESSION]
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

	subscribe_user_to_plan (a_user: CMS_USER; a_plan: ES_CLOUD_PLAN; nb_months: INTEGER)
		require
			a_plan.has_id
		local
			sub: ES_CLOUD_PLAN_SUBSCRIPTION
			l_date: DATE
			y,mo: INTEGER
		do
			create sub.make (a_user, a_plan)
			l_date := sub.creation_date.date
			y := l_date.year
			mo := l_date.month
			mo := mo + nb_months
			if mo = 12 then
				y := y + 1
			else
				y := y + mo // 12
				mo := mo \\ 12
			end
			create l_date.make (y, mo, l_date.day)
			if nb_months /= 0 then
				sub.set_expiration_date (create {DATE_TIME}.make_by_date_time (l_date, sub.creation_date.time))
			end
			es_cloud_storage.save_subscription (sub)
		end

	ping_installation (a_user: CMS_USER; a_session: ES_CLOUD_SESSION)
		do
			a_session.set_last_date (create {DATE_TIME}.make_now_utc)
			es_cloud_storage.save_session (a_session)
		end

	end_session (a_user: CMS_USER; a_session: ES_CLOUD_SESSION)
		do
			a_session.stop
			es_cloud_storage.save_session (a_session)
		end

	pause_session (a_user: CMS_USER; a_session: ES_CLOUD_SESSION)
		do
			if
				not a_session.is_paused
			then
				a_session.pause
				es_cloud_storage.save_session (a_session)
			end
		end

	resume_session (a_user: CMS_USER; a_session: ES_CLOUD_SESSION)
		do
			if
				a_session.is_paused or a_session.is_ended
			then
				a_session.resume
				es_cloud_storage.save_session (a_session)
			end
		end

	register_installation (a_user: CMS_USER; a_install_id: READABLE_STRING_GENERAL; a_info: detachable READABLE_STRING_GENERAL)
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

