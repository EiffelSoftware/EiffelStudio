
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

feature -- Conversion

	as_sql_storage: detachable CMS_STORAGE_SQL_I
			-- SQL based variant of `Current' if possible.
		do
			if attached {CMS_STORAGE_SQL_I} Current as st then
				Result := st
			end
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		deferred
		end

	is_initialized: BOOLEAN
			-- Is storage initialized?
		deferred
		end

	is_reuseable: BOOLEAN assign set_is_reuseable
			-- Is current storage marked as reusable?

feature -- Basic operation

	close
			-- Close/disconnect current storage.
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

	set_is_reuseable (b: BOOLEAN)
		do
			is_reuseable := b
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
