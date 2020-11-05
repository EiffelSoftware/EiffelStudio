note
	description: "[
			Union-find data structure.
			Element lookup with `find' completes in O(log(n))
			Set merging with `union' completes in O(1)
			]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	UNION_FIND_STRUCTURE [G -> HASHABLE]

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create union-find structure for `n' elements.
			-- Structure grows automatically for more elements.
		do
			count := 0
			set_count := 0
				-- create elements.make (1, n)
			create elements.make_empty
				--create parent.make (1, n)
			create parent.make_empty
				--create elements_in_set.make (1, n)
			create elements_in_set.make_empty
			create index_of_element.make (n)
				--create next_element_in_set.make (1, n)
			create next_element_in_set.make_empty
				--create last_element_in_set.make (1, n)
			create last_element_in_set.make_empty
				--create next_valid_identifier.make (1, n)
			create next_valid_identifier.make_empty
				--create prev_valid_identifier.make (1, n)
			create prev_valid_identifier.make_empty
			prev_valid_identifier.force (-1, 1)
			first_valid_identifier := -1
		end

feature -- Access

	find (e: G): INTEGER
			-- Identifier of set containing `e'
		require
			has_element: has (e)
		local
			set_index, root_index, par: INTEGER
		do
			set_index := index_of_element.item (e)

				-- Traverse the "tree" upwards to get the root index.
			from
				root_index := set_index
			until
					-- The "root" set number is found when the value is equal to its index.
				parent.item (root_index) = root_index
			loop
					-- Get the parent set number until the "root" set number is found.
				root_index := parent.item (root_index)
			end

				-- Optimize `parent' array for "root" access in one single step.
			from
			until
				parent.item (set_index) = root_index
			loop
				par := parent.item (set_index)
				parent.put (root_index, set_index)
				set_index := par
			end

			Result := root_index
		ensure
			valid_identifier: valid_identifier (Result)
		end

	i_th_set (a_identifier: INTEGER): SET [G]
			-- Members of the set identified by `a_identifier'
		require
			valid_identifier: valid_identifier (a_identifier)
		local
			item_cnt: INTEGER
			id: INTEGER
		do
			item_cnt := item_count (a_identifier)
			create {ARRAYED_SET [G]} Result.make (item_cnt)
			from
				id := a_identifier
			until
				id = -1
			loop
				Result.extend (elements.item (id))
				id := next_element_in_set.item (id)
			end
		ensure
			item_count: Result.count = item_count (a_identifier)
		end

	identifiers: SET [INTEGER]
			-- All valid set identifiers
		local
			id: INTEGER
		do
			create {ARRAYED_SET [INTEGER]} Result.make (set_count)
			from
				id := first_valid_identifier
			until
				id = -1
			loop
				Result.extend (id)
				id := next_valid_identifier.item (id)
			end
		ensure
			identifier_count: Result.count = set_count
		end

	sets: SET [SET [G]]
			-- All sets
		local
			id: INTEGER
		do
			create {ARRAYED_SET [SET [G]]} Result.make (set_count)
			from
				id := first_valid_identifier
			until
				id = -1
			loop
				Result.extend (i_th_set (id))
				id := next_valid_identifier.item (id)
			end
		ensure
			set_count: Result.count = set_count
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements

	set_count: INTEGER
			-- Number of disjoint sets

	item_count (a_identifier: INTEGER): INTEGER
			-- Number of elements in set identified by `a_identifier'
		require
			valid_identifier: valid_identifier (a_identifier)
		do
			Result := elements_in_set.item (a_identifier)
		ensure
			not_empty: Result >= 1
		end

feature -- Status report

	has (e: G): BOOLEAN
			-- Is `e' a registered element?
		do
			Result := index_of_element.has (e)
		end

	valid_identifier (a_identifier: INTEGER): BOOLEAN
			-- Is `a_identifier' a valid set identifier?
		do
				-- An identifier is only valid if it denotes a root element.
				-- Root elements point to themselves in `parent'.
			if parent.valid_index (a_identifier) then
				Result := parent.item (a_identifier) = a_identifier
			else
				Result := False
			end
		end

feature -- Element change

	put (e: G)
			-- Put `e' into new unary set.
			-- Do nothing if `e' has been inserted before.
		do
			index_of_element.put (count + 1, e)
			if index_of_element.inserted then
				count := count + 1
				set_count := set_count + 1

					-- Put `e' in unary set: `parent' points to itself.
				elements.force (e, count)
				parent.force (count, count)
				elements_in_set.force (1, count)
				next_element_in_set.force (-1, count)
				last_element_in_set.force (count, count)

					-- Update `valid_identifiers' list.
				next_valid_identifier.force (-1, count)
				if count = 1 then
					first_valid_identifier := 1
					prev_valid_identifier.force (-1, 1)
				else
					next_valid_identifier.put (count, count - 1)
					prev_valid_identifier.force (count - 1, count)
				end
			end
		ensure
			inserted: has (e)
			count_increased: not (old has (e)) implies (count = old count + 1)
		end

feature -- Basic operations

	union (a_identifier, other_identifier: INTEGER)
			-- Merge sets identified by `a_identifier' and `other_identifier'.
			-- The smaller set gets merged into the larger set.
		require
			valid_identifier: valid_identifier (a_identifier) and valid_identifier (other_identifier)
		do
				-- `a_set_identifier' and `other_set_identifier' are both root elements
				-- (because of `valid_identifier').

				-- Make smaller set part of larger set.
			if item_count (a_identifier) >= item_count (other_identifier) then
				merge_sets (a_identifier, other_identifier)
			else
				merge_sets (other_identifier, a_identifier)
			end
		ensure
			set_invalidated: (valid_identifier (a_identifier) and not valid_identifier (other_identifier)) or
							 (valid_identifier (other_identifier) and not valid_identifier (a_identifier))
			set_count_decreased: set_count = old set_count - 1
		end

feature {NONE} -- Implementation

	index_of_element: HASH_TABLE [INTEGER, G]
			-- Gives index in `elements' for each item

	elements: ARRAY [G]
			-- All elements

	parent: ARRAY [INTEGER]
			-- Contains indices of parent set

	elements_in_set: ARRAY [INTEGER]
			-- Number of elements in each set

	next_element_in_set: ARRAY [INTEGER]
			-- "Linked list" of elements in the same set (realized as array). Terminated by "-1"

	last_element_in_set: ARRAY [INTEGER]
			-- Positions of the entry "-1" in `next_element_in_set' for each set.

	first_valid_identifier: INTEGER
			-- First set identifier

	next_valid_identifier: ARRAY [INTEGER]
			-- Forward links of "doubly linked list" of valid identifiers
			-- Terminated by "-1"

	prev_valid_identifier: ARRAY [INTEGER]
			-- Backward links of "doubly linked list" of valid identifiers
			-- Terminated by "-1"

	merge_sets (a_identifier, other_identifier: INTEGER)
			-- Make set identified by `other_identifier' child of set with name `a_identifier'.
		require
			valid_identifier: valid_identifier (a_identifier) and valid_identifier (other_identifier)
		local
			element_sum: INTEGER
			last_of_larger, last_of_smaller: INTEGER
		do
				-- Compute size of merged set.
			element_sum := item_count (a_identifier) + item_count (other_identifier)
			elements_in_set.put (element_sum, a_identifier)

				-- Reparent set items.
			parent.put (a_identifier, other_identifier)

				-- Update element list.
			last_of_larger := last_element_in_set.item (a_identifier)
			last_of_smaller := last_element_in_set.item (other_identifier)
			last_element_in_set.put (last_of_smaller, a_identifier)
			next_element_in_set.put (other_identifier, last_of_larger)

				-- Invalidate `other_identifier'.
			remove_identifier (other_identifier)

				-- Decrease number of sets.
			set_count := set_count - 1
		ensure
			set_count: set_count = old set_count - 1
			first_set_invalid: not valid_identifier (other_identifier)
			new_set_size: item_count (a_identifier) =
						  (old item_count (a_identifier) +
						   old item_count (other_identifier))
		end

	remove_identifier (a_identifier: INTEGER)
			-- Remove `a_identifier' from "valid identifier" list.
		local
			prev_valid, next_valid: INTEGER
		do
			if first_valid_identifier = a_identifier then
					-- Remove first element of "valid identifier" list.
				next_valid := next_valid_identifier.item (a_identifier)
				first_valid_identifier := next_valid
				prev_valid_identifier.put (-1, first_valid_identifier)
			else
				next_valid := next_valid_identifier.item (a_identifier)
				prev_valid := prev_valid_identifier.item (a_identifier)
				if next_valid = -1 then
					-- Remove last element.
					next_valid_identifier.put (-1, prev_valid)
				else
					-- Remove item in middle of list.
					next_valid_identifier.put (next_valid, prev_valid)
					prev_valid_identifier.put (prev_valid, next_valid)
				end
			end
		ensure
			identifier_removed: identifiers.count = old identifiers.count - 1
		end

invariant

	set_count: set_count <= count

	parent_count: parent.count = elements.count
	hash_table_count: index_of_element.count = count

	set_count: sets.count = set_count
	same_count: identifiers.count = set_count

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class UNION_FIND_STRUCTURE
