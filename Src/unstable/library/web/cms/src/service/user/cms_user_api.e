note
	description: "API providing user related features."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create
	make

feature -- Validation

	is_valid_username (a_name: READABLE_STRING_32): BOOLEAN
		local
			c: CHARACTER_32
		do
			if a_name.is_empty or a_name.is_whitespace then
				Result := False
			elseif a_name[1].is_space then
				Result := False
			elseif a_name[a_name.count].is_space then
				Result := False
			else
				Result := True
				across
					a_name as ic
				until
					not Result
				loop
					c := ic.item
					if c.is_alpha_numeric or c = '-' or c = '_' then
					else
						Result := False
					end
				end
			end
		end

	is_valid_profile_name (a_name: READABLE_STRING_32): BOOLEAN
		local
			c: CHARACTER_32
		do
			if a_name.is_empty or a_name.is_whitespace then
				Result := False
			elseif a_name[1].is_space then
				Result := False
			elseif a_name[a_name.count].is_space then
				Result := False
			else
				Result := True
				across
					a_name as ic
				until
					not Result
				loop
					c := ic.item
					if c.is_alpha_numeric or c = '-' or c = '_' or c.is_space or c = '%'' then
					else
						Result := False
					end
				end
			end
		end

feature -- Query

	user_display_name (u: CMS_USER): READABLE_STRING_32
			-- Display name for user `u`.
		do
			if attached u.profile_name as pn and then not pn.is_whitespace then
				Result := pn
			elseif not u.name.is_whitespace then
				Result := u.name
			else
				Result := {STRING_32} "user #" + u.id.out
			end
		end

feature -- Access: user

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
			-- User by id `a_id', if any.
		do
			Result := storage.user_by_id (a_id)
		end

	user_by_name (a_username: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User by name `a_user_name', if any.
		do
			Result := storage.user_by_name (a_username)
		end

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User by email `a_email', if any.
		do
			Result := storage.user_by_email (a_email)
		end

	user_by_activation_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User by activation token `a_token'.
		do
			Result := storage.user_by_activation_token (a_token)
		end

	user_by_password_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User by password token `a_token'.
		do
			Result := storage.user_by_password_token (a_token)
		end

	users_count: INTEGER
			-- Number of users.
		do
			Result := storage.users_count
		end

	recent_users (params: CMS_DATA_QUERY_PARAMETERS): ITERABLE [CMS_USER]
			-- List of the `a_rows' most recent users starting from  `a_offset'.
		do
			Result := storage.recent_users (params.offset.to_integer_32, params.size.to_integer_32)
		end

feature -- Change User

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		require
			no_id: not a_user.has_id
			no_hashed_password: a_user.hashed_password = Void
		do
			reset_error
			if
				attached a_user.email as l_email
			then
				storage.new_user (a_user)
				error_handler.append (storage.error_handler)
			else
				error_handler.add_custom_error (0, "bad new user request", "Missing password or email to create new user!")
			end
		end

	update_username (a_user: CMS_USER; a_new_username: READABLE_STRING_32)
			-- Update username of `a_user' to `a_new_username'.
		require
			has_id: a_user.has_id
			valid_user_name: is_valid_username (a_new_username)
			user_by_name (a_new_username) = Void
		do
			reset_error
			storage.update_username (a_user, a_new_username)
			error_handler.append (storage.error_handler)
		end

	update_user (a_user: CMS_USER)
			-- Update user `a_user'.
		require
			has_id: a_user.has_id
		do
			reset_error
			storage.update_user (a_user)
			error_handler.append (storage.error_handler)
		end

	delete_user (a_user: CMS_USER)
			-- Delete user `a_user'.
		require
			has_id: a_user.has_id
		do
			reset_error
			storage.delete_user (a_user)
			error_handler.append (storage.error_handler)
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
			-- Retrieve a `Role' represented by an id `a_id' if any.
		do
			Result := storage.user_role_by_id (a_id)
		end

	user_role_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_USER_ROLE
			-- Retrieve a `Role' represented by a name `a_name' if any.
		do
			Result := storage.user_role_by_name (a_name)
		end

	role_permissions: HASH_TABLE [LIST [READABLE_STRING_8], STRING_8]
			-- Possible known permissions indexed by modules.
		local
			lst, l_full_lst, l_used_permissions: LIST [READABLE_STRING_8]
		do
			create Result.make (cms_api.enabled_modules.count + 1)

			l_used_permissions := storage.role_permissions
			across
				cms_api.enabled_modules as ic
			loop
				lst := ic.item.permissions
				if attached {CMS_ADMINISTRABLE} ic.item as adm then
					create {ARRAYED_LIST [READABLE_STRING_8]} l_full_lst.make (lst.count)
					l_full_lst.compare_objects
						-- l_full_lst.append (lst)
					across
						lst as lst_ic
					loop
						if not l_full_lst.has (lst_ic.item) then
							l_full_lst.extend (lst_ic.item)
						end
					end
						-- l_full_lst.append (adm.module_administration.permissions)
					lst := adm.module_administration.permissions
					across
						lst as lst_ic
					loop
						if not l_full_lst.has (lst_ic.item) then
							l_full_lst.extend (lst_ic.item)
						end
					end
					lst := l_full_lst
				end
				Result.force (lst, ic.item.name)
				across
					lst as p_ic
				loop
					from
						l_used_permissions.start
					until
						l_used_permissions.after
					loop
						if l_used_permissions.item.is_case_insensitive_equal (p_ic.item) then
							l_used_permissions.remove
							l_used_permissions.finish
						end
						l_used_permissions.forth
					end
				end

				if not l_used_permissions.is_empty then
					Result.force (l_used_permissions, "")
				end
			end
		end

	roles: LIST [CMS_USER_ROLE]
			-- List of possible roles.
		do
			Result := storage.user_roles
		end

	effective_roles: LIST [CMS_USER_ROLE]
			-- List of possible roles, apart from anonymous and authenticated roles that are special.
		local
			l_roles: like roles
			r: CMS_USER_ROLE
		do
			l_roles := storage.user_roles
			create {ARRAYED_LIST [CMS_USER_ROLE]} Result.make (l_roles.count)
			across
				l_roles as ic
			loop
				r := ic.item
				if r.same_user_role (anonymous_user_role) or r.same_user_role (authenticated_user_role) then
					-- Ignore
				else
					Result.force (r)
				end
			end
		end

	roles_count: INTEGER
			-- Number of roles
		do
			Result := storage.user_roles.count
		end

feature -- Change User role		

	save_user_role (a_user_role: CMS_USER_ROLE)
		do
			reset_error
			storage.save_user_role (a_user_role)
			error_handler.append (storage.error_handler)
		end

	unassign_role_from_user (a_role: CMS_USER_ROLE; a_user: CMS_USER; )
			-- Unassign user_role `a_role' to user `a_user'.
		do
			reset_error
			storage.unassign_role_from_user (a_role, a_user)
			error_handler.append (storage.error_handler)
		end

	assign_role_to_user (a_role: CMS_USER_ROLE; a_user: CMS_USER; )
			-- Assign user_role `a_role' to user `a_user'.
		do
			reset_error
			storage.assign_role_to_user (a_role, a_user)
			error_handler.append (storage.error_handler)
		end

	delete_role (a_role: CMS_USER_ROLE)
		do
			reset_error
			storage.delete_role (a_role)
			error_handler.append (storage.error_handler)
		end

feature -- User Activation

	new_activation (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- Save activation token `a_token', for the user with the id `a_id'.
		do
			storage.save_activation (a_token, a_id)
		end

feature -- User Password Recovery

	new_password (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- Save password token `a_token', for the user with the id `a_id'.
		do
			storage.save_password (a_token, a_id)
		end

	remove_password (a_token: READABLE_STRING_32)
			-- Remove password token `a_token', from the storage.
		do
			storage.remove_password (a_token)
		end

feature -- User status

	not_active: INTEGER = 0
			-- The user is not active.

	active: INTEGER = 1
			-- The user is active

	Trashed: INTEGER = -1
			-- The user is trashed (soft delete), ready to be deleted/destroyed from storage.

feature -- Access - Temp User

	temp_users_count: INTEGER
			-- Number of pending users.
			--! to be accepted or rehected
		do
			Result := storage.temp_users_count
		end

	temp_user_by_name (a_username: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User by name `a_user_name', if any.
		do
			Result := storage.temp_user_by_name (a_username.as_string_32)
		end

	temp_user_by_email (a_email: READABLE_STRING_8): detachable CMS_USER
			-- User by email `a_email', if any.
		do
			Result := storage.temp_user_by_email (a_email)
		end

	temp_user_by_activation_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User by activation token `a_token'.
		do
			Result := storage.temp_user_by_activation_token (a_token)
		end

	temp_recent_users (params: CMS_DATA_QUERY_PARAMETERS): ITERABLE [CMS_TEMP_USER]
			-- List of the `a_rows' most recent users starting from  `a_offset'.
		do
			Result := storage.temp_recent_users (params.offset.to_integer_32, params.size.to_integer_32)
		end

	token_by_temp_user_id (a_id: like {CMS_USER}.id): detachable STRING
		do
			Result := storage.token_by_temp_user_id (a_id)
		end

feature -- Change Temp User

	new_user_from_temp_user (a_user: CMS_TEMP_USER)
			-- Add a new user `a_user'.
		require
			no_id: not a_user.has_id
			has_hashed_password: a_user.hashed_password /= Void
			has_sal: a_user.salt /= Void
		do
			reset_error
			if
				attached a_user.hashed_password as l_password and then
				attached a_user.salt as l_salt and then
				attached a_user.email as l_email
			then
				storage.new_user_from_temp_user (a_user)
				error_handler.append (storage.error_handler)
			else
				error_handler.add_custom_error (0, "bad new user request", "Missing password or email to create new user!")
			end
		end

	new_temp_user (a_user: CMS_TEMP_USER)
			-- Add a new user `a_user'.
		require
			no_id: not a_user.has_id
			no_hashed_password: a_user.hashed_password = Void
		do
			reset_error
			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				storage.new_temp_user (a_user)
				error_handler.append (storage.error_handler)
			else
				error_handler.add_custom_error (0, "bad new user request", "Missing password or email to create new user!")
			end
		end

	remove_activation (a_token: READABLE_STRING_32)
			-- Remove activation token `a_token', from the storage.
		do
			storage.remove_activation (a_token)
		end

	delete_temp_user (a_user: CMS_TEMP_USER)
			-- Delete user `a_user'.
		require
			has_id: a_user.has_id
		do
			reset_error
			storage.delete_temp_user (a_user)
			error_handler.append (storage.error_handler)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
