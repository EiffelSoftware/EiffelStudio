note
	description: "Summary description for {ABSTRACT_DB_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ABSTRACT_DB_TEST


feature -- Database connection

	connection: DATABASE_CONNECTION_MYSQL
			-- MYSQL database connection
		once
			create Result.login_with_schema ("cms_dev", "root", "")
		end
end
