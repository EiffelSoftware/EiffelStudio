note
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
			are_items_available as is_connected
		end

	DISPOSABLE_SAFE
		redefine
			is_interface_usable
		end

	ACTIVE_COLLECTION_OBSERVER [G]
		redefine
			on_item_added,
			on_item_changed,
			on_item_removed,
			on_items_reset
		end

	TAG_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create item_added_event
			automation.auto_dispose (item_added_event)
			create item_removed_event
			automation.auto_dispose (item_removed_event)
			create item_changed_event
			automation.auto_dispose (item_changed_event)
			create items_reset_event
			automation.auto_dispose (items_reset_event)

			create positive_matchers.make_default
			create negative_matchers.make_default

			create internal_items.make_default
		ensure
			not_has_expression: not has_expression
			not_connected: not is_connected
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				--| FIXME: Arno, correctly clean up resources	
			end
		end

feature -- Access

	items: attached DS_LINEAR [attached G]
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
			results_match_expression: has_expression implies Result.for_all (agent (a_item: attached G): BOOLEAN do Result := matches (a_item) end)
		end

	collection: attached like internal_collection
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
			observing: Result.active_collection_connection.is_connected (Current)
		end

	expression: attached STRING
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

	internal_items: attached DS_HASH_SET [attached G]
			-- Cache holding items currently matching expression

	internal_collection: detachable ACTIVE_COLLECTION_I [G]
			-- Collection beeing filtered

	internal_expression: detachable like expression
			-- Last defined expression

	positive_matchers: attached DS_ARRAYED_LIST [attached RX_PCRE_REGULAR_EXPRESSION]
			-- Regular expressions which item must match to be in `items'

	negative_matchers: attached DS_ARRAYED_LIST [attached RX_PCRE_REGULAR_EXPRESSION]
			-- Regular expressions which item must not match to be in `items'

	empty_items: detachable DS_ARRAYED_LIST [attached G]
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
			Result := Precursor and then (collection /= Void implies collection.is_interface_usable)
		ensure then
			collection_is_interface_usable: Result implies (collection = Void or else collection.is_interface_usable)
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
			if is_connected then
				update (l_had_expr)
			end
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
			if is_connected then
				update (l_had_expr)
			end
		ensure
			not_has_expression: not has_expression
		end

	connect (a_collection: like collection)
			-- Connect to `a_collection' and filter its items.
		require
			a_collection_usable: a_collection.is_interface_usable
			not_connected: not is_connected
		do
			internal_collection := a_collection
			internal_collection.active_collection_connection.connect_events (Current)
			update (False)
		end

	disconnect
			-- Disconnect from `collection'.
		require
			connected: is_connected
		do
			collection.active_collection_connection.disconnect_events (Current)
			internal_collection := Void
			items_reset_event.publish ([Current])
		end

feature -- Events

	item_added_event: attached EVENT_TYPE [TUPLE [collection: attached ACTIVE_COLLECTION_I [G]; active: attached G]]
			-- <Precursor>

	item_removed_event: attached EVENT_TYPE [TUPLE [collection: attached ACTIVE_COLLECTION_I [G]; active: attached G]]
			-- <Precursor>

	item_changed_event: attached EVENT_TYPE [TUPLE [collection: attached ACTIVE_COLLECTION_I [G]; active: attached G]]
			-- <Precursor>

	items_reset_event: attached EVENT_TYPE [TUPLE [collection: attached ACTIVE_COLLECTION_I [G]]]
			-- <Precursor>

feature {ACTIVE_COLLECTION_I} -- Events

	on_item_added (a_collection: like collection; an_item: attached G)
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

	on_item_removed (a_collection: like collection; an_item: attached G)
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

	on_item_changed (a_collection: like collection; an_item: attached G)
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

	matches (an_item: G): BOOLEAN
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

	tag_matches_regexes (a_tag: attached STRING; a_list: like positive_matchers): BOOLEAN
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

	tags_match_regex (a_list: attached DS_LINEAR [attached STRING]; a_regex: like create_matcher): BOOLEAN
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
			l_cursor: DS_LINEAR_CURSOR [attached G]
			l_removed, l_added: detachable like internal_items
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
						if attached {G} l_added.item_for_iteration as l_added_g then
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
						if attached {G} l_removed.item_for_iteration as l_removed_g then
							item_removed_event.publish ([Current, l_removed_g])
						else
							check False end
						end
						l_removed.forth
					end
				end
			end
		end

	add_matchers (a_expr: attached STRING)
			-- Add matchers to `positive_matchers' and `negative_matchers' according to given expression.
			--
			-- `a_expression': Expression from which matchers are created.
		local
			i: INTEGER
			l_expr: detachable STRING
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

feature {NONE} -- Factory

	create_matcher (a_expr: attached STRING): attached RX_PCRE_REGULAR_EXPRESSION
			-- Create new regular expression
		do
			create Result.make
			Result.set_caseless (True)
			Result.compile (a_expr)
		end

invariant
	positive_matchers_compiled: positive_matchers.for_all (agent {like create_matcher}.is_compiled)
	negative_matchers_compiled: negative_matchers.for_all (agent {like create_matcher}.is_compiled)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
