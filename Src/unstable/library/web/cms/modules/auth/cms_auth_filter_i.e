note
	description: "[
				Processes a HTTP request, and depending on header, authenticate a current user or not.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_AUTH_FILTER_I

inherit
	WSF_FILTER

feature {NONE} -- Initialization

	make (a_api: CMS_API)
			-- Initialize Current handler with `a_api'.
		do
			api := a_api
		end

feature -- API Service

	api: CMS_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		deferred
		end

	auth_strategy: STRING
		deferred
		end

	set_current_user (u: CMS_USER)
		do
			api.set_user (u)
				-- Record auth strategy:
			api.set_execution_variable ("auth_strategy", auth_strategy)
		end

end
