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
	TAG_BASED_TREE_NODE_PARENT [G]
		redefine
			token,
			parent
		end

create {TAG_BASED_TREE_NODE_PARENT}
	make

feature {NONE} -- Initialization

	make (a_parent: like parent; a_token: like token) is
		require
			not_a_parent_cached: not a_parent.is_cached
			a_token_valid: is_valid_token (a_token)
				-- Precondition stating that for every key in `a_tag_table' (representing a descending tag)
				-- joined with `a_token', `a_parent' must contain a descending tag with the same item count.
		local
			l_cursor: !DS_HASH_TABLE_CURSOR [NATURAL, !STRING]
			l_descendant: like tag
		do
			parent := a_parent
			parent.descending_tags.search (token)
			if parent.descending_tags.found then
				item_count := parent.descending_tags.found_item
			end
			create token.make_from_string (a_token)
			create descending_tags.make_default
			tree := a_parent.tree
		ensure
			parent_set: parent = a_parent
			token_set: token.is_equal (a_token)
			not_cached: not is_cached
			descending_tags_empty: descending_tags.is_empty
			item_count_zero: item_count = 0
		end

feature -- Access

	token: !STRING
			-- Token `Current' represents in the tag

	tag: !STRING
			-- Tag defining ancestors of `Current'

	parent: !TAG_BASED_TREE_NODE_PARENT [G]
			-- Node listing `Current' as one of its children

feature {TAG_BASED_TREE_NODE_PARENT} -- Access

	tree: !TAG_BASED_TREE [G]
			-- <Precursor>

feature -- Status report

	is_root: BOOLEAN = False
			-- <Precursor>

invariant
	tag_valid: parent.tag.is_empty implies tag.is_equal (token)
	tag_correct: not parent.tag.is_empty implies tag.is_equal (join_tokens (parent.tag, token))

end
