indexing

	description:
		"Structures whose items are sorted according to a total order relation";

	copyright: "See notice at end of class";
	names: sorted_struct, comparable_struct;
	access: index, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SORTED_STRUCT [G -> COMPARABLE] inherit

	COMPARABLE_STRUCT [G]
		undefine
			search
		redefine
			min, max
		end;
		
	INDEXABLE [G, INTEGER]
		rename
			item as i_th,
			put as put_i_th,
			bag_put as putt
		redefine
			putt
		end;
	
	LINEAR [G]

feature -- Measurement

	min: like item is
			-- Minimum element
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
			-- Maximum element
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
			-- Median element
		deferred
		ensure
		--	is_median:
		--		Result = i_th (first_position +
		--			(last_position - first_position) // 2)
		end;

feature -- Status report

	sorted: BOOLEAN is
			-- Is structure sorted?
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

feature -- Transformation

	sort is
			-- Sort structure.
		deferred
		ensure
			is_sorted: sorted
		end;

feature {} -- compiler stuff .
			-- FIX ME

	putt (v: like item) is
		do
		end;	

end -- class SORTED_STRUCT


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
