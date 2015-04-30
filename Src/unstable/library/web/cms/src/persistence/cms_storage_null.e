note
	description: "Summary description for {CMS_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_NULL

inherit
	CMS_STORAGE
		redefine
			default_create
		select
			default_create
		end

	REFACTORING_HELPER
		rename
			default_create as default_create_rh
		end

feature -- Initialization

	default_create
		do
			create error_handler.make
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		do
			Result := True
		end

	is_initialized: BOOLEAN
			-- Is storage initialized?
		do
			Result := True
		end

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



feature -- Logs

	save_log (a_log: CMS_LOG)
			-- Save `a_log'.
		do
		end

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: detachable READABLE_STRING_8)
			-- Save data `a_name:a_value' for type `a_type' (or default if none).
		do
		end

	unset_custom_value (a_name: READABLE_STRING_8; a_type: detachable READABLE_STRING_8)
			-- Delete data `a_name' for type `a_type' (or default if none).
		do
		end

	custom_value (a_name: READABLE_STRING_GENERAL; a_type: detachable READABLE_STRING_8): detachable READABLE_STRING_32
			-- Data for name `a_name' and type `a_type' (or default if none).
		do
		end


end
