note
	description: "Summary description for {CMS_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_NULL

inherit
	CMS_STORAGE
		redefine
			default_create
		select
			default_create
		end

	REFACTORING_HELPER
		rename
			default_create as default_create_rh
		end

feature -- Initialization

	default_create
		do
			create error_handler.make
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		do
			Result := True
		end

	is_initialized: BOOLEAN
			-- Is storage initialized?
		do
			Result := True
		end

feature -- Access: user

	has_user: BOOLEAN
			-- Has any user?
		do
		end

	users: LIST [CMS_USER]
		do
			create {ARRAYED_LIST[CMS_USER]} Result.make (0)
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
		do
		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
		do
		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
		do
		end

	is_valid_credential (l_auth_login, l_auth_password: READABLE_STRING_32): BOOLEAN
		do
		end

feature -- User Nodes

	user_collaborator_nodes (a_id: like {CMS_USER}.id): LIST[CMS_NODE]
			-- Possible list of nodes where the user identified by `a_id', is a collaborator.
		do
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
		end

	user_author_nodes (a_id: like {CMS_USER}.id): LIST[CMS_NODE]
			-- Possible list of nodes where the user identified by `a_id', is the author.
		do
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
		end

feature -- Change: user

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		do
		end

	update_user (a_user: CMS_USER)
			-- Update user `a_user'.
		do
		end

feature -- Access: roles and permissions

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		do
		end

	user_roles: LIST [CMS_USER_ROLE]
		do
			create {ARRAYED_LIST[CMS_USER_ROLE]} Result.make (0)
		end


feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		do
		end

feature -- Access: node

	nodes_count: INTEGER_64
			-- Count of nodes.
		do
		end

	nodes: LIST[CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of the `a_count' most recent nodes, starting from `a_lower'.
		do
			create {ARRAYED_LIST[CMS_NODE]} Result.make (0)
		end

	node_by_id (a_id: INTEGER_64): detachable CMS_NODE
			-- <Precursor>
		do
		end

	node_author (a_id: like {CMS_NODE}.id): detachable CMS_USER
			-- Node's author. if any.
		do
		end

	node_collaborators (a_id: like {CMS_NODE}.id): LIST [CMS_USER]
			-- Possible list of node's collaborator.
		do
			create {ARRAYED_LIST[CMS_USER]} Result.make (0)
		end

feature -- Node

	new_node (a_node: CMS_NODE)
			-- Add a new node
		do
		end

	delete_node_by_id (a_id: INTEGER_64)
			-- <Precursor>
		do
		end

	update_node (a_node: CMS_NODE)
			-- <Precursor>
		do
		end

	update_node_title (a_user_id: like {CMS_NODE}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
			-- <Precursor>
		do
		end

	update_node_summary (a_user_id: like {CMS_NODE}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
			-- <Precursor>
		do
		end

	update_node_content (a_user_id: like {CMS_NODE}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
			-- <Precursor>
		do
		end

end
