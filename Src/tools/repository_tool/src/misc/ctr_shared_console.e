note
	description: "Summary description for {CTR_SHARED_CONSOLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_SHARED_CONSOLE

feature -- Access

	console_log (m: STRING_GENERAL)
		do
			console.log (m)
		end

	console: CTR_CONSOLE
		once
			create Result.make
		end

end
