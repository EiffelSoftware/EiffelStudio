--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- State of Deterministic Finite Automata

indexing

	date: "$Date$";
	revision: "$Revision$"

class STATE_OF_DFA

inherit

	STATE
		undefine
			twin
		end;

	ARRAY [STATE_OF_DFA]
		rename
			make as array_make
		export
			{ANY} item
		end

creation

	make

feature

	make (s: INTEGER) is
			-- Make state with 0 to s possibles inputs.
		do
			array_make (0, s)
		end; -- make

	append_transition (i: INTEGER; t: STATE_OF_DFA) is
			-- Append transition from current state to state t on input i.
		require
			no_other_transition: item (i) = Void;
			possible_input: i <= upper and i >= 0
		do
			put (t, i)
		end; -- append_transition

	successor (i: INTEGER): STATE_OF_DFA is
			-- Successor of current state on input i;
			-- Void if no successor
		require
			possible_input: i <= upper and i >= 0
		do
			Result := item (i)
		end -- successor

end -- class STATE_OF_DFA
