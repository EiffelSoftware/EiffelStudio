note
	description: "Summary description for {CMS_SESSION_AUTH_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_STORAGE_NULL

inherit

	CMS_SESSION_AUTH_STORAGE_I


feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access

	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- Retrieve user by token `a_token', if any.
		do
		end

	has_user_token (a_user: CMS_USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		do
		end

feature -- Change User session

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER;)
			-- New user session for user `a_user' with token `a_token'.
		do
		end


	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER )
			-- Update user session for user `a_user' with token `a_token'.
		do
		end

end
