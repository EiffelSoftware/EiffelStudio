indexing

	description:

		"Shared access to AUT_PATHNAMES."

	library: "AutoTest Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_SHARED_PATHNAMES

feature -- Singleton Access

	pathnames: AUT_PATHNAMES is
			-- Singleton Access to AUT_PATHNAMES
		once
			create Result.make
		ensure
			pathnames_not_void: Result /= Void
		end
end
		
