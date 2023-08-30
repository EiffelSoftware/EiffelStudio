note
	description: "Summary description for {CMS_USER_STORAGE_NULL}."
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

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable CMS_USER
		do
		end

	users_by_profile_name (a_profile_name: READABLE_STRING_GENERAL): detachable LIST [CMS_USER]
		do
		end

	user_by_activation_token (a_token: READABLE_STRING_32): detachable CMS_USER
		do
		end

	user_by_password_token (a_token: READABLE_STRING_32): detachable CMS_USER
		do
		end

	user_with_credential (a_user_name, a_password: READABLE_STRING_GENERAL): detachable CMS_USER
		do
		end

	users_count: INTEGER
			--<Precursor>
		do
		end

	recent_users (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_USER]
			-- <Precursor>
		do
			create {ARRAYED_LIST[CMS_USER]} Result.make (0)
		end

	recent_users_filtered_by_name (a_name: READABLE_STRING_GENERAL; a_lower: INTEGER; a_count: INTEGER): LIST [CMS_USER]
			-- <Precursor>
		do
			create {ARRAYED_LIST[CMS_USER]} Result.make (0)
		end

feature -- Change: user

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		do
			a_user.set_id (1)
		end

	update_username (a_user: CMS_USER; a_new_username: READABLE_STRING_32)
		do
		end

	update_user (a_user: CMS_USER)
			-- Update user `a_user'.
		do
		end

	delete_user (a_user: CMS_USER)
			-- Delete user `a_user'.
		do
		end

feature -- Access: roles and permissions

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		do
		end

	user_role_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_USER_ROLE
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

	role_permissions: LIST [READABLE_STRING_8]
			-- Possible known permissions.
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (0)
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		do
		end

	unassign_role_from_user (a_user_role: CMS_USER_ROLE; a_user: CMS_USER)
		do
		end

	assign_role_to_user (a_user_role: CMS_USER_ROLE; a_user: CMS_USER)
		do
		end

	delete_role (a_role: CMS_USER_ROLE)
			-- <Precursor>
		do
		end

feature -- Change: User activation

	save_activation (a_token: READABLE_STRING_32; a_id: INTEGER_64)
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

feature -- Access: Users

	temp_user_with_credential (a_user_name, a_password: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- <Precursor>
		do
		end

	temp_users_count: INTEGER
			-- <Precursor>
		do
		end

	temp_user_by_id (a_uid: like {CMS_USER}.id; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- <Precursor>
		do
		end

	temp_user_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- <Precursor>
		do
		end

	temp_user_by_email (a_email: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- <Precursor>
		do
		end

	temp_user_by_activation_token (a_token: READABLE_STRING_GENERAL): detachable CMS_TEMP_USER
			-- <Precursor>
		do
		end

	temp_recent_users (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_TEMP_USER]
			-- List of recent `a_count' temporal users with an offset of `lower'.
		do
			create {ARRAYED_LIST[CMS_TEMP_USER]} Result.make (0)
		end

	token_by_temp_user_id (a_id: like {CMS_USER}.id): detachable STRING
			-- <Precursor>
		do
		end

feature -- Temp Users

	new_user_from_temp_user (a_user: CMS_TEMP_USER)
			-- <Precursor>
		do
  		end

	remove_activation (a_token: READABLE_STRING_GENERAL)
			-- <Precursor>.
		do
		end

	new_temp_user (a_user: CMS_TEMP_USER)
			-- <Precursor>
		do
		end

	delete_temp_user (a_user: CMS_TEMP_USER)
			-- <Precursor>
		do
		end
note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
