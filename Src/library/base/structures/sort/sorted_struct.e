indexing

	description:
		"Structures whose items are sorted according to a total order relation";

	status: "See notice at end of class";
	names: sorted_struct, comparable_struct;
	access: index, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SORTED_STRUCT [G -> COMPARABLE] inherit

	COMPARABLE_STRUCT [G]
		undefine
			search, off
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
			-- Minimum item
		require else
			is_sorted: sorted
		do
			start;
			Result := item
		ensure then
		--	smallest:
		--		 For every `i' in `first_position' .. `last_position':
		--				`Result <= i_th (i)';
		--		 `Result' = `i_th' (`first_position')
		end;

	max: like item is
			-- Maximum item
		require else
			is_sorted: sorted
		do
			finish;
			Result := item
		ensure then
		--	largest:
		--		 For every `i' in `first_position' .. `last_position':
		--				`i_th (`i') <= `Result';
		--		 `Result' = `i_th' (`last_position')
		end;

	median: like item is
			-- Median element
		deferred
		ensure
			median_present: has (Result)
		--	median_definition:
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

feature {NONE} -- Inapplicable

	putt (v: like item) is
		do
		end;

end -- class SORTED_STRUCT


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
