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
	make, make_with_database

feature {NONE} -- Initialization

	make
			-- Create an object with defaults
		local
			l_retried: BOOLEAN
			mailer: NOTIFICATION_MAILER
			ext_mailer: NOTIFICATION_EXTERNAL_MAILER
			l_path: PATH
			l_env: EXECUTION_ENVIRONMENT
		do
			if not l_retried then
				create l_env
				if attached l_env.item ({ESA_CONSTANTS}.Esa_directory_variable_name) as s then
					create layout.make_with_path (create {PATH}.make_from_string (s))
				else
					create layout.make_default
				end
				create {ESA_DATABASE_CONNECTION_ODBC} database.make_common
				create api_service.make_with_database (database)
				if {PLATFORM}.is_windows then
					create {WS_NOTIFICATION_SENDMAIL_MAILER} mailer
				else
					create {NOTIFICATION_SENDMAIL_MAILER} mailer
				end
				create email_service.make_with_mailer (mailer)
				set_successful
			else
				create l_env
				if attached l_env.item ({ESA_CONSTANTS}.Esa_directory_variable_name) as s then
					create layout.make_with_path (create {PATH}.make_from_string (s))
				else
					create layout.make_default
				end
				create {ESA_DATABASE_CONNECTION_NULL} database.make_common
				create api_service.make_with_database (database)
				create {NOTIFICATION_SENDMAIL_MAILER} mailer
				create email_service.make_with_mailer (mailer)
			end
		rescue
			set_last_error_from_exception ("Database Connection execution")
			l_retried := True
			retry
		end


	make_with_database (a_connection_string: READABLE_STRING_32; a_database: READABLE_STRING_32)
			-- Create an object with defaults
		local
			l_retried: BOOLEAN
			mailer: NOTIFICATION_MAILER
			ext_mailer: NOTIFICATION_EXTERNAL_MAILER
			l_path: PATH
			l_env: EXECUTION_ENVIRONMENT
		do
			if not l_retried then
				create l_env
				if attached l_env.item ({ESA_CONSTANTS}.Esa_directory_variable_name) as s then
					create layout.make_with_path (create {PATH}.make_from_string (s))
				else
					create layout.make_default
				end

				create {ESA_DATABASE_CONNECTION_ODBC} database.login_with_connection_string (a_connection_string, a_database)
				create api_service.make_with_database (database)
				if {PLATFORM}.is_windows then
					create {WS_NOTIFICATION_SENDMAIL_MAILER} mailer
				else
					create {NOTIFICATION_SENDMAIL_MAILER} mailer
				end
				create email_service.make_with_mailer (mailer)
				set_successful
			else
				create l_env
				if attached l_env.item ({ESA_CONSTANTS}.Esa_directory_variable_name) as s then
					create layout.make_with_path (create {PATH}.make_from_string (s))
				else
					create layout.make_default
				end
				create {ESA_DATABASE_CONNECTION_NULL} database.make_common
				create api_service.make_with_database (database)
				create {NOTIFICATION_SENDMAIL_MAILER} mailer
				create email_service.make_with_mailer (mailer)
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

	email_service: ESA_EMAIL_SERVICE
			-- Eiffel email service

	layout: ESA_LAYOUT
			-- Api layout.		

end
