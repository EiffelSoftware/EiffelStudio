indexing
	description: "Objects that wrap constants used in AutoTest"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class AUT_CONSTANTS

feature -- Printing

	time_passed_mark: STRING is "-- Time passed: "
			-- String used in proxy log to mark the passing of every minute

	itp_start_time_message: STRING is "-- Interpreter started after: "
			-- String used in proxy log to mark the time of every intepreter start

	exception_thrown_message: STRING is "-- Exception thrown after: "
			-- String used in proxy log to mark the time elpased until an exception is thrown

end
