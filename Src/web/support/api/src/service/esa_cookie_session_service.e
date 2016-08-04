note
	description: "Provide cookie session details to use with Authentication with Cookies."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_COOKIE_SESSION_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_remember_me: INTEGER_64;)
		do
			if a_remember_me > 0 then
				remember_me_max_age := a_remember_me
			else
				remember_me_max_age := internal_max_age
			end

			default_max_age := internal_default_max_age
		end

feature -- Access

	remember_me_max_age: INTEGER_64
			-- remember me.

	default_max_age: INTEGER_64
			-- default max age.

feature {NONE} -- Implementation

	internal_max_age: INTEGER = 2678400
			-- Use for remember_me one month (31 days).
			-- One day (24(h) * 60 (m) * 60 (s)

	internal_default_max_age: INTEGER = 1200
			-- 20 minutes.
end
