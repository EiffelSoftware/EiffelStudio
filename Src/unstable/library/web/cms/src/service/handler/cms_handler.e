note
	description: "Summary description for {CMS_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HANDLER

inherit
	WSF_HANDLER

	CMS_REQUEST_UTIL

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make (a_api: CMS_API)
			-- Initialize Current handler with `a_api'.
		do
			api := a_api
		end

feature -- API Service

	api: CMS_API

end
