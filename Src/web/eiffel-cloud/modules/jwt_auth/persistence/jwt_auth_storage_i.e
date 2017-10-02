note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JWT_AUTH_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

	token (a_token: READABLE_STRING_GENERAL): detachable JWT_AUTH_TOKEN
			-- Token record for token `a_token`.
		require
			not_blank: not a_token.is_whitespace
		deferred
		end

	user_tokens (a_user: CMS_USER): detachable LIST [JWT_AUTH_TOKEN]
			-- Tokens associated with `a_user`.
		require
			valid_user: a_user.has_id
		deferred
		end

feature -- Change

	record_user_token (a_info: JWT_AUTH_TOKEN)
			-- Record `a_info` JWT auth information.
		require
			user_has_id: a_info.user.has_id
			valid_token: not a_info.token.is_whitespace
		deferred
		end

	discard_user_token (a_user: CMS_USER; a_token: READABLE_STRING_GENERAL)
			-- Discard `a_token` from `a_user`.
		require
			user_has_id: a_user.has_id
			valid_token: not a_token.is_whitespace
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
