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
		rename
			is_connected as is_observer_connected,
			are_items_available as is_connected
		end

	ACTIVE_COLLECTION_OBSERVER [G]
		redefine
			on_item_added,
			on_item_changed,
			on_item_removed,
			on_items_reset
		end

	EVENT_OBSERVER_CONNECTION [!ACTIVE_COLLECTION_OBSERVER [G]]
		rename
			is_connected as is_observer_connected
		redefine
			is_interface_usable
		end

	TAG_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create item_added_event
			create item_removed_event
			create item_changed_event
			create items_reset_event

			create positive_matchers.make_default
			create negative_matchers.make_default

			create internal_items.make_default
		end

feature -- Access

	items: !DS_LINEAR [!G]
			-- <Precursor>
		local
			l_empty: like empty_items
		do
			if has_expression then
				Result := internal_items
			elseif collection.are_items_available then
				Result := collection.items
			else
				l_empty := empty_items
				if l_empty = Void then
					create l_empty.make (0)
					empty_items := l_empty
				end
				Result := l_empty
			end
		ensure then
			results_match_expression: has_expression implies Result.for_all (agent (a_item: !G): BOOLEAN do Result := matches (a_item) end)
		end

	collection: !like internal_collection
			-- Collection being filtered
		require
			connected: is_connected
		local
			l_collection: like internal_collection
		do
			l_collection := internal_collection
			check l_collection /= Void end
			Result := l_collection
		ensure
			observing: Result.is_connected (Current)
		end

	expression: !STRING
			-- Last expression set through `set_expression'.
		require
			has_expression: has_expression
		local
			l_expr: like internal_expression
		do
			l_expr := internal_expression
			check l_expr /= Void end
			Result := l_expr
		end

feature {NONE} -- Access

	internal_items: !DS_HASH_SET [!G]
			-- Cache holding items currently matching expression

	internal_collection: ?ACTIVE_COLLECTION_I [G]
			-- Collection beeing filtered

	internal_expression: ?like expression
			-- Last defined expression

	positive_matchers: !DS_ARRAYED_LIST [!RX_PCRE_REGULAR_EXPRESSION]
			-- Regular expressions which item must match to be in `items'

	negative_matchers: !DS_ARRAYED_LIST [!RX_PCRE_REGULAR_EXPRESSION]
			-- Regular expressions which item must not match to be in `items'

	empty_items: ?DS_ARRAYED_LIST [!G]
			-- Empty list of items

feature -- Status report

	is_connected: BOOLEAN
			-- <Precursor>
		do
			Result := internal_collection /= Void
		end

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {EVENT_OBSERVER_CONNECTION}
			if Result and is_connected then
				Result := collection.is_interface_usable
			end
		end

	has_expression: BOOLEAN
			-- Is there any expression currently defined?
		do
			Result := not (positive_matchers.is_empty and negative_matchers.is_empty)
		end

feature -- Status setting

	set_expression (a_expression: like expression)
			-- Set `expression' to `a_expression' and
			-- update `items' accordingly
		require
			expression_not_empty: not a_expression.is_empty
		local
			l_had_expr: BOOLEAN
		do
			internal_expression := a_expression
			l_had_expr := has_expression
			positive_matchers.wipe_out
			negative_matchers.wipe_out
			add_matchers (a_expression)
			update (l_had_expr)
		end

	remove_expression
			-- Remove all expressions and disable filtering.
		local
			l_had_expr: BOOLEAN
		do
			l_had_expr := has_expression
			internal_expression := Void
			positive_matchers.wipe_out
			negative_matchers.wipe_out
			update (l_had_expr)
		ensure
			not_has_expression: not has_expression
		end

	connect (a_collection: like collection) is
			-- Connect to `a_collection' and filter its items.
		require
			a_collection_usable: a_collection.is_interface_usable
			not_connected: not is_connected
		do
			internal_collection := a_collection
			internal_collection.connect_events (Current)
			update (False)
		end

	disconnect
			-- Disconnect from `collection'.
		require
			connected: is_connected
		do
			collection.disconnect_events (Current)
			internal_collection := Void
			items_reset_event.publish ([Current])
		end

feature -- Events

	item_added_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; active: !G]]
			-- <Precursor>

	item_removed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; active: !G]]
			-- <Precursor>

	item_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; active: !G]]
			-- <Precursor>

	items_reset_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]]]
			-- <Precursor>

feature {ACTIVE_COLLECTION_I} -- Events

	on_item_added (a_collection: like collection; an_item: !G)
			-- <Precursor>
		do
			if has_expression then
				if matches (an_item) then
					internal_items.force (an_item)
					item_added_event.publish ([Current, an_item])
				end
			else
				item_added_event.publish ([Current, an_item])
			end
		end

	on_item_removed (a_collection: like collection; an_item: !G)
			-- <Precursor>
		do
			if has_expression then
				internal_items.search (an_item)
				if internal_items.found then
					internal_items.remove_found_item
					item_removed_event.publish ([Current, an_item])
				end
			else
				item_removed_event.publish ([Current, an_item])
			end
		end

	on_item_changed (a_collection: like collection; an_item: !G)
			-- <Precursor>
		do
			if has_expression then
				internal_items.search (an_item)
				if internal_items.found then
					if matches (an_item) then
						item_changed_event.publish ([Current, an_item])
					else
						internal_items.remove_found_item
						item_removed_event.publish ([Current, an_item])
					end
				elseif matches (an_item) then
					internal_items.force (an_item)
					item_added_event.publish ([Current, an_item])
				end
			else
				item_changed_event.publish ([Current, an_item])
			end
		end

	on_items_reset (a_collection: like collection)
			-- <Precursor>
		do
			internal_items.wipe_out
			items_reset_event.publish ([Current])
		end

feature {NONE} -- Query

	matches (an_item: G): BOOLEAN is
			-- Does `an_item' match `expression'?
		require
			has_expression: has_expression
		local
			l_done: BOOLEAN
		do
			l_done := tag_matches_regexes (an_item.name, negative_matchers)
			from
				an_item.tags.start
			until
				l_done or an_item.tags.after
			loop
				l_done := tag_matches_regexes (an_item.tags.item_for_iteration, negative_matchers)
				an_item.tags.forth
			end
			if not l_done then
				Result := True
				if not positive_matchers.is_empty then
					from
						positive_matchers.start
					until
						positive_matchers.after or not Result
					loop
						Result := positive_matchers.item_for_iteration.matches (an_item.name)
						if not Result then
							Result := tags_match_regex (an_item.tags, positive_matchers.item_for_iteration)
						end
						positive_matchers.forth
					end
				end
			end
		end

	tag_matches_regexes (a_tag: !STRING; a_list: like positive_matchers): BOOLEAN
			-- Does `a_tag' match on of matchers in `a_list'?
		do
			if not a_list.is_empty then
				from
					a_list.start
				until
					Result or a_list.after
				loop
					Result := a_list.item_for_iteration.matches (a_tag)
					a_list.forth
				end
			end
		end

	tags_match_regex (a_list: !DS_LINEAR [!STRING]; a_regex: like create_matcher): BOOLEAN
			-- Does one of the tags satisfy a given regular expression?
		do
			if not a_list.is_empty then
				from
					a_list.start
				until
					Result or a_list.after
				loop
					Result := a_regex.matches (a_list.item_for_iteration)
					a_list.forth
				end
			end
		end

feature {NONE} -- Implementation

	update (a_had_expr: BOOLEAN)
			-- Initialize `cached_items' and put all items of `observed_collection' for which `matches'
			-- returns True into `cached_items'.
			--
			-- `a_had_expr': Should be set to True if `has_expression' was true the last time `update' was
			--               called.
		require
			connected: is_connected
		local
			l_cursor: DS_LINEAR_CURSOR [!G]
			l_removed, l_added: ?like internal_items
			l_expr, l_int: BOOLEAN
		do
			if collection.are_items_available then
				l_expr := has_expression
				from
					l_cursor := collection.items.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					l_int := False
					if l_expr then
						if matches (l_cursor.item) then
							l_int := True
						end
					end
					internal_items.search (l_cursor.item)
					if not internal_items.found and ((l_expr and l_int) or (not l_expr and a_had_expr)) then
						if l_expr then
							internal_items.force_last (l_cursor.item)
						end
						if a_had_expr then
							if l_added = Void then
								create l_added.make_default
							end
							l_added.force_last (l_cursor.item)
						end
					elseif l_expr and not l_int and (internal_items.found or not a_had_expr) then
						if l_removed = Void then
							create l_removed.make_default
						end
						if internal_items.found then
							internal_items.remove_found_item
						end
						l_removed.force_last (l_cursor.item)
					end
					l_cursor.forth
				end
				if l_added /= Void then
					from
						l_added.start
					until
						l_added.after
					loop
						if {l_added_g: G} l_added.item_for_iteration then
							item_added_event.publish ([Current, l_added_g])
						else
							check False end
						end
						l_added.forth
					end
				end
				if l_removed /= Void then
					from
						l_removed.start
					until
						l_removed.after
					loop
						if {l_removed_g: G} l_removed.item_for_iteration then
							item_removed_event.publish ([Current, l_removed_g])
						else
							check False end
						end
						l_removed.forth
					end
				end
			end
		end

	add_matchers (a_expr: !STRING) is
			-- Add matchers to `positive_matchers' and `negative_matchers' according to given expression.
			--
			-- `a_expression': Expression from which matchers are created.
		local
			i: INTEGER
			l_expr: ?STRING
			l_pos, l_add: BOOLEAN
			c: CHARACTER
			l_new: like create_matcher
		do
			from
				i := 1
			until
				i > a_expr.count
			loop
				c := a_expr.item (i)

				if not c.is_space then
					l_add := True
					if l_expr = Void then
						create l_expr.make (20)
						l_pos := True
						if c = '+' then
							l_add := False
						elseif c = '-' then
							l_add := False
							l_pos := False
						end
					end
					if l_add then
						if not c.is_alpha_numeric then
							if c = '*' then
								l_expr.append_character ('.')
							else
								l_expr.append_character ('\')
							end
						end
						l_expr.append_character (c)
					end
				end
				i := i + 1
				if i > a_expr.count or else a_expr.item (i).is_space then
					if l_expr /= Void then
						if not l_expr.is_empty then
							l_new := create_matcher (l_expr)
							if l_pos then
								positive_matchers.force_last (l_new)
							else
								negative_matchers.force_last (l_new)
							end
						end
						l_expr := Void
					end
				end
			end
		end

	create_matcher (a_expr: !STRING): !RX_PCRE_REGULAR_EXPRESSION
			-- Create new regular expression
		do
			create Result.make
			Result.set_caseless (True)
			Result.compile (a_expr)
		end

invariant
	positive_matchers_compiled: positive_matchers.for_all (agent {like create_matcher}.is_compiled)
	negative_matchers_compiled: negative_matchers.for_all (agent {like create_matcher}.is_compiled)

end
