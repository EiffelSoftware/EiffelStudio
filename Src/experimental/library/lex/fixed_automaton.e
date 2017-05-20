note
	description:
		"General finite-state automata, implemented by arrays"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class FIXED_AUTOMATON [S-> detachable STATE] inherit

	ARRAY [S]
		rename
			make as array_make,
			make_filled as array_make_filled
		export
			{ANY} lower, upper, item, put
		end

create
	make, make_filled

feature {NONE} -- Initialization

	make (i, s: INTEGER)
			-- Make an automaton including at most `s' states,
			-- with transitions 0 to `i'.
		obsolete
			"Use `make_filled' instead. [2017-05-31]"
		require
			s_large_enough: s > 0;
			i_large_enough: i >= 0
		do
			array_make (1, s);
		end;

	make_filled (a_default_value: S; i, s: INTEGER_32)
			-- Make an automaton including at most `s' states,
			-- with transitions 0 to `i'.
		require
			s_large_enough: s > 0;
			i_large_enough: i >= 0
		do
			array_make_filled (a_default_value, 1, s);
		end;

feature -- Access

	last_position: INTEGER;
			-- Position of last state inserted

feature -- Status setting

	set_final (state, f: INTEGER)
			-- Make `state' `final' for regular expression `f'.
		require
			is_in_automaton: state <= upper and state >= lower
		do
			if attached item (state) as l_state then
				l_state.set_final (f)
			end
		end;

feature -- Element change

	add_right (s: S)
			-- Assign `s' to the first possible item.
		require
			not_full: last_position < count
		do
			last_position := last_position + 1;
			put (s, last_position)
		ensure
			last_position_incremented: last_position = old last_position + 1
		end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
