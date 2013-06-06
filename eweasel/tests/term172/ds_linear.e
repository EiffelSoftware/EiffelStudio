note

	description:

		"Data structures that may be traversed forward"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class DS_LINEAR [G]

inherit

	DS_TRAVERSABLE [G]
		redefine
			new_cursor,
			do_all,
			do_if
		end

	DS_SEARCHABLE [G]

feature -- Access

	first: G
			-- First item in container
		require
			not_empty: not is_empty
		deferred
		ensure
			has_first: has (Result)
		end

	new_cursor: DS_LINEAR_CURSOR [G]
			-- New external cursor for traversal
		deferred
		end

feature -- Status report

	is_first: BOOLEAN
			-- Is internal cursor on first item?
		do
			Result := cursor_is_first (internal_cursor)
		ensure
			not_empty: Result implies not is_empty
			not_off: Result implies not off
			definition: Result implies (item_for_iteration = first)
		end

	after: BOOLEAN
			-- Is there no valid position to right of internal cursor?
		do
			Result := cursor_after (internal_cursor)
		end

	has (v: G): BOOLEAN
			-- Does container include `v'?
			-- (Use `equality_tester''s comparison criterion
			-- if not void, use `=' criterion otherwise.)
		local
			a_cursor: like new_cursor
		do
			a_cursor := new_cursor
			a_cursor.start
			a_cursor.search_forth (v)
			if not a_cursor.after then
				Result := True
				a_cursor.go_after
			end
		end

feature -- Measurement

	occurrences (v: G): INTEGER
			-- Number of times `v' appears in container
			-- (Use `equality_tester''s comparison criterion
			-- if not void, use `=' criterion otherwise.)
		local
			a_cursor: like new_cursor
		do
			a_cursor := new_cursor
			from
				a_cursor.start
			until
				a_cursor.after
			loop
				a_cursor.search_forth (v)
				if not a_cursor.after then
					Result := Result + 1
					a_cursor.forth
				end
			end
		end

feature -- Cursor movement

	start
			-- Move internal cursor to first position.
		do
			cursor_start (internal_cursor)
		ensure
			empty_behavior: is_empty implies after
			not_empty_behavior: not is_empty implies is_first
		end

	forth
			-- Move internal cursor to next position.
		require
			not_after: not after
		do
			cursor_forth (internal_cursor)
		end

	search_forth (v: G)
			-- Move internal cursor to first position at or after current
			-- position where `item_for_iteration' and `v' are equal.
			-- (Use `equality_tester''s comparison criterion
			-- if not void, use `=' criterion otherwise.)
			-- Move `after' if not found.
		require
			not_off: not off or after
		do
			cursor_search_forth (internal_cursor, v)
		end

	go_after
			-- Move internal cursor to `after' position.
		do
			cursor_go_after (internal_cursor)
		ensure
			after: after
		end

feature -- Iteration

	do_all (an_action: PROCEDURE [ANY, TUPLE [G]])
			-- Apply `an_action' to every item, from first to last.
			-- (Semantics not guaranteed if `an_action' changes the structure.)
		deferred
		end

	do_all_with_index (an_action: PROCEDURE [ANY, TUPLE [G, INTEGER]])
			-- Apply `an_action' to every item, from first to last.
			-- `an_action' receives the item and its index.
			-- (Semantics not guaranteed if `an_action' changes the structure.)
		require
			an_action_not_void: an_action /= Void
		deferred
		end

	do_if (an_action: PROCEDURE [ANY, TUPLE [G]]; a_test: FUNCTION [ANY, TUPLE [G], BOOLEAN])
			-- Apply `an_action' to every item that satisfies `a_test', from first to last.
			-- (Semantics not guaranteed if `an_action' or `a_test' change the structure.)
		deferred
		end

	do_if_with_index (an_action: PROCEDURE [ANY, TUPLE [G, INTEGER]]; a_test: FUNCTION [ANY, TUPLE [G, INTEGER], BOOLEAN])
			-- Apply `an_action' to every item that satisfies `a_test', from first to last.
			-- `an_action' and `a_test' receive the item and its index.
			-- (Semantics not guaranteed if `an_action' or `a_test' change the structure.)
		require
			an_action_not_void: an_action /= Void
			a_test_not_void: a_test /= Void
		deferred
		end

feature -- Duplication

	to_array: ARRAY [G]
			-- Array containing the same items as current
			-- container in the same order
		local
			a_cursor: like new_cursor
			i: INTEGER
			l_default: G
		do
			create Result.make_filled (l_default, 1, count)
			a_cursor := new_cursor
			from
				a_cursor.start
			until
				a_cursor.after
			loop
				i := i + 1
				Result.put (a_cursor.item, i)
				a_cursor.forth
			end
		ensure
			to_array_not_void: Result /= Void
			same_count: Result.count = count
		end

feature {DS_CURSOR} -- Cursor implementation

	cursor_off (a_cursor: like new_cursor): BOOLEAN
			-- Is there no item at `a_cursor' position?
		do
			Result := cursor_after (a_cursor)
		end

feature {DS_LINEAR_CURSOR} -- Cursor implementation

	cursor_is_first (a_cursor: like new_cursor): BOOLEAN
			-- Is `a_cursor' on first item?
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
		deferred
		ensure
			not_empty: Result implies not is_empty
			a_cursor_not_off: Result implies not cursor_off (a_cursor)
			definition: Result implies (cursor_item (a_cursor) = first)
		end

	cursor_after (a_cursor: like new_cursor): BOOLEAN
			-- Is there no valid position to right of `a_cursor'?
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
		deferred
		end

	cursor_start (a_cursor: like new_cursor)
			-- Move `a_cursor' to first position.
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
		deferred
		ensure
			empty_behavior: is_empty implies cursor_after (a_cursor)
			not_empty_behavior: not is_empty implies cursor_is_first (a_cursor)
		end

	cursor_forth (a_cursor: like new_cursor)
			-- Move `a_cursor' to next position.
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
			a_cursor_not_after: not cursor_after (a_cursor)
		deferred
		end

	cursor_search_forth (a_cursor: like new_cursor; v: G)
			-- Move `a_cursor' to first position at or after its current
			-- position where `cursor_item (a_cursor)' and `v' are equal.
			-- (Use `equality_tester''s comparison criterion
			-- if not void, use `=' criterion otherwise.)
			-- Move `after' if not found.
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
			a_cursor_not_off: not cursor_off (a_cursor) or cursor_after (a_cursor)
		deferred
		end

	cursor_go_after (a_cursor: like new_cursor)
			-- Move `a_cursor' to `after' position.
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
		deferred
		ensure
			a_cursor_after: cursor_after (a_cursor)
		end

invariant

	after_constraint: initialized implies (after implies off)

end
