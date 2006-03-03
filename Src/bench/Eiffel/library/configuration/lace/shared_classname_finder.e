indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CLASSNAME_FINDER

feature

	Classname_finder: CLASSNAME_FINDER is
			-- Classname finder
		once
			create Result.make
		ensure
			classname_finder_not_void: Result /= Void
		end
end
