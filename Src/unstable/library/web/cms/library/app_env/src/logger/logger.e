note
	description: "Object to log messages for a specific application. "
	date: "$Date$"
	revision: "$Revision$"

class
	LOGGER

inherit
	ANY

	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make,
	make_with_environment

feature {NONE} -- Initialization

	make
			-- Initialize a logger object.
		do
			create log.make
		end

	make_with_environment (app: separate APPLICATION_ENVIRONMENT)
			-- Initialize a logger object with an application environment `app'.
		do
			make
			apply_environment (app)
		end

feature -- Change

	apply_environment (app: separate APPLICATION_ENVIRONMENT)
		do
			initialize_logger (app, log)
		end

feature {NONE} -- Internal		

	log: LOGGING_FACILITY

feature -- Settings

	level: INTEGER

feature -- Logging

	put_debug (a_message: separate READABLE_STRING_8)
			-- Put message `a_message' to the log at debug level.
		do
			if level >= log_debug then
				log.write_debug (create {STRING}.make_from_separate (a_message))
			end
		end

	put_information (a_message: separate READABLE_STRING_8)
			-- Put message `a_message' to the log at information level.
		do
			if level >= log_information  then
				log.write_information (create {STRING}.make_from_separate (a_message))
			end
		end

	put_warning (a_message: separate READABLE_STRING_8)
			-- Put message `a_message' to the log at warning level.
		do
			if level >= log_warning then
				log.write_warning (create {STRING}.make_from_separate (a_message))
			end
		end

	put_error (a_message: separate READABLE_STRING_8)
			-- Put message `a_message' to the log at error level.
		do
			if level >= log_error then
				log.write_error (create {STRING}.make_from_separate (a_message))
			end
		end

	put_critical (a_message: separate READABLE_STRING_8)
			-- Put message `a_message' to the log at critical level.
		do
			if level >= log_critical then
				log.write_critical (create {STRING}.make_from_separate (a_message))
			end
		end

	put_alert (a_message: separate READABLE_STRING_8)
			-- Put message `a_message' to the log at alert level.
		do
			if level >= log_alert then
				log.write_alert (create {STRING}.make_from_separate (a_message))
			end
		end

feature {NONE} -- Implementation

	initialize_logger (app: separate APPLICATION_ENVIRONMENT; a_log: like log)
		local
			l_log_writer_file: LOG_ROLLING_WRITER_FILE
			l_log_writer: detachable LOG_WRITER
			l_logs_path: detachable PATH
			l_logger_config: LOGGER_CONFIGURATION
			ut: FILE_UTILITIES
			p: PATH
			l_name: IMMUTABLE_STRING_32
		do
			create l_name.make_from_separate (app.name)
			create p.make_from_separate (app.application_config_path)
--			l_name := app.name
--			p := app.application_config_path

			l_logger_config := new_logger_level_configuration (p)
			if l_logger_config.type.is_case_insensitive_equal_general ("file") then
				l_logs_path := l_logger_config.location
				if l_logs_path = Void then
					create  l_logs_path.make_from_separate (app.logs_path)
				end
				if ut.directory_path_exists (l_logs_path) then
					create l_log_writer_file.make_at_location (l_logs_path.extended (l_name).appended_with_extension ("log"))
					l_log_writer_file.set_max_file_size ({NATURAL_64} 1024 * 1204)
					l_log_writer_file.set_max_backup_count (l_logger_config.backup_count)
					l_log_writer := l_log_writer_file
				else
						-- Should we create the directory anyway ?
				end
			elseif l_logger_config.type.is_case_insensitive_equal_general ("stderr") then
				create {LOG_WRITER_STDERR} l_log_writer
			end
			if l_log_writer = Void then
				create {LOG_WRITER_NULL} l_log_writer
				set_logger_level (l_log_writer, log_notice)
			else
				set_logger_level (l_log_writer, 0) -- None
			end
			a_log.register_log_writer (l_log_writer)
		end

	set_logger_level (a_log_writer: LOG_WRITER; a_priority: INTEGER)
			-- Setup the logger level based on `a_priority'
		do
			level := a_priority
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
			ut: FILE_UTILITIES
		do
			create Result
			if
				ut.file_path_exists (a_path) and then
				attached (create {JSON_FILE_READER}).read_json_from (a_path.name) as json_file
			then
				create l_parser.make_with_string (json_file)
				l_parser.parse_content
				if
					l_parser.is_valid and then
					attached l_parser.parsed_json_object as jv and then
					attached {JSON_OBJECT} jv.item ("logger") as l_logger
				then
					if attached {JSON_STRING} l_logger.item ("type") as l_type then
						Result.set_type_with_string (l_type.item)
					end
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

note
	copyright: "2011-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
