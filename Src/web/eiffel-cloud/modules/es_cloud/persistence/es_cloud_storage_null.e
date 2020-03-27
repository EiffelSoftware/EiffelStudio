note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORAGE_NULL

inherit
	ES_CLOUD_STORAGE_I

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access: plan

	plans: LIST [ES_CLOUD_PLAN]
		do
			create {ARRAYED_LIST [ES_CLOUD_PLAN]} Result.make (0)
		end

	plan (a_plan_id: INTEGER): detachable ES_CLOUD_PLAN
		do
		end

	subscriptions: LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
			create {ARRAYED_LIST [ES_CLOUD_PLAN_SUBSCRIPTION]} Result.make (0)
		end

feature -- Access: organization

	organizations: LIST [ES_CLOUD_ORGANIZATION]
		do
			create {ARRAYED_LIST [ES_CLOUD_ORGANIZATION]} Result.make (0)
		end

	user_organizations (a_user: ES_CLOUD_USER): detachable LIST [ES_CLOUD_ORGANIZATION]
		do
		end

	save_organization (org: ES_CLOUD_ORGANIZATION)
		do
		end

	delete_organization (org: ES_CLOUD_ORGANIZATION)
		do
		end

	organization_members (org: ES_CLOUD_ORGANIZATION; a_role: INTEGER): LIST [ES_CLOUD_USER]
		do
			create {ARRAYED_LIST [ES_CLOUD_USER]} Result.make (0)
		end

	save_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		do
		end

feature -- Access: subscriptions		

	user_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
		end

	organization_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
		end

	plan_subscriptions (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
		end

feature -- Access: installations

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
		end

	user_installation (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		do
		end

feature -- Access: sessions		

	last_user_session (a_user: ES_CLOUD_USER): detachable ES_CLOUD_SESSION
		do
		end

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		do
		end

	user_session (a_user: ES_CLOUD_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		do
		end

feature -- Change

	save_plan (a_plan: ES_CLOUD_PLAN)
		do
		end

	delete_plan (a_plan: ES_CLOUD_PLAN)
		do
		end

	save_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		do
		end

	discard_user_subscription (sub: ES_CLOUD_PLAN_USER_SUBSCRIPTION)
		do
		end

	save_organization_subscription (sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION)
		do
		end

	discard_organization_subscription (sub: ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION)
		do
		end

	save_installation (inst: ES_CLOUD_INSTALLATION)
		do
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION)
		do
		end

	save_session (a_session: ES_CLOUD_SESSION)
		do
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
