note
	description: "[
		Provides one testing feature for the servlet.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

inherit
	XWA_CONTROLLER

create
	make

feature {NONE} -- Initialization	

	make
			-- Initializes 'Current'
		do
			default_create
		end

feature -- Basic Operations

	world: STRING
			-- Displays 'WORLD' or world depending on the current time
		local
			l_time: TIME
		do
				-- Sets the sessions max age to 1000 seconds
			session.set_max_age (10000)

			create l_time.make_now

			if l_time.second \\ 2 = 0 then
				Result := "WORLD"
			else
				Result := "world"
			end
		end


end
