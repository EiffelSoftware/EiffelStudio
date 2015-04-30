note
	description: "Summary description for {CMS_USER_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create
	make

feature -- Access

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
			-- User by id `a_id', if any.
		do
			Result := storage.user_by_id (a_id)
		end

	user_by_name (a_username: READABLE_STRING_32): detachable CMS_USER
			-- User by name `a_user_name', if any.
		do
			Result := storage.user_by_name (a_username)
		end

feature -- Status report

	is_valid_credential (a_auth_login, a_auth_password: READABLE_STRING_32): BOOLEAN
				-- Is the credentials `a_auth_login' and `a_auth_password' valid?
		do
			Result := storage.is_valid_credential (a_auth_login, a_auth_password)
		end

	user_has_permission (a_user: detachable CMS_USER; a_permission: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Anonymous or user `a_user' has permission for `a_permission'?
			--| `a_permission' could be for instance "create page".
		do
			if a_permission = Void then
				Result := True
			elseif a_user = Void then
				Result := user_role_has_permission (anonymous_user_role, a_permission)
			else
				if is_admin_user (a_user) then
					Result := True
				else
					Result := user_role_has_permission (authenticated_user_role, a_permission)
					if not Result then
						Result := across user_roles (a_user) as ic some user_role_has_permission (ic.item, a_permission) end
					end
				end
			end
		end

	is_admin_user (u: CMS_USER): BOOLEAN
		do
			Result := u.id = 1
		end

	user_roles (a_user: CMS_USER): LIST [CMS_USER_ROLE]
		local
			l_roles: detachable LIST [CMS_USER_ROLE]
		do
			l_roles := a_user.roles
			if l_roles = Void then
					-- Fill user with its roles.
				create {ARRAYED_LIST [CMS_USER_ROLE]} l_roles.make (0)
				l_roles := storage.user_roles_for (a_user)
			end
			Result := l_roles
		end

feature -- User roles.		

	anonymous_user_role: CMS_USER_ROLE
		do
			if attached user_role_by_id (1) as l_anonymous then
				Result := l_anonymous
			else
				create Result.make ("anonymous")
			end
		end

	authenticated_user_role: CMS_USER_ROLE
		do
			if attached user_role_by_id (2) as l_authenticated then
				Result := l_authenticated
			else
				create Result.make ("authenticated")
			end
		end

	user_role_has_permission (a_role: CMS_USER_ROLE; a_permission: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_role.has_permission (a_permission)
		end

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		do
			Result := storage.user_role_by_id (a_id)
		end

feature -- Change User

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		require
			no_id: not a_user.has_id
			no_hashed_password: a_user.hashed_password = Void
		do
			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				storage.new_user (a_user)
			else
				debug ("refactor_fixme")
					fixme ("Add error")
				end
			end
		end

	update_user (a_user: CMS_USER)
			-- Update user `a_user'.
		require
			has_id: a_user.has_id
		do
			storage.update_user (a_user)
		end

end
