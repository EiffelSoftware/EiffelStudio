note
	description: "Summary description for {ESA_SHARED_LOGGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SHARED_LOGGER

inherit
	LOG_PRIORITY_CONSTANTS

feature -- Logger


	log: ESA_LOGGING_FACILITY
		local
			l_log_writer: LOG_ROLLING_WRITER_FILE
			l_environment: EXECUTION_ENVIRONMENT
			l_path: PATH
			l_logger_config: ESA_LOGGER_CONFIGURATION
		once
					--| Initialize the logging facility
			create Result.make
			create l_environment
			if attached l_environment.item ("ESA_DIR") as s then
				l_path := create {PATH}.make_from_string (s)
				create l_log_writer.make_at_location (l_path.extended ("..").appended ("\esa_api.log"))
			else
				l_path := create {PATH}.make_current
				create l_log_writer.make_at_location (l_path.extended("esa_api.log"))
			end
			l_log_writer.set_max_file_size ({NATURAL_64}1024*1204)
			if attached l_environment.item ("ESA_DIR") as s then
				l_logger_config := new_logger_level_configuration (l_path.extended("config").extended ("esa_application_configuration.json"))
			else
				l_logger_config := new_logger_level_configuration (l_path.extended ("esa_folder").extended("config").extended ("esa_application_configuration.json"))
			end
			l_log_writer.set_max_backup_count (l_logger_config.backup_count)
			set_logger_level (l_log_writer, l_logger_config.level)
			log.register_log_writer (l_log_writer)

					--| Write an informational message
			Result.write_information ("The application is starting up...")
		end





feature {NONE} -- JSON

	set_logger_level (a_log_writer: LOG_ROLLING_WRITER_FILE; a_priority: INTEGER)
			-- Setup the logger level based on `a_priority'
		do
			if a_priority = log_debug then
				a_log_writer.enable_debug_log_level
			elseif a_priority = Log_emergency then
				a_log_writer.enable_emergency_log_level
			elseif a_priority = Log_alert then
				a_log_writer.enable_alert_log_level
			elseif a_priority = Log_critical then
				a_log_writer.enable_critical_log_level
			elseif a_priority = Log_error then
				a_log_writer.enable_error_log_level
			elseif a_priority = Log_warning then
				a_log_writer.enable_warning_log_level
			elseif a_priority = Log_notice then
				a_log_writer.enable_notice_log_level
			elseif a_priority = Log_information then
				a_log_writer.enable_information_log_level
			else
				a_log_writer.enable_unkno_log_level
			end
		end

	new_logger_level_configuration (a_path: PATH): ESA_LOGGER_CONFIGURATION
			-- Retrieve a new logger level configuration.
			-- By default, level is set to `DEBUG'.
		local
			l_parser: JSON_PARSER
		do
			create Result
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("logger") as l_logger and then
			     attached {JSON_STRING} l_logger.item ("backup_count") as l_count and then
			     attached {JSON_STRING} l_logger.item ("level") as l_level then
			     Result.set_level (l_level.item)
			     if l_count.item.is_natural then
			     	Result.set_backup_count (l_count.item.to_natural)
			     end
			 end
			end
		end


	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name.out)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_parser (a_string)
		end

end
