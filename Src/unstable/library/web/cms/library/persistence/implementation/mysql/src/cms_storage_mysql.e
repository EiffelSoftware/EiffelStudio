note
	description: "Summary description for {CMS_STORAGE_MYSQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_MYSQL

inherit

	CMS_STORAGE
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			--
		require
			is_connected: a_connection.is_connected
		do
			connection := a_connection
			log.write_information (generator+".make_with_database is database connected?  "+ a_connection.is_connected.out )
			create node_provider.make (a_connection)
			create user_provider.make (a_connection)
			create error_handler.make
		end


feature -- Access: user

	has_user: BOOLEAN
			-- Has any user?
		do
			Result := user_provider.has_user
		end

	all_users: LIST [CMS_USER]
		do
			to_implement (generator + ".all_users")
			create {ARRAYED_LIST[CMS_USER]} Result.make (0)
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
		do
			Result := user_provider.user (a_id)

		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
		do
			Result := user_provider.user_by_name (a_name)

		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
		do
			Result := user_provider.user_by_email (a_email)

		end

	is_valid_credential (l_auth_login, l_auth_password: READABLE_STRING_32): BOOLEAN
		local
			l_security: SECURITY_PROVIDER
		do
			if attached user_provider.user_salt (l_auth_login) as l_hash then
				if attached user_provider.user_by_name (l_auth_login) as l_user then
					create l_security
					if
						attached l_user.password as l_password and then
					   	l_security.password_hash (l_auth_password, l_hash).is_case_insensitive_equal (l_password)
					then
						Result := True
					else
						log.write_information (generator + ".login_valid User: wrong username or password" )
					end
				else
					log.write_information (generator + ".login_valid User:" + l_auth_login + "does not exist" )
				end
			end

		end

feature -- User Nodes

	user_collaborator_nodes (a_id: like {CMS_USER}.id): LIST[CMS_NODE]
			-- Possible list of nodes where the user identified by `a_id', is a collaborator.
		do
			to_implement (generator + ".user_collaborator_nodes")
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
		end

	user_author_nodes (a_id: like {CMS_USER}.id): LIST[CMS_NODE]
			-- Possible list of nodes where the user identified by `a_id', is the author.
		do
			to_implement (generator + ".user_author_nodes")
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
		end

feature -- Access: roles and permissions

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		do
			to_implement (generator + ".user_role_by_id")
		end

	user_roles: LIST [CMS_USER_ROLE]
		do
			to_implement (generator + ".user_roles")
			create {ARRAYED_LIST[CMS_USER_ROLE]} Result.make (0)
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		do
			to_implement (generator + ".save_user_role")
		end

feature -- Change: user

	save_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		do

			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				connection.begin_transaction
				user_provider.new_user (a_user.name, l_password, l_email)
				connection.commit
			else
				debug ("refactor_fixme")
					fixme ("maybe we should not always carry password, in this case, to implement the else part..")
				end
			end
		end

feature -- Access: node

	nodes: LIST[CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
			across node_provider.nodes as c loop
				Result.force (c.item)
			end

		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of the `a_count' most recent nodes, starting from `a_lower'.
		do
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
			across node_provider.recent_nodes (a_lower,a_count) as c loop
				Result.force (c.item)
			end

		end

	node (a_id: INTEGER_64): detachable CMS_NODE
			-- <Precursor>
		do
			Result :=  node_provider.node (a_id)

		end

	node_author (a_id: like {CMS_NODE}.id): detachable CMS_USER
			-- <Precursor>
		do
			Result := node_provider.node_author (a_id)

		end

	node_collaborators (a_id: like {CMS_NODE}.id): LIST [CMS_USER]
			-- Possible list of node's collaborator.
		do
			create {ARRAYED_LIST[CMS_USER]} Result.make (0)
			across node_provider.node_collaborators (a_id) as c loop Result.force (c.item) end
		end

feature -- Node

	save_node (a_node: CMS_NODE)
			-- <Precursor>
		do
			node_provider.new_node (a_node)

		end

	delete_node (a_id: INTEGER_64)
		do
			node_provider.delete_from_user_nodes(a_id)
			node_provider.delete_node (a_id)

		end

	update_node (a_id: like {CMS_USER}.id; a_node: CMS_NODE)
			-- <Precursor>
		do
			node_provider.update_node (a_id, a_node)

		end

	update_node_title (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
			-- <Precursor>
		do
			node_provider.update_node_title (a_node_id, a_title)
			internal_node_update (a_id, a_node_id)

		end

	update_node_summary (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
			-- <Precursor>
		do
			node_provider.update_node_summary (a_node_id, a_summary)
			internal_node_update (a_id, a_node_id)

		end

	update_node_content (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
			-- <Precursor>
		do
			node_provider.update_node_content (a_node_id, a_content)
			internal_node_update (a_id, a_node_id)

		end

feature {NONE} -- NODE Implemenation

		internal_node_update (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id)
				-- Update node editor or add collaborator.
			do
				if not node_provider.is_collaborator (a_id, a_node_id) then
					node_provider.add_collaborator (a_id, a_node_id)
				else
					node_provider.update_node_last_editor (a_id, a_node_id)
				end
			end

feature -- User

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		do
			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				user_provider.new_user (a_user.name, l_password, l_email)
			else
				-- set error
			end
		end

feature {NONE} -- Post process


	node_provider: NODE_DATA_PROVIDER
			-- Node Data provider.

	user_provider: USER_DATA_PROVIDER
			-- User Data provider.

	connection: DATABASE_CONNECTION
			-- Current database connection.
end
