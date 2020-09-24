note
	description: "Summary description for {CMS_NODE_STORAGE_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Storage extension

	register_node_storage_extension (a_extension: CMS_NODE_STORAGE_EXTENSION [CMS_NODE])
			-- Register `a_extension' as extension to the node storage system.
		local
			tb: like node_storage_extensions
		do
			tb := node_storage_extensions
			if tb = Void then
				create tb.make_caseless (1)
				node_storage_extensions := tb
			end
			tb.force (a_extension, a_extension.content_type)
		end

	node_storage_extension (a_node: CMS_NODE): detachable CMS_NODE_STORAGE_EXTENSION [CMS_NODE]
			-- Extension to the node storage system for node `a_node'.
		do
			if attached node_storage_extensions as tb then
				Result := tb.item (a_node.content_type)
			end
		end

feature {NONE} -- Implementation

	node_storage_extensions: detachable STRING_TABLE [CMS_NODE_STORAGE_EXTENSION [CMS_NODE]]
			-- Table of node storage extensions.

	extended_store (a_node: CMS_NODE)
			-- Store extended data from `a_node'.
		require
			not_has_error: not error_handler.has_error
		do
			if attached node_storage_extension (a_node) as ext then
				ext.store_node (a_node)
			end
		end

	extended_load (a_node: CMS_NODE)
			-- Load extended data into `a_node'.
		require
			not_has_error: not error_handler.has_error
		do
			if attached node_storage_extension (a_node) as ext then
				ext.load_node (a_node)
			end
		end

	extended_delete (a_node: CMS_NODE)
			-- Delete extended data related to node `a_node'.
		require
			not_has_error: not error_handler.has_error
		do
			if attached node_storage_extension (a_node) as ext then
				ext.delete_node (a_node)
			end
		end

feature -- Access		

	nodes_count: NATURAL_64
			-- Count of nodes.
		deferred
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		deferred
		end

	node_revisions (a_node: CMS_NODE): LIST [CMS_NODE]
			-- Revisions of node `a_node'.
		deferred
		end

	trashed_nodes (a_user: detachable CMS_USER): LIST [CMS_NODE]
			-- List of nodes by user `a_user' if set, or any.
		require
			a_user /= Void implies a_user.has_id
		deferred
		end

	recent_nodes (a_offset: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of recent `a_count' nodes with an offset of `a_offset'.
		deferred
		end

	recent_nodes_of_type (a_node_type: CMS_CONTENT_TYPE; a_offset: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- Recent `a_count` nodes of type `a_node_type` with an offset of `a_offset`.
		deferred
		ensure
			across Result as ic all ic.item.is_typed_as (a_node_type.name) end
		end

	recent_published_nodes_of_type (a_node_type: CMS_CONTENT_TYPE; a_offset: INTEGER; a_count: INTEGER): ITERABLE [CMS_NODE]
			-- Recent published `a_count` nodes of type `a_node_type` with an offset of `a_offset`
		deferred
		ensure
			expected_type: across Result as ic all ic.item.is_typed_as (a_node_type.name) end
			published: across Result as ic all ic.item.is_published end
		end

	recent_node_changes_before (a_offset: INTEGER; a_count: INTEGER; a_date: DATE_TIME): LIST [CMS_NODE]
			-- List of recent changes, before `a_date', according to `params' settings.
		deferred
		end

	node_by_id (a_id: INTEGER_64): detachable CMS_NODE
			-- Retrieve node by id `a_id', if any.
		require
			a_id > 0
		deferred
		end

	node_by_id_and_revision (a_node_id, a_revision: INTEGER_64): detachable CMS_NODE
			-- Retrieve node by node id `a_node_id' and revision `a_revision', if any.
		require
			has_node_id: a_node_id > 0
			has_revision: a_revision > 0
		deferred
		end

	nodes_of_type_count (a_node_type: CMS_CONTENT_TYPE): NATURAL_64
			-- Count of nodes of type `a_node_type`.
		do
			Result := nodes_of_type (a_node_type).count.to_natural_64
		end

	nodes_of_type (a_node_type: CMS_CONTENT_TYPE): LIST [CMS_NODE]
			-- List of nodes of type `a_node_type'.
			--| Redefine to optimize!
		do
			Result := nodes
			from
				Result.start
			until
				Result.after
			loop
				if Result.item.content_type.same_string (a_node_type.name) then
					Result.forth
				else
					Result.remove
				end
			end
		ensure
			expected_type: across Result as ic all ic.item.is_typed_as (a_node_type.name) end
		end

	nodes_of_type_with_title (a_node_type: CMS_CONTENT_TYPE; a_title: READABLE_STRING_GENERAL): LIST [CMS_NODE]
			-- List of nodes of type `a_node_type' with title `a_title`.
			--| Redefine to optimize!	
		do
			Result := nodes_of_type (a_node_type)
			from
				Result.start
			until
				Result.after
			loop
				if a_title.same_string (Result.item.title) then
					Result.forth
				else
					Result.remove
				end
			end
		end

feature -- Change: Node

	save_node (a_node: CMS_NODE)
			-- Create or update `a_node'.
		do
			if a_node.has_id then
				update_node (a_node)
			else
				new_node (a_node)
			end
		end

	new_node (a_node: CMS_NODE)
			-- Save node `a_node'.
		require
			no_id: not a_node.has_id
			valid_user: attached a_node.author as l_author and then l_author.id > 0
		deferred
		ensure
			has_id: not error_handler.has_error implies a_node.has_id
		end

	update_node (a_node: CMS_NODE)
			-- Update node content `a_node'.
			-- The user `a_id' is an existing or new collaborator.
		require
			has_id: a_node.has_id
			has_author: attached a_node.author as l_author and then l_author.has_id
		deferred
		end

	delete_node (a_node: CMS_NODE)
			-- Delete `a_node'.
		require
				valid_node_id: a_node.has_id
		do
				-- TODO
				-- Check if we need to use a transaction
				-- we delete a node
				-- node_revisions
				-- and extensions (PAGE, BLOG, etc).
			delete_node_base (a_node)
		end

	delete_node_base (a_node: CMS_NODE)
			-- Remove node `a_node'.
		deferred
		end

	trash_node (a_node: CMS_NODE)
			-- Trash `a_node'.
		do
			if a_node.has_id then
				trash_node_by_id (a_node.id)
			end
		end

	restore_node (a_node: CMS_NODE)
			-- Restore `a_node'.
		do
			if a_node.has_id then
				restore_node_by_id (a_node.id)
			end
		end

	trash_node_by_id (a_id: INTEGER_64)
			-- Trash node by id `a_id'.
		require
			valid_node_id: a_id > 0
		deferred
		end

	restore_node_by_id (a_id: INTEGER_64)
			-- Restore node by id `a_id'.
		require
			valid_node_id: a_id > 0
		deferred
		end

feature -- Helpers

	fill_node (a_node: CMS_NODE)
			-- Fill `a_node' with extra information from database.
			-- i.e: specific to each content type data.
		require
			has_id: a_node.has_id
		deferred
		end

end
