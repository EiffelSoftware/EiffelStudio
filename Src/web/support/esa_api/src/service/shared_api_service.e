note
	description: "Summary description for {SHARED_API_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_API_SERVICE

feature -- API access

	api_service: API_SERVICE
		once
			create Result.make
		end
end
