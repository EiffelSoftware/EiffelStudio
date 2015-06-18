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

	storage: CMS_STORAGE_STORE_MYSQL
		once
			create Result.make (connection)
		end

feature {NONE} -- Fixture Factory: Users

	default_user: CMS_USER
		do
			Result := custom_user ("test", "password", "test@test.com")
		end

	custom_user (a_name, a_password: READABLE_STRING_32; a_email: READABLE_STRING_8): CMS_USER
		do
			create Result.make (a_name)
			Result.set_password (a_password)
			Result.set_email (a_email)
		end

feature {NONE} -- Fixture Factories: Nodes

	default_node: CMS_NODE
		do
			Result := custom_node ("Default content", "default summary", "Default")
		end

	custom_node (a_content, a_summary, a_title: READABLE_STRING_32): CMS_PAGE
		do
			create Result.make (a_title)
			Result.set_content (a_content, a_summary, Void)
		end
end
