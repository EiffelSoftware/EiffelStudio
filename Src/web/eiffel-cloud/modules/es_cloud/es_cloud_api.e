note
	description: "API to handle ES Cloud api."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API

inherit
	ES_CLOUD_ACCOUNT_API_I

	ES_CLOUD_SUBSCRIPTION_API_I

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
			create config.make
			if attached cms_api.module_configuration_by_name ({ES_CLOUD_MODULE}.name, "config") as cfg then
				if attached cfg.resolved_text_item ("session.expiration_delay") as s then
					config.session_expiration_delay := s.to_integer
				end
			end

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

	active_user: detachable ES_CLOUD_USER
		do
			if attached cms_api.user as u then
				create Result.make (u)
			end
		end

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

feature -- Access: licenses

	licenses: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER]]
			-- Licenses
		do
			Result := es_cloud_storage.licenses
		end

	licenses_for_plan (a_plan: ES_CLOUD_PLAN): like licenses
		do
			Result := es_cloud_storage.licenses_for_plan (a_plan)
		end

	license (a_license_id: INTEGER_64): detachable ES_CLOUD_LICENSE
		do
			Result := es_cloud_storage.license (a_license_id)
		end

	license_by_key (a_license_key: READABLE_STRING_GENERAL): detachable ES_CLOUD_LICENSE
		do
			Result := es_cloud_storage.license_by_key (a_license_key)
		end

	user_for_license (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_USER
		local
			uid: INTEGER_64
		do
			uid := es_cloud_storage.user_id_for_license (a_license)
			if uid /= 0 and then attached cms_api.user_api.user_by_id (uid) as u then
				create Result.make (u)
			end
		end

	user_has_license (a_user: ES_CLOUD_USER; a_license_id: INTEGER_64): BOOLEAN
		do
			Result := es_cloud_storage.user_has_license (a_user, a_license_id)
		end

	user_licenses (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_USER_LICENSE]
		do
			Result := es_cloud_storage.user_licenses (a_user)
		end

	email_licenses (a_email: READABLE_STRING_8): LIST [ES_CLOUD_EMAIL_LICENSE]
		do
			Result := es_cloud_storage.email_licenses (a_email)
		end

feature -- Element change license

	new_license_for_plan (a_plan: ES_CLOUD_PLAN): ES_CLOUD_LICENSE
		local
			k: STRING_32
		do
			k := cms_api.new_random_identifier (16, once "ABCDEFGHJKMNPQRSTUVW23456789") -- Without I O L 0 1 , which are sometime hard to distinguish!
			create Result.make (0, k, a_plan)
			es_cloud_storage.save_license (Result)
		end

	save_new_license (a_license: ES_CLOUD_LICENSE; a_user: detachable ES_CLOUD_USER)
		do
			es_cloud_storage.save_license (a_license)
			if a_user /= Void then
				assign_license_to_user (a_license, a_user)
			end
		end

	update_license (a_license: ES_CLOUD_LICENSE; a_user: detachable ES_CLOUD_USER)
		require
			existing_license: license (a_license.id) /= Void
		do
			if a_user /= Void and then not user_has_license (a_user, a_license.id) then
				assign_license_to_user (a_license, a_user)
			end
			es_cloud_storage.save_license (a_license)
		end

	assign_license_to_user (a_license: ES_CLOUD_LICENSE; a_user: ES_CLOUD_USER)
		do
			es_cloud_storage.assign_license_to_user (a_license, a_user)
		end

	move_email_license_to_user (a_email_license: ES_CLOUD_EMAIL_LICENSE; a_user: ES_CLOUD_USER)
		do
			es_cloud_storage.move_email_license_to_user (a_email_license, a_user)
		end
	assign_license_to_email (a_license: ES_CLOUD_LICENSE; a_email: READABLE_STRING_8)
		do
			es_cloud_storage.assign_license_to_email (a_license, a_email)
		end

	converted_license_from_user_subscription (a_sub: ES_CLOUD_PLAN_SUBSCRIPTION; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_LICENSE
		local
			inst: ES_CLOUD_INSTALLATION
		do
			if attached {ES_CLOUD_PLAN_USER_SUBSCRIPTION} a_sub as sub then
				Result := new_license_for_plan (sub.plan)
				Result.set_creation_date (sub.creation_date)
				if attached sub.expiration_date as exp then
					Result.set_expiration_date (exp)
				else
					Result.set_remaining_days (sub.plan.trial_period_in_days)
				end
				if a_installation /= Void then
					Result.set_platform (a_installation.platform)
					Result.set_version (a_installation.product_version)
				end
				save_new_license (Result, sub.user)
				es_cloud_storage.discard_user_subscription (sub)
					-- HACK: previously installation tables included the uid, now we have license id `lid`
				if attached es_cloud_storage.license_installations (sub.user_id) as lst then
					across
						lst as ic
					loop
						inst := ic.item
						inst.update_license_id (Result.id)
						es_cloud_storage.save_installation (inst)
					end
				end
			end
		end

feature -- Access: store

	store (a_currency: detachable READABLE_STRING_8): ES_CLOUD_STORE
		local
			l_item: ES_CLOUD_STORE_ITEM
			l_cents: NATURAL_32
		do
			Result := internal_store (a_currency)
			if Result = Void then
				if a_currency = Void then
					create Result.make
				else
					create Result.make_with_currency (a_currency)
				end
				if attached cms_api.module_configuration_by_name ({ES_CLOUD_MODULE}.name, "store-" + Result.currency) as cfg then
					set_internal_store (Result)
					if attached cfg.table_keys ("") as lst then
						across
							lst as ic
						loop
							if
								attached cfg.text_table_item (ic.item) as tb and then
								attached tb.item ("plan") as l_plan and then
								attached tb.item ("price") as l_price and then
								attached tb.item ("currency") as l_currency
							then
								if attached tb.item ("price.cents") as l_cents_price then
									l_cents := l_cents_price.to_natural_32
								else
									l_cents := 0
								end
								create l_item.make (ic.item)
								l_item.set_price (l_price.to_natural_32, l_cents, l_currency.to_string_8, tb.item ("interval"))
								l_item.set_title (tb.item ("title"))
								l_item.set_name (l_plan)
								Result.extend (l_item)
							end
						end
					end
				end
			end
		end

	internal_store (a_currency: detachable READABLE_STRING_8): detachable ES_CLOUD_STORE
		local
			l_currency: READABLE_STRING_8
		do
			l_currency := a_currency
			if l_currency = Void then
				l_currency := {ES_CLOUD_STORE}.default_currency
			end
			if attached internal_store_by_currency as tb then
				Result := tb.item (l_currency)
			end
		end

	set_internal_store (a_store: ES_CLOUD_STORE)
		local
			tb: like internal_store_by_currency
		do
			tb := internal_store_by_currency
			if tb = Void then
				create tb.make_caseless (1)
			end
			tb[a_store.currency] := a_store
		end

	internal_store_by_currency: detachable STRING_TABLE [ES_CLOUD_STORE]

feature -- Access: subscriptions

	default_concurrent_sessions_limit: NATURAL = 1
	 		-- Default, a unique concurrent session!

	default_heartbeat: NATURAL = 900 -- 15 * 60
	 		-- Default heartbeat in seconds	 		

	user_concurrent_sessions_limit (a_user: ES_CLOUD_USER): NATURAL
		do
			if attached user_subscription (a_user) as l_plan_sub then
				Result := l_plan_sub.concurrent_sessions_limit
			else
				Result := default_concurrent_sessions_limit
			end
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION)
		do
			es_cloud_storage.discard_installation (inst)
		end

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.user_installations (a_user)
			user_installations_sorter.reverse_sort (Result)
		end

	installation (a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		do
			Result := es_cloud_storage.installation (a_install_id)
		end

	license_installations (a_license: ES_CLOUD_LICENSE): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.license_installations (a_license.id)
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
								Result := u.id < v.id
							end
						elseif v.creation_date /= Void then
							Result := True
						else
							Result := u.id < v.id
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_INSTALLATION]} Result.make (comp)
		end

	last_user_session (a_user: ES_CLOUD_USER; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_SESSION
			-- Last user session, and only for installation `a_installation` is provided.
		do
			Result := es_cloud_storage.last_user_session (a_user, a_installation)
		end

	last_license_session (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_SESSION
		do
			Result := es_cloud_storage.last_license_session (a_license)
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

	user_active_concurrent_sessions (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL; a_current_session: ES_CLOUD_SESSION): detachable STRING_TABLE [LIST [ES_CLOUD_SESSION]]
			-- Active sessions indexed by installation id.
		local
			l_session: ES_CLOUD_SESSION
			lst, lst_by_installation: like user_sessions
		do
			lst := user_sessions (a_user, Void, True)
			if lst /= Void then
				from
					lst.start
				until
					lst.off
				loop
					l_session := lst.item
					if
						l_session.is_paused or else
						a_current_session.same_as (l_session) or else
						a_current_session.installation_id.same_string (l_session.installation_id)
					then
						lst.remove
					else
						lst.forth
					end
				end
				if lst.is_empty then
					lst := Void
				end
				if lst /= Void then
					create Result.make_caseless (2)
					from
						lst.start
					until
						lst.after
					loop
						l_session := lst.item
						lst_by_installation := Result [l_session.installation_id]
						if lst_by_installation = Void then
							create {ARRAYED_LIST [ES_CLOUD_SESSION]} lst_by_installation.make (3)
							Result [l_session.installation_id] := lst_by_installation
						end
						lst_by_installation.force (l_session)
						lst.forth
					end
				end
			end
		ensure
			only_concurrent_sessions: Result /= Void implies across Result as ic all not a_current_session.installation_id.is_case_insensitive_equal_general (ic.key) end
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

	register_installation (a_license: ES_CLOUD_LICENSE; a_install_id: READABLE_STRING_GENERAL; a_info: detachable READABLE_STRING_GENERAL)
		local
			ins: ES_CLOUD_INSTALLATION
		do
			create ins.make (a_install_id, a_license)
			ins.set_info (a_info)
			es_cloud_storage.save_installation (ins)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

