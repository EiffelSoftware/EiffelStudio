indexing
	description: "Shared metric manager"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_METRIC_MANAGER

feature -- Access

	metric_manager: EB_METRIC_MANAGER is
			-- Metric manager
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end
end
