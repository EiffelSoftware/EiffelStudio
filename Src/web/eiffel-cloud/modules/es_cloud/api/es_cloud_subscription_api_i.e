note
	description: "API to handle ES Cloud api."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_SUBSCRIPTION_API_I

feature {CMS_MODULE} -- Access nodes storage.

	cms_api: CMS_API
		deferred
		end

	es_cloud_storage: ES_CLOUD_STORAGE_I
		deferred
		end

feature -- Access: account

	user_organizations (a_user: ES_CLOUD_USER): detachable LIST [ES_CLOUD_ORGANIZATION]
		deferred
		end

feature -- Access

	plan_subscriptions (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			Result := es_cloud_storage.plan_subscriptions_for (a_plan)
		end

feature -- Access: subscriptions

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			Result := es_cloud_storage.subscriptions
		end

	user_direct_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.user_plan_subscription (a_user)
		end

	user_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		local
			sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.user_plan_subscription (a_user)
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
-- FIXME			
--			if Result = Void then
--					-- Subscribe to default plan
--				if attached default_plan as dft then
--					create {ES_CLOUD_PLAN_USER_SUBSCRIPTION} Result.make (a_user, dft)
--						-- Set default plan!
--					es_cloud_storage.save_subscription (Result)
--				end
--			end
		end

	organization_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.organization_plan_subscription (org)
		end

feature -- Change	

	subscribe_user_to_plan_until_date (a_user: ES_CLOUD_USER; a_plan: ES_CLOUD_PLAN; a_exp_date: DATE)
		require
			a_plan.has_id
		local
			sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION
		do
			create sub.make (a_user, a_plan)
			sub.set_expiration_date (create {DATE_TIME}.make_by_date_time (a_exp_date, create {TIME}.make (23, 59, 59)))
			es_cloud_storage.save_user_subscription (sub)
		end

	subscribe_user_to_plan (a_user: ES_CLOUD_USER; a_plan: ES_CLOUD_PLAN; nb_days: INTEGER)
		require
			a_plan.has_id
		local
			sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION
			l_date: DATE
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
		do
			create sub.make (org, a_plan)
			l_date := sub.creation_date.date.twin
			l_date.day_add (nb_days)
			if nb_days /= 0 then
				sub.set_expiration_date (create {DATE_TIME}.make_by_date_time (l_date, sub.creation_date.time))
			end
			es_cloud_storage.save_organization_subscription (sub)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

