--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sorted data-structures

indexing

	names: sorted_struct, comparable_struct;
	access: index, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SORTED_STRUCT [G -> PART_COMPARABLE] inherit

	COMPARABLE_STRUCT [G]
		undefine
			search, search_equal
		redefine
			min, max
		end;
		
	INDEXABLE [G, INTEGER]
		rename
			item as i_th,
			put as put_i_th
		end;
	
	LINEAR [G]

feature -- Access

	min: like item is
			-- Minimum in `Current'
		require else
			is_sorted: sorted
		do
			start;
			Result := item
		ensure then
		--	is_minimum:
		--		 for all i in first_position .. last_position:
		--				`Result <= i_th (i)';
		--		 `Result = i_th (first_position)'
		end;

	max: like item is
			-- Maximum in `Current'
		require else
			is_sorted: sorted
		do
			finish;
			Result := item
		ensure then
		--	is_maximum:
		--		 for all i in first_position .. last_position:
		--				`i_th (i) <= Result';
		--		 Result = i_th (last_position)
		end;

	median: like item is
			-- Median in `Current'
		deferred
		ensure
		--	is_median:
		--		Result = i_th (first_position +
		--			(last_position - first_position) // 2)
		end;

feature -- Transformation

	sort is
			-- Sort `Current'.
		deferred
		ensure
			is_sorted: sorted
		end;

feature -- Assertion check

	sorted: BOOLEAN is
			-- Is `Current' sorted?
		local
			m: like item
		do
			if empty then
				Result := true
			else
				from
					start;
					m := item;
					forth
				until
					exhausted or else (item < m)
				loop
					m := item;
					forth
				end;
				Result := exhausted
			end
		end;

end -- class SORTED_STRUCT
