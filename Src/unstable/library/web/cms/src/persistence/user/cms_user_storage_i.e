note
	description: "Summary description for {CMS_USER_STORAGE_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_STORAGE_I

inherit
	SHARED_LOGGER

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

	has_user: BOOLEAN
			-- Has any user?
		deferred
		end

	users: LIST [CMS_USER]
			-- List of users.
		deferred
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
			-- User with id `a_id', if any.
		require
			a_id > 0
		deferred
		ensure
			same_id: Result /= Void implies Result.id = a_id
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
			-- User with name `a_name', if any.
		require
			 a_name /= Void and then not a_name.is_empty
		deferred
		ensure
			same_name: Result /= Void implies a_name ~ Result.name
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
			-- User with name `a_email', if any.
		deferred
		ensure
			same_email: Result /= Void implies a_email ~ Result.email
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	user_by_activation_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User with activation token `a_token', if any.
		deferred
		ensure
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	user_by_password_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User with password token `a_token', if any.
		deferred
		ensure
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	is_valid_credential (a_u, a_p: READABLE_STRING_32): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		deferred
		end

feature -- Change: user

	save_user (a_user: CMS_USER)
			-- Create or update `a_user'.
		do
			if a_user.has_id then
				update_user (a_user)
			else
				new_user (a_user)
			end
		end

	new_user (a_user: CMS_USER)
			-- New user `a_user'.
		require
			no_id: not a_user.has_id
		deferred
		end

	update_user (a_user: CMS_USER)
			-- Save user `a_user'.
		require
			has_id: a_user.has_id
		deferred
		end

feature -- Access: roles and permissions

--	user_has_permission (u: detachable CMS_USER; s: detachable READABLE_STRING_8): BOOLEAN
--			-- Anonymous or user `u' has permission for `s' ?
--			--| `s' could be "create page",	
--		do
----			if s = Void then
----				Result := True
----			elseif u = Void then
------				Result := user_role_has_permission (anonymous_user_role, s)
----			else
----				Result := user_role_has_permission (authenticated_user_role, s)
----				if not Result and attached u.roles as l_roles then
----					across
----						l_roles as r
----					until
----						Result
----					loop
----						if attached user_role_by_id (r.item) as ur then
----							Result := user_role_has_permission (ur, s)
----						end
----					end
----				end
----			end
--		end

	user_role_has_permission (a_role: CMS_USER_ROLE; s: READABLE_STRING_8): BOOLEAN
		do
			Result := a_role.has_permission (s)
		end

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
			-- User role by id `a_id', if any.
		deferred
		end

	user_roles_for (a_user: CMS_USER): LIST [CMS_USER_ROLE]
			-- User roles for user `a_user'.
			-- Note: anonymous and authenticated roles are not included.
		deferred
		end

	user_roles: LIST [CMS_USER_ROLE]
			-- Possible list of user roles.
		deferred
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
			-- Save user role `a_user_role'
		deferred
		end

feature -- Change: User activation

	save_activation (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- <Precursor>.
		deferred
		end

	remove_activation (a_token: READABLE_STRING_32)
			-- <Precursor>.
		deferred
		end

feature -- Change: User password recovery

	save_password (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- <Precursor>.
		deferred
		end

	remove_password (a_token: READABLE_STRING_32)
			-- <Precursor>.
		deferred
		end

end
