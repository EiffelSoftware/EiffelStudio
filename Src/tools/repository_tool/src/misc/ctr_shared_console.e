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

	console_log_warning (m: STRING_GENERAL)
		do
			console.log_warning (m)
		end

	console_log_error (m: STRING_GENERAL)
		do
			console.log_error (m)
		end

	console_log_custom (m: STRING_GENERAL; t: INTEGER)
		do
			console.log_custom (m, t)
		end

	console: CTR_CONSOLE
		once
			create Result.make
		end

end
