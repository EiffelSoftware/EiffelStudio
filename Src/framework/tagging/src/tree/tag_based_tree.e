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
	TAG_BASED_TREE_NODE_CONTAINER [G]
		rename
			tag as tag_prefix
		end

	ACTIVE_COLLECTION_OBSERVER [G]
		redefine
			on_item_added,
			on_item_removed,
			on_item_changed,
			on_items_reset
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create internal_untagged_items.make_default
		ensure
			not_connected: not is_connected
		end

feature -- Access

	tag_prefix: !STRING
			-- Tag defining which tag are used to build tree
		local
			l_result: like internal_prefix
		do
			l_result := internal_prefix
			if l_result = Void then
				Result := once ""
			else
				Result := l_result
			end
		ensure then
			not_connected_implies_empty: not is_connected implies Result.is_empty
		end

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

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Access

	collection: !ACTIVE_COLLECTION_I [G]
			-- Collection for which tree is maintained
		require
			usable: is_interface_usable
			connected: is_connected
		local
			l_collection: like internal_collection
		do
			l_collection := internal_collection
			check l_collection /= Void end
			Result := l_collection
		end

	tree: !TAG_BASED_TREE [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Access

	internal_prefix: ?STRING
			-- Internal storage for `prefix'

	internal_collection: ?ACTIVE_COLLECTION_I [G]
			-- Internal storage for `observed_collection'

	internal_untagged_items: !DS_HASH_SET [!G]
			-- Items which do not contain a tag prefixed with `tag'

feature -- Status report

	is_connected: BOOLEAN
			-- Is tree currently connected with an active collection?
		do
			Result := internal_collection /= Void and then
				internal_prefix /= Void
		ensure then
			result_implies_collection_attached: Result implies internal_collection /= Void
			result_implies_prefix_attached: Result implies internal_prefix /= Void
			result_implies_connected: Result implies collection.is_connected (Current)
		end

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := not is_connected or else collection.is_interface_usable
		ensure then
			not_connected_implies_true: not is_connected implies Result
		end

	frozen is_root: BOOLEAN = True
			-- <Precursor>

feature -- Status setting

	connect (a_collection: like collection; a_prefix: like tag_prefix) is
			-- Build tree for collection and given tag.
			--
			-- `a_collection': Active collection containing items for which tree shall be built.
			-- `a_prefix': The tree will search for tags in the collection beginning with `a_prefix'. For
			--             each tag found, it will insert a leaf holding the corresponding item. The path to
			--             the leaf is represented by the remaining suffix, which is the original tag
			--             without the leading prefix.
			--             Items which were not tagged with a tag beginning with `a_prefix', are provided
			--             in a separate untagged list.
		require
			not_connected: not is_connected
			a_collection_usable: a_collection.is_interface_usable
			a_tag_valid: is_valid_tag (a_prefix)
		do
			internal_collection := a_collection
			internal_prefix := a_prefix
			collection.connect_events (Current)
			fill
		ensure
			connected: is_connected
			collection_set: collection = a_collection
		end

	disconnect is
			-- Disconnect from `collection' and clear tree
		require
			connected: is_connected
		do
			wipe_out
			collection.disconnect_events (Current)
			internal_collection := Void
			internal_prefix := Void
		ensure
			not_connected: not is_connected
		end

feature {NONE} -- Element change

	add_untagged_item (a_item: !G) is
			-- Add `a_item' to `untagged_items'.
		require
			a_item_not_added: not untagged_items.has (a_item)
			a_item_valid: tag_suffixes (a_item.tags, tag_prefix).is_empty
		do
			internal_untagged_items.force (a_item)
		ensure
			a_item_added: untagged_items.has (a_item)
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

	wipe_out is
			-- Wipe out all nodes and items.
		do
			cached_children := Void
			cached_items := Void
			item_count := 0
			internal_untagged_items.wipe_out
			create descending_tags.make_default
		ensure
			empty: is_empty
		end

	fill is
			-- Add all items from `observed_collection' to tree.
		require
			empty: is_empty
			connected: is_connected
			collection_usable: collection.is_interface_usable
		do
			if collection.are_items_available then
				collection.items.do_all (agent on_item_added (collection, ?))
			end
		end

feature {NONE} -- Events

	frozen on_item_added (a_collection: like collection; a_item: !G)
			-- <Precursor>
		require else
			a_collection_valid: a_collection = collection
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

	frozen on_item_removed (a_collection: like collection; a_item: !G)
			-- <Precursor>
		require else
			a_collection_valid: a_collection = collection
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

	frozen on_item_changed (a_collection: like collection; a_item: !G) is
			-- <Precursor>
		require else
			a_collection_valid: a_collection = collection
		local
			l_tags, l_unchanged_tags: !DS_HASH_SET [!STRING]
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
			l_unchanged_tags := tag_suffixes (a_item.tags, tag_prefix)
			if not l_tags.is_empty then
				l_tags.do_all (agent remove_tag_for_item (?, a_item))
				if not l_is_tagged then
					if l_unchanged_tags.is_empty then
						add_untagged_item (a_item)
					end
				end
			end
			if not l_unchanged_tags.is_empty then
				l_unchanged_tags.do_all (agent propagate_item_change (?, a_item))
			end
		end

	frozen on_items_reset (a_collection: like collection)
			-- <Precursor>
		require else
			a_collection_valid: a_collection = collection
		do
			wipe_out
		ensure then
			not_cached: not is_evaluated
			descending_tags_empty: descending_tags.is_empty
			untagged_items_empty: untagged_items.is_empty
		end

end
