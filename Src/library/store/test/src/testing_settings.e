note
	description : "Objects that ..."
	author: "$Author: manus $"
	date: "$Date: 2014-01-14 21:55:46 +0100 (Tue, 14 Jan 2014) $"
	revision: "$Revision: 93991 $"

deferred class
	TESTING_SETTINGS

feature -- Storage

	host: STRING
		deferred
		end

	database_name: STRING
		deferred
		end

	user_login: STRING
		deferred
		end

	user_password: STRING
		deferred
		end

	is_trusted: BOOLEAN
		do
		end

feature {NONE} -- Imp

	json_configuration: JSON_CONFIGURATION
			-- Json configuration
		once
			if {PLATFORM}.is_windows then
				create Result.make ("test.config")
			else
				create Result.make ("test.config")
			end
			Result.load
		end

end
