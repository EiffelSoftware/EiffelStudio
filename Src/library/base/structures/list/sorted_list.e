
indexing

	description:
		"Sequential lists where the cells are sorted in ascending order %
		%according to the relational operators of PART_COMPARABLE";

	copyright: "See notice at end of class";
	names: sorted_list, sorted_struct, sequence;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SORTED_LIST [G -> COMPARABLE] inherit

	PART_SORTED_LIST [G]
--		select
--			put
--		end;

--	SORTED_STRUCT [G]
--		undefine
--			index_of, exhausted,
--			sequential_representation, off,
--			prune_all, has
--		redefine
--			min, max
--		end

feature -- Measurement

	min: like item is
			-- Minimum element
		do
			Result := first
		end;
			
	max: like item is
			-- Maximum element
		do
			Result := last
		end;

	median: like item is
			-- Median element
		do
			Result := i_th ((count + 1) // 2)
		end;

end -- class SORTED_LIST


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
