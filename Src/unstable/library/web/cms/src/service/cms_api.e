note
	description: "API for a CMS"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API

inherit
	ANY

	REFACTORING_HELPER

	SHARED_HTML_ENCODER
		export
			{NONE} all
		end

	SHARED_WSF_PERCENT_ENCODER
		export
			{NONE} all
		end

create
	make

feature -- Initialize

	make (a_setup: CMS_SETUP)
			-- Create the API service with a setup  `a_setup'
		do
			setup := a_setup
			create error_handler.make
			initialize
		ensure
			setup_set: setup = a_setup
			error_handler_set: not error_handler.has_error
		end

	setup: CMS_SETUP
			-- CMS setup.

	initialize
				-- Initialize the persitent layer.
		do
			to_implement ("Refactor database setup")
			if attached setup.storage (error_handler) as l_storage then
				storage := l_storage
			else
				create {CMS_STORAGE_NULL} storage
			end
		end

feature -- Access: Error

	has_error: BOOLEAN
			-- Has error?
		do
			Result := error_handler.has_error
		end

	as_string_representation: STRING_32
			-- String representation of all error(s).
		do
			Result := error_handler.as_string_representation
		end

feature -- Element Change: Error

	reset
			-- Reset error handler.
		do
			error_handler.reset
		end

feature {NONE}-- Error handler implemenations

	error_handler: ERROR_HANDLER
			-- Error handler.

feature -- Status Report

	is_valid_credential (a_auth_login, a_auth_password: READABLE_STRING_32): BOOLEAN
				-- Is the credentials `a_auth_login' and `a_auth_password' valid?
		do
			Result := storage.is_valid_credential (a_auth_login, a_auth_password)
		end

feature -- Access: persistency

	storage: CMS_STORAGE
			-- Persistence storage.

	sql_storage: detachable CMS_STORAGE_SQL
			-- Storage based on EiffelStore SQL interface if selected.
		do
			if attached {CMS_STORAGE_SQL} storage as st then
				Result := st
			end
		end

feature -- Access: Node

	nodes_count: INTEGER_64
		do
			Result := storage.nodes_count
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			Result := storage.nodes
		end

	recent_nodes (a_offset, a_rows: INTEGER): LIST [CMS_NODE]
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
			Result := storage.node_by_id (a_id)
		end

feature -- Change: Node

	new_node (a_node: CMS_NODE)
			-- Add a new node `a_node'
		require
			no_id: not a_node.has_id
		do
			storage.new_node (a_node)
		end

	delete_node (a_node: CMS_NODE)
			-- Delete `a_node'.
		do
			if a_node.has_id then
				storage.delete_node (a_node)
			end
		end

	update_node (a_node: CMS_NODE)
			-- Update node `a_node' data.
		do
			storage.update_node (a_node)
		end

	update_node_title (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
			-- Update node title, with user identified by `a_id', with node id `a_node_id' and a new title `a_title'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_title (a_user_id, a_node_id, a_title)
		end

	update_node_summary (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
			-- Update node summary, with user identified by `a_user_id', with node id `a_node_id' and a new summary `a_summary'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_summary (a_user_id, a_node_id, a_summary)
		end

	update_node_content (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
			-- Update node content, with user identified by `a_user_id', with node id `a_node_id' and a new content `a_content'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_content (a_user_id, a_node_id, a_content)
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
		require
			no_id: not a_user.has_id
			no_hashed_password: a_user.hashed_password = Void
		do
			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				storage.new_user (a_user)
			else
				debug ("refactor_fixme")
					fixme ("Add error")
				end
			end
		end

	update_user (a_user: CMS_USER)
			-- Update user `a_user'.
		require
			has_id: a_user.has_id
		do
			storage.update_user (a_user)
		end

feature -- Helpers

	html_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded for html output.
		do
			Result := html_encoder.general_encoded_string (a_string)
		end

	percent_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded with percent encoding, mainly used for url.
		do
			Result := percent_encoder.percent_encoded_string (a_string)
		end

feature -- Layout

	module_configuration (a_module_name: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader for `a_module', and if `a_name' is set, using name `a_name'.
		local
			p, l_path: PATH
			ut: FILE_UTILITIES
		do
			p := setup.layout.config_path.extended ("modules").extended (a_module_name)
			if a_name = Void then
				p := p.extended (a_module_name)
			else
				p := p.extended (a_name)
			end
			l_path := p.appended_with_extension ("json")
			if ut.file_path_exists (l_path) then
				create {JSON_CONFIG} Result.make_from_file (l_path)
			else
				l_path := p.appended_with_extension ("ini")
				if ut.file_path_exists (l_path) then
					create {INI_CONFIG} Result.make_from_file (l_path)
				end
			end
			if Result = Void and a_name /= Void then
					-- Use sub config from default?
				if attached {CONFIG_READER} module_configuration (a_module_name, Void) as cfg then
					Result := cfg.sub_config (a_name)
				else
					-- Maybe try to use the global cms.ini ?	
				end
			end
		end

end

