note
	description	: "[
			Topological sorter.
			Used to produce a total order on a set of
			elements having only a partial order.
			]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Devising and engineering an algorithm: Topological Sort", "src=https://link.springer.com/chapter/10.1007/978-3-540-92145-5_15", "protocol=uri"

class
	TOPOLOGICAL_SORTER [G -> HASHABLE]

create
	make

feature {NONE} -- Initialization

	make
			-- Create topological sorter.
		do
			create index_of_element.make (1)
			create element_of_index.make_empty
			create successors.make_empty
			create predecessor_count.make_empty

			create {LINKED_LIST [G]} cycle_list_impl.make
			create output.make
			use_fifo_output
			count := 0
		ensure
			index_of_element_empty: index_of_element.is_empty
			element_of_index_empty: element_of_index.is_empty
			successors_empty: successors.is_empty
			predecessor_count_is_empty: predecessor_count.is_empty

			cycle_list_impl_empty: cycle_list_impl.is_empty
			output_empty: output.is_empty
			fifo_output: fifo_output
		end

feature -- Initialization

	record_element (e: G)
			-- Add `e` to the set of elements, unless already present.
		require
			not_sorted: not done
		do
			index_of_element.put (count+1, e)
			if index_of_element.inserted then
				count := count + 1
				element_of_index.force (e, count)
				predecessor_count.force (0, count)
				successors.force (create {LINKED_LIST [INTEGER]}.make, count)
			end
		end

	record_constraint (e, f: G)
			-- Add the constraint `[e,f]`.
		require
			not_sorted: not done
			not_void: e /= Void and f /= Void
		local
			x, y: INTEGER
		do
			-- Ensure `e` and `f` are inserted (no effect if they already were):
			record_element (e)
			record_element (f)

			x := index_of_element.item (e)
			y := index_of_element.item (f)
			predecessor_count.put (predecessor_count.item (y) + 1, y)
			add_successor (x, y)
		end

feature -- Access

	cycle_found: BOOLEAN
			-- Did the original constraint imply a cycle?
		require
			sorted: done
		do
			Result := has_cycle
		end

	cycle_list: LIST [G]
			-- Elements involved in cycles
		require
			sorted: done
		do
			Result := cycle_list_impl
		ensure
			empty_iff_none: (not cycle_found) = (Result.is_empty)
			not_empty_if_cycle: cycle_found implies (not Result.is_empty)
		end

	sorted_elements: LIST [G]
			-- List, in an order respecting the constraints, of all
			-- the elements that can be ordered in that way
		require
			sorted: done
		do
			Result := output
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements

feature -- Status report

	done: BOOLEAN
			-- Has topological sort been performed?

	object_comparison: BOOLEAN
			-- Must `record_element' operations use `equal` rather than `=`
			-- to avoid duplicate elements?

	fifo_output: BOOLEAN
			-- Are elements without constraints added to output by
			-- FIFO (first in first out) strategy?

	has_element (e: G): BOOLEAN
			-- Is e one of the elements to be topologically sorted?
		do
			Result := index_of_element.has (e)
		ensure
			exist: Result implies Result =index_of_element.has (e) and then
						index_of_element [e] >= 1 and then
						index_of_element [e] <= element_of_index.count
			not_exist: not Result implies not index_of_element.has (e)
		end

feature -- Status setting

	reset
			-- Allow further updates of the elements and constraints.
		do
			done := False
			has_cycle := False
			cycle_list_impl.wipe_out
			processed_count := 0
		ensure
			fresh: not done
		end

	compare_references
			-- Ensure that future `record_element	 operations will use `=`
			-- rather than `equal' for comparing references.
		require
			empty: count = 0
		do
			object_comparison := False
			element_of_index.compare_references
		ensure
			reference_comparison: not object_comparison
		end

	compare_objects
			-- Ensure that future `record_element` operations will use `equal`
			-- rather than `=' for comparing references.
		require
			empty: count = 0
		do
			object_comparison := True
			element_of_index.compare_objects
		ensure
			object_comparison: object_comparison
		end

	use_fifo_output
			-- Elements without constraints are added to output with
			-- FIFO (first in first out) strategy.
		require
			not_sorted: not done
		do
			create {LINKED_QUEUE [INTEGER]} candidates.make
			fifo_output := True
		ensure
			fifo_output: fifo_output
		end

	use_lifo_output
			-- Elements without constraints are added to output with
			-- LIFO (last in first out) strategy.
		require
			not_sorted: not done
		do
			create {ARRAYED_STACK [INTEGER]} candidates.make (1)
			fifo_output := False
		ensure
			lifo_output: not fifo_output
		end



feature -- Element change

	process
			-- Perform a topological sort over all applicable elements.
			-- Results are accessible through `sorted', `cycle_found' and `cycle_list'.
		require
			not_sorted: not done
		local
			x, y: INTEGER
			x_successors: LIST [INTEGER]
		do
			from
				find_initial_candidates
			invariant
				-- The data structures represent a subset of the original elements
				-- and the corresponding subset of the original relation	
			until
				candidates.is_empty
			loop
					-- Let x be a member of elements with no  predecessor for constraints
				x := candidates.item
				candidates.remove
				output.extend (element_of_index.item (x))

					-- Remove x from elements and all pairs starting with x from constraints
				x_successors := successors.item (x)		-- A list
				from
					x_successors.start
				until
					x_successors.after
				loop
					y := x_successors.item
					predecessor_count [y] := predecessor_count [y] - 1
					if predecessor_count.item (y) = 0 then
							-- Record that y is now without predecessors
						candidates.put (y)
					end
					x_successors.forth
				end
				processed_count := processed_count + 1
			variant
				count -processed_count
			end
			report_cycles
			done := True
		ensure
			sorted: done
		end

feature {NONE} -- Implementation

	successors: ARRAY [LINKED_LIST [INTEGER]]
			-- Indexed by element numbers; for each element `x',
			-- gives the list of its successors (the elements `y'
			-- such that there is a constraint `[x,y]')

	predecessor_count: ARRAY [INTEGER]
			-- Indexed by element numbers; for each, says how many
			-- predecessors the element has

	candidates: DISPENSER [INTEGER]
			-- Elements with no predecessor, ready to be released

	processed_count: INTEGER
			-- Number of sorted elements

	has_cycle: like cycle_found
			-- Internal attribute with same value as `cycle_found'.
			-- (needed because `cycle_found' has precondition `done'.)

	cycle_list_impl: like cycle_list
			-- Internal attribute with same value as `cycle_list'.
			-- (needed because `cycle_list' has precondition `done'.)

	output: LINKED_LIST [G]
			-- Internal attribute with same value as `sorted'.
			-- (needed because `sorted' has precondition `done'.)


	index_of_element: HASH_TABLE [INTEGER, G]
			-- Index of every element

	element_of_index: ARRAY [G]
			-- For every assigned index, gives the associated element

	find_initial_candidates
			-- Insert into `candidates' any elements without predecessors.
		require
			predecessor_count_not_void: predecessor_count /= Void
			candidates_not_void: candidates /= Void
		local
			x: INTEGER
		do
			from
				x := 1
			until
				x > count
			loop
				if predecessor_count.item (x) = 0 then
					candidates.force (x)
				end
				x := x + 1
			end
		end

	report_cycles
			-- Make information about cycles available to clients
		local
			x: INTEGER
		do
			if processed_count < count then
				-- There was a cycle in the original relation
				has_cycle := True
				from
					x := 1
				until
					x > count
				loop
					if predecessor_count.item (x) /= 0 then
							-- item with index `x' was involved in a cycle
						cycle_list_impl.extend (element_of_index.item (x))
					end
					x := x + 1
				end
			end
		end

	add_successor (x, y: INTEGER)
			-- Record `y' as successor of `x'.
		require
			valid_x: 1 <= x; x <= count
			valid_y: 1 <= y; y <= count
		local
			x_successors: LINKED_LIST [INTEGER]
		do
			x_successors := successors.item (x)
			-- The successor list for `x' may not have been created yet:
			if x_successors = Void then
				create x_successors.make
				successors.put (x_successors, x)
			end
			x_successors.extend (y)
		ensure
			has_successor: successors.item (x).has (y)
		end

invariant

--	elements_not_void:			element_of_index /= Void
--	hash_table_not_void:		index_of_element /= Void
--	predecessor_count_not_void:	predecessor_count /= Void
--	successors_not_void:		successors /= Void
--	candidates_not_void:		candidates /= Void

	element_count:			element_of_index.count = count
	predecessor_list_count:	predecessor_count.count = count
	successor_list_count:	successors.count = count

--	cycle_list_iff_cycle: done implies (cycle_found = (cycle_list /= Void))
	cycle_list_iff_cycle: done implies (cycle_found = (not cycle_list.is_empty))

	all_items_sorted:  (done and then not cycle_found) implies (count = sorted_elements.count)
	no_item_forgotten: (done and then cycle_found) implies (count = sorted_elements.count + cycle_list.count)
	processed_count:   done implies processed_count = sorted_elements.count

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
end -- class TOPOLOGICAL_SORTER
