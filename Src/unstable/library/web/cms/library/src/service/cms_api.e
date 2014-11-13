note
	description: "API for a CMS"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API

inherit

	SHARED_ERROR

	REFACTORING_HELPER

create
	make

feature -- Initialize

	make (a_setup: CMS_SETUP)
			-- Create the API service with a setup  `a_setup'
		do
			setup := a_setup
			create error_handler.make
			initialize
			set_successful
		ensure
			setup_set: setup = a_setup
			error_handler_set: not error_handler.has_error
		end

	setup: CMS_SETUP
			-- CMS setup.

	initialize
				-- Initialize the persitent layer.
		local
			l_database: DATABASE_CONNECTION
			retried: BOOLEAN
			l_message: STRING
		do
			if not retried then
				to_implement ("Refactor database setup")
				if attached (create {JSON_CONFIGURATION}).new_database_configuration (setup.layout.application_config_path) as l_database_config then
					create {DATABASE_CONNECTION_MYSQL} l_database.login_with_connection_string (l_database_config.connection_string)
					create {CMS_STORAGE_MYSQL} storage.make (l_database)
				else
					create {DATABASE_CONNECTION_NULL} l_database.make_common
					create {CMS_STORAGE_NULL} storage
				end
			else
				to_implement ("Workaround code, persistence layer does not implement yet this kind of error handling.")
					-- error hanling.
				create {DATABASE_CONNECTION_NULL} l_database.make_common
				create {CMS_STORAGE_NULL} storage
				create l_message.make (1024)
				if attached ((create {EXCEPTION_MANAGER}).last_exception) as l_exception then
					if attached l_exception.description as l_description then
						l_message.append (l_description.as_string_32)
						l_message.append ("%N%N")
					elseif attached l_exception.trace as l_trace then
						l_message.append (l_trace)
						l_message.append ("%N%N")
					else
						l_message.append (l_exception.out)
						l_message.append ("%N%N")
					end
				else
					l_message.append ("The application crash without available information")
					l_message.append ("%N%N")
				end
				error_handler.add_custom_error (0, " Database Connection ", l_message)
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	error_handler: ERROR_HANDLER
			-- Error handler.

feature -- Status Report

	is_valid_credential (a_auth_login, a_auth_password: READABLE_STRING_32): BOOLEAN
				-- Is the credentials `a_auth_login' and `a_auth_password' valid?
		do
			Result := storage.is_valid_credential (a_auth_login, a_auth_password)
		end

feature -- Access: Node

	nodes: LIST[CMS_NODE]
			-- List of nodes.
		do
			debug ("refactor_fixme")
				fixme ("Implementation")
			end
			Result := storage.recent_nodes (0, 10)
		end

	recent_nodes (a_offset, a_rows: INTEGER): LIST[CMS_NODE]
			-- List of the `a_rows' most recent nodes starting from  `a_offset'.
		do
			Result := storage.recent_nodes (a_offset, a_rows)
		end

	node (a_id: INTEGER_64): detachable CMS_NODE
			-- Node by ID.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			Result := storage.node (a_id)
		end

feature -- Change: Node

	new_node (a_node: CMS_NODE)
			-- Add a new node `a_node'
		do
			storage.save_node (a_node)
		end

	delete_node (a_id: INTEGER_64)
			-- Delete a node identified by `a_id', if any.
		do
			storage.delete_node (a_id)
		end

	update_node (a_id: like {CMS_USER}.id; a_node: CMS_NODE)
			-- Update node by id `a_id' with `a_node' data.
		do
			storage.update_node (a_id,a_node)
		end

	update_node_title (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
			-- Update node title, with user identified by `a_id', with node id `a_node_id' and a new title `a_title'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_title (a_id,a_node_id,a_title)
		end

	update_node_summary (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
			-- Update node summary, with user identified by `a_id', with node id `a_node_id' and a new summary `a_summary'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_summary (a_id,a_node_id, a_summary)
		end

	update_node_content (a_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
			-- Update node content, with user identified by `a_id', with node id `a_node_id' and a new content `a_content'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_content (a_id,a_node_id, a_content)
		end


feature -- Access: User

	user_by_name (a_username: READABLE_STRING_32): detachable CMS_USER
			-- User by name `a_user_name', if any.
		do
			Result := storage.user_by_name (a_username)
		end

feature -- Change User

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		do
			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				storage.save_user (a_user)
			else
				debug ("refactor_fixme")
					fixme ("Add error")
				end
			end
		end


feature {NONE} -- Implemenataion


	storage: CMS_STORAGE
		-- Persistence storage.

end

