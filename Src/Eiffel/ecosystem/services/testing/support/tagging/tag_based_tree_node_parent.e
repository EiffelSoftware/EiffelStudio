indexing
	description: "[
		Objects that represent a node in {TAG_BASED_TREE} that can have child nodes.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_BASED_TREE_NODE_PARENT [G -> TAGABLE_I]

inherit
	TAG_UTILITIES

feature -- Access

	frozen children: !DS_LINEAR [!TAG_BASED_TREE_NODE [G]]
			-- Child nodes of `Current'
		do
			if is_cached then
				compute_descendants
			end
			Result ?= cached_children
		ensure
			results_valid: ({!DS_LINEAR [!TAG_BASED_TREE_NODE [G]]} #? Result).for_all (
				agent (a_child: !TAG_BASED_TREE_NODE [G]): BOOLEAN
					do
						Result := a_child.tree = tree and then
							cached_children.item (a_child.token) = a_child
					end)
		end

	frozen items: !DS_LINEAR [!G]
			-- Items tagged with `tag'
		do
			if is_cached then
				compute_descendants
			end
			Result ?= cached_items
		ensure
			results_valid: ({!DS_LINEAR [!G]} #? Result).for_all (
				agent (a_item: !G): BOOLEAN
					do
						Result := a_item.tags.has (tag)
					end)
		end

	tag: !STRING
			-- Tag which `Current' represents
		deferred
		ensure
			empty_implies_root: Result.is_empty implies is_root
			not_empty_implies_valid: not Result.is_empty implies is_valid_tag (Result)
			not_root_implies_valid: not is_root implies Result.is_equal (join_tokens (parent.tag, token))
		end

	token: !STRING
			-- Token represented by `Current'
		require
			not_root: not is_root
		do
		ensure
			valid: is_valid_token (Result)
		end

	parent: !TAG_BASED_TREE_NODE_PARENT [G]
			-- Node listing `Current' as one of its children
		require
			not_root: not is_root
		do
		end

feature {TAG_BASED_TREE_NODE_PARENT} -- Acccess

	tree: !TAG_BASED_TREE [G]
			-- Tree in which `Current' represents a node
		deferred
		end

	descending_tags: ?DS_HASH_TABLE [NATURAL, !STRING]
			-- Tag suffixes of all tags found in collection with begin with `tag'.

	item_count: NATURAL
			-- Number of items which are tagged with `tag'

	last_added_child: ?TAG_BASED_TREE_NODE [G]
			-- Child last added through `add_child'

feature {NONE} -- Access

	cached_children: ?DS_HASH_TABLE [!TAG_BASED_TREE_NODE [G], !STRING]
			--

	cached_items: ?DS_HASH_SET [!G]
			-- Items tagged with `tag'

feature -- Status report

	is_root: BOOLEAN
			-- Does `Current' represent the root of the tree?
		deferred
		end

	has_child_for_token (a_token: !STRING): BOOLEAN
			-- Does `Current' contain a child for `a_token'?
		require
			a_token_is_valid: is_valid_token (a_token)
		do
			if not is_cached then
				compute_descendants
			end
			Result := cached_children.has (a_token)
		end

feature {TAG_BASED_TREE_NODE_PARENT} -- Status report

	is_cached: BOOLEAN
			-- Have child nodes for `Current' been computed yet?
		do
			Result := descending_tags /= Void
		ensure
			result_correct: Result = (descending_tags /= Void)
		end

feature {TAG_BASED_TREE_NODE_PARENT} -- Status setting

	set_item_count (a_item_count: NATURAL)
			-- Set `item_count' to `a_item_count'.
		do
			item_count := a_item_count
		ensure
			item_count_set: item_count = a_item_count
		end

feature -- Query

	child_for_token (a_token: !STRING): !TAG_BASED_TREE_NODE [G]
			-- Item in `children' for `a_token'.
		require
			a_token_valid: is_valid_token (a_token)
		do
			if not is_cached then

			end
			Result := cached_children.item (a_token)
		ensure
			result_has_token: Result.token.is_equal (a_token)
		end

feature {TAG_BASED_TREE_NODE_PARENT} -- Element change

	add_child (a_token: !STRING) is
			-- Add child to node in `Current'
		require
			cached: is_cached
			a_token_valid: is_valid_token (a_token)
			a_token_new: not has_child_for_token (a_token)
		local
			l_child: !TAG_BASED_TREE_NODE [G]
		do
			create l_child.make (Current, a_token)
			cached_children.put (l_child, a_token)
		ensure
			last_added_child_attached: last_added_child /= Void
			child_added: cached_children.has (a_token) and then
				cached_children.item (a_token) = last_added_child
			child_not_cached: not last_added_child.is_cached
			child_empty: last_added_child.descending_tags.is_empty and then
				last_added_child.item_count = 0
		end

	add_item (a_item: !G) is
			-- Add item to `items'
		require
			cached: is_cached
			a_item_valid: a_item.tags.has (tag)
			a_item_not_added: not items.has (a_item)
		do
			cached_items.put (a_item)
		ensure
			a_item_added: items.has (a_item)
		end

	remove_child (a_token: !STRING) is
			-- Remove child for `a_token'
		require
			cached: is_cached
			a_token_valid: is_valid_token (a_token)
			has_child_for_token: has_child_for_token (a_token)
		do
			cached_children.remove (a_token)
		ensure
			child_removed: not has_child_for_token (a_token)
		end

	remove_item (a_item: !G)
			-- Remove item from `items'
		require
			cached: is_cached
			a_item_added: items.has (a_item)
		do
			cached_items.remove (a_item)
		ensure
			a_item_removed: not items.has (a_item)
		end

feature {NONE} -- Implementation

	compute_descendants is
			-- Use tags in `descending_tags' to compute children.
		require
			not_cached: not is_cached
		local
			l_cursor: !DS_HASH_TABLE_CURSOR [NATURAL, !STRING]
			l_tag, l_token: !STRING
			i: INTEGER
			l_child: TAG_BASED_TREE_NODE [G]
		do
			l_cursor ?= descending_tags.new_cursor
			retrieve_items
			create cached_children.make_default
			descending_tags := Void
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_tag := l_cursor.key
				i := l_tag.index_of (split_char, 1)
				if i > 0 then
					l_token := l_tag.substring (1, i - 1)
					l_tag := l_tag.substring (i + 1, l_tag.count)
				else
					l_token := l_tag
				end
				cached_children.search (l_token)
				if not cached_children.found then
					add_child (l_token)
					l_child := last_added_child
				else
					l_child := cached_children.found_item
				end

				check
					child_not_cached: not l_child.is_cached
				end
				if i > 0 then
					l_child.descending_tags.put (l_cursor.item, l_tag)
				else
					l_child.set_item_count (l_cursor.item)
				end
				l_cursor.forth
			end
			descending_tags := Void
		ensure
			cached: is_cached
		end

	retrieve_items
			-- Fill `cached_items' with items from collection observed by `tree' tagged with `tag'.
		require
			not_cached: not is_cached
		local
			l_collection: !ACTIVE_COLLECTION_I [G]
		do
			if item_count > 0 then
				l_collection := tree.observed_collection
				if {l_cursor: !DS_LINEAR_CURSOR [G]} l_collection.items.new_cursor then
					create cached_items.make_default
					from
						l_cursor.start
					until
						l_cursor.after
					loop
						if {l_item: !G} l_cursor.item then
							if l_item.tags.has (tag) then
								cached_items.put (l_item)
							end
						end
						l_cursor.forth
					end
				end
			end
		ensure
			items_count_equals_old_item_count: old item_count = items.count
		end

invariant
	cached_equals_children_attached: is_cached = (cached_children /= Void)
	cached_equals_items_attached: is_cached = (cached_items /= Void)

end
