indexing
	description: "Shared metric interface names"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_METRIC_NAMES

feature -- Access

	metric_names: EB_METRIC_NAMES is
			-- Names used in metric interface
		once
			create Result
		ensure
			result_attached: Result /= Void
		end
	
end
