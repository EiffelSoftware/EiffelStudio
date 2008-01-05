indexing
	description: "Collection of stateful visitors"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_STATEFUL_VISITOR

feature -- Access

	built_in_processor: BUILT_IN_PROCESSOR
			-- Processor for built-in routines.
		once
			create Result.make
		end

end
