indexing

	description:

		"Shared access to random number generator"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_SHARED_RANDOM

feature -- Access

	random: RANDOM is
		once
			create Result.make
		ensure
			random_not_void: Result /= Void
		end

end
