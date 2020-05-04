note
	description: "Interface for accessing plan from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_SUBSCRIPTION_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: subscriptions

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		deferred
		end

	user_plan_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		deferred
		end

	organization_plan_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		deferred
		end

	plan_subscriptions_for (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		deferred
		end

feature -- Change

	save_subscription (sub: ES_CLOUD_PLAN_SUBSCRIPTION)
		do
			if attached {ES_CLOUD_PLAN_USER_SUBSCRIPTION} sub as usub then
				save_user_subscription (usub)
			elseif attached {ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION} sub as osub then
				save_organization_subscription (osub)
			end
		end

	discard_subscription (sub: ES_CLOUD_PLAN_SUBSCRIPTION)
		do
			if attached {ES_CLOUD_PLAN_USER_SUBSCRIPTION} sub as usub then
				discard_user_subscription (usub)
			elseif attached {ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION} sub as osub then
				discard_organization_subscription (osub)
			end
		end

	save_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		deferred
		end

	discard_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		deferred
		end

	save_organization_subscription (sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION)
		deferred
		end

	discard_organization_subscription (sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION)
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
