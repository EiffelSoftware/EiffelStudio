note
	description: "API to handle ES Cloud api."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_ACCOUNT_API_I

feature {CMS_MODULE} -- Access nodes storage.

	cms_api: CMS_API
		deferred
		end

	es_cloud_storage: ES_CLOUD_STORAGE_I
		deferred
		end

feature -- Access: organizations

	organizations: LIST [ES_CLOUD_ORGANIZATION]
		do
			Result := es_cloud_storage.organizations
		end

	organization (a_id_or_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_ORGANIZATION
		do
			Result := es_cloud_storage.organization (a_id_or_name)
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

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

