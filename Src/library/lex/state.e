indexing

	description:
		"States of finite automata";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class STATE feature

	final: INTEGER;
			-- Number of the regular expression of which Current
			-- is a final state; 0 if not final
			-- (That is to say that when you go from state to state
			-- in an automaton, at the end of the course the
			-- attribute final of the Current state is the
			-- identification number of the regular expression
			-- recognized, 0 means that nothing has been recognized)

	final_array: ARRAY [INTEGER];
			-- Array of all the possible ``final'' (useful
			-- in the case of several possible final attributes)

	set_final (i: INTEGER) is
			-- Set final and the first entry of final_array to i.
		do
			if final_array = Void then
				!!final_array.make (1, 1);
				final_array.put (i, 1);
				final := i
			elseif final_array.item (final_array.lower) /= i then
				final_array.force (i, final_array.lower - 1);
				final := i
			end
		ensure
			final_is_i: final = i;
			lower_entry_is_i: final_array.item (final_array.lower) = i
		end -- set_final

invariant

	lower_entry_is_final: (final = 0 and final_array = Void)
			or else final_array.item (final_array.lower) = final

end -- class STATE
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
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
