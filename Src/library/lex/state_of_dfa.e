note
	description: "States of deterministic finite automata"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class STATE_OF_DFA inherit

	STATE
		undefine
			copy, is_equal
		end;

	ARRAY [detachable STATE_OF_DFA]
		rename
			make as array_make
		export
			{NONE} to_c
		end

create

	make

feature {NONE} -- Initialization

	make (s: INTEGER)
			-- Make state with 0 to `s' possibles inputs.
		do
			make_filled (Void, 0, s)
		end

feature -- Element change

	append_transition (i: INTEGER; t: detachable STATE_OF_DFA)
			-- Append transition from current state to state t on input i.
		require
			no_other_transition: item (i) = Void;
			possible_input: i <= upper and i >= 0
		do
			put (t, i)
		end;

feature -- Cursor movement

	successor (i: INTEGER): detachable STATE_OF_DFA
			-- Successor of current state for input `i';
			-- Void if no successor
		require
			possible_input: i <= upper and i >= 0
		do
			Result := item (i)
		end

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
