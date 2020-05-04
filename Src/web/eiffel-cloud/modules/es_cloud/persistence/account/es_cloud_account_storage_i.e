note
	description: "Interface for accessing Cloud user and organization from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_ACCOUNT_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
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

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
