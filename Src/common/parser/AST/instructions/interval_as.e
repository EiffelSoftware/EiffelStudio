indexing

	description: 
		"AST representation for alternative values of a multi-branch instruction.";
	date: "$Date$";
	revision: "$Revision$"

class INTERVAL_AS

inherit

	AST_EIFFEL

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			lower ?= yacc_arg (0);
			upper ?= yacc_arg (1);
		ensure then
			lower_exists: lower /= Void;
		end;

feature -- Properties

	lower: ATOMIC_AS;
			-- Lower bound

	upper: ATOMIC_AS;
			-- Upper bound
			-- void if constant rather than interval

feature {COMPILER_EXPORTER} -- Access

	good_integer_interval: BOOLEAN is
			-- Is the current interval a good integer interval ?
		do
			Result := 	lower.good_integer
						and then
						(upper = Void or else upper.good_integer)
		end;

	good_character_interval: BOOLEAN is
			-- Is the current interval a good character interval ?
		do
			Result := 	lower.good_character
						and then
						(upper = Void or else upper.good_character)
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (lower);
			if upper /= void then
				ctxt.put_text_item_without_tabs (ti_Dotdot);
				ctxt.format_ast (upper);
			end;
		end;

feature {INTERVAL_AS} -- Replication

	set_lower (l: like lower) is
			-- Set `lower' to `l'.
		do
			lower := l
		end;

	set_upper (u: like upper) is
			-- Set `upper' to `u'.
		require
			valid_arg: u /= Void
		do
			upper := u
		end;

end -- class INTERVAL_AS
