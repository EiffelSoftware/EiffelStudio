indexing

	description: 
		"Class chart information based on the BON method.";
	date: "$Date$";
	revision: "$Revision $"

class S_CLASS_CHART

inherit

	S_CHART

feature -- Properties

	queries: ARRAYED_LIST [S_TEXT_DATA];
			-- Comments of current class functions,
			-- as inputed in the chart view

	commands: ARRAYED_LIST [S_TEXT_DATA];
			-- Comments of current class routines,
			-- as inputed in the chart view

	constraints: ARRAYED_LIST [S_TEXT_DATA];
			-- Assertions and invariants of the current class,
			-- as inputed in the chart view.

feature -- Setting

	set_queries (l: like queries) is
			-- Set queries to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			queries := l
		ensure
			queries_set: queries = l
		end;

	set_commands (l: like commands) is
			-- Set commands to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			commands := l
		ensure
			commands_set: commands = l
		end;

	set_constraints (l: like constraints) is
			-- Set constraints to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			constraints := l
		ensure
			constraints_set: constraints = l
		end;

end -- class S_CLASS_CHART
