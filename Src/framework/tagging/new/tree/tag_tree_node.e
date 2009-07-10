note
	description: "[
		Node of {TAG_TREE}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE_NODE [G -> TAG_ITEM]

inherit
	HASHABLE

	TAG_SHARED_EQUALITY_TESTER

create
	make_root,
	make_node

feature {NONE} -- Initialization

	make_root (a_tree: like tree)
			-- Initialize `Current' to be a root node.
			--
			-- `a_tree': Tree in which new node will be root.
		require
			a_tree_attached: a_tree /= Void
		local
			l_table: like internal_child_table
		do
			initialize (a_tree)
			create l_table.make_default
			l_table.set_key_equality_tester (equality_tester)
			internal_child_table := l_table
		ensure
			active: is_active
			root: is_root
			tree_set: tree = a_tree
			empty: is_empty
		end

	make_node (a_parent: like parent; a_tag: READABLE_STRING_GENERAL; an_item: G)
			-- Initialize `Current' as a inner node.
			--
			-- `a_parent': Parent node for `Current'.
			-- `a_tag': Tag suffix to be represented by `Current' and it's new children.
			-- `an_item': Item to be attached to leaf.
		require
			a_parent_attached: a_parent /= Void
			a_tag_attached: a_tag /= Void
			a_parent_active: a_parent.is_active
			a_tag_valid: a_parent.tree.validator.is_valid_tag (a_tag)
		local
			l_validator: TAG_VALIDATOR
			l_formatter: TAG_FORMATTER
			l_token: READABLE_STRING_GENERAL
		do
			initialize (a_parent.tree)
			l_formatter := tree.formatter
			l_validator := tree.validator
			l_token := l_formatter.first_token (a_tag)

			internal_token := l_validator.immutable_string (l_formatter.first_token (a_tag))

			if l_token.count = a_tag.count then
						-- Current node will become a leaf
					create internal_item.put (an_item)
			else
					-- Current node will not be a leaf

					-- Note: `internal_parent' is set after recursively adding a child, but before adding the item.
					--       Reason is the invariant saying that `Current' can only be empty if it is root. Since
					--       `Current' is passed when creating a new child, we initialize `Current' as root until
					--       the child node is added (making `Current' not empty) and then set `internal_parent'
					--       to `a_parent'.

					make_root (tree)
					add_tag_with_item (l_formatter.suffix (l_token, a_tag), an_item)
			end
			internal_token := l_validator.immutable_string (l_token)
			internal_parent := a_parent
		ensure
			active: is_active
			valid_token: token.same_string (tree.formatter.first_token (a_tag))
		end

	initialize (a_tree: like tree)
			-- Active `Current' by assigning the tree.
		do
			internal_tree := a_tree
		ensure
			active: is_active
			tree_set: tree = a_tree
		end

feature -- Access

	tree: TAG_TREE [G]
			-- Tree to which `Current' belongs.
		require
			active: is_active
		local
			l_tree: like internal_tree
		do
			l_tree := internal_tree
			check l_tree /= Void end
			Result := l_tree
		ensure
			result_attached: Result /= Void
			result_valid: not is_root implies (parent.tree = Result)
		end

	token: IMMUTABLE_STRING_8
			-- Token represented by `Current'.
		require
			active: is_active
			not_root: not is_root
		local
			l_token: like internal_token
		do
			l_token := internal_token
			check l_token /= Void end
			Result := l_token
		end

	children: DS_ARRAYED_LIST [like child_with_token]
			-- Arrayed list containing child nodes
		require
			active: is_active
			not_leaf: not is_leaf
		do
			create Result.make_from_linear (child_table)
		ensure
			result_attached: Result /= Void
		end

	child_with_token (a_token: READABLE_STRING_GENERAL): TAG_TREE_NODE [G]
			-- Child node representing given token
			--
			-- `a_token': Token for which corresponding child node should be returned.
			-- `Result': Child node for `a_token'.
		require
			active: is_active
			not_leaf: not is_leaf
			has_child_with_token: has_child_with_token (a_token)
		do
			Result := child_table.item (a_token)
		ensure
			result_is_child: child_table.has_item (Result)
			result_valid: a_token.same_string (Result.token)
		end

	item: G
			-- Item contained in `Current'.
		require
			active: is_active
			has_items: is_leaf
		local
			l_cell: like internal_item
		do
			l_cell := internal_item
			check l_cell /= Void end
			Result := l_cell.item
		ensure
			result_attached: Result /= Void
		end

	count: INTEGER
			-- Number of children and items in `Current'
		require
			active: is_active
		do
			if is_leaf then
				Result := 1
			else
				Result := child_table.count
			end
		ensure
			account_for_item: (is_leaf  implies Result >= 1)
			account_for_children: not is_leaf implies Result >= child_table.count
		end

	parent: like child_with_token
			-- Parent node of `Current'
		require
			active: is_active
			not_root: not is_root
		local
			l_parent: like internal_parent
		do
			l_parent := internal_parent
			check l_parent /= Void end
			Result := l_parent
		ensure
			result_attached: Result /= Void
			result_active: Result.is_active
		end

	tag: STRING_8
			-- Tag represented by `Current'.
		require
			active: is_active
		do
			if is_root then
				create Result.make_empty
			elseif parent.is_root then
					-- Assuming average tag length is 50
				create Result.make (50)
				Result.append (token)
			else
				Result := parent.tag
				tree.formatter.append_tag (Result, token)
			end
		ensure
			result_attached: Result /= Void
			result_valid: tree.validator.is_valid_tag (Result) or Result.is_empty
			result_empty_equals_root: Result.is_empty = is_root
		end

feature -- Access: hashing

	hash_code: INTEGER_32
			-- <Precursor>
		do
			Result := hash_code_cache
			if Result = 0 and is_active then
				if not is_root then
					Result := token.hash_code
					hash_code_cache := Result
				end
			end
		end

feature {TAG_TREE} -- Access

	last_added_child: like child_with_token
			-- Last added child node

feature {NONE} -- Access

	internal_tree: detachable like tree
			-- Internal storage of `tree'

	internal_token: detachable IMMUTABLE_STRING_8
			-- Internal storage of `token'

	internal_parent: detachable like parent
			-- Internal storage of `parent'

feature {NONE} -- Access: content

	child_table: DS_HASH_TABLE [like child_with_token, READABLE_STRING_GENERAL]
			-- Table associating child nodes with their corresponding token
			--
			-- keys: token
			-- values: child node with token
		require
			active: is_active
			not_leaf: not is_leaf
		local
			l_table: like internal_child_table
		do
			l_table := internal_child_table
			check l_table /= Void end
			Result := l_table
		ensure
			result_attached: Result /= Void
			result_equals_internal: Result = internal_child_table
		end

	internal_child_table: detachable like child_table
			-- Internal storage of `children' if `Current' is not leaf

	internal_item: detachable CELL [G]
			-- Internal storage of `item' if `Current' is leaf

	hash_code_cache: like hash_code
			-- Cache for `hash_code'

feature -- Status report

	frozen is_active: BOOLEAN
			-- Is `Current' an active node in a tree?
		do
			Result := internal_tree /= Void
		ensure
			result_equals_tree_attached: Result = (internal_tree /= Void)
		end

	frozen is_root: BOOLEAN
			-- Is `Current' the root node in `tree'?
		require
			active: is_active
		do
			Result := internal_parent = Void
		ensure
			result_equals_parent_detached: Result = (internal_parent = Void)
		end

	frozen is_leaf: BOOLEAN
		require
			active: is_active
		do
			Result := internal_item /= Void
		ensure
			result_implies_item_attached: Result implies attached internal_item
		end

	is_empty: BOOLEAN
			-- Does `Current' contain no child nodes or items?
		require
			active: is_active
		do
			Result := count = 0
		ensure
			result_correct: Result = (count = 0)
		end

feature {TAG_TREE_NODE} -- Status setting

	frozen remove
			-- Remove `Current' from tree.
		require
			active: is_active
		do
			remove_internal
			if is_leaf then
				internal_item := Void
			else
				child_table.do_all (agent {like child_with_token}.remove)
				child_table.wipe_out
				internal_child_table := Void
			end
			last_added_child := Void
			internal_tree := Void
			internal_token := Void
			internal_parent := Void
		ensure
			not_active: not is_active
		end

feature {NONE} -- Status setting

	remove_internal
			-- Remove `current' from tree.
			--
			-- Note: this is called indirectly by `remove' and enables descendant to perform cleanup tasks.
		require
			active: is_active
		do
		end

feature -- Query

	has_child_with_token (a_token: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `Current' contain a child node with corresponding token?
			--
			-- `a_token': A token.
			-- `Result': True if `Current' contains a child node for `a_token', False otherwise.
		require
			active: is_active
			not_leaf: not is_leaf
		do
			Result := child_table.has (a_token)
		ensure
			correct_result: Result implies child_table.has (a_token)
		end

	has_item (an_item: G): BOOLEAN
			-- Does `Current' contain item?
			--
			-- `an_item': An item.
			-- `Result': True if `Current' contains `an_item', False otherwise.
		obsolete
			"nope"
		require
			active: is_active
		do
			if is_leaf then
			end
		ensure
			result_implies_has_items: Result implies is_leaf
		end

	is_parent_of (a_node: like child_with_token): BOOLEAN
			-- Is `Current' an indirect parent of given node?
			--
			-- `a_node': Some node.
			-- `Result': True if `Current' is a indirect parent node of `a_node', False otherwise.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		local
			l_parent: like child_with_token
		do
			if not (Current = a_node or a_node.is_root) then
				from
					l_parent := a_node
				until
					l_parent.is_root or Result
				loop
					l_parent := l_parent.parent
					Result := l_parent = Current
				end
			end
		end

feature {TAG_TREE} -- Element change

	add_tag_with_item (a_tag: READABLE_STRING_GENERAL; an_item: G)
			-- Extend `Current' according to given tag and item.
			--
			-- `a_node': Node to be extended with tag
			-- `a_tag': Tag describing new subnodes of `a_node'.
			-- `an_item': Item to be attached to leaf node.
		require
			a_tag_attached: a_tag /= Void
			an_item_attached: an_item /= Void
			active: is_active
			not_leaf: not is_leaf
			a_tag_valid: tree.validator.is_valid_tag (a_tag)
			a_tokken_not_added: not has_child_with_token (tree.formatter.first_token (a_tag))
		local
			l_new: like child_with_token
		do
			l_new := tree.node_factory.create_node (Current, a_tag, an_item)
			last_added_child := l_new
			child_table.force (l_new, l_new.token)
		ensure
			count_increased: count = old count + 1
			child_node_added: attached tree.formatter.first_token (a_tag) as l_t and then
				has_child_with_token (l_t) and then
				last_added_child = child_with_token (l_t)
		end

	remove_child_with_token (a_token: READABLE_STRING_GENERAL)
			-- Remove child for given token.
			--
			-- `a_node': Node from which child node should be removed.
			-- `a_token': Token of child to be removed.
		require
			a_token_attached: a_token /= Void
			active: is_active
			not_leaf: not is_leaf
			has_child_with_token: has_child_with_token (a_token)
			not_root_implies_count_greater_one: not is_root implies count > 1
		do
			child_with_token (a_token).remove
			child_table.remove (a_token)
		ensure
			removed: not has_child_with_token (a_token)
			count_decreased: count = old count - 1
			child_deactivated: not (old child_with_token (a_token)).is_active
		end

	add_item (an_item: G)
			-- Add item to `Current'.
			--
			-- `an_item': Item to be added.
		obsolete
			"does not make sense..."
		require
			an_item_attached: an_item /= Void
			active: is_active
			leaf: is_leaf
			not_has_item: not has_item (an_item)
		do
		ensure
			count_increased: count = old count + 1
			has_item: has_item (an_item)
		end

	remove_item (an_item: G)
			-- Remove item from `Current'.
			--
			-- `an_item': Item to be removed.
		obsolete
			"does not make sense anymore..."
		require
			an_item_attached: an_item /= Void
			active: is_active
			not_root: not is_root
			has_item: has_item (an_item)
			count_greater_one: count > 1
		do
		ensure
			count_decreased: count = old count - 1
			not_has_item: not has_item (an_item)
		end

feature -- Basic operations

	process (a_visitor: TAG_TREE_NODE_VISITOR [G])
			-- Process `Current' with given visitor.
			--
			-- `a_visitor': Visitor proccessing `Current'.
		require
			active: is_active
			a_visitor_attached: a_visitor /= Void
		do
			a_visitor.process_node (Current)
		end

invariant
	only_root_can_be_empty: (is_active and then is_empty) implies is_root
	not_root_and_leaf: is_active implies not (is_root and is_leaf)
	children_xor_items_attached: is_active implies (attached internal_child_table xor attached internal_item)

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
end -- class TAG_TREE_NODE
