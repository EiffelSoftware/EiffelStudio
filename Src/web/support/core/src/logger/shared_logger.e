note
	description: "Provides logger information"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGGER

inherit
	LOG_PRIORITY_CONSTANTS

	ARGUMENTS

	JSON_PARSER_ACCESS

feature -- Logger


	log: LOGGING_FACILITY
			-- New `log' (once per process)
            -- that could be shared between threads
            -- without reinitializing it.
		local
			l_log_writer: ESA_LOG_ROLLING_WRITER_FILE
			l_path: PATH
			l_logger_config: LOGGER_CONFIGURATION
			dir: DIRECTORY
		once ("PROCESS")
					--| Initialize the logging facility
			create Result.make

			l_path := create {PATH}.make_current
			if attached separate_character_option_value ('d') as l_dir then
				l_path := create {PATH}.make_from_string (l_dir)
				l_logger_config := new_logger_level_configuration (l_path.extended("config").extended ("application_configuration.json"))
			else
				l_logger_config := new_logger_level_configuration (l_path.extended ("site").extended("config").extended ("application_configuration.json"))
			end

			if attached separate_character_option_value ('d') as l_dir then
				l_path := create {PATH}.make_from_string (l_dir)
				create dir.make_with_path (l_path)
				create l_log_writer.make_at_location_and_count (l_path.extended ("..").appended ("\api.log"), dir.entries.count.to_natural_8)
			else
				if attached {PATH} l_logger_config.path as l_log_path then
					if l_log_path.is_absolute then
						create l_log_writer.make_at_location (l_log_path.extended ("api.log"))
					else
						l_path := create {PATH}.make_current
						create l_log_writer.make_at_location (l_path.extended_path (l_log_path).extended ("api.log"))
					end
				else
						-- by default logs are located the current directory /logs/api.log
					create l_log_writer.make_at_location (l_path.extended("logs").extended("api.log"))
				end
			end
			l_log_writer.set_max_file_size ({NATURAL_64}4*1024*1204)
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

	new_logger_level_configuration (a_path: PATH): LOGGER_CONFIGURATION
			-- Retrieve a new logger level configuration.
			-- By default, level is set to `DEBUG'.
		local
			l_parser: JSON_PARSER
		do
			create Result
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.next_parsed_json_value as jv and then l_parser.is_valid and then
			     attached {JSON_OBJECT} jv.item ("logger") as l_logger and then
			     attached {JSON_STRING} l_logger.item ("backup_count") as l_count and then
			     attached {JSON_STRING} l_logger.item ("level") as l_level then
			     if attached {JSON_STRING} l_logger.item ("path") as l_path then
			     	Result.set_path(create {PATH}.make_from_string (l_path.item))
			     end
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
			create Result.make_with_string (a_string)
		end

end
