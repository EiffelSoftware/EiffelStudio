note
	description: "Object that represent Database configuration settings"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make (a_driver: READABLE_STRING_32; a_server: READABLE_STRING_32; a_name: READABLE_STRING_32)
			-- Create a database configuration setting: `driver' with `a_driver',
			-- `server' with `a_server' and `name' with `a_name'
		do
			driver := a_driver
			server := a_server
			name := a_name
		ensure
			driver_set: driver = a_driver
			server_set: server = a_server
			name_set: name = a_name
			not_trusted_connection: not trusted_connection
		end

feature -- Access

	driver: READABLE_STRING_32
		--Database driver.

	server: READABLE_STRING_32
		-- Database server.	

	name: READABLE_STRING_32
		-- Database Name.

	schema: detachable READABLE_STRING_32
		-- Database Schema

	trusted_connection: BOOLEAN
		-- Is a trusted connection?

	connection_string: READABLE_STRING_32
			-- Connection string
		do
			Result := "Driver={"+driver+"};Server=" + server + ";Database=" + name + ";Trusted_Connection=yes;user instance=true;"
		end

feature -- Change Element

	set_schema (a_schema: READABLE_STRING_32)
			-- Set `schema' with `a_schema'
		do
			schema := a_schema
		ensure
			schema_set: schema = a_schema
		end

	mark_trusted
			-- Mark `trusted_connection' as True
		do
			trusted_connection := True
		ensure
			truested_connection_set: trusted_connection
		end

	mark_untrusted
			-- Mark `trusted_connection' as False
		do
			trusted_connection := False
		ensure
			not_truested_connection_set: not trusted_connection
		end


end
