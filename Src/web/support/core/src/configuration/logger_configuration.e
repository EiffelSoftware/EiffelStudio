note
	description: "Object that represent Logger configuration settings"
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
		ensure then
			backup_count_set: backup_count = 4
			level_set: level = Log_debug
		end

feature -- Access

	backup_count: NATURAL
			-- Max number of backup files.
			-- When 0, no backup files are created, and the log file is simply truncated when it becomes larger than `max_file_size'.
			-- When non-zero, the value specifies the maximum number of backup files.

	level: INTEGER
		-- Logger level.

feature -- Element Change

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
end
