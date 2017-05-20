note
	description: "[
			Time-based One-time Password Algorithm (TOTP)
			
			see https://en.wikipedia.org/wiki/Time-based_One-time_Password_Algorithm
		]"
	revision: "$Revision$"

class
	TOTP

inherit
	HOTP
		redefine
			make_with_secret
		end

create
	make_with_secret

feature {NONE} -- Intialization

	make_with_secret (k: READABLE_STRING_8)
		do
			Precursor (k)
			time_step := 30 -- seconds
		end

feature -- Settings

	time_step: NATURAL_64
			-- Time Step , default is 30 seconds.

feature -- Basic operation

	time_token: STRING
			-- Current time token.
		do
			Result := time_token_at (create {DATE_TIME}.make_now_utc)
		end

	time_token_at (a_time_utc: DATE_TIME): STRING
			-- Time based OTP token at `a_time_utc`.
		do
			Result := token (a_time_utc.definite_duration (epoch).seconds_count.as_natural_64 // time_step)
		end

feature -- Settings change

	set_time_step (ts: like time_step)
			-- Set `time_step` to `ts`.
		do
			time_step := ts
		end

feature {NONE} -- Implementation		

	epoch: DATE_TIME
		once ("THREAD")
			create Result.make_from_epoch (0)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
