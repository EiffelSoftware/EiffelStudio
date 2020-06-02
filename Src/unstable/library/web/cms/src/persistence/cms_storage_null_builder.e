note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_NULL_BUILDER

inherit
	CMS_STORAGE_BUILDER

feature -- Factory

	storage (a_db_cfg: DATABASE_CONFIGURATION; a_setup: CMS_SETUP; a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE_NULL
		do
			create Result
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
