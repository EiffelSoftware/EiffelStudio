-- Topological sort on classes

class CLASS_SORTER

inherit
	SHARED_ERROR_HANDLER
	COMPILER_EXPORTER
	SHARED_COUNTER
	SHARED_CONFIGURE_RESOURCES

creation
	make

feature -- Initialization

	make is
			-- Creation
		do
			!! order.make (1,0)
			!! precursor_count.make (1,0)
			!! successors.make (1,0)
			!! original.make (1,0)
			!! outsides1.make
			!! outsides2.make
		end

feature -- Sort

	sort is
			-- Topological sort of classes
		do
				-- Initialize data structures
			init (System.classes.count)

				-- Initialize arrays `successors' and `precursor_count'.
			fill

				-- Perform sort
			perform_sort

				-- Check validity: there must be no cycle in the 
				-- inheritance graph
			check_validity
		end

	init (n: INTEGER) is
			-- Initialization for `n' items to sort.
		do
			order.resize (1, n)
			precursor_count.resize (1, n)
			successors.resize (1, n)
			original.resize (1, n)
			outsides1.wipe_out
			outsides2.wipe_out
			count := n
			clear
			fill_original
		end

feature -- Access

	count: INTEGER
			-- Number of items to sort

	order: ARRAY [CLASS_C]
			-- Order to build

	original: ARRAY [CLASS_C]
			-- Origin order (unsorted)

	precursor_count: ARRAY [INTEGER]
			-- Count of precursors

	outsides1: LINKED_LIST [CLASS_C]
	outsides2: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			-- Items with precursor count equal to 0

	successors: ARRAY [LINKED_LIST [CLASS_C]]
			-- Succesors of items

feature -- Filling

	fill_original is
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
					successors.put (a_class.descendants, count)
				end
				i := i + 1
			end
		end

	fill is
			-- Fill `precursor_count' and `outsides'.
		require
			good_context: count > 0
		local
			i, k, succ_id: INTEGER
			succ: LINKED_LIST [CLASS_C]
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

	perform_sort is
			-- Preform topological sort
		require
			good_context: count > 0
		local
			next, k, succ_id: INTEGER
			item, succ_item: CLASS_C
			succ: LINKED_LIST [CLASS_C]
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

	insert_succ (succ_list: LINKED_LIST [CLASS_C]) is
			-- Insert all the successors in `outsides' if they don't have any
			-- precursor which still remains for a later sutdy.
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

	sort_succ (succ: LINKED_LIST [CLASS_C]): ARRAY [CLASS_C] is
			-- Create a sorted array of CLASS_C where the criteria is
			-- less precursor and less successors.
		local
			a_class: CLASS_C
			i, j, nb_succ, nb_prec, nb_item: INTEGER
			class_id: INTEGER
			inserted: BOOLEAN
			index: ARRAY [INTEGER]
		do
			nb_item := succ.count
			if succ.count /= 0 then
				from
					!! Result.make (1, nb_item)
					!! index.make (1, nb_item)
					nb_item := 0
					succ.start
				until
					succ.after
				loop
					a_class := succ.item
					class_id := a_class.topological_id
					nb_succ := successors.item (class_id).count
					nb_prec := precursor_count.item (class_id)
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

	check_validity is
			-- Check if there is cycle(s) in the inheritance graph
		local
			i: INTEGER
			no_cycle: BOOLEAN
			name_list: LINKED_LIST [INTEGER]
			a_class: CLASS_C
			vhpr1: VHPR1
		do
			from
				no_cycle := True
				i := 1
			until
				i > count
			loop
				if precursor_count.item (i) /= 0 then
						-- I_th item of the graph is involved in a cycle
						-- in the inheritance graph
					no_cycle := False
					a_class := original.item (i)
					if name_list = Void then
						!! name_list.make
					end
					name_list.put_front (a_class.class_id)
				end
				i := i + 1
			end
			if no_cycle then
					-- Update class ids
				finalize
			else
					-- Cycle(s) in inheritance graph
				!!vhpr1
				vhpr1.set_involved_classes (name_list)
				Error_handler.insert_error (vhpr1)
			end
		end

	finalize is
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
io.error.putint (i)
io.error.putstring (": ")
io.error.putstring (cl.name)
io.error.new_line
end
				cl.set_topological_id (i)
				i := i + 1
			end

			System.set_max_class_id (count)
		--	update_system
		end

feature -- Update System

	update_system is
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

	clear is
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

	sort_class_c (nb: INTEGER) is
			-- Sort an ARRAY by the topological ID of CLASS_C.
		do
			quick_sort (1, nb)
		end

	quick_sort (min, max: INTEGER) is
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

	partition_quick_sort  (min, max: INTEGER): INTEGER is
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
	
end
