note
	description: "[
			Provides shared access to a XT_CONFIG
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_SHARED_CONFIG

feature -- Access

	config: XT_CONFIG
			-- Shared access to  config
		note
			once_status: global
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end
end
