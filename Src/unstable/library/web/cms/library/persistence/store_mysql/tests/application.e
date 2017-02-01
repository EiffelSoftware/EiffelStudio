note
	description : "tests application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			storage: CMS_STORAGE
			l_node: CMS_NODE
		do
			create connection.login_with_schema ("cms_dev", "root", "")

			(create {CLEAN_DB}).clean_db(connection)

			create {CMS_STORAGE_STORE_MYSQL} storage.make (connection)
			l_node := custom_node ("Content", "Summary", "Title")
			storage.new_user (default_user)
			storage.new_user (custom_user ("u2", "p2", "e2"))
			if attached default_user.email as l_email then
				l_node.set_author (storage.user_by_email (l_email))
			end
--			storage.new_node (l_node)
--			if attached {CMS_NODE} storage.node_by_id (1) as ll_node then
--				storage.update_node_title (2,ll_node.id, "New Title")
--				check
--					attached {CMS_NODE} storage.node_by_id (1) as u_node and then not (u_node.title ~ ll_node.title) and then u_node.content ~ ll_node.content and then u_node.summary ~ ll_node.summary
--				end
--			end
		end


feature {NONE} -- Fixture Factory: Users

	default_user: CMS_USER
		do
			Result := custom_user ("test", "password", "test@test.com")
		end

	custom_user (a_name, a_password, a_email: READABLE_STRING_32): CMS_USER
		do
			create Result.make (a_name)
			Result.set_password (a_password)
			Result.set_email (a_email)
		end

feature {NONE} -- Implementation


	connection: DATABASE_CONNECTION_MYSQL


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
