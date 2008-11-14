indexing
	description: "[
		Objects that represent a node in {TAG_BASED_TREE} that can have child nodes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_BASED_TREE_NODE_CONTAINER [G -> TAGABLE_I]

inherit
	TAG_UTILITIES

	USABLE_I

feature -- Access

	frozen children: !DS_LINEAR [like child_for_token]
			-- Child nodes of `Current'
		require
			usable: is_interface_usable
		local
			l_cached: like cached_children
		do
			if not is_evaluated then
				compute_descendants
			end
			l_cached := cached_children
			check l_cached /= Void end
			Result := l_cached
		ensure
			results_valid: ({!DS_LINEAR [like child_for_token]} #? Result).for_all (
				agent (a_child: like child_for_token): BOOLEAN
					do
						Result := a_child.tree = tree and then
							cached_children.item (a_child.token) = a_child
					end)
		end

	frozen items: !DS_LINEAR [!G]
			-- Items tagged with `tag'
		require
			usable: is_interface_usable
		local
			l_items: like cached_items
		do
			if not is_evaluated then
				compute_descendants
			end
			l_items := cached_items
			check l_items /= Void end
			Result := l_items
		ensure
			results_valid: ({!DS_LINEAR [!G]} #? Result).for_all (
				agent (a_item: !G): BOOLEAN
					do
						Result := a_item.tags.has (tag)
					end)
		end

	tag: !STRING
			-- Tag which `Current' represents
		require
			usable: is_interface_usable
		deferred
		ensure
			result_valid: is_valid_tag (Result)
			empty_implies_root: Result.is_empty implies is_root
		end

	token: !STRING
			-- Token represented by `Current'
		require
			usable: is_interface_usable
			not_root: not is_root
		do
		ensure
			valid: is_valid_token (Result)
		end

	parent: !TAG_BASED_TREE_NODE_CONTAINER [G]
			-- Node listing `Current' as one of its children
		require
			usable: is_interface_usable
			not_root: not is_root
		do
		ensure
			usable: Result.is_interface_usable
		end

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Acccess

	tree: !TAG_BASED_TREE [G]
			-- Tree in which `Current' represents a node
		require
			usable: is_interface_usable
		deferred
		end

	descending_tags: ?DS_HASH_TABLE [NATURAL, !STRING]
			-- Tag suffixes of all tags found in collection with begin with `tag'.

	item_count: NATURAL
			-- Number of items which are tagged with `tag'

feature {NONE} -- Access

	cached_children: ?DS_HASH_TABLE [like child_for_token, !STRING]
			-- Children having `tag' as prefix

	cached_items: ?DS_HASH_SET [!G]
			-- Items tagged with `tag'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		deferred
		end

	is_root: BOOLEAN
			-- Does `Current' represent the root of the tree?
		require
			usable: is_interface_usable
		deferred
		end

	has_child_for_token (a_token: !STRING): BOOLEAN
			-- Does `Current' contain a child for `a_token'?
		require
			usable: is_interface_usable
			a_token_is_valid: is_valid_token (a_token)
		do
			if not is_evaluated then
				compute_descendants
			end
			Result := cached_children.has (a_token)
		end

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Status report

	is_evaluated: BOOLEAN
			-- Have child nodes for `Current' been computed yet?
		require
			usable: is_interface_usable
		do
			Result := cached_items /= Void and cached_children /= Void
		ensure
			result_correct: Result implies cached_items /= Void
			result_correct: Result implies cached_children /= Void
		end

	is_empty: BOOLEAN
			-- Does `Current' have no children or items?
		require
			usable: is_interface_usable
		do
			if is_evaluated then
				Result := children.is_empty and items.is_empty
			else
				Result := item_count = 0 and descending_tags.is_empty
			end
		end

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Status setting

	set_item_count (a_item_count: NATURAL)
			-- Set `item_count' to `a_item_count'.
		require
			usable: is_interface_usable
		do
			item_count := a_item_count
		ensure
			item_count_set: item_count = a_item_count
		end

feature -- Query

	child_for_token (a_token: !STRING): !TAG_BASED_TREE_NODE [G]
			-- Item in `children' for `a_token'.
		require
			usable: is_interface_usable
			a_token_valid: is_valid_token (a_token)
			has_child_for_token: has_child_for_token (a_token)
		do
			Result := cached_children.item (a_token)
		ensure
			result_has_token: Result.token.is_equal (a_token)
		end

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Element change

	insert_tag_for_item (a_tag: !STRING; a_item: !G) is
			-- Recursively add tag for given item to subtree represented by `Current'.
			--
			-- `a_tag': Suffix of original tag that has `tag' as prefix
			-- `a_item': Given item tagged with original tag
		require
			usable: is_interface_usable
			a_tag_valid: is_valid_tag (a_tag)
			a_item_tagged: a_item.tags.has (join_tags (tag, a_tag))
		local
			l_token, l_suffix: !STRING
		do
			if a_tag.is_empty then
				if is_evaluated then
					add_item (a_item)
				else
					item_count := item_count + 1
				end
			else
				if is_evaluated then
					l_token := first_token (a_tag)
					l_suffix := suffix (l_token, a_tag)
					if not has_child_for_token (l_token) then
						add_child (l_token)
					end
					child_for_token (l_token).insert_tag_for_item (l_suffix, a_item)
				else
					descending_tags.search (a_tag)
					if descending_tags.found then
						descending_tags.force (descending_tags.found_item + 1, a_tag)
					else
						descending_tags.force (1, a_tag)
					end
				end
			end
		ensure
			inserted: (not a_tag.is_empty and not is_evaluated) implies descending_tags.has (a_tag)
			inserted: (not a_tag.is_empty and is_evaluated) implies has_child_for_token (first_token (a_tag))
			inserted: (a_tag.is_empty and not is_evaluated) implies item_count = old item_count + 1
			inserted: (a_tag.is_empty and is_evaluated) implies cached_items.has (a_item)
		end

	remove_tag_for_item (a_tag: !STRING; a_item: !G) is
			-- Recursively remove tag for given item from subtree represented by `Current'.
			--
			-- `a_tag': Suffix of original tag that has `tag' as prefix
			-- `a_item': Item for which tag shall be removed
		require
			usable: is_interface_usable
			a_tag_valid: is_valid_tag (a_tag)
		local
			l_child: like child_for_token
			l_token, l_suffix: !STRING
		do
			if a_tag.is_empty then
				if is_evaluated then
					remove_item (a_item)
				else
					item_count := item_count - 1
					check
						not_item_count_negative: item_count >= 0
					end
				end
			else
				if is_evaluated then
					l_token := first_token (a_tag)
					l_suffix := suffix (l_token, a_tag)
					l_child := child_for_token (l_token)
					l_child.remove_tag_for_item (l_suffix, a_item)
					if l_child.is_empty then
						remove_child (l_token)
					end
				else
					descending_tags.search (a_tag)
					if descending_tags.found_item = 1 then
						descending_tags.remove_found_item
					else
						descending_tags.put (descending_tags.found_item - 1, a_tag)
					end
				end
			end
		ensure
			item_removed: (a_tag.is_empty and not is_evaluated) implies item_count = old item_count - 1
			item_removed: (a_tag.is_empty and is_evaluated) implies not cached_items.has (a_item)
		end

	add_item (a_item: !G) is
			-- Add item to `items'
		require
			usable: is_interface_usable
			evaluated: is_evaluated
			a_item_valid: a_item.tags.has (tag)
			a_item_not_added: not items.has (a_item)
		do
			cached_items.force (a_item)
		ensure
			a_item_added: items.has (a_item)
		end

	remove_item (a_item: !G)
			-- Remove item from `items'
		require
			usable: is_interface_usable
			evaluated: is_evaluated
			a_item_added: items.has (a_item)
		do
			cached_items.remove (a_item)
		ensure
			a_item_removed: not items.has (a_item)
		end

	propagate_item_change (a_tag: !STRING; a_item: !G) is
			-- Notify nodes representing tag that an item has changed.
		require
			usable: is_interface_usable
			a_tag_valid: is_valid_tag (a_tag)
		local
			l_token: !STRING
		do
			if is_evaluated then
				if not a_tag.is_empty then
					l_token := first_token (a_tag)
					child_for_token (l_token).propagate_item_change (suffix (l_token, a_tag), a_item)
				end
			end
		end

feature {NONE} -- Element change

	add_child (a_token: !STRING) is
			-- Add child to node in `Current'
		require
			usable: is_interface_usable
			evaluated: is_evaluated
			a_token_valid: is_valid_token (a_token)
			a_token_new: not has_child_for_token (a_token)
		local
			l_child: like child_for_token
		do
			create l_child.make (Current, a_token)
			cached_children.force (l_child, a_token)
		ensure
			child_added: has_child_for_token (a_token)
			child_not_evaluated: not child_for_token (a_token).is_evaluated
			child_empty: child_for_token (a_token).is_empty
		end

	remove_child (a_token: !STRING) is
			-- Remove child for `a_token'
		require
			usable: is_interface_usable
			evaluated: is_evaluated
			a_token_valid: is_valid_token (a_token)
			has_child_for_token: has_child_for_token (a_token)
		do
			cached_children.remove (a_token)
		ensure
			child_removed: not has_child_for_token (a_token)
		end

feature {TAG_BASED_TREE} -- Implementation

	compute_descendants is
			-- Use tags in `descending_tags' to compute children.
		require
			usable: is_interface_usable
			not_evaluated: not is_evaluated
		local
			l_cursor: DS_HASH_TABLE_CURSOR [NATURAL, !STRING]
			l_tag, l_token: !STRING
			i: INTEGER
			l_child: like child_for_token
		do
			l_cursor := descending_tags.new_cursor
			descending_tags := Void
			create cached_children.make_default
			create cached_items.make (item_count.as_integer_32)
			retrieve_items
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
				if not has_child_for_token (l_token) then
					add_child (l_token)
				end
				l_child := child_for_token (l_token)

				check
					child_not_evaluated: not l_child.is_evaluated
				end
				if i > 0 then
					l_child.descending_tags.force (l_cursor.item, l_tag)
				else
					l_child.set_item_count (l_cursor.item)
				end
				l_cursor.forth
			end
		ensure
			evaluated: is_evaluated
		end

feature {NONE} -- Implementation

	retrieve_items
			-- Fill `cached_items' with items from collection observed by `tree' tagged with `tag'.
		require
			usable: is_interface_usable
			collection_usable: tree.collection.is_interface_usable
			evaluated: is_evaluated
		local
			l_collection: !ACTIVE_COLLECTION_I [G]
			l_cursor: DS_LINEAR_CURSOR [G]
		do
			if item_count > 0 then
				l_collection := tree.collection
				l_cursor := l_collection.items.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					if {l_item: !G} l_cursor.item then
						if l_item.tags.has (tag) then
							add_item (l_item)
						end
					end
					if cached_items.count.as_natural_32 = item_count then
						l_cursor.go_after
					else
						l_cursor.forth
					end
				end
			end
		ensure
			correct_item_count: items.count.as_natural_32 = old item_count
		end

invariant
	not_evaluated_implies_descending_tags_attached:
		(is_interface_usable and then not is_evaluated) implies descending_tags /= Void

end
