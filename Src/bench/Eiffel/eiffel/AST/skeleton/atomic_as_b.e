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

	string_value: STRING is
			-- String representation of value_i
		do
			if value_i = Void then
				Result := ""
			else
				Result := value_i.dump
			end
		end;

end -- class ATOMIC_AS_B
