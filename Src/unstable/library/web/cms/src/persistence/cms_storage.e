
note
	description : "[ 
				CMS interface to storage
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE

inherit
	CMS_CORE_STORAGE_I

	CMS_USER_STORAGE_I

	SHARED_LOGGER

feature {NONE} -- Initialization

	initialize
		do
		end

feature -- Access

	api: detachable CMS_API assign set_api
			-- Associated CMS API.

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		deferred
		end

	is_initialized: BOOLEAN
			-- Is storage initialized?
		deferred
		end

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.

feature -- Element change

	set_api (a_api: like api)
			-- Set `api' to `a_api'.
		do
			api := a_api
		end

end
