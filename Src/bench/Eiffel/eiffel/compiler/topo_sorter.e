-- Abstract descirption of a topological sorter

deferred class TOPO_SORTER [T->TOPOLOGICAL]

feature -- Attributes

	count: INTEGER;
			-- Number of items to sort

	order: ARRAY [T];
			-- Order to build

	original: ARRAY [T];
			-- Origin order (unsorted)

	precursor_count: ARRAY [INTEGER];
			-- Count of precursors

	outsides: PART_SORTED_TWO_WAY_LIST [T];
			-- Items with precursor count equal to 0

	successors: ARRAY [LINKED_LIST [T]];
			-- Succesors of items

feature -- Initialization

	init (n: INTEGER) is
			-- Initialization for `n' items to sort.
		do
			order.resize (1, n);
			precursor_count.resize (1, n);
			successors.resize (1, n);
			original.resize (1, n);
			outsides.wipe_out;
			count := n;
			clear;
			fill_original;
		end;

	clear is
			-- Clear the structure
		do
			order.clear_all;
			precursor_count.clear_all;
			successors.clear_all;
			original.clear_all;
			outsides.wipe_out;
		end;

	fill_original is
			-- Fill original array
		deferred
		end;

	sort is
			-- Perform topological sort
		do
				-- Fill the structures
			fill;
				-- Sort
			perform_sort;
		end;

	fill is
			-- Fill `precursor_count' and `outsides'.
		require
			good_context: count > 0
		local
			i, k, succ_id: INTEGER;
			succ: LINKED_LIST [T];
		do
			from
					-- Initialization of `precursor_count'
				i := 1;
			until
				i > count
			loop
				from
					succ := successors.item (i);
					check 
						successor_exists: succ /= Void;
							-- Data structure `successors' for id `i'
							-- must exist.
					end;
					succ.start
				until
					succ.after
				loop
					succ_id := succ.item.topological_id;
					k := precursor_count.item (succ_id);
					precursor_count.put (k + 1, succ_id);
					succ.forth
				end;
				i := i + 1;
			end;
			from
					-- Initialization of `outsides'
				i := 1
			until
				i > count
			loop
				if precursor_count.item (i) = 0 then
					outsides.extend (original.item (i));
				end;
				i := i + 1
			end;
		end;

	perform_sort is
			-- Preform topological sort
		require
			good_context: count > 0
		local
			next, k, succ_id: INTEGER;
			item, succ_item: T;
			succ: LINKED_LIST [T];
		do
			from
			until
				outsides.empty
			loop
				item := outsides.first;
				outsides.start;
				outsides.remove;
				next := next + 1;
				order.put (item, next);
				from
					succ := successors.item (item.topological_id);
					succ.start
				until
					succ.after
				loop
					succ_item := succ.item;
					succ_id := succ_item.topological_id;
					k := precursor_count.item (succ_id);
					if k = 0 then
						-- Nothing
					elseif k = 1 then
						outsides.extend (succ_item);
						precursor_count.put (0, succ_id)
					else
						precursor_count.put (k - 1, succ_id)
					end;
					succ.forth
				end;
			end;
		end;
		
end
