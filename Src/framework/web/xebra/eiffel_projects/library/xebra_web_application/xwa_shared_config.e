note
	description: "[
			Provides shared access to a XU_WEBAPP_CONFIG for webapp classes.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SHARED_CONFIG

feature -- Access

	config: XC_WEBAPP_CONFIG
			-- Shared access to a config
		note
			once_status: global
		once
			create Result.make_empty
		ensure
			result_attached: Result /= Void
		end

end
