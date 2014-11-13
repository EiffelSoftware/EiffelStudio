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

	SHARED_LOGGER

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make (a_api: CMS_API)
		do
			api := a_api
		end

feature -- Setup

	setup:  CMS_SETUP
		do
			Result := api.setup
		end

feature -- API Service

	api: CMS_API

end
