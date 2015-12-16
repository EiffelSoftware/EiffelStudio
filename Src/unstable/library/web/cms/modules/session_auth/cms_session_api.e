note
	description: "API to manage CMS User session authentication"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_API


inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create {CMS_SESSION_AUTH_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_session_auth_storage: CMS_SESSION_AUTH_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_session_auth_storage'.
		do
			session_auth_storage := a_session_auth_storage
			make (a_api)
		ensure
			session_auth_storage_set:  session_auth_storage = a_session_auth_storage
		end

feature {CMS_MODULE} -- Access: User session storage.

	session_auth_storage: CMS_SESSION_AUTH_STORAGE_I
			-- storage interface.

feature -- Access

	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- Retrieve user by token `a_token', if any.
		do
			Result := session_auth_storage.user_by_session_token (a_token)
		end

	has_user_token (a_user: CMS_USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		do
			Result := session_auth_storage.has_user_token (a_user)
		end

feature -- Change User session

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER;)
			-- New user session for user `a_user' with token `a_token'.
		do
			session_auth_storage.new_user_session_auth (a_token, a_user)
		end


	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER )
			-- Update user session for user `a_user' with token `a_token'.
		do
			session_auth_storage.update_user_session_auth (a_token, a_user)
		end

end
