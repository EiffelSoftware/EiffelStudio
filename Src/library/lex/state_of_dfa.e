indexing

	description:
		"States of deterministic finite automata";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class STATE_OF_DFA inherit

	STATE
		undefine
			copy, consistent, setup, is_equal
		end;

	ARRAY [STATE_OF_DFA]
		rename
			make as array_make
		export
			{NONE} to_c
		end

creation

	make

feature -- Initialization

	make (s: INTEGER) is
			-- Make state with 0 to s possibles inputs.
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

end -- class STATE_OF_DFA
 

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
