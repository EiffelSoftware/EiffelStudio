note
	description: "Summary description for {EWF_DOWNLOAD_CONFIGURATION_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DOWNLOAD_CONFIGURATION_FACTORY

inherit
	ARGUMENTS

feature -- Configuration

	config: EWF_DOWNLOAD_CONFIGURATION
		local
			l_database: DATABASE_CONNECTION
			l_layout: APPLICATION_LAYOUT
			email_service: EMAIL_SERVICE
			database_service: detachable DATA_SERVICE
			j_cfg: APP_JSON_CONFIGURATION
		once ("THREAD")
			if attached separate_character_option_value ('d') as l_dir then
				create l_layout.make_with_path (create {PATH}.make_from_string (l_dir))
			else
				create l_layout.make_default
			end
			create Result.make (l_layout)
			create j_cfg

			if
				attached j_cfg.new_smtp_configuration (l_layout.application_config_path) as l_smtp_server and then
				not l_smtp_server.is_whitespace
			then
				create email_service.make (l_smtp_server)
			elseif
				attached j_cfg.new_sendmail_configuration (l_layout.application_config_path) as l_sendmail_location and then
				not l_sendmail_location.is_whitespace
			then
				create email_service.make_with_sendmail_location (l_sendmail_location)
			else
				create email_service.make_sendmail
			end

			Result.is_using_safe_redirection := j_cfg.using_safe_redirection_solution (l_layout.application_config_path)

			if attached (create {APP_JSON_CONFIGURATION}).new_database_configuration (l_layout.application_config_path) as l_database_config then
				create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string)
				create {DATABASE_SERVICE} database_service.make (l_database)
			else
				create {DATATEST_SERVICE} database_service.make
			end
			Result.set_email_service (email_service)
			Result.set_data_service (database_service)
		end
end
