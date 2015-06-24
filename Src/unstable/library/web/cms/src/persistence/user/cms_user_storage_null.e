note
	description: "Summary description for {CMS_USER_STORAGE_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_STORAGE_NULL

inherit
	CMS_USER_STORAGE_I

feature -- Access: user

	has_user: BOOLEAN
			-- Has any user?
		do
		end

	users: LIST [CMS_USER]
		do
			create {ARRAYED_LIST [CMS_USER]} Result.make (0)
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
		do
		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
		do
		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
		do
		end

	user_by_activation_token (a_token: READABLE_STRING_32): detachable CMS_USER
		do
		end

	user_by_password_token (a_token: READABLE_STRING_32): detachable CMS_USER
		do
		end

	is_valid_credential (l_auth_login, l_auth_password: READABLE_STRING_32): BOOLEAN
		do
		end

feature -- Change: user

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		do
			a_user.set_id (1)
		end

	update_user (a_user: CMS_USER)
			-- Update user `a_user'.
		do
		end


feature -- Access: roles and permissions

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		do
		end

	user_roles_for (a_user: CMS_USER): LIST [CMS_USER_ROLE]
			-- User roles for user `a_user'.
			-- Note: anonymous and authenticated roles are not included.
		do
			create {ARRAYED_LIST [CMS_USER_ROLE]} Result.make (0)
		end

	user_roles: LIST [CMS_USER_ROLE]
		do
			create {ARRAYED_LIST [CMS_USER_ROLE]} Result.make (0)
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		do
		end

feature -- Change: User activation

	save_activation (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- <Precursor>.
		do
		end

	remove_activation (a_token: READABLE_STRING_32)
			-- <Precursor>.
		do
		end

feature -- Change: User password recovery

	save_password (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- <Precursor>.
		do
		end

	remove_password (a_token: READABLE_STRING_32)
			-- <Precursor>.
		do
		end

end
