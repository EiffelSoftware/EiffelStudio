note
	description: "Ec launcher's implementation for Mac OS X."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_LAUNCHER_IMP

inherit
	EC_LAUNCHER_I
		redefine
			error
		end

feature -- Access

	error (m: STRING)
			-- notify error message `m'
		do
			-- Display message m
		end

end