indexing
	description:

		"Node elements for ERL_G_TRIE"

	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class
	ERL_G_TRIE_NODE [G, H]

create
	make,
	make_root

feature {NONE} -- Initialization

	make (a_parent: like Current; a_key: H) is
			-- Create new empty node with parent `a_parent' and key `a_key'.
		require
			a_parent_not_void: a_parent /= Void
		do
			parent := a_parent
			level := a_parent.level + 1
			key_item := a_key
			create children.make_default
		end

	make_root is
			-- Create new empty root.
		do
			level := 0
			create children.make_default
		ensure
			parent_is_void: parent = Void
			level_is_zero: level = 0
		end

feature -- Status report

	is_valid_key (a_key: DS_INDEXABLE [H]): BOOLEAN is
			-- Is `a_key' a valid item to put in this node or its one of its children?
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			p: DS_INDEXABLE [H]
		do
			Result := a_key.count >= level
			if Result and level > 0 then
				from
					i := 1
					p := node_prefix
				until
					i > level or else (not (a_key.item (i).is_equal (p.item (i))))
				loop
					i := i + 1
				end
				Result := i > level
			end
		end

	has_item: BOOLEAN
			-- Does current node have an item?

	is_leaf: BOOLEAN is
			-- Is current node a leaf node? I.e. does it not have any children?
		do
			Result := children.count = 0
		end


	is_degenerate: BOOLEAN is
			-- Is the tree starting at current node degenerate
			-- (every parent has only one child), no inner node
			-- has an item and the leaf node has an item? If
			-- true this means that there is exactly one
			-- prefix to an item in this tree and the tree looks
			-- looks like a list.
		do
			if has_item then
				Result := is_leaf
			else
				Result := children.count = 1 and children.item (1).is_degenerate
			end
		end

	is_part_degenerate: BOOLEAN is
			-- Is there a sequence of degenerate nodes starting with this node?
			-- I.e. a sequence of nodes (>1) that each have exactly one child and no item?
		do
			Result := part_degenerate_count > 1
		end

feature -- Access

	item: G
			-- Value of current item (if any)

	children: DS_ARRAYED_LIST [like Current]
			-- Child nodes

	parent: ERL_G_TRIE_NODE [G, H]
		-- Parent node (Void if root node)

	level: INTEGER
			-- Nesting level of node in trie. (Root node has level 0.)

	key_item: H
		-- Key part of this node

	node_prefix: DS_INDEXABLE [H]
			-- Prefix of this node
		do
			create {DS_ARRAYED_LIST [H]} Result.make (level)
			append_prefix_to_indexable (Result)
		end

	node_postfix: DS_INDEXABLE [H] is
			-- Postfix of only item stored in this tree.
			-- Only applicable if tree is leaf-degenerate.
		require
			is_degenerate: is_degenerate
		do
			create {DS_ARRAYED_LIST [H]} Result.make (30)
			append_postfix_to_indexable (Result)
		end

	leaf_node: like Current
			-- Value of only leaf in tree.
			-- Note only applicable if tree is leaf-degenerate.
		require
			is_degenerate: is_degenerate
		local
			n: like Current
		do
			from
				n := Current
			until
				n.is_leaf
			loop
				n := n.children.item (1)
			end
			Result := n
		end

	part_degenerate_count: INTEGER is
			-- Number of nodes that have one child and no item (starting with current)
		local
			n: ERL_G_TRIE_NODE [G, H]
		do
			from
				n := Current
			until
				n.children.count /= 1 or else n.children.item (1).has_item
			loop
				Result := Result + 1
				n := n.children.item (1)
			end
			if n.children.count = 1 then
				Result := Result + 1
			end
		end

	part_degenerate_end_node: ERL_G_TRIE_NODE [G, H] is
			-- Last node that has no item and whose parent has one child
		require
			is_part_degenerate: is_part_degenerate
		local
			n: ERL_G_TRIE_NODE [G, H]
		do
			from
				n := Current
			until
				n.children.count /= 1 or else n.children.item (1).has_item
			loop
				n := n.children.item (1)
			end
			if n.children.count = 1 then
				Result := n.children.item (1)
			else
				Result := n
			end
		end

feature -- Element change

	put (a_item: G; a_key: DS_INDEXABLE [H]) is
			-- Associate `a_item' with `a_key'.
		require
			a_key_not_void: a_key /= Void
			a_key_valid: is_valid_key (a_key)
		local
			cs: DS_LINEAR_CURSOR [ERL_G_TRIE_NODE [G, H]]
			k: H
			child: ERL_G_TRIE_NODE [G, H]
		do
			if a_key.count = level then
					-- Insert item right here.
				has_item := True
				item := a_item
			else
				from
					cs := children.new_cursor
					cs.start
					k := a_key.item (level + 1)
				until
					cs.off or child /= Void
				loop
					if cs.item.key_item = k then
						child := cs.item
					end
					cs.forth
				end
				if child = Void then
					create child.make (Current, k)
					children.force_last (child)
				end
				child.put (a_item, a_key)
			end
		end

feature {ERL_G_TRIE_NODE} -- Implementation

	append_prefix_to_indexable (a_list: DS_INDEXABLE [H]) is
			-- Apprend prefix to `a_list'.
		require
			a_list_not_void: a_list /= Void
		do
			if parent /= Void then
				parent.append_prefix_to_indexable (a_list)
				a_list.force_last (key_item)
			end
		ensure
			size_correct: a_list.count = old a_list.count + level
		end

	append_postfix_to_indexable (a_list: DS_INDEXABLE [H]) is
			-- Apprend postfix to `a_list'.
			-- Only applicable if tree is leaf-degenerate.
		require
			a_list_not_void: a_list /= Void
			is_degenerate: is_degenerate
		do
			a_list.force_last (key_item)
			if not is_leaf then
				children.item (1).append_postfix_to_indexable (a_list)
			end
		end

invariant

	children_not_void: children /= Void
	children_does_not_have_void: not children.has (Void)
	level_not_negative: level >= 0
	root_node_is_level_0: (parent = Void) = (level = 0)

end
