note
	description: "Object that represents Logger configuration settings"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGGER_CONFIGURATION

inherit
	LOG_PRIORITY_CONSTANTS
		rename
			default_create as log_default_create
		end
	ANY
		redefine
			default_create
		select
			default_create
		end

create
	default_create

feature -- Initialization

	default_create
			-- Initialize a Logger Instance configuration with default values
			-- backups = `4' and level = `DEBUG'.
		do
			backup_count := 4
			level := Log_debug
			location := Void
			type := {STRING_32} "null"
		ensure then
			backup_count_set: backup_count = 4
			level_set: level = Log_debug
		end

feature -- Access

	location: detachable PATH
			-- Location for logs files, if none use default logs location.

	backup_count: NATURAL
			-- Max number of backup files.
			-- When 0, no backup files are created, and the log file is simply truncated when it becomes larger than `max_file_size'.
			-- When non-zero, the value specifies the maximum number of backup files.

	level: INTEGER
			-- Logger level.

	type: IMMUTABLE_STRING_32
			-- Type of logging.

feature -- Element Change

	set_location (a_location: detachable PATH)
			-- Set `location' to `a_location'.
		do
			location := a_location
		ensure
			location_set: a_location ~ location
		end

	set_location_with_string (a_location: READABLE_STRING_GENERAL)
		require
			a_location /= Void and then not a_location.is_whitespace
		do
			set_location (create {PATH}.make_from_string (a_location))
		end

	set_type_with_string (a_type: detachable READABLE_STRING_GENERAL)
		do
			if a_type /= Void and then not a_type.is_whitespace then
				create type.make_from_string_general (a_type)
			else
				create type.make_from_string_general ("null")
			end
		end

	set_backup_count (a_backup: NATURAL)
			-- Set backup_count to `a_backup'.
		do
			backup_count := a_backup
		ensure
			backup_count_set: backup_count = a_backup
		end

	set_level (a_level: READABLE_STRING_GENERAL)
			-- Set a level  based on `a_level'.
		do
			if a_level.is_case_insensitive_equal (emerg_str)  then
				level := log_emergency
			elseif a_level.is_case_insensitive_equal (alert_str)  then
				level := log_alert
			elseif a_level.is_case_insensitive_equal (crit_str)  then
				level := log_critical
			elseif a_level.is_case_insensitive_equal (error_str)  then
				level := log_error
			elseif a_level.is_case_insensitive_equal (warn_str)  then
				level := log_warning
			elseif a_level.is_case_insensitive_equal (notic_str)  then
				level := log_notice
			elseif a_level.is_case_insensitive_equal (info_str)  then
				level := log_information
			elseif a_level.is_case_insensitive_equal (debug_str)  then
				level := log_debug
			else
				level := 0
			end
		end
note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
