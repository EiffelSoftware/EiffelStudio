indexing
	description: "[
		Objects that take a collection of {TAGABLE_I} and create a tree based on their tags.
		
		The tree is defined through a prefix, which itself is a valid tag or simply empty. An empty
		prefix means the tree will contain all tags found in the collection. For each item in the
		collection, the tree will contain a branch for all suffixes of tags beginning with that prefix.
		Items not containing a tag beginning with the prefix will be stored in a list of untagged items.
		
		The tree is not completely built after defining the prefix. Childrens of a node in the tree are
		computed on demand.
		
		Example: two items in a collection are tagged each with one tag
		
			item1: platform.os.unix.x86_64
			item2: platform.os.unix.sparc
			item3: platform.proc.ia32
			
		The resulting tree for prefix `platform.os' would have the following structure:
		
			+ unix
				+ x86_64
					+ item1
				+ sparc
					+ item2
					
			untagged_items: {item3}

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_BASED_TREE [G -> TAGABLE_I]

inherit
	TAG_BASED_TREE_NODE_PARENT [G]
		rename
			tag as tag_prefix
		end

	ACTIVE_COLLECTION_OBSERVER [G]
		redefine
			on_item_added,
			on_item_removed,
			on_item_changed,
			on_items_wiped_out
		end

create
	make

feature {NONE} -- Initialization

	make (a_collection: like observed_collection; a_prefix: like tag_prefix)
			-- Initialize `Current'.
		require
			a_collection_usable: a_collection.is_interface_usable
			a_tag_valid: a_prefix.is_empty or else is_valid_tag (a_prefix)
		do
			observed_collection := a_collection
			create internal_untagged_items.make_default
			set_prefix (a_prefix)
		end

feature -- Access

	tag_prefix: !STRING
			-- Tag defining which tag are used to build tree

	frozen untagged_items: like items
			-- Items which do not contain a tag with prefix `tag'
		do
			Result := internal_untagged_items
		ensure
			results_valid: ({!DS_LINEAR [!G]} #? Result).for_all (
				agent (a_item: !G): BOOLEAN
					do
						Result := tag_suffixes (a_item.tags, tag_prefix).is_empty
					end)
		end

feature {TAG_BASED_TREE_NODE_PARENT} -- Access

	observed_collection: !ACTIVE_COLLECTION_I [G]
			-- Collection for which tree is maintained

	tree: !TAG_BASED_TREE [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Access

	internal_untagged_items: !DS_HASH_SET [!G]
			-- Items which do not contain a tag prefixed with `tag'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := observed_collection.is_interface_usable and then
				observed_collection.is_connected (Current)
		end

	frozen is_root: BOOLEAN = True
			-- <Precursor>

feature -- Status setting

	set_prefix (a_prefix: like tag_prefix)
			-- Set `tag_prefix' to `a_prefix' and rebuild tree with new prefix.
		do
			wipe_out
			tag_prefix := a_prefix
			observed_collection.items.do_all (agent on_item_added (observed_collection, ?))
		end

feature {NONE} -- Query

	node_for_tag (a_tag: !STRING): !TAG_BASED_TREE_NODE_PARENT [G] is
			-- Last cached node for `a_tag'
		require
			a_tag_valid: is_valid_tag (a_tag)
			tag_is_prefix_of_a_tag: is_prefix (tag_prefix, a_tag)
		local
			l_tag, l_token: !STRING
		do
			from
				Result := Current
				l_tag := a_tag
			until
				not Result.is_cached or else l_tag.is_empty
			loop
				l_token := first_token (l_tag)
				if Result.has_child_for_token (l_token) then
					Result := Result.child_for_token (l_token)
					if l_tag.is_equal (l_token) then
						l_tag := ""
					else
						l_tag := suffix (l_token, l_tag)
					end
				else
					l_tag := ""
				end
			end
		ensure
			result_tag_prefix: is_prefix (Result.tag, a_tag)
				-- Postcondition stating that if no node with the exact tag was found, the last node was either
				-- not cached, or there was no child in the last node for the next token in `a_tag'.
			not_equal_implies_not_cached_or_no_child: not Result.tag.is_equal (a_tag) implies (not Result.is_cached
				or else not Result.has_child_for_token (first_token (suffix (Result.tag, a_tag))))
		end

feature {NONE} -- Element change

	add_untagged_item (a_item: !G) is
			-- Add `a_item' to `untagged_items'.
		require
			a_item_not_added: not untagged_items.has (a_item)
			a_item_valid: tag_suffixes (a_item.tags, tag_prefix).is_empty
		do
			internal_untagged_items.put (a_item)
		ensure
			a_item_added: untagged_items.has (a_item)
		end

	insert_tag_for_item (a_tag: !STRING; a_item: !G) is
			-- Insert item into tree at location `a_tag'
		require
			a_tag_valid: is_valid_tag (a_tag)
			a_item_valid: a_item.tags.has (a_tag)
		local
			l_node: !TAG_BASED_TREE_NODE_PARENT [G]
			l_tag, l_token: !STRING
			n: NATURAL
		do
			l_node := node_for_tag (a_tag)
			l_tag := a_tag
			if l_node.is_cached then
				if l_node.tag.is_equal (l_tag) then
					l_node.add_item (a_item)
				else
					l_token := first_token (l_tag)
					l_node.add_child (l_token)
					l_node ?= l_node.last_added_child
					l_tag := suffix (l_token, l_tag)
				end
			end
			if not l_node.is_cached then
				if l_node.tag.is_equal (l_tag) then
					n := l_node.item_count
					l_node.set_item_count (n + 1)
				else
					l_node.descending_tags.search (l_tag)
					if l_node.descending_tags.found then
						n := l_node.descending_tags.found_item + 1
					else
						n := 1
					end
					l_node.descending_tags.put (n, l_tag)
				end
			end
		end

	remove_untagged_item (a_item: !G)
			-- Remove `a_item' from `untagged_items'.
		require
			a_item_added: untagged_items.has (a_item)
		do
			internal_untagged_items.remove (a_item)
		ensure
			a_item_removed: not untagged_items.has (a_item)
		end

	remove_tag_for_item (a_tag: !STRING; a_item: !G) is
			-- Remove item from tree located at `a_tag'
		require
			a_tag_valid: is_valid_tag (a_tag)
		local
			l_node: !TAG_BASED_TREE_NODE_PARENT [G]
			n: NATURAL
			l_token: !STRING
		do
			l_node := node_for_tag (a_tag)
			check
				tag_exists: l_node.tag.is_equal (a_tag) or (not l_node.is_cached and then
					l_node.descending_tags.has (suffix (l_node.tag, a_tag)))
			end
			if l_node.tag.is_equal (a_tag) then
				if l_node.is_cached then
					check
						item_was_added: l_node.items.has (a_item)
					end
					l_node.remove_item (a_item)
				else
					n := l_node.item_count
					l_node.set_item_count (n - 1)
				end
			else
				check
					tag_was_added: not l_node.is_cached
				end
				l_node.descending_tags.search (suffix (l_node.tag, a_tag))
				check
					tag_was_added: l_node.descending_tags.found
				end
				n := l_node.descending_tags.found_item
				if n = 1 then
					l_node.descending_tags.remove_found_item
				else
					l_node.descending_tags.put (n - 1, l_node.descending_tags.found_key)
				end
			end
			if not (l_node.is_root or n > 1) then
				 from
				 	l_token := l_node.token
				 	l_node := l_node.parent
				 until
				 	not (l_node.children.count = 1 and l_node.items.is_empty) or l_node.is_root
				 loop
					l_token := l_node.token
					l_node := l_node.parent
				 end
				 l_node.remove_child (l_token)
			end
		end

	wipe_out is
			-- Wipe out all nodes and items.
		do
			cached_children := Void
			cached_items := Void
			item_count := 0
			internal_untagged_items.wipe_out
		ensure
			not_cached: not is_cached
			descending_tags_empty: descending_tags.is_empty
			untagged_items_empty: untagged_items.is_empty
		end

feature {NONE} -- Events

	frozen on_item_added (a_collection: like observed_collection; a_item: !G)
			-- <Precursor>
		require else
			a_collection_valid: a_collection = observed_collection
		local
			l_tags: !DS_HASH_SET [!STRING]
		do
			l_tags := tag_suffixes (a_item.tags, tag_prefix)
			if l_tags.is_empty then
				add_untagged_item (a_item)
			else
				l_tags.do_all (agent insert_tag_for_item (?, a_item))
			end
		end

	frozen on_item_removed (a_collection: like observed_collection; a_item: !G)
			-- <Precursor>
		require else
			a_collection_valid: a_collection = observed_collection
		local
			l_tags: !DS_HASH_SET [!STRING]
		do
			l_tags := tag_suffixes (a_item.tags, tag_prefix)
			if l_tags.is_empty then
				remove_untagged_item (a_item)
			else
				l_tags.do_all (agent remove_tag_for_item (?, a_item))
			end
		end

	frozen on_item_changed (a_collection: like observed_collection; a_item: !G) is
			-- <Precursor>
		require else
			a_collection_valid: a_collection = observed_collection
		local
			l_tags: !DS_HASH_SET [!STRING]
			l_is_tagged: BOOLEAN
		do
			l_tags := tag_suffixes (a_item.memento.added_tags, tag_prefix)
			if not l_tags.is_empty then
				l_tags.do_all (agent insert_tag_for_item (?, a_item))
				if untagged_items.has (a_item) then
					remove_untagged_item (a_item)
				end
				l_is_tagged := True
			end
			l_tags := tag_suffixes (a_item.memento.removed_tags, tag_prefix)
			if not l_tags.is_empty then
				l_tags.do_all (agent remove_tag_for_item (?, a_item))
				if not l_is_tagged then
					l_tags := tag_suffixes (a_item.tags, tag_prefix)
					if l_tags.is_empty then
						add_untagged_item (a_item)
					end
				end
			end
		end

	frozen on_items_wiped_out (a_collection: like observed_collection)
			-- <Precursor>
		require else
			a_collection_valid: a_collection = observed_collection
		do
			wipe_out
		ensure then
			not_cached: not is_cached
			descending_tags_empty: descending_tags.is_empty
			untagged_items_empty: untagged_items.is_empty
		end

end
