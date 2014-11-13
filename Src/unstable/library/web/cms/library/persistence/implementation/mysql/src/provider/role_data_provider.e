note
	description: "Summary description for {ROLE_DATA_PROVIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROLE_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	SHARED_ERROR

	REFACTORING_HELPER

create
	make

feature -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a data provider.
		do
			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			post_execution
		end

	db_handler: DATABASE_HANDLER
			-- Db handler.

feature -- Status Report

	is_successful: BOOLEAN
			-- Is the last execution sucessful?
		do
--			Result := db_handler.successful
		end

	has_roles: BOOLEAN
			-- Has any role?
		do
			Result := count > 0
		end

feature -- Access

	roles: DATABASE_ITERATION_CURSOR [CMS_USER_ROLE]
			-- List of roles.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".roles")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_roles, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_role)
			post_execution
		end

feature -- Basic Operations

	new_role (a_role: READABLE_STRING_32)
			-- Create a new node.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			log.write_information (generator + ".new_role")
			create l_parameters.make (1)
			l_parameters.put (a_role,"name")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_insert_role, l_parameters))
			db_handler.execute_change
			post_execution
		end

	role (a_id: INTEGER_64): detachable CMS_USER_ROLE
			-- Role for the given id `a_id', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".role")
			create l_parameters.make (1)
			l_parameters.put (a_id,"id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_role_by_id, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := fetch_role
			end
			post_execution
		end

	role_by_name (a_name: READABLE_STRING_32): detachable CMS_USER_ROLE
			-- Role for the given name `a_name', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".role_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name,"name")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_role_by_name, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := fetch_role
			end
			post_execution
		end

	count: INTEGER
			-- Number of items users.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".count")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_count, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end

	save_role_permission (a_role_id: INTEGER; a_permission: READABLE_STRING_32)
			-- Add permission `a_permission' to the role id `a_role_id'.
		require
			valid_id: a_role_id > 0
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			log.write_information (generator + ".save_role_permission")
			create l_parameters.make (1)
			l_parameters.put (a_permission,"name")
			l_parameters.put (a_role_id,"id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (SQL_Insert_permissions, l_parameters))
			db_handler.execute_change
			post_execution
		end

	permission_by_role (a_role_id: INTEGER_64): DATABASE_ITERATION_CURSOR [READABLE_STRING_32]
			-- List of permission by role `a_role_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".permission_by_role")
			create l_parameters.make (1)
			l_parameters.put (a_role_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_permissions, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_permission)
			post_execution
		end

feature -- New Object

	fetch_role: CMS_USER_ROLE
		do
			create Result.make_with_id (0,"")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_u then
				Result.set_name (l_u)
			end
		end

	fetch_permission: STRING_32
		do
			create Result.make_empty
			if attached db_handler.read_string (1) as l_u then
				Result := l_u
			end
		end


feature {NONE} -- Sql Queries: Roles

	Select_count: STRING = "select count(*) from Roles;"
		-- Number of roles.

	Select_roles: STRING = "select * from Roles;"
		-- roles.

	Select_role_by_id: STRING = "select * from Roles where id =:id;"
		-- Retrieve role by id if exists.

	Select_role_by_name: STRING = "select * from Roles where role =:name;"
		-- Retrieve user by name if exists.

	SQL_Insert_role: STRING = "insert into roles (role) values (:name);"
		-- SQL Insert to add a new node.


feature {NONE} -- Sql Queries: Permissions

	Select_permissions_count: STRING = "select count(*) from permissions where roles_id=:id;"
		-- Number of permissions for a given role.

	Select_permissions: STRING = "select * from permissions where roles_id=:id;"
		-- List of permissions for a given role.

	Select_permissions_by_id: STRING = "select name from permissions where roles_id=:id and id=:permissionid;"
		-- Permission for a given role and permission id

	SQL_Insert_permissions: STRING = "insert into permissions (name, roles_id) values (:name, :id);"
		-- SQL Insert to add a new node.

feature {NONE} -- Implementation

	post_execution
			-- Post database execution.
		do

		end

end
