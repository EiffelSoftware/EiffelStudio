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
			database_service: detachable DATABASE_SERVICE
			download_service: DOWNLOAD_SERVICE
			j_cfg: JSON_CONFIGURATION
		once("THREAD")
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
			else
				create email_service.make_sendmail
			end
			Result.is_using_safe_redirection := j_cfg.using_safe_redirection_solution (l_layout.application_config_path)

			if attached (create {JSON_CONFIGURATION}).new_database_configuration (l_layout.application_config_path) as l_database_config then
				create {DATABASE_CONNECTION_ODBC} l_database.login_with_connection_string (l_database_config.connection_string)
				create database_service.make (l_database)
			end
			create download_service.make ((create {DOWNLOAD_JSON_CONFIGURATION}).new_download_configuration (l_layout.config_path.extended ("downloads_configuration.json")))
			Result.set_email_service (email_service)
			Result.set_database_service (database_service)
			Result.set_download_service (download_service)
		end
end
