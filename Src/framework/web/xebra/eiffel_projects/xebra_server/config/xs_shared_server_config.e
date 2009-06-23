note
	description: "[
			Provides shared access to a XS_SERVER_CONFIG
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SHARED_SERVER_CONFIG

feature -- Access

	config: XS_SERVER_CONFIG
			-- Shared access to a server config
		note
			once_status: global
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end
end
