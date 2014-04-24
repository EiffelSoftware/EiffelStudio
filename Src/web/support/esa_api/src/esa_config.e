note
	description: "Eiffel Suppor API configuration"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIG

inherit

	ESA_API_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_database: ESA_DATABASE_CONNECTION; a_api_service: ESA_API_SERVICE; a_email_service: ESA_EMAIL_SERVICE; a_layout: ESA_LAYOUT )
			-- Create an object with defaults
		do
			database := a_database
			api_service := a_api_service
			email_service := a_email_service
			layout := a_layout
		ensure
			database_set: database = a_database
			api_service_set: api_service = a_api_service
			email_service_set: email_service = a_email_service
			layout_set: layout = a_layout
		end

feature -- Access

	is_successful: BOOLEAN
			-- Is the configuration successfult?
		do
			Result := successful
		end


	database: ESA_DATABASE_CONNECTION
			-- Database connection

	api_service: ESA_API_SERVICE
			-- Eiffel Support API

	email_service: ESA_EMAIL_SERVICE
			-- Eiffel email service

	layout: ESA_LAYOUT
			-- Api layout.		

end
