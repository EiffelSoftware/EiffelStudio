note
	description: "Summary description for {SHARED_DATABASE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_DATABASE_API

feature -- Access

	db_access: DATABASE_API
		once
			create Result.make
		end
note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
