indexing

	description:
		"Atomic node: strings, integers, reals etc. %
		%Version for Bench version.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ATOMIC_AS_B

inherit

	ATOMIC_AS;

	AST_EIFFEL_B
		redefine
			byte_node
		end

feature -- Type check and dead code removal

	byte_node: EXPR_B is
		do
		end;

	value_i: VALUE_I is
		do
			-- Do nothing
		end;

	make_integer: INT_VAL_B is
			-- Integer value.
		require
			good_integer
		do
			-- Do nothing
		end;

	make_character: CHAR_VAL_B is
			-- Character value.
		require
			good_character
		do
			-- Do nothing
		end;

end -- class ATOMIC_AS_B
