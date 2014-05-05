note
	description: "Summary description for {ESA_SHARED_LOGGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SHARED_LOGGER

feature -- Logger


	log: LOG_LOGGING_FACILITY
		local
		once
				--| Initialize the logging facility
			create Result.make

				--| Enable log output to go to the default file
			Result.enable_default_file_log

				--| Write an informational message
			Result.write_information ("The application is starting up...")

		end
end
