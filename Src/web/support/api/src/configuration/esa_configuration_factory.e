note
	description: "API configuration factory"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIGURATION_FACTORY

inherit

	SHARED_EXECUTION_ENVIRONMENT

	SHARED_ERROR

feature -- Factory

	esa_config (a_dir: detachable STRING): ESA_CONFIG
		local
			l_layout: APPLICATION_LAYOUT
			l_email_service: ESA_EMAIL_SERVICE
			l_database: DATABASE_CONNECTION
			l_api_service: ESA_API_SERVICE
			l_retried: BOOLEAN
		once ("PROCESS")
			if not l_retried then
				if attached a_dir then
					create l_layout.make_with_path (create {PATH}.make_from_string (a_dir))
				else
					create l_layout.make_default
				end
				log.write_information (generator + ".esa_config " + l_layout.path.name.out)

				create l_email_service.make ((create {JSON_CONFIGURATION}).new_smtp_configuration(l_layout.application_config_path))

				if attached (create {JSON_CONFIGURATION}).new_database_configuration (l_layout.application_config_path) as l_database_config then
					create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string)
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_email_service, l_layout)
					set_successful
				else
					create {DATABASE_CONNECTION_NULL} l_database.make_common
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_email_service, l_layout)
					set_last_error ("Database Connections", generator + ".esa_config")
					log.write_error (generator + ".esa_config Error database connection" )
				end
			else
				if attached a_dir then
					create l_layout.make_with_path (create {PATH}.make_from_string (a_dir))
				else
					create l_layout.make_default
				end
				create l_email_service.make ((create {JSON_CONFIGURATION}).new_smtp_configuration(l_layout.application_config_path))

				create {DATABASE_CONNECTION_NULL} l_database.make_common
				create l_api_service.make_with_database (l_database)
				create Result.make (l_database, l_api_service, l_email_service, l_layout)
			end
		rescue
			set_last_error_from_exception ("Database Connection execution")
			log.write_critical (generator + ".esa_config Database Connection execution exceptions")
			l_retried := True
			retry
		end

	esa_config_test (a_dir: detachable STRING): ESA_CONFIG
		local
			l_layout: APPLICATION_LAYOUT
			l_email_service: ESA_EMAIL_SERVICE
			l_database: DATABASE_CONNECTION
			l_api_service: ESA_API_SERVICE
			l_retried: BOOLEAN
		do

			if not l_retried then
				if attached a_dir and then attached Execution_environment.item (a_dir) as s then
					create l_layout.make_with_path (create {PATH}.make_from_string (s))
				else
					create l_layout.make_default
				end

				create l_email_service.make ((create {JSON_CONFIGURATION}).new_smtp_configuration(l_layout.application_config_path))

				if attached (create {JSON_CONFIGURATION}).new_database_configuration_test (l_layout.application_config_path) as l_database_config then
					create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string)
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_email_service, l_layout)
					set_successful
				else
					create {DATABASE_CONNECTION_NULL} l_database.make_common
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_email_service, l_layout)
					set_last_error ("Database Connections", generator+".esa_config")
				end
			else
				if attached a_dir and then attached Execution_environment.item (a_dir) as s then
					create l_layout.make_with_path (create {PATH}.make_from_string (s))
				else
					create l_layout.make_default
				end
				create l_email_service.make ((create {JSON_CONFIGURATION}).new_smtp_configuration(l_layout.application_config_path))
				create {DATABASE_CONNECTION_NULL} l_database.make_common
				create l_api_service.make_with_database (l_database)
				create Result.make (l_database, l_api_service, l_email_service, l_layout)
			end
		rescue
			set_last_error_from_exception ("Database Connection execution")
			l_retried := True
			retry
		end
end
