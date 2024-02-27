note
	description: "Summary description for {CMS_USER_STORAGE_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_STORAGE_I

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

	user_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User with name `a_name', if any.
		require
			 a_name /= Void and then not a_name.is_empty
		deferred
		ensure
			same_name: Result /= Void implies a_name ~ Result.name
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User with name `a_email', if any.
		deferred
		ensure
			same_email: Result /= Void implies (attached Result.email as r_email and then a_email.same_string (r_email))
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	users_by_profile_name (a_profile_name: READABLE_STRING_GENERAL): detachable LIST [CMS_USER]
			-- Users with profile_name `a_profile_name', if any.
		deferred
		ensure
			same_profile_name: Result /= Void implies across Result as c all
					(attached c.item.profile_name as r_profile_name and then a_profile_name.same_string (r_profile_name))
				end
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

	user_with_credential (a_user_name, a_password: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User validating the credential `a_user_name` and `a_password`, if any.
			-- note: can be used to check if credentials are valid.
		deferred
		end

	is_valid_credential (a_username, a_password: READABLE_STRING_GENERAL): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		do
			Result := user_with_credential (a_username, a_password) /= Void
		end

	users_count: INTEGER
			-- Number of users
		deferred
		end

	recent_users (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_USER]
			-- List of recent `a_count' users with an offset of `lower'.
		deferred
		end

	recent_users_filtered_by_name (a_name: READABLE_STRING_GENERAL; a_lower: INTEGER; a_count: INTEGER): LIST [CMS_USER]
			-- List of recent `a_count' name-filtered users with an offset of `lower'.
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

	update_username (a_user: CMS_USER; a_new_username: READABLE_STRING_32)
			-- Update username of `a_user' to `a_new_username`.
		require
			has_id: a_user.has_id
		deferred
		end

	update_user (a_user: CMS_USER)
			-- Save user `a_user'.
		require
			has_id: a_user.has_id
		deferred
		end

	delete_user (a_user: CMS_USER)
			-- Delete user `a_user'.
		require
			has_id: a_user.has_id
		deferred
		end

feature -- Access: roles and permissions

	user_role_has_permission (a_role: CMS_USER_ROLE; s: READABLE_STRING_8): BOOLEAN
		do
			Result := a_role.has_permission (s)
		end

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
			-- User role by id `a_id', if any.
		deferred
		end

	user_role_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_USER_ROLE
			-- User role by name `a_id', if any.
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

	role_permissions: LIST [READABLE_STRING_8]
			-- Possible known role permissions.
		deferred
		ensure
			object_comparison: Result.object_comparison
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
			-- Save user role `a_user_role'
		deferred
		end

	unassign_role_from_user (a_role: CMS_USER_ROLE; a_user: CMS_USER)
			-- Unassign user_role to user
		require
				a_user.has_id
				a_role.has_id
		deferred
		end

	assign_role_to_user (a_role: CMS_USER_ROLE; a_user: CMS_USER)
			-- Assign user_role to user
		require
				a_user.has_id
				a_role.has_id
		deferred
		end


	delete_role (a_role: CMS_USER_ROLE)
			-- Remove role `a_role'.
		require
			a_role.has_id
		deferred
		end

feature -- Change: User activation

	save_activation (a_token: READABLE_STRING_32; a_id: INTEGER_64)
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

feature -- Access: Temp Users

	temp_user_with_credential (a_user_identifier, a_password: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- Temp user validating the credential `a_user_identifier` and `a_password`, if any.
			-- note: can be used to check if credentials are valid.
		deferred
		end

	is_valid_temp_user_credential (a_username, a_password: READABLE_STRING_GENERAL): BOOLEAN
			-- Does temp account with username `a_username' and password `a_password' exist?
		do
			Result := temp_user_with_credential (a_username, a_password) /= Void
		end

	temp_users_count: INTEGER
			-- Number of pending users
			--! to be accepted or rejected
		deferred
		end

	temp_user_by_id (a_uid: like {CMS_USER}.id; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- Retrieve a temporal user by id `a_uid' for the consumer `a_consumer', if aby.
		deferred
		end

	temp_user_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- User with name `a_name', if any.
		require
			 a_name /= Void and then not a_name.is_empty
		deferred
		ensure
			same_name: Result /= Void implies a_name ~ Result.name
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	temp_user_by_email (a_email: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- User with name `a_email', if any.
		deferred
		ensure
			same_email: Result /= Void implies a_email ~ Result.email
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	temp_user_by_activation_token (a_token: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- User with activation token `a_token', if any.
		deferred
		ensure
			password: Result /= Void implies (Result.hashed_password /= Void and Result.password = Void)
		end

	temp_recent_users (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_TEMP_USER]
			-- List of recent `a_count' temporal users with an offset of `lower'.
		deferred
		end

	token_by_temp_user_id (a_id: like {CMS_USER}.id): detachable READABLE_STRING_8
			-- Retrieve activation token for user identified with id `a_id', if any.
		deferred
		end

feature -- New Temp User

	new_user_from_temp_user (a_temp_user: CMS_TEMP_USER)
  			-- new user from temporal user `a_temp_user'
  		deferred
  		end

	remove_activation (a_token: READABLE_STRING_GENERAL)
			-- Remove activation by token `a_token'.
		deferred
		end

	new_temp_user (a_temp_user: CMS_TEMP_USER)
			-- New temp user `a_temp_user'.
		require
			no_id: not a_temp_user.has_id
		deferred
		end

	delete_temp_user (a_temp_user: CMS_TEMP_USER)
			-- Delete user `a_temp_user'.
		require
			has_id: a_temp_user.has_id
		deferred
		end

note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
