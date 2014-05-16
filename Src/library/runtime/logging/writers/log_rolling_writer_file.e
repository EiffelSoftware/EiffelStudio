note
	description: "A log writer that backups log files circularly when they reach a certain size."
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_ROLLING_WRITER_FILE

inherit
	LOG_WRITER_FILE
		redefine
			make_at_location,
			do_write
		end

create
	make_at_location

feature {NONE} -- Creation


	make_at_location (a_path: PATH)
			-- <Precursor>
			-- Set a default value for max_file_size: 4 MB.
		do
			Precursor (a_path)
				-- One backup file by default.
			set_max_backup_count (1)

				-- Max size log.
			set_max_file_size ({NATURAL_64}4*1024*1024)

				-- Default index.
			backup_count := 1
		ensure then
			max_backup_set: max_backup_count = 1
			max_file_size_set: max_file_size = {NATURAL_64}4*1024*1024
			backup_count_set: backup_count = 1
		end

feature -- Access

	max_backup_count: NATURAL
			-- Max number of backup files.
			-- When 0, no backup files are created, and the log file is simply truncated when it becomes larger than `max_file_size'.
			-- When non-zero, the value specifies the maximum number of backup files.

	max_file_size: NATURAL_64
			-- File size in bytes, that, when exceeded, causes the log file to be
			-- restarted from scratch.

feature -- Modification

	set_max_backup_count (a_max: NATURAL)
			-- Set `max_backup_count' to `a_max'.
		do
			max_backup_count := a_max
		ensure
			max_backup_set: max_backup_count = a_max
		end

	set_max_file_size (a_max: NATURAL_64)
			-- Set `max_file_size' to `a_max'.
		require
			a_max_positive: a_max > 0
		do
			max_file_size := a_max
		ensure
			max_file_size_set: max_file_size = a_max
		end

feature {LOG_LOGGING_FACILITY} -- Output

	do_write (priority: INTEGER; msg: STRING)
			-- <Precursor>
			-- Create backup files if log file size exceeds `max_file_size'.
			-- See also: `max_backup_count'.
		do
			roll_over
			Precursor (priority, msg)
		end

feature -- Roll over

	roll_over
			-- Backup log file if it becomes larger than `max_file_size', preserving at most `max_backup_count' most recent backups of the log file if `max_backup_count > 0'.
			-- Truncate log file if it becomes larger than `max_file_size' and `max_backup_count = 0'.
			-- If the file name is called "system.log", then the backup files are named "system.log.1", ..."system.log.MaxN".
			-- Thus, the most recent file is "system.log" and "system.log.MaxN" is the oldest.
		local
			i: NATURAL
			l_log_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				if log_file.count.as_natural_64 >= max_file_size then
					if max_backup_count > 0 then
							-- Rename files, move data from Logi to Logi+1.
							-- LogN ... Log1 to LogN+1 .. Log2.
						from
							i := backup_count
						until
							i < 2
						loop
							create l_log_file.make_with_path (path.appended (".").appended ((i - 1).out))
							if l_log_file.exists then
								l_log_file.rename_path (path.appended (".").appended ((i).out))
							end
							i := i - 1
						end
						if backup_count < max_backup_count then
							backup_count := backup_count + 1
						end
						log_file.close
						log_file.rename_path (path.appended (".1"))
						create log_file.make_with_path (path)
					else
							-- The current log is truncated and no backup is created.
					end
					log_file.open_write
				end
			else
					-- A file could not be created.
					-- Stop the log writer.
				is_initialized := False

			end
		rescue
			l_retried := True
			retry
		end


feature {NONE} -- Implementation

	backup_count: NATURAL
			-- Current number of backup files, bounded by `max_backup_count'.

;note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
