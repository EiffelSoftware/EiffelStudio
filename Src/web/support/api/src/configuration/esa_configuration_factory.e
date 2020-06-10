note
	description: "API configuration factory"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIGURATION_FACTORY

inherit

	SHARED_EXECUTION_ENVIRONMENT

	SHARED_ERROR

feature -- Defaults

	default_admin_email: STRING = "noreplies@eiffel.com"
	default_webmaster_email: STRING = "webmaster@eiffel.com"

feature -- Factory

	esa_config (a_dir: detachable STRING): ESA_CONFIG
			-- Setup ESA_CONFGI from an external configuration at `a_dir' if attached
			-- or default.
		local
			l_layout: APPLICATION_LAYOUT
			l_notification_service: ESA_NOTIFICATION_EMAIL_SERVICE
			l_database: DATABASE_CONNECTION
			l_api_service: ESA_API_SERVICE
			l_retried: BOOLEAN
			l_reply_to_email, l_admin_email, l_webmaster_email: READABLE_STRING_8
		once ("THREAD")
			if attached a_dir then
				create l_layout.make_with_path (create {PATH}.make_from_string (a_dir))
			else
				create l_layout.make_default
			end
			log.write_information (generator + ".esa_config " + l_layout.path.name.out)

			if
				attached (create {JSON_CONFIGURATION}).new_emails_configuration (l_layout.application_config_path) as l_email_addresses
			then
				l_admin_email := l_email_addresses ["admin"]
				l_webmaster_email := l_email_addresses ["webmaster"]
				l_reply_to_email :=  l_email_addresses ["reply-to"]
			end
			if l_admin_email = Void then
				l_admin_email := default_admin_email
			end
			if l_webmaster_email = Void then
				l_webmaster_email := default_webmaster_email
			end
			if
				attached (create {JSON_CONFIGURATION}).new_smtp_configuration (l_layout.application_config_path) as l_smtp_server and then
				not l_smtp_server.is_whitespace
			then
				create l_notification_service.make (l_smtp_server, l_admin_email, l_webmaster_email)
			else
				create l_notification_service.make_sendmail (l_admin_email, l_webmaster_email)
			end
			if l_reply_to_email /= Void then
				l_notification_service.set_reply_to_email_pattern (l_reply_to_email)
			end

			if not l_retried then
				if attached (create {JSON_CONFIGURATION}).new_database_configuration (l_layout.application_config_path) as l_database_config then
					create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string.to_string_8)
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_notification_service, l_layout)
					set_successful
				else
					create {DATABASE_CONNECTION_NULL} l_database.make_common
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_notification_service,  l_layout)
					set_last_error ("Database Connections", generator + ".esa_config")
					log.write_error (generator + ".esa_config Error database connection")
				end
			else
				create {DATABASE_CONNECTION_NULL} l_database.make_common
				create l_api_service.make_with_database (l_database)
				create Result.make (l_database, l_api_service, l_notification_service, l_layout)
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
			l_notification_service: ESA_NOTIFICATION_EMAIL_SERVICE
			l_database: DATABASE_CONNECTION
			l_api_service: ESA_API_SERVICE
			l_retried: BOOLEAN
			l_reply_to_email, l_admin_email, l_webmaster_email: READABLE_STRING_8
		do
			if attached a_dir and then attached Execution_environment.item (a_dir) as s then
				create l_layout.make_with_path (create {PATH}.make_from_string (s))
			else
				create l_layout.make_default
			end
			if
				attached (create {JSON_CONFIGURATION}).new_emails_configuration (l_layout.application_config_path) as l_email_addresses
			then
				l_admin_email := l_email_addresses ["admin"]
				l_webmaster_email := l_email_addresses ["webmaster"]
				l_reply_to_email :=  l_email_addresses ["reply-to"]
			end
			if l_admin_email = Void then
				l_admin_email := default_admin_email
			end
			if l_webmaster_email = Void then
				l_webmaster_email := default_webmaster_email
			end
			if
				attached (create {JSON_CONFIGURATION}).new_smtp_configuration (l_layout.application_config_path) as l_smtp_server and then
				not l_smtp_server.is_whitespace
			then
				create l_notification_service.make (l_smtp_server, l_admin_email, l_webmaster_email)
			else
				create l_notification_service.make_sendmail (l_admin_email, l_webmaster_email)
			end

			if not l_retried then
				if attached (create {JSON_CONFIGURATION}).new_database_configuration_test (l_layout.application_config_path) as l_database_config then
					create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string.to_string_8)
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_notification_service, l_layout)
					set_successful
				else
					create {DATABASE_CONNECTION_NULL} l_database.make_common
					create l_api_service.make_with_database (l_database)
					create Result.make (l_database, l_api_service, l_notification_service, l_layout)
					set_last_error ("Database Connections", generator+".esa_config")
				end
			else
				create {DATABASE_CONNECTION_NULL} l_database.make_common
				create l_api_service.make_with_database (l_database)
				create Result.make (l_database, l_api_service, l_notification_service, l_layout)
			end
		rescue
			set_last_error_from_exception ("Database Connection execution")
			l_retried := True
			retry
		end


end
