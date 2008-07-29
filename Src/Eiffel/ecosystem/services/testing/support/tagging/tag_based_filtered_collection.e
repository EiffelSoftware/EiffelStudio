indexing
	description: "[
		Filtered subset of an active collection which represents an active collection itself. Subset is
		defined by an expression used to filter the items.
		
		Filtering is based on defined tags in each of the itmes. The interface is a collection and
		observer at the same time. That way changes in the original collection will be applied to the 
		filtered collection imediatly.
		
		The filter uses a cache and only evaluates it on demand. So if the observered collection changes
		or a new expression is set, the cache only gets reevaluated if a client accesses the items.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_BASED_FILTERED_COLLECTION [G -> TAGABLE_I]

inherit
	ACTIVE_COLLECTION_I [G]

	ACTIVE_COLLECTION_OBSERVER [G]
		redefine
			on_item_added,
			on_item_changed,
			on_item_removed,
			on_items_reset
		end

	EVENT_OBSERVER_CONNECTION [!ACTIVE_COLLECTION_OBSERVER [G]]
		redefine
			is_interface_usable
		end

create
	make

feature {NONE} -- Initialization

	make (a_collection: like observed_collection; a_expression: STRING) is
			-- Initialize `Current'.
			--
			-- `a_collection': Filter items of `a_collection' and make them available through `items'.
			-- `a_expression': Expression used as filter criteria
		require
			a_collection_usable: a_collection.is_interface_usable
			a_expression_not_empty: not a_expression.is_empty
		do
			create item_added_event
			create item_removed_event
			create item_changed_event
			create items_reset_event

			observed_collection := a_collection
			set_expression (a_expression)
		end

feature -- Access

	items: !DS_LINEAR [!G]
			-- <Precursor>
		do
			if cached_items = Void then
				fill_cache
			end
			Result ?= cached_items
		ensure then
			results_match_expression: Result.for_all (agent matches)
		end

feature {NONE} -- Access

	cached_items: ?DS_HASH_SET [!G]
			-- Cache holding items currently matching expression

	observed_collection: !ACTIVE_COLLECTION_I [G]
			-- Collection beeing filtered

	regex: !RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression used to filter items

feature -- Status report

	are_items_available: BOOLEAN = True
			-- <Precursor>

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {EVENT_OBSERVER_CONNECTION} and
				observed_collection.is_interface_usable and then
				observed_collection.is_connected (Current)
		end

feature -- Status setting

	set_expression (a_expression: STRING)
			-- Set `expression' to `a_expression' and
			-- update `items' accordingly
		require
			expression_not_empty: not a_expression.is_empty
		do
			regex.compile (a_expression)
			refresh
		end

feature -- Events

	item_added_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- <Precursor>

	item_removed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- <Precursor>

	item_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- <Precursor>

	items_reset_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]]]
			-- <Precursor>

feature {ACTIVE_COLLECTION_I} -- Events

	on_item_added (a_collection: like observed_collection; an_item: !G)
			-- <Precursor>
		do
			if cached_items /= Void then
				if matches (an_item) then
					cached_items.put (an_item)
					item_added_event.publish ([Current, an_item])
				end
			else
				refresh
			end
		end

	on_item_removed (a_collection: like observed_collection; an_item: !G)
			-- <Precursor>
		do
			if cached_items /= Void then
				cached_items.search (an_item)
				if cached_items.found then
					cached_items.remove_found_item
					item_removed_event.publish ([Current, an_item])
				end
			else
				refresh
			end
		end

	on_item_changed (a_collection: like observed_collection; an_item: !G)
			-- <Precursor>
		do
			if cached_items /= Void then
				cached_items.search (an_item)
				if cached_items.found then
					if matches (an_item) then
						item_changed_event.publish ([Current, an_item])
					else
						cached_items.remove_found_item
						item_removed_event.publish ([Current, an_item])
					end
				elseif matches (an_item) then
					cached_items.put (an_item)
					item_added_event.publish ([Current, an_item])
				end
			else
				refresh
			end
		end

	on_items_reset (a_collection: like observed_collection)
			-- <Precursor>
		do
			refresh
		end

feature {NONE} -- Query

	matches (an_item: !G): BOOLEAN
			-- Does `an_item' match `expression'?
		do
			Result := an_item.tags.there_exists ({FUNCTION [ANY, TUPLE [!STRING], BOOLEAN]} #? agent regex.matches)
		end

feature {NONE} -- Implementation

	refresh
			-- Rebuild `items' corresponding to items `observerd_collection'.
		do
			cached_items := Void
			items_reset_event.publish ([Current])
		end

	fill_cache
			-- Initialize `cached_items' and put all items of `observed_collection' for which `matches'
			-- returns True into `cached_items'.
		do
			create cached_items.make_default
			observed_collection.items.do_all (
				agent (an_item: !G)
					do
						if matches (an_item) then
							cached_items.put (an_item)
						end
					end)
		ensure
			cached_items_attached: cached_items /= Void
				-- All items in `observerd_collection' are also in `cached_items' if and only if they match
			cached_items_valid: observed_collection.items.for_all (
				agent (an_item: !G): BOOLEAN
					do
						Result := matches (an_item) = cached_items.has (an_item)
					end)
		end

invariant
	regex_compiled: regex.is_compiled

end
