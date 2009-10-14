note
	description: "Summary description for {TAG_SPARSE_TREE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_SPARSE_TREE [G -> TAG_ITEM]

inherit
	TAG_TREE_OBSERVER [G]
		redefine
			on_node_added,
			on_node_remove
		end

create
	make, make_default

feature {NONE} -- Initialization

	make (a_filter: like filter)
			-- Initialize `Current'.
			--
			-- `a_filter': Filter determining `root_nodes'.
		require
			an_updater_attached: a_filter /= Void
		do
			filter := a_filter
			create internal_root_nodes.make (10)
			create parent_nodes.make (10)
		ensure
			filter_set: filter = a_filter
		end

	make_default
			-- Initialize `Current' to use {TAG_DEFAULT_FILTER}.
		do
			make (create {TAG_DEFAULT_FILTER [G]})
		ensure
			default_filter: attached {TAG_DEFAULT_FILTER [G]} filter
		end

feature -- Access

	tree: TAG_TREE [G]
			-- Tree of which `Current' contains a subset of nodes
		require
			connected: is_connected
		local
			l_tree: like internal_tree
		do
			l_tree := internal_tree
			check l_tree /= Void end
			Result := l_tree
		end

	items: SEARCH_TABLE [G]
			-- All items contained in nodes or child nodes of `root_nodes'
			--
			-- Note: this query is expensive as it traverses all nodes in `root_nodes' recursively.
		require
			connected: is_connected
		do
			create Result.make (10)
			append_items_recursive (Result)
		end

feature -- Access

--	root_nodes: DS_ARRAYED_LIST [TAG_TREE_NODE [G]]
--			-- Arrayed list of all nodes representing the root of a sub tree in `tree'
--		require
--			connected: is_connected
--		do
--			create Result.make_from_linear (internal_root_nodes)
--		end

	common_parent: TAG_TREE_NODE [G]
			-- Greates common parent of `root_nodes'
			--
			-- Note: during an update this might not represent the actual common parent, see
			--       `reset_common_parent'.
		require
			connected: is_connected
		do
			if attached internal_common_parent as l_parent then
				Result := l_parent
			else
				Result := tree.root_node
			end
		end

	filter: TAG_SPARSE_TREE_FILTER [G]
			-- Filter which determines which nodes belong to `root_nodes'

feature {NONE}  -- Access

	internal_tree: detachable like tree
			-- Internal storage for `tree'

	internal_root_nodes: SEARCH_TABLE [like common_parent]
			-- Internal storage for `root_nodes'
			--
			-- Note: if `root_nodes' contains only a single node, `common_parent' points to that node.

	parent_nodes: HASH_TABLE [NATURAL, like common_parent]
			-- Table containing parent nodes of all `root_nodes' together with a reference counter
			--
			-- key: (indirect) parent of `root_nodes'
			-- values: number of direct children which are either also in `parent_nodes' or `root_nodes'
			--         (serves as a reference counter when removing nodes from `root_nodes')

	internal_common_parent: detachable like common_parent
			-- Internal storgae for `common_parent'
			--
			-- Note: Void if `root_nodes' is empty

	last_modified_node: detachable like common_parent
			-- Greatest common parent of all nodes which have been modified during last update, Void if no
			-- node has been modified

	added_node: detachable like common_parent
			-- Node added before current update

	removed_node: detachable like common_parent
			-- Node which will be removed after current update

feature -- Status report

	is_connected: BOOLEAN
			-- Is `Current' connected to a tag tree?
		do
			Result := internal_tree /= Void
		end

	is_updating: BOOLEAN
			-- Is `Current' refreshing `root_nodes'?

	has_root_nodes: BOOLEAN
			-- Does `root_nodes' contain any nodes?
		do
			Result := not internal_root_nodes.is_empty
		end

feature {NONE} -- Status report

	has_nodes_changed: BOOLEAN
			-- Has the content of `root_nodes' changed during last update?

	has_common_parent_changed: BOOLEAN
			-- Has `common_parent' changed during last update?

feature -- Status setting

	connect (a_tree: like tree)
			-- Connect to an existing tag tree.
		require
			not_connected: not is_connected
		do
			internal_tree := a_tree
			tree.connection.connect_events (Current)
			reset
		ensure
			connected: is_connected
			connected_to_a_tree: tree = a_tree
		end

	disconnect
			-- Disconnect from `tree'.
		require
			connected: is_connected
			not_updating: not is_updating
		do
			tree.connection.disconnect_events (Current)
			wipe_out
			internal_tree := Void
		ensure
			not_connected: not is_connected
		end

feature {TAG_SPARSE_TREE_FILTER} -- Status setting

	begin_update
		require
			connected: is_connected
			not_updating: not is_updating
		do
			tree.lock
			is_updating := True
			has_nodes_changed := False
			has_common_parent_changed := False
		ensure
			updating: is_updating
		end

	finish_update
		require
			connected: is_connected
			updating: is_updating
		do
			removed_node := Void
			last_modified_node := Void
			tree.unlock
			is_updating := False
		ensure
			not_updating: not is_updating
		end

feature -- Query

	is_inside_node (a_node: TAG_TREE_NODE [G]): BOOLEAN
			-- Is node item or child of one of the nodes in `root_nodes'?
			--
			-- `a_node': a node.
			-- `Result': True if `a_node' or one of `a_nodes' parent item of `root_nodes', False otherwise.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
		local
			l_node: TAG_TREE_NODE [G]
			l_nodes: like internal_root_nodes
		do
			from
				l_nodes := internal_root_nodes
				l_node := a_node
				Result := l_nodes.has (l_node)
			until
				Result or l_node.is_root
			loop
				l_node := l_node.parent
				Result := l_nodes.has (l_node)
			end
		end

	is_parent_node (a_node: TAG_TREE_NODE [G]): BOOLEAN
			-- Is node a parent of one of the nodes in `root_nodes'?
			--
			-- `a_node': a_node.
			-- `Result': True if `a_node' is a parent of a node in `root_nodes', False otherwise.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
		do
			Result := parent_nodes.has (a_node)
		end

feature -- Element change

	add_node (a_node: like common_parent)
			-- Add node to `root_nodes', extending sparse tree represented by `Current'.
			--
			-- `a_node': Node to be added to `root_nodes'.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
			a_node_not_inside: not is_inside_node (a_node)
		local
			l_perform_add: BOOLEAN
			l_current: like common_parent
			l_parents: like parent_nodes
			l_nodes: like internal_root_nodes
		do
			if a_node.is_root then
				l_perform_add := True
			else
				add_parent_if_siblings_inside (a_node)
				l_perform_add := not is_inside_node (a_node)
			end
			if l_perform_add then
				l_parents := parent_nodes
				l_nodes := internal_root_nodes
				l_nodes.force (a_node)
				l_current := a_node
				if l_parents.has (a_node) then
						-- Remove any children from `parent_nodes' or `root_nodes'
					remove_parent_node (a_node)
				else
						-- Add parents of `a_node' to `parent_nodes' if `a_node' was not there before.
					from

					until
						l_current.is_root
					loop
						l_current := l_current.parent
						l_parents.search (l_current)
						if l_parents.found then
							l_parents.replace (l_parents.found_item + 1, l_current)
							l_current := tree.root_node
						else
							l_parents.force (1, l_current)
						end
					end
				end
				has_nodes_changed := True
				set_last_modified_node (l_current)

					-- Update `common_parent'
				recompute_common_parent
			end
		ensure
			a_node_inside: is_inside_node (a_node)
		end

	remove_node (a_node: TAG_TREE_NODE [G])
			-- Remove node from `inside' nodes.
			--
			-- If node is item in `root_nodes', simply remove it. Otherwise remove it's parent from nodes, but adding
			-- back any siblings (also for its parents) since they should still be inside.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
			a_node_inside: is_inside_node (a_node)
		local
			l_parents: like parent_nodes
			l_nodes: like internal_root_nodes
			l_current, l_parent, l_child: like common_parent
			l_count: NATURAL
			l_keep_parents: BOOLEAN
			l_children: ARRAYED_LIST [TAG_TREE_NODE [G]]
		do
			l_nodes := internal_root_nodes
			l_parents := parent_nodes

				-- Remove corresponding parent of `a_node' from `root_nodes' (can be `a_node' itself)
			from
				l_current := a_node
			until
				l_nodes.has (l_current)
			loop
				check
					not_root: not l_current.is_root
				end
				l_parent := l_current.parent

					-- Add siblings back since they should still be inside and add corresponding reference count
					-- to `parent_nodes' for `l_parent'
				l_children := l_parent.children
				l_count := l_children.count.to_natural_32
				if l_count > 1 then
					from
					l_children.start
					until
						l_children.after
					loop
						l_child := l_children.item_for_iteration
						if l_child /= l_current then
							l_nodes.force (l_child)
						end
						l_children.forth
					end
					if l_keep_parents then
						l_parents.force (l_count, l_parent)
					else
						l_parents.force (l_count - 1, l_parent)
					end
					l_keep_parents := True
				elseif l_keep_parents then
					l_parents.force (1, l_parent)
				end

				l_current := l_parent
			end
			l_nodes.remove (l_current)
			has_nodes_changed := True

			if l_keep_parents then
				set_last_modified_node (l_current)
			else
				if not l_current.is_root then
					decrease_parent_nodes_recursive (l_current)
				end
				recompute_common_parent
			end
		ensure
			a_node_not_inside: not is_inside_node (a_node)
		end

	reset
			-- Remove any nodes in `root_nodes' and evaluate complete tree from scratch using `filter'.
		require
			connected: is_connected
			not_updating: not is_updating
		local
			l_root: like common_parent
		do
			begin_update
			wipe_out
			l_root := tree.root_node
			set_last_modified_node (l_root)
			fill_tree_recursive (l_root)
			finish_update
		end

feature {NONE} -- Element change

	set_last_modified_node (a_node: like common_parent)
			-- Set `last_modified_node' to the greatest common parent of given node and current.
			--
			-- `a_node': Node which was modified last.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
		do
			if attached last_modified_node as l_last then
				last_modified_node := gcp (l_last, a_node)
			else
				last_modified_node := a_node
			end
		end

	wipe_out
			-- Wipe out any information in `root_nodes' and `parent_nodes'.
		do
			internal_root_nodes.wipe_out
			parent_nodes.wipe_out
			internal_common_parent := Void
			has_nodes_changed := True
			has_common_parent_changed := True
		ensure
			internal_root_nodes_empty: internal_root_nodes.is_empty
			parent_nodes_empty: parent_nodes.is_empty
			internal_common_parent_detached: internal_common_parent = Void
			nodes_have_changed: has_nodes_changed
			common_parent_changed: has_common_parent_changed
		end

feature -- Basic operations

	append_items_recursive (a_hash_set: like items)
			-- Recursively add items in children of `root_nodes' to given hash set.
			--
			-- `a_hash_set': Hash set to which items will be added.
		require
			a_hash_set_attached: a_hash_set /= Void
			connected: is_connected
		local
			l_nodes: like internal_root_nodes
		do
			from
				l_nodes := internal_root_nodes
				l_nodes.start
			until
				l_nodes.after
			loop
				l_nodes.item_for_iteration.append_items_recursive (a_hash_set)
				l_nodes.forth
			end
		end

feature {TAG_TREE} -- Events

	on_node_added (a_tree: TAG_TREE [G]; a_node: TAG_TREE_NODE [G])
			-- <Precursor>
		do
			check not_updating: not is_updating end

			begin_update
			set_last_modified_node (a_node)
			added_node := a_node
			fill_tree_recursive (a_node)
			finish_update
		end

	on_node_remove (a_tree: TAG_TREE [G]; a_node: TAG_TREE_NODE [G])
			-- <Precursor>
		do
			check not_updating: not is_updating end

			begin_update
			removed_node := a_node

			if internal_root_nodes.has (a_node) then
				remove_node (a_node)
			else
				set_last_modified_node (a_node)
				if parent_nodes.has (a_node) then
					remove_parent_node (a_node)
					if not a_node.is_root then
						decrease_parent_nodes_recursive (a_node)
					end
					recompute_common_parent
				elseif not is_inside_node (a_node) then
					add_parent_if_siblings_inside (a_node)
				end
			end
			finish_update
		end

feature {NONE} -- Implementation

	gcp (a_node1, a_node2: like common_parent): like common_parent
			-- Greates common parent of two nodes
		require
			a_node1_attached: a_node1 /= Void
			a_node2_attached: a_node2 /= Void
			connected: is_connected
			a_node1_active: a_node1.is_active
			a_node2_active: a_node2.is_active
			a_node1_valid: a_node1.tree = tree
			a_node2_valid: a_node2.tree = tree
		local
			l_formatter: TAG_FORMATTER
			l_tag1, l_tag2, l_token1, l_token2: STRING
			l_done: BOOLEAN
		do
			l_formatter := tree.formatter

			from
				l_tag1 := a_node1.tag
				l_tag2 := a_node2.tag
				Result := tree.root_node
			until
				l_tag1.is_empty or l_tag2.is_empty or l_done
			loop
				l_token1 := l_formatter.first_token (l_tag1)
				l_token2 := l_formatter.first_token (l_tag2)
				if l_token1.same_string (l_token2) then
					l_tag1 := l_formatter.suffix (l_token1, l_tag1)
					l_tag2 := l_formatter.suffix (l_token2, l_tag2)
					check child_for_token: not Result.is_leaf and then Result.has_child_with_token (l_token1) end
					Result := Result.child_with_token (l_token1)
				else
					l_done := True
				end
			end
		ensure
			result_valid_wrt_node1: Result = a_node1 or else Result.is_parent_of (a_node1)
			result_valid_wrt_node2: Result = a_node2 or else Result.is_parent_of (a_node2)
			result_is_greatest: Result.is_leaf or not Result.children.there_exists (
				agent (l_child, a_n1, a_n2: like common_parent): BOOLEAN
					do
						Result := l_child.is_parent_of (a_n1) and l_child.is_parent_of (a_n2)
					end (?, a_node1, a_node2))
		end

	decrease_parent_nodes_recursive (a_node: like common_parent)
			-- Decrease reference counting for node in `parent_nodes', also setting `last_modified_node' to
			-- the top most modified parent node.
			--
			-- `a_node': Node for which references in `parend_nodes' should be decreased.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
			a_node_not_root: not a_node.is_root
			a_node_not_parent: is_parent_node (a_node.parent)
		local
			l_done: BOOLEAN
			l_nodes: like internal_root_nodes
			l_parents: like parent_nodes
			l_current: like common_parent
			l_count: NATURAL
		do
				-- Decrease references
			l_nodes := internal_root_nodes
			l_parents := parent_nodes
			from
				l_current := a_node
			until
				l_done
			loop
				l_current := l_current.parent
				check
					parent_nodes_has_current: l_parents.has (l_current)
				end
				l_count := l_parents.item (l_current)
				if l_count > 1 then
					l_parents.force (l_count - 1, l_current)
					l_done := True
				else
					l_parents.remove (l_current)
					l_done := l_current.is_root
				end
			end
			set_last_modified_node (l_current)
		end

	remove_parent_node (a_node: like common_parent)
			-- Remove given node from `parent_nodes', also removing any (indirect) children from
			-- `parent_nodes' and `root_nodes'.
			--
			-- Note: this routine simply removes the nodes and does not update `last_modified_node' nor
			--       does it call `add_parent_if_siblings_inside' nor does it update `parent_nodes'
			--       for parents of `a_node'.
			--
			-- `a_node': Node for which child nodes should be removed from `root_nodes' and `parent_nodes'.
		require
			a_parent_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
			a_node_is_parent: is_parent_node (a_node)
		local
			l_parents: like parent_nodes
			l_roots: like internal_root_nodes
			l_children: ARRAYED_LIST [like common_parent]
			l_node: like common_parent
		do
			l_parents := parent_nodes
			l_roots := internal_root_nodes
			l_parents.remove (a_node)
			l_children := a_node.children
			from
				l_children.start
			until
				l_children.after
			loop
				l_node := l_children.item_for_iteration
				l_roots.remove (l_node)
				if l_parents.has (l_node) then
					remove_parent_node (l_node)
				end
				l_children.forth
			end
		ensure
			a_node_not_parent: not is_parent_node (a_node)
		end

	recompute_common_parent
			-- Recompute `internal_common_parent' and set `has_common_parent_changed' accordingly.
		local
			l_common_parent: like internal_common_parent
			l_parents: like parent_nodes
			l_nodes: like internal_root_nodes
		do
			l_nodes := internal_root_nodes
				-- Recompute `common_parent'
			inspect l_nodes.count
			when 0 then
					-- set `internal_common_parent' to Void
			when 1 then
				l_nodes.start
				l_common_parent := l_nodes.item_for_iteration
			else
				from
					l_parents := parent_nodes
					l_common_parent := Void
					l_parents.start
				until
					l_parents.after
				loop
					if l_parents.item_for_iteration > 1 then
						if attached l_common_parent then
							l_common_parent := gcp (l_common_parent, l_parents.key_for_iteration)
						else
							l_common_parent := l_parents.key_for_iteration
						end
					end
					l_parents.forth
				end
				check
					valid_common_parent: attached l_common_parent implies l_parents.has (l_common_parent)
				end
			end

				-- This makes sure leafs can not be `common_parent', this could be made adjustable
			if attached l_common_parent and then l_common_parent.is_leaf then
				l_common_parent := l_common_parent.parent
			end
			if l_common_parent /= internal_common_parent then
				has_common_parent_changed := True
				internal_common_parent := l_common_parent
			end
		end

	add_parent_if_siblings_inside (a_node: like common_parent)
			-- If siblings of node are all inside sparse tree, add the parent. Do this recursively for the
			-- parent of an added parent node.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_not_root: not a_node.is_root
			a_node_valid: a_node.tree = tree
			a_node_not_inside: not is_inside_node (a_node)
		local
			l_parent, l_sibling: like common_parent
			l_siblings: ARRAYED_LIST [like common_parent]
			b: BOOLEAN
		do
			l_parent := a_node.parent
			check l_parent_has_children: not l_parent.is_leaf end
			from
				l_siblings := l_parent.children
				l_siblings.start
				b := filter.is_node_included (Current, l_parent).boolean_item (1)
			until
				not b or l_siblings.after
			loop
				l_sibling := l_siblings.item_for_iteration
				b := a_node = l_sibling or internal_root_nodes.has (l_sibling)
				l_siblings.forth
			end
			if b then
				add_node (l_parent)
			end
		end

	fill_tree_recursive (a_node: like common_parent)
			-- Query `filter' whether given node is in tree. If so, make sure node is inside and continue
			-- recursively to check if any child nodes should be excluded. Otherwise continue to check
			-- if child nodes should be added.
			--
			-- `a_node': Current node being added to `Current'.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			updating: is_updating
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
		local
			l_query: TUPLE [is_inside: BOOLEAN; check_children: BOOLEAN]
			l_children: ARRAYED_LIST [like common_parent]
		do
			l_query := filter.is_node_included (Current, a_node)
			if l_query.is_inside /= is_inside_node (a_node) then
				if l_query.is_inside then
					add_node (a_node)
				else
					remove_node (a_node)
				end
			end
			if l_query.check_children and not a_node.is_leaf then
				l_children := a_node.children
				l_children.do_all (agent fill_tree_recursive)
			end
		end

invariant
	filter_attached: filter /= Void
	internal_nodes_attached: internal_root_nodes /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class TAG_SPARSE_TREE


