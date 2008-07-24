indexing
	description: "[
		Objects that represent a child node in {TAG_BASED_TREE}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_BASED_TREE_NODE [G -> TAGABLE_I]

inherit
	TAG_BASED_TREE_NODE_CONTAINER [G]
		redefine
			token,
			parent
		end

create {TAG_BASED_TREE_NODE_CONTAINER}
	make

feature {NONE} -- Initialization

	make (a_parent: like parent; a_token: like token) is
			-- Initialize `Current'.
			--
			-- `a_parent': Parent node for `Current'.
			-- `a_token': Token which `Current' will represent in tree.
		require
			a_token_valid: is_valid_token (a_token)
		local
			l_cursor: !DS_HASH_TABLE_CURSOR [NATURAL, !STRING]
			l_descendant: like tag
		do
			parent := a_parent
			create token.make_from_string (a_token)
			tag := join_tags (parent.tag, token)
			create descending_tags.make_default
			tree := a_parent.tree
		ensure
			parent_set: parent = a_parent
			token_set: token.is_equal (a_token)
			not_cached: not is_evaluated
			empty: is_empty
		end

feature -- Access

	token: !STRING
			-- Token `Current' represents in the tag

	tag: !STRING
			-- Tag defining ancestors of `Current'

	parent: !TAG_BASED_TREE_NODE_CONTAINER [G]
			-- Node listing `Current' as one of its children

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Access

	tree: !TAG_BASED_TREE [G]
			-- <Precursor>

feature -- Status report

	is_root: BOOLEAN = False
			-- <Precursor>

invariant
	tag_correct: tag.is_equal (join_tags (parent.tag, token))

end
