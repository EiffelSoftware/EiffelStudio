note
	description: "Summary description for {SHARED_DATABASE}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_DATABASE

feature -- Database

	database: separate MESSAGES_API
		once ("PROCESS")
			create Result.make
		end

end
