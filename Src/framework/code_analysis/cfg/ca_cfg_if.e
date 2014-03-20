note
	description: "Represents an If block in the CFG."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CFG_IF

inherit
	CA_CFG_BASIC_BLOCK

create
	make_complete

feature {NONE} -- Initialization

	make_complete (a_condition: attached EXPR_AS; a_label: INTEGER)
			-- Initializes `Current' with if condition `a_condition' and label
			-- `a_label'.
		do
			initialize
			create out_edges.make_filled (2)
			condition := a_condition
			label := a_label
		end

feature -- Properties

	condition: EXPR_AS
			-- The if condition.

	true_branch: detachable CA_CFG_BASIC_BLOCK
			-- The node of the "true" edge.
		do
			Result := out_edges [1]
		end

	false_branch: detachable CA_CFG_BASIC_BLOCK
			-- The node of the "false" edge.
		do
			Result := out_edges [2]
		end

	set_true_branch (a_bb: CA_CFG_BASIC_BLOCK)
			-- Sets the node of the "true" edge to `a_bb'.
		do
			out_edges [1] := a_bb
		end

	set_false_branch (a_bb: CA_CFG_BASIC_BLOCK)
			-- Sets the node of the "false" edge to `a_bb'.
		do
			out_edges [2] := a_bb
		end

invariant
	out_edges.count = 2 -- The "true" and the "false" edge.
end
