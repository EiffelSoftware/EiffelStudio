note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_STORAGE_NULL

inherit
	JWT_AUTH_STORAGE_I

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access/token

	token (a_token: READABLE_STRING_GENERAL): detachable JWT_AUTH_TOKEN
			-- <Precursor>
		do
		end

	user_tokens (a_user: CMS_USER): detachable LIST [JWT_AUTH_TOKEN]
			-- <Precursor>
		do
		end

feature -- Change/token

	record_user_token (a_info: JWT_AUTH_TOKEN)
			-- <Precursor>
		do
		end

	discard_user_token (a_user: CMS_USER; a_token: READABLE_STRING_GENERAL)
			-- Discard `a_token` from `a_user`.
		do
		end

	discard_all_user_tokens (a_user: CMS_USER)
			-- Discard all tokens for `a_user`.
		do
		end

	discard_expired_tokens (dt: DATE_TIME; a_discarded_count: detachable CELL [INTEGER])
		do
		end

feature -- Access/challenge

	sign_in_challenge (ch: READABLE_STRING_GENERAL): detachable JWT_AUTH_SIGN_IN_CHALLENGE
		do
		end

feature -- Change/challenge

	record_sign_in_challenge (ch: JWT_AUTH_SIGN_IN_CHALLENGE)
		do
		end

	discard_sign_in_challenge (ch: READABLE_STRING_GENERAL)
		do
		end

	clean_sign_in_challenges
		do
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
