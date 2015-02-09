
note
	description : "[ 
				CMS interface to storage
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE

inherit
	CMS_USER_STORAGE

	CMS_NODE_STORAGE

	SHARED_LOGGER

feature {NONE} -- Initialization

	initialize
		do
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

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.

feature -- Misc

--	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: READABLE_STRING_8)
--			-- Save data `a_name:a_value' for type `a_type'
--		deferred
--		end

--	custom_value (a_name: READABLE_STRING_8; a_type: READABLE_STRING_8): detachable TABLE_ITERABLE [READABLE_STRING_8, STRING_8]
--			-- Data for name `a_name' and type `a_type'.
--		deferred
--		end

--	custom_value_names_where (a_where_key, a_where_value: READABLE_STRING_8; a_type: READABLE_STRING_8): detachable LIST [READABLE_STRING_8]
--			-- Names where custom value has item `a_where_key' same as `a_where_value' for  type `a_type'.
--		deferred
--		end

end
