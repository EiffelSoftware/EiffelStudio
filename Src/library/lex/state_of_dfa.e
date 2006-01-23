indexing

	description:
		"States of deterministic finite automata"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class STATE_OF_DFA inherit

	STATE
		undefine
			copy, is_equal
		end;

	ARRAY [STATE_OF_DFA]
		rename
			make as array_make
		export
			{NONE} to_c
		end

create

	make

feature -- Initialization

	make (s: INTEGER) is
			-- Make state with 0 to `s' possibles inputs.
		do
			array_make (0, s)
		end; 

feature -- Element change

	append_transition (i: INTEGER; t: STATE_OF_DFA) is
			-- Append transition from current state to state t on input i.
		require
			no_other_transition: item (i) = Void;
			possible_input: i <= upper and i >= 0
		do
			put (t, i)
		end; 

feature -- Cursor movement

	successor (i: INTEGER): STATE_OF_DFA is
			-- Successor of current state for input `i';
			-- Void if no successor
		require
			possible_input: i <= upper and i >= 0
		do
			Result := item (i)
		end 

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




end -- class STATE_OF_DFA

