note
	description: "Represents an instruction block in the CFG."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CFG_INSTRUCTION

inherit
	CA_CFG_BASIC_BLOCK

create
	make_with_instruction,
	make_complete

feature {NONE} -- Initialization

	make_with_instruction (a_instruction: attached INSTRUCTION_AS)
			-- Initializes `Current' with AST instruction node `a_instruction'.
		do
			initialize
			instruction := a_instruction
		end

	make_complete (a_instruction: attached INSTRUCTION_AS; a_label: INTEGER)
			-- Initializes `Current' with AST instruction node `a_instruction' and label `a_label'.
		do
			make_with_instruction (a_instruction)
			label := a_label
		end

feature -- Properties

	instruction: INSTRUCTION_AS
			-- The AST instruction node associated with this CFG block.

invariant
	out_edges.count <= 1

	-- `instruction' is not attached to an {IF_AS}, {INSPECT_AS}, or {LOOP_AS} instance.
end
