note
	description: "[
		API to handle OAUTH storage
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SESSION_AUTH_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: Users

	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- Retrieve user by token `a_token', if any.
		deferred
		end

	has_user_token (a_user: CMS_USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		deferred
		end


feature -- Change User session

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER;)
			-- New user session for user `a_user' with token `a_token'.
		deferred
		end


	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER )
			-- Update user session for user `a_user' with token `a_token'.
		deferred
		end
end
