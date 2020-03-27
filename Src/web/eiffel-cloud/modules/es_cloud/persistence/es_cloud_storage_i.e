note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: plan

	plans: LIST [ES_CLOUD_PLAN]
		deferred
		end

	plan (a_plan_id: INTEGER): detachable ES_CLOUD_PLAN
		deferred
		end

feature -- Access: organization

	organizations: LIST [ES_CLOUD_ORGANIZATION]
		deferred
		end

	user_organizations (a_user: ES_CLOUD_USER): detachable LIST [ES_CLOUD_ORGANIZATION]
		deferred
		end

	save_organization (org: ES_CLOUD_ORGANIZATION)
		deferred
		end

	delete_organization (org: ES_CLOUD_ORGANIZATION)
		deferred
		end

	organization_members (org: ES_CLOUD_ORGANIZATION; a_role: INTEGER): LIST [ES_CLOUD_USER]
		deferred
		end

	save_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		deferred
		end

	discard_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		do
			save_membership (org, a_user, {ES_CLOUD_ORGANIZATION}.role_none_id)
		end

feature -- Access: subscriptions

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		deferred
		end

	user_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		deferred
		end

	organization_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		deferred
		end

	plan_subscriptions (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		deferred
		end

feature -- Access: installations		

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		deferred
		end

	user_installation (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		deferred
		end

feature -- Access: sessions

	last_user_session (a_user: ES_CLOUD_USER): detachable ES_CLOUD_SESSION
		deferred
		end

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		deferred
		end

	user_session (a_user: ES_CLOUD_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		deferred
		end

feature -- Change

	save_plan (a_plan: ES_CLOUD_PLAN)
		deferred
		end

	delete_plan (a_plan: ES_CLOUD_PLAN)
		deferred
		end

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

	save_installation (inst: ES_CLOUD_INSTALLATION)
		deferred
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION)
		deferred
		end

	save_session (a_session: ES_CLOUD_SESSION)
		deferred
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
