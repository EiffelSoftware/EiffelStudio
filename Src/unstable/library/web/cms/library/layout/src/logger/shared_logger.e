note
	description: "Provides logger information"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGGER

inherit
	LOG_PRIORITY_CONSTANTS

	ARGUMENTS

feature -- Logger


	log: LOGGING_FACILITY
			-- New `log' (once per process)
            -- that could be shared between threads
            -- without reinitializing it.
		local
			l_log_writer: LOG_ROLLING_WRITER_FILE
			l_environment: EXECUTION_ENVIRONMENT
			l_path: PATH
			l_logger_config: LOGGER_CONFIGURATION
		once ("PROCESS")
					--| Initialize the logging facility
			create Result.make
			create l_environment
			if attached separate_character_option_value ('d') as l_dir then
				create l_path.make_from_string (l_dir)
			else
				create l_path.make_current
				l_path := l_path.extended ("site")
			end
			l_logger_config := new_logger_level_configuration (l_path.extended("config").extended ("application_configuration.json"))
			if attached l_logger_config.location as p then
				create l_log_writer.make_at_location (p.extended ("api.log"))
			else
				create l_log_writer.make_at_location (l_path.extended ("logs").extended ("api.log"))
			end

			l_log_writer.set_max_file_size ({NATURAL_64} 1024*1204)
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
				l_parser.parse_content
				if
					l_parser.is_valid and then
					attached l_parser.parsed_json_object as jv and then
					attached {JSON_OBJECT} jv.item ("logger") as l_logger
				then
					if attached {JSON_STRING} l_logger.item ("location") as l_location then
						Result.set_location_with_string (l_location.item)
					end
					if attached {JSON_STRING} l_logger.item ("backup_count") as l_count then
						if l_count.item.is_natural then
							Result.set_backup_count (l_count.item.to_natural)
						end
					end
					if attached {JSON_STRING} l_logger.item ("level") as l_level then
						Result.set_level (l_level.item)
					end
				end
			end
		end

	json_file_from (a_fn: PATH): detachable STRING
		local
			ut: FILE_UTILITIES
		do
			if ut.file_path_exists (a_fn) then
				Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name)
			end
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
