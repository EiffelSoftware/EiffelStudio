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
