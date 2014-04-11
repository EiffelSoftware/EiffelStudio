note
	description: "Summary description for {ESA_DATABASE_TEST_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_TEST_CONFIG

feature -- Access
		-- Todo move to an external file to make it configurable.

	server_name: STRING = "JVELILLA\SQLEXPRESS"
		-- Server Name.

	database_name: STRING = "EiffelDBtest"
		-- Database Name.

	schema : STRING = "eiffeltest"
	 	-- Database schema.

end
