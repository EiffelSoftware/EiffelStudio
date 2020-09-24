note
	description: "Interface for accessing account data from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_ACCOUNT_STORAGE_SQL

inherit
	ES_CLOUD_ACCOUNT_STORAGE_I
		redefine
			organization
		end

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

feature -- Access: organization

	organizations: LIST [ES_CLOUD_ORGANIZATION]
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_ORGANIZATION]} Result.make (0)
			sql_query (sql_select_organizations, Void)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached fetch_organization as org then
						Result.force (org)
					else
						check valid_record: False end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_organizations)
		end

	organization (a_id_or_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_ORGANIZATION
		local
			l_oid: INTEGER_64
		do
			if a_id_or_name.is_integer_64 then
				l_oid := a_id_or_name.to_integer_64
				Result := organization_by_id (l_oid)
			else
				Result := organization_by_name (a_id_or_name)
			end
		end

	organization_by_name (a_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_ORGANIZATION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_name.as_lower, "lower_name")

			sql_query (sql_select_organization_by_name, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_organization
			end
			sql_finalize_query (sql_select_organization_by_name)
		end

	organization_by_id (oid: like {ES_CLOUD_ORGANIZATION}.id): detachable ES_CLOUD_ORGANIZATION
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (oid, "oid")

			sql_query (sql_select_organization_by_id, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_organization
			end
			sql_finalize_query (sql_select_organization_by_id)
		end

	user_organizations (a_user: ES_CLOUD_USER): detachable LIST [ES_CLOUD_ORGANIZATION]
		local
			l_params: STRING_TABLE [detachable ANY]
			lst: ARRAYED_LIST [like {ES_CLOUD_ORGANIZATION}.id]
		do
			reset_error

			create lst.make (1)
			create l_params.make (1)
			l_params["uid"] := a_user.id
			sql_query (sql_select_user_organizations, l_params)
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					lst.force (sql_read_integer_64 (2))
					sql_forth
				end
			end
			sql_finalize_query (sql_select_user_organizations)
			if not lst.is_empty then
				create {ARRAYED_LIST [ES_CLOUD_ORGANIZATION]} Result.make (lst.count)
				across
					lst as ic
				loop
					if attached organization_by_id (ic.item) as org then
						Result.force (org)
					end
				end
			end
		end

	save_organization (org: ES_CLOUD_ORGANIZATION)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_is_new: BOOLEAN
		do
			l_is_new := not org.has_id

			reset_error
			if l_is_new then
				create l_params.make (4)
			else
				create l_params.make (5)
				l_params.force (org.id, "oid")
			end
			l_params.force (org.name, "name")
			l_params.force (org.title, "title")
			l_params.force (org.description, "description")
			l_params.force (org.data, "data")
			if l_is_new then
				sql_insert (sql_insert_organization, l_params)
				sql_finalize_insert (sql_insert_organization)
			else
				sql_modify (sql_update_organization, l_params)
				sql_finalize_modify (sql_update_organization)
			end
		end

	delete_organization (org: ES_CLOUD_ORGANIZATION)
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (org.id, "oid")
			sql_delete (sql_delete_organization, l_params)
			sql_finalize_delete (sql_delete_organization)
		end

	organization_members (org: ES_CLOUD_ORGANIZATION; a_role: INTEGER): LIST [ES_CLOUD_USER]
		local
			l_params: STRING_TABLE [detachable ANY]
			oid,uid: INTEGER_64
			r: INTEGER
		do
			reset_error
			create {ARRAYED_LIST [ES_CLOUD_USER]} Result.make (0)
			create l_params.make (2)
			l_params["oid"] := org.id
			if a_role /= 0 then
				l_params["role"] := a_role
				sql_query (sql_select_members_with_role, l_params)
			else
				sql_query (sql_select_members, l_params)
			end

			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					uid := sql_read_integer_64 (1)
					oid := sql_read_integer_64 (2)
					r := sql_read_integer_32 (3)
					if a_role = 0 or else r = a_role then
						Result.force (create {ES_CLOUD_USER}.make (create {CMS_PARTIAL_USER}.make_with_id (uid)))
					end
					sql_forth
				end
			end
			if a_role /= 0 then
				sql_finalize_query (sql_select_members_with_role)
			else
				sql_finalize_query (sql_select_members)
			end
		end

	save_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER; a_role: INTEGER)
		local
			l_params: STRING_TABLE [detachable ANY]
			l_exists: BOOLEAN
		do
			l_exists := has_membership (org, a_user)
			reset_error
			create l_params.make (3)
			l_params.force (a_user.id, "uid")
			l_params.force (org.id, "oid")
			l_params.force (a_role, "role")
			if a_role = {ES_CLOUD_ORGANIZATION}.role_none_id then
				if l_exists then
					sql_delete (sql_delete_member, l_params)
					sql_finalize_delete (sql_delete_member)
				end
			else
				if l_exists then
					sql_modify (sql_update_member, l_params)
					sql_finalize_modify (sql_update_member)
				else
					sql_insert (sql_insert_member, l_params)
					sql_finalize_insert (sql_insert_member)
				end
			end
		end

	has_membership (org: ES_CLOUD_ORGANIZATION; a_user: ES_CLOUD_USER): BOOLEAN
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (2)
			l_params.force (a_user.id, "uid")
			l_params.force (org.id, "oid")

			sql_query (sql_select_member_with_role, l_params)
			sql_start
			if not has_error and not sql_after then
				Result := True
			end
			sql_finalize_query (sql_select_member_with_role)
		end

feature {NONE} -- Fetcher

	fetch_organization: detachable ES_CLOUD_ORGANIZATION
		local
			oid: INTEGER
			l_name: READABLE_STRING_32
		do
			oid := sql_read_integer_32 (1)
			l_name := sql_read_string_32 (2)
			if l_name = Void then
				l_name := "org#" + oid.out
			end
			create Result.make (oid, l_name)
			Result.set_title (sql_read_string_32 (3))
			Result.set_description (sql_read_string_32 (4))
			Result.set_data (sql_read_string_32 (5))
		end

feature {NONE} -- organizations, users

	sql_select_organizations: STRING = "SELECT oid, name, title, description, data FROM es_orgs ;"

	sql_select_organization_by_id: STRING = "SELECT oid, name, title, description, data FROM es_orgs WHERE oid=:oid;"

	sql_select_organization_by_name: STRING = "SELECT oid, name, title, description, data FROM es_orgs WHERE LOWER(name)=:lower_name;"

	sql_insert_organization: STRING = "INSERT INTO es_orgs (name, title, description, data) VALUES (:name, :title, :description, :data);"

	sql_update_organization: STRING = "UPDATE es_orgs SET name=:name, title=:title, description=:description, data=:data WHERE oid=:oid;"

	sql_delete_organization: STRING = "DELETE FROM es_orgs WHERE oid=:oid;"

	sql_select_members: STRING = "SELECT uid, oid, role FROM es_members WHERE oid=:oid ;"

	sql_select_members_with_role: STRING = "SELECT uid, oid, role FROM es_members WHERE oid=:oid AND role=:role;"

	sql_select_member_with_role: STRING = "SELECT uid, oid, role FROM es_members WHERE oid=:oid AND uid=:uid;"

	sql_select_user_organizations: STRING = "SELECT uid, oid, role FROM es_members WHERE uid=:uid ;"

	sql_insert_member: STRING = "INSERT INTO es_members (uid, oid, role) VALUES (:uid, :oid, :role);"

	sql_update_member: STRING = "UPDATE es_members SET uid=:uid, oid=:oid, role=:role WHERE uid=:uid AND oid=:oid;"

	sql_delete_member: STRING = "DELETE FROM es_members WHERE uid=:uid AND oid=:oid;"

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
