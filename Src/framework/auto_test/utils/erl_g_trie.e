indexing
	description:

		"Objects representing a trie (also called a prefix tree) of strings and an arbitrary associated value"

	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ERL_G_TRIE [G, H]

create
	make

feature {NONE} -- Initialization

	make is
			-- Create empty trie.
		do
			create root_node.make_root
		end

feature -- Status report

	last_found: BOOLEAN
			-- Was an item found during last search?

	last_item: G
			-- Item found during last search

feature -- Searching

	search (a_key: DS_INDEXABLE [H]) is
			-- Search for item with key `a_key'. If an item could be found set
			-- `last_found' to `True' (`False' otherwise) and make item available
			-- via `last_item'.
		require
			a_key_not_void: a_key /= Void
		do
			last_found := False
			search_recursive (a_key, root_node)
		end

feature -- Element change

	put (a_value: G; a_key: DS_INDEXABLE [H]) is
			-- Put value `a_value' with key `a_key' in trie.
		require
			a_key_not_void: a_key /= Void
		do
			root_node.put (a_value, a_key)
		end

feature -- Nodes

	root_node: ERL_G_TRIE_NODE [G, H]
			-- Root child nodes of trie

	search_recursive (a_key: DS_INDEXABLE [H]; a_node: like root_node) is
			-- Search for item with key `a_key' in `node' and its children. If an item could be found set
			-- `last_found' to `True' and make item available
			-- via `last_item'.
		require
			a_key_not_void: a_key /= Void
			a_node_not_void: a_node /= Void
			not_found: not last_found
			correct_prefix: a_node.is_valid_key (a_key)
		local
			cs: DS_LINEAR_CURSOR [ERL_G_TRIE_NODE [G, H]]
		do
			if a_key.count = a_node.level and a_node.has_item then
				check
					valid_key: a_key.item (a_node.level) = a_node.key_item
				end
				last_found := True
				last_item := a_node.item
			elseif a_key.count > a_node.level then
				from
					cs := a_node.children.new_cursor
					cs.start
				until
					cs.off
				loop
					if cs.item.key_item = a_key.item (cs.item.level) then
						search_recursive (a_key, cs.item)
					end
					cs.forth
				end
			end
		end

invariant

	root_node_not_void: root_node /= Void

end
