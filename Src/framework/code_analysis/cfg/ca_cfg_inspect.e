note
	description: "Represents an Inspect block in the CFG."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CFG_INSPECT

inherit
	CA_CFG_BASIC_BLOCK

create
	make_complete

feature {NONE} -- Initialization

	make_complete (a_expr: attached EXPR_AS; a_intervals: detachable LIST [EIFFEL_LIST [INTERVAL_AS]]; a_has_else: BOOLEAN; a_label: INTEGER)
			-- Initializes `Current' with inspect expression `a_expr', inspect intervals `a_intervals', and label `a_label'.
			-- `a_has_else' is True iff the inspect has an else clause.
		do
			initialize
			has_else := a_has_else
			if a_intervals /= Void then
				n_when_branches := a_intervals.count
			end
			if a_has_else then
				create out_edges.make_filled (n_when_branches + 1)
			else
				create out_edges.make_filled (n_when_branches)
			end
			create intervals.make_filled (n_when_branches)
			across a_intervals as l_intervals loop
				intervals.put_i_th (l_intervals, @ l_intervals.cursor_index)
			end
			expression := a_expr
			label := a_label
		end

feature -- Properties

	expression: EXPR_AS
			-- The inspect expression.

	intervals: detachable ARRAYED_LIST [EIFFEL_LIST [INTERVAL_AS]]
			-- The inspect intervals, if existing.

	n_when_branches: INTEGER
			-- Number of when branches.

	has_else: BOOLEAN
			-- Does the inspect instruction have an else branch?

	set_when_branch (a_bb: attached CA_CFG_BASIC_BLOCK; a_index: INTEGER)
			-- Sets the when branch with index `a_index' to `a_bb'.
		require
			valid_index: (a_index >= 1) and (a_index <= n_when_branches)
		do
			out_edges [a_index] := a_bb
		end

	set_else_branch (a_bb: attached CA_CFG_BASIC_BLOCK)
			-- Sets the else branch to `a_bb'.
		require
			has_else
		do
			out_edges [n_when_branches + 1] := a_bb
		end

invariant
	has_else implies (out_edges.count = 1 + n_when_branches)
	(not has_else) implies (out_edges.count = n_when_branches)
end
