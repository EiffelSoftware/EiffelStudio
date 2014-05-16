note
	description: "Summary description for {ESA_SHARED_LOGGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SHARED_LOGGER

feature -- Logger


	log: LOG_LOGGING_FACILITY
		local
			l_log_writer: LOG_ROLLING_WRITER_FILE
		once
					--| Initialize the logging facility
			create Result.make

			create l_log_writer.make_at_location ((create {PATH}.make_current).extended("esa_api.log"))
			l_log_writer.set_max_file_size ({NATURAL_64}1024*1204)
			l_log_writer.set_max_backup_count (4)
			l_log_writer.enable_debug_log_level
			log.register_log_writer (l_log_writer)

					--| Write an informational message
			Result.write_information ("The application is starting up...")
		end


end
