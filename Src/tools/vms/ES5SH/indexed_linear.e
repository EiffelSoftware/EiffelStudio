indexing
	original_author: "Mark Howard"
	description: "linear with count and index, from ROSE_LINEAR"
	keywords: "linear,iterator,agent"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	path: "$File: //rose/source/kernel/infrastructure/containers/rose_linear.e $"

deferred class INDEXED_LINEAR[G]

inherit
	LINEAR [G]
		rename
			search as ise_linear_search
		redefine
			there_exists, for_all
		end

feature -- Access

	cursor : LINEAR_CURSOR is
			-- New cursor for `Current'
		do
			create Result.make (index)
		ensure
			cursor_not_void: Result /= Void
		end

	has_reference (a_value: G): BOOLEAN is
			-- Is 'a_value' referenced in this linear?
		local
			l_save_index: INTEGER
		do
			l_save_index := index
			from
				start
			until
				Result or else off
			loop
				Result := item = a_value
				forth
			end
			go_i_th (l_save_index)
		end

	has_value (a_value: G): BOOLEAN is
			-- Is 'a_value' present in this linear?
			-- Warning: uses 'deep_equal' !
		local
			l_save_index: INTEGER
		do
			l_save_index := index
			from
				start
			until
				Result or else off
			loop
				Result := deep_equal (item, a_value)
				forth
			end
			go_i_th (l_save_index)
		end

	index: INTEGER is
		-- Position of cursor
		deferred
		ensure then
			non_negative_index: Result >= 0
		end

	count: INTEGER is
		-- Number of items in `Current'
		deferred
		ensure
			non_negative_count: Result >= 0
		end

feature -- Status report

	valid_cursor (a_cursor : like cursor) : BOOLEAN is
			-- Is `a_cursor' valid for `Current'?
		require
			a_cursor_not_void: a_cursor /= Void
		deferred
		end

feature -- Cursor movement

	go_to (a_cursor : like cursor) is
			-- Go to item pointed at by `a_cursor'.
		require
			a_cursor_not_void: a_cursor /= Void
			valid_cursor: valid_cursor (a_cursor)
		do
			go_i_th (a_cursor.index)
		ensure
			correct_position: index = a_cursor.index
		end

	go_i_th (a_index: INTEGER) is
			-- Go to item at `a_index'.
		require
			-- Can we add positive index requirement? (used in many places)
		deferred
		ensure
			-- likewise
		end

feature -- Iteration

	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
		local
			l_cursor: like cursor
			l_args: TUPLE [G]
		do
			create l_args
			l_cursor := cursor

			from
				start
			until
				after or Result
			loop
				l_args.put (item, 1)
				Result := test.item (l_args)
				forth
			end

			go_to (l_cursor)
		end

	for_all (a_test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `a_test' true for all items?
		local
			l_cursor: like cursor
			l_args: TUPLE [G]
		do
			create l_args
			l_cursor := cursor

			from
				start
				Result := True
			until
				after or not Result
			loop
				l_args.put (item, 1)
				Result := a_test.item (l_args)
				forth
			end

			go_to (l_cursor)
		end

	for_all_with_index (a_test: FUNCTION [ANY, TUPLE [G, INTEGER], BOOLEAN]): BOOLEAN is
			-- Is `a_test' true for all items?
		require
			a_test_not_void: a_test /= Void
		local
			l_cursor: like cursor
			l_args: TUPLE [G, INTEGER]
		do
			create l_args
			l_cursor := cursor

			from
				start
				Result := True
			until
				after or not Result
			loop
				l_args.put (item, 1)
				l_args.put (index, 2)
				Result := a_test.item (l_args)
				forth
			end

			go_to (l_cursor)
		end

	do_all_with_index2 (a_action: PROCEDURE [ANY, TUPLE [G, INTEGER]]) is
			-- Apply `a_action' to every item.
			-- `a_action' receives item and it's index.
			-- Semantics not guaranteed if `a_action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		obsolete
			"Use do_all_with_index"
		require
			a_action_not_void: a_action /= Void
		local
			l_args: TUPLE [G, INTEGER]
			l_cursor: like cursor
		do
			l_cursor := cursor

			create l_args
			from
				start
			until
				after
			loop
				l_args.put (item, 1)
				l_args.put (index, 2)
				a_action.call (l_args)
				forth
			end

			go_to (l_cursor)
		end

	do_all_intervals (a_action: PROCEDURE [ANY, TUPLE [G, G]]) is
			-- Apply `a_action' to every pair of (item, following item) in the container.
			-- For instance for the list << 1,2,3,4 >>, call the action 3 times on [1,2], [2,3] and [3,4].
		require
			a_action_not_void: a_action /= Void
		local
			l_first_done: CELL [BOOLEAN]
			l_previous: CELL [G]
			l_g : G
		do
			if count > 1 then
				create l_first_done.put (False)
				create l_previous.put(l_g)
				do_all (agent do_all_intervals_item (a_action, l_first_done, l_previous, ?))
			end
		end

	do_all_product (a_other: INDEXED_LINEAR [G]; a_action: PROCEDURE [ANY, TUPLE [G, G]]) is
			-- Call `a_action' on items of the product of `Current' by `a_other'.
			-- for example
			--  Current := << 1, 2 >> and a_other := << 101, 102, 103 >>
			-- will call the action with
			--  [1, 101] [1, 102] [1, 103] [2, 101] [2, 102] [2, 103]
		require
			a_other_not_void: a_other /= Void
			a_action_not_void: a_action /= Void
		do
			do_all (agent do_all_product_item (a_action, a_other, ?))
		end

feature {NONE} -- Implementation

	do_all_intervals_item (a_action: PROCEDURE [ANY, TUPLE [G, G]]; a_first_done: CELL [BOOLEAN]; a_previous: CELL [G]; a_item: G) is
			-- Implementation for `do_all_intervals'.
		require
			a_action_not_void: a_action /= Void
			a_previous_not_void: a_previous /= Void
			a_first_done_not_void: a_first_done /= Void
		do
			if a_first_done.item then
				a_action.call ([a_previous.item, a_item])
			else
				a_first_done.put (True)
			end
			a_previous.put (a_item)
		ensure
			first_done: a_first_done.item
		end

	do_all_product_item (a_action: PROCEDURE [ANY, TUPLE [G, G]]; a_other: INDEXED_LINEAR [G]; a_item: G) is
			-- Implementation for `do_all_product'.
		require
			a_action_not_void: a_action /= Void
			a_other_not_void: a_other /= Void
		do
			a_other.do_all (agent do_all_product_item_agent (a_action, a_item, ?))
		end

	do_all_product_item_agent (a_action: PROCEDURE [ANY, TUPLE [G, G]]; a_item: G; a_other_item: G)
			-- Leaf implementation for `do_all_product'.
		require
			a_action_not_void: a_action /= Void
		do
			a_action.call ([a_item, a_other_item])
		end
end

