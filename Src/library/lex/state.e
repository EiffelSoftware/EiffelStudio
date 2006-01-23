indexing

	description:
		"States of finite automata"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class STATE 

feature -- Access

	final: INTEGER;
			-- Number of the regular expression of which `Current'
			-- is a final state; 0 if not final.
			-- (When you go from state to state
			-- in an automaton, at the end of the course the
			-- attribute `final' of the current state is the
			-- identification number of the regular expression
			-- recognized. 0 means that nothing has been recognized.)

	final_array: ARRAY [INTEGER];
			-- Array of all the possible `final' states (useful
			-- in the case of several possible final attributes)

feature -- Status setting

	set_final (i: INTEGER) is
			-- Make current state final for `i'-th regular expression.
		do
			if final_array = Void then
				create final_array.make (1, 1);
				final_array.put (i, 1);
				final := i
			elseif final_array.item (final_array.lower) /= i then
				final_array.force (i, final_array.lower - 1);
				final := i
			end
		ensure
			final_is_i: final = i;
			lower_entry_is_i: final_array.item (final_array.lower) = i
		end 

invariant

	lower_entry_is_final: (final = 0 and final_array = Void)
			or else final_array.item (final_array.lower) = final

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STATE

