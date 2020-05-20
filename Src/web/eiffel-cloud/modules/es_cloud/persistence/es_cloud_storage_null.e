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

feature -- Licenses

	licenses: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER]]
			-- Licenses
		do
			check False then end
		end

	licenses_for_plan (a_plan: ES_CLOUD_PLAN): like licenses
		do
			check False then end
		end

	license (a_license_id: INTEGER_64): detachable ES_CLOUD_LICENSE
		do
		end

	license_by_key (a_license_key: READABLE_STRING_GENERAL): detachable ES_CLOUD_LICENSE
		do
		end

	user_id_for_license (a_license: ES_CLOUD_LICENSE): INTEGER_64
		do
		end

	user_has_license (a_user: ES_CLOUD_USER; a_license_id: INTEGER_64): BOOLEAN
		do
		end

	users_licenses: LIST [ES_CLOUD_USER_LICENSE]
		do
			check False then end
		end

	user_licenses (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_USER_LICENSE]
		do
			check False then end
		end

	email_for_license (a_license: ES_CLOUD_LICENSE): detachable READABLE_STRING_8
		do
		end

	email_licenses (a_email: READABLE_STRING_8): LIST [ES_CLOUD_EMAIL_LICENSE]
		do
			check False then end
		end

feature -- Element change: license

	save_license (a_license: ES_CLOUD_LICENSE)
		do
		end

	assign_license_to_user (a_license: ES_CLOUD_LICENSE; a_user: ES_CLOUD_USER)
		do
		end

	assign_license_to_email (a_license: ES_CLOUD_LICENSE; a_email: READABLE_STRING_8)
		do
		end

	move_email_license_to_user (a_email_license: ES_CLOUD_EMAIL_LICENSE; a_user: ES_CLOUD_USER)
		do
			assign_license_to_user (a_email_license.license, a_user)
		end

feature -- Subscriptions		

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

	user_plan_subscription (a_user: ES_CLOUD_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
		end

	organization_plan_subscription (org: ES_CLOUD_ORGANIZATION): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
		end

	plan_subscriptions_for (a_plan: ES_CLOUD_PLAN): detachable LIST [ES_CLOUD_PLAN_SUBSCRIPTION]
		do
		end

feature -- Access: installations

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
		end

	installation (a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		do
		end

	license_installations (a_license_id: like {ES_CLOUD_LICENSE}.id): LIST [ES_CLOUD_INSTALLATION]
		do
			check False then end
		end

feature -- Access: sessions		

	last_user_session (a_user: ES_CLOUD_USER; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_SESSION
		do
		end

	last_license_session (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_SESSION
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
