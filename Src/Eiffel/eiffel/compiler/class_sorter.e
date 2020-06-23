note
	description: "Topological sort on classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_SORTER

inherit
	COMPILER_EXPORTER

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_COUNTER
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation
		do
			create order.make_empty
			create precursor_count.make_empty
			create successors.make_empty
			create original.make_empty
			create outsides1.make (1)
			create outsides2.make
		end

	init (n: INTEGER)
			-- Initialization for `n' items to sort.
		require
			n_positive: n > 0
		local
			c: CLASS_C
		do
			across
				system.classes as ic
			until
				attached c
			loop
				c := ic.item
			end
			order.conservative_resize_with_default (c, 1, n)
			precursor_count.conservative_resize_with_default (0, 1, n)
			successors.conservative_resize_with_default (create {like successors.item}.make (0), 1, n)
			original.conservative_resize_with_default (c, 1, n)
			outsides1.wipe_out
			outsides2.wipe_out
			count := n
			clear
			fill_original
		ensure
			count_set: count = n
			order_capacity_set: order.capacity >= n
			successors_capacity_set: successors.capacity >= n
			original_capacity_set: original.capacity >= n
			outsides1_empty: outsides1.is_empty
			outsides2_empty: outsides2.is_empty
		end

feature -- Sort

	sort
			-- Topological sort of classes
		local
			n: like system.classes.count
		do
				-- Initialize data structures
			n := system.classes.count
			if n > 0 then
				init (n)

					-- Initialize arrays `successors' and `precursor_count'.
				fill

					-- Perform sort
				perform_sort

					-- Check validity: there must be no cycle in the
					-- inheritance graph
				check_validity
			end
		end

feature {NONE} -- Access

	count: INTEGER
			-- Number of items to sort

	order: ARRAY [CLASS_C]
			-- Order to build

	original: ARRAY [CLASS_C]
			-- Origin order (unsorted)

	precursor_count: ARRAY [INTEGER]
			-- Count of precursors

	outsides1: ARRAYED_LIST [CLASS_C]
	outsides2: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			-- Items with precursor count equal to 0

	successors: ARRAY [ARRAYED_LIST [CLASS_C]]
			-- Succesors of items

feature {NONE} -- Filling

	fill_original
			-- Fill `original' with the lists `descendants' of classes
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
		do
			class_array := System.classes
			check
				consistency: count = System.classes.count
			end

			count := 0
			from
				nb := Class_counter.count
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
				if a_class /= Void then
					count := count + 1
					a_class.set_topological_id (count)
					original.put (a_class, count)
					successors.put (a_class.direct_descendants, count)
				end
				i := i + 1
			end
		end

	fill
			-- Fill `precursor_count' and `outsides'.
		require
			good_context: count > 0
		local
			i, k, succ_id: INTEGER
			succ: ARRAYED_LIST [CLASS_C]
		do
			from
					-- Initialization of `precursor_count'
				i := 1
			until
				i > count
			loop
				from
					succ := successors.item (i)
					check
						successor_exists: succ /= Void
							-- Data structure `successors' for id `i'
							-- must exist.
					end
					succ.start
				until
					succ.after
				loop
					succ_id := succ.item.topological_id
					k := precursor_count.item (succ_id)
					precursor_count.put (k + 1, succ_id)
					succ.forth
				end
				i := i + 1
			end
			from
					-- Initialization of `outsides'
				i := 1
			until
				i > count
			loop
				if precursor_count.item (i) = 0 then
					outsides1.extend (original.item (i))
					outsides2.extend (original.item (i))
				end
				i := i + 1
			end
		end

	perform_sort
			-- Perform topological sort
		require
			good_context: count > 0
		local
			next, k, succ_id: INTEGER
			item, succ_item: CLASS_C
			succ: ARRAYED_LIST [CLASS_C]
		do
			if Configure_resources.get_boolean ("topo", True) then
				insert_succ (successors.item (outsides1.first.topological_id))
				from
					outsides1.start
				until
					outsides1.after
				loop
					next := next + 1
					order.put (outsides1.item, next)
					outsides1.forth
				end
			else
				from
				until
					outsides2.is_empty
				loop
					item := outsides2.first
					outsides2.start
					outsides2.remove
					next := next + 1
					order.put (item, next)
					from
						succ := successors.item (item.topological_id)
						succ.start
					until
						succ.after
					loop
						succ_item := succ.item
						succ_id := succ_item.topological_id
						k := precursor_count.item (succ_id)
						if k = 0 then
							-- Nothing
						elseif k = 1 then
							outsides2.extend (succ_item)
							precursor_count.put (0, succ_id)
						else
							precursor_count.put (k - 1, succ_id)
						end
						succ.forth
					end
				end
			end
		end

	insert_succ (succ_list: ARRAYED_LIST [CLASS_C])
			-- Insert all the successors in `outsides' if they don't have any
			-- precursor which still remains for a later sutdy.
		require
			succ_list_not_void: succ_list /= Void
		local
			succ: ARRAY [CLASS_C]
			i, nb_item, succ_id, k: INTEGER
			succ_item: CLASS_C
		do
			succ := sort_succ (succ_list)
			if succ /= Void then
				from
					nb_item := succ_list.count
					i := 1
				until
					i > nb_item
				loop
					succ_item := succ.item (i)
					succ_id := succ_item.topological_id
					k := precursor_count.item (succ_id)
					if k = 0 then
						-- Nothing
					elseif k = 1 then
						outsides1.extend (succ_item)
						precursor_count.put (0, succ_id)
						insert_succ (successors.item (succ_id))
					else
						precursor_count.put (k - 1, succ_id)
					end
					i := i + 1
				end
			end
		end

	sort_succ (succ: ARRAYED_LIST [CLASS_C]): ARRAY [CLASS_C]
			-- Create a sorted array of CLASS_C where the criteria is
			-- less precursor and less successors and more class usage (i.e.
			-- referring more classes).
		require
			succ_not_void: succ /= Void
		local
			a_class: CLASS_C
			i, j, nb_succ, nb_prec, nb_item, nb_clients: INTEGER
			class_id: INTEGER
			inserted: BOOLEAN
			index: ARRAY [INTEGER]
		do
			nb_item := succ.count
			if succ.count /= 0 then
				from
					create Result.make_filled (succ [1], 1, nb_item)
					create index.make_filled (0, 1, nb_item)
					nb_item := 0
					succ.start
				until
					succ.after
				loop
					a_class := succ.item
					class_id := a_class.topological_id
					nb_succ := successors.item (class_id).count
					nb_prec := precursor_count.item (class_id)
					nb_clients := a_class.syntactical_suppliers.count
					from
						inserted := False
						i := 1
					until
						inserted or else i > nb_item
					loop
						if
							nb_prec < index.item (i) or else
							(nb_prec = index.item (i) and then
							nb_succ <= successors.item (Result.item (i).topological_id).count)
						then
							inserted := True
							nb_item := nb_item + 1
							from
								j := nb_item
							until
								j = i
							loop
								Result.put (Result.item (j - 1), j)
								index.put (index.item (j - 1), j)
								j := j - 1
							end
							Result.put (a_class, j)
							index.put (nb_prec, j)
						else
							i := i + 1
						end
					end
					if not inserted then
						nb_item := nb_item + 1
						Result.put (a_class, nb_item)
						index.put (nb_prec, nb_item)
					end
					succ.forth
				end
			end
		end

	check_validity
			-- Check if there is cycle(s) in the inheritance graph
		local
			i, l_count: INTEGER
			name_list: LINKED_LIST [INTEGER]
			vhpr1: VHPR1
			l_precursor_count: like precursor_count
			l_cyclic_inheritance_list: LINKED_LIST [CLASS_C]
			l_exit, l_remove: BOOLEAN
			l_direct_descendants: ARRAYED_LIST [CLASS_C]
		do
			from
				l_precursor_count := precursor_count
				create l_cyclic_inheritance_list.make
				i := 1
				l_count := count
			until
				i > l_count
			loop
				if l_precursor_count [i] /= 0 then
						-- I_th item of the graph is involved in a cycle
						-- in the inheritance graph
					l_cyclic_inheritance_list.put_front (original [i])
				end
				i := i + 1
			end
			if l_cyclic_inheritance_list.is_empty then
					-- Update class ids
				finalize
			else
					-- Cycle(s) in inheritance graph
					-- List needs post-processing to remove false positives of descendents of classes involved
					-- in the cyclic inheritance loop.
				create vhpr1
				create name_list.make
				from
					l_exit := False
				until
					l_exit
				loop
					from
						l_exit := True
						l_cyclic_inheritance_list.start
					until
						l_cyclic_inheritance_list.after
					loop
						l_direct_descendants := l_cyclic_inheritance_list.item.direct_descendants
						from
							l_direct_descendants.start
							l_remove := True
						until
							l_direct_descendants.after
						loop
							if l_cyclic_inheritance_list.has (l_direct_descendants.item) then
								l_remove := False
							end
							l_direct_descendants.forth
						end
						if l_remove then
							l_exit := False
							l_cyclic_inheritance_list.remove
						else
							l_cyclic_inheritance_list.forth
						end
					end
				end

				from
					l_cyclic_inheritance_list.start
				until
					l_cyclic_inheritance_list.after
				loop
					name_list.extend (l_cyclic_inheritance_list.item.class_id)
					l_cyclic_inheritance_list.forth
				end
				vhpr1.set_involved_classes (name_list)
				Error_handler.insert_error (vhpr1)
			end
		end

	finalize
			-- Finalization of the topological sort: i.e change the
			-- class ids
		local
			i: INTEGER
			cl: CLASS_C
		do
			from
				i := 1
			until
				i > count
			loop
				cl := order.item (i)
debug ("ACTIVITY", "DLE TOPO")
io.error.put_integer (i)
io.error.put_string (": ")
io.error.put_string (cl.name)
io.error.put_new_line
end
				cl.set_topological_id (i)
				i := i + 1
			end

			System.set_max_class_id (count)
		--	update_system
		end

feature -- Update System

	update_system
			-- Sort all the data structures of the system by following the new
			-- topological sort
		local
			nb: INTEGER
		do
			order := System.classes
			nb := class_counter.count
			sort_class_c (nb)
		end

feature -- Wipe out

	clear
			-- Clear the structure
		do
			order.clear_all
			precursor_count.clear_all
			successors.clear_all
			original.clear_all
			outsides1.wipe_out
			outsides2.wipe_out
		end

feature {NONE} -- Implementation

	sort_class_c (nb: INTEGER)
			-- Sort an ARRAY by the topological ID of CLASS_C.
		do
			quick_sort (1, nb)
		end

	quick_sort (min, max: INTEGER)
			-- Apply `quick_sort' algorithm.
			-- If `max' < `min' then it stops
		local
			pivo_index: INTEGER
		do
			if min < max then
				pivo_index := partition_quick_sort (min, max)
				quick_sort (min, pivo_index - 1)
				quick_sort (pivo_index + 1, max)
			end
		end

	partition_quick_sort  (min, max: INTEGER): INTEGER
			-- Apply `quick_sort' algorithm to position [`min'..`max']
		require
			correct_bounds: min <= max
		local
			up, down: INTEGER
			x, temp: CLASS_C
		do
				-- Define the pivot value as the first element of table
			x := order.item (min)

				-- Initialize UP to first
			up := min

				-- Initialize DOWN to last
			down := max

			from
			until
				up >= down    -- Repeat until up meets or passes down
			loop
					-- Increment up until up selects the first element
					-- greater than the pivot value
				from
				until
					up >= max or else order.item (up) > x
				loop
					up := up + 1
				end

					-- Decrement down until it selects the first element
					-- lesser than or equal to the pivot
				from
				until
					order.item (down) <= x
				loop
					down := down - 1
				end

				if up < down then
						-- If up < down  exchange their values until up
						-- meets or passes down
					temp := order.item (up)
					order.put (order.item (down), up)
					order.put (temp, down)
				end
			end

			temp := order.item (down)
			order.put (order.item (min), down)
			order.put (temp, min)
			Result := down
		end

invariant
	order_not_void: order /= Void
	precursor_count_not_void: precursor_count /= Void
	successors_not_void: successors /= Void
	original_not_void: original /= Void
	outsides1_not_void: outsides1 /= Void
	outsides2_not_void: outsides2 /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
