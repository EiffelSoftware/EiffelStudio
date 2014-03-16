note
	description: "Eiffel Suppor API configuration"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIG

inherit

	ESA_API_ERROR

create
	make

feature {NONE} -- Initialization

	make
			-- Create an object with defaults
		local
			l_retried: BOOLEAN
		do
			if not l_retrIed then
				create {ESA_DATABASE_CONNECTION_ODBC} database.make_common
				create api_service.make_with_database (database)
				set_successful
			else
				create {ESA_DATABASE_CONNECTION_NULL} database.make_common
				create api_service.make_with_database (database)
			end
		rescue
			set_last_error_from_exception ("Database Connection execution")
			l_retried := True
			retry
		end

feature -- Access

	is_successful: BOOLEAN
			-- Is the configuration successful?
		do
			Result := successful
		end

	database: ESA_DATABASE_CONNECTION
			-- Database connection

	api_service: ESA_API_SERVICE
			-- Eiffel Support API

end
