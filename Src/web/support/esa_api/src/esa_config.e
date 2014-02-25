note
	description: "Eiffel Suppor API configuration"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIG

create
	make

feature {NONE} -- Initialization

	make
			-- Create an object with defaults
		do
			create {ESA_DATABASE_CONNECTION_ODBC} database.make_common
			create api_service.make_with_database (database)
		end

feature -- Access

	database: ESA_DATABASE_CONNECTION
			-- Database connection

	api_service: ESA_API_SERVICE
			-- Eiffel Support API

feature -- Status Report

	is_service_available: BOOLEAN
			-- Is the API service available?
		do
			Result := database.is_connected
		end

end
