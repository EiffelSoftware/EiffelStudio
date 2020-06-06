note
	description: "Object that represent Database configuration settings"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make (a_driver: READABLE_STRING_32; a_connection: READABLE_STRING_32)
			-- Create a database configuration setting: `driver' with `a_driver',
			-- `database_string' with `a_connection'.
		do
			driver := a_driver
			database_string := a_connection
		ensure
			driver_set: driver = a_driver
			server_set: database_string = a_connection
		end

feature -- Access

	driver: READABLE_STRING_32
		--Database driver.

	database_string: READABLE_STRING_32
		-- Database connection.	

	connection_string: READABLE_STRING_32
			-- Connection string
		do
			Result := {STRING_32}"Driver={"+driver+"};" + database_string;
		end

end
