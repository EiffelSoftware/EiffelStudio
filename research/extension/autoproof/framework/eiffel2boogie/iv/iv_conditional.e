note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_CONDITIONAL

inherit

	IV_STATEMENT

create
	make,
	make_if_then,
	make_if_then_else

feature {NONE} -- Initialization

	make (a_condition: IV_EXPRESSION)
			-- Initialize conditional with condition `a_condition' and empty then and else blocks.
			-- (if `a_condition' is Void use *).
		require
			a_condition_valid: attached a_condition implies a_condition.type.is_boolean
		do
			condition := a_condition
			create then_block.make
			create else_block.make
		ensure
			condition_set: condition = a_condition
		end


	make_if_then (a_condition: IV_EXPRESSION; a_then: IV_BLOCK)
			-- Initialize conditional with condition `a_condition',
			-- then block `a_then', and empty else block;
			-- (if `a_condition' is Void use *).			
		require
			a_condition_valid: attached a_condition implies a_condition.type.is_boolean
			a_then_attached: attached a_then
		do
			condition := a_condition
			then_block := a_then
			create else_block.make
		ensure
			condition_set: condition = a_condition
			then_block_set: then_block = a_then
			empty_else: else_block.is_empty
		end

	make_if_then_else (a_condition: IV_EXPRESSION; a_then: IV_BLOCK; a_else: IV_BLOCK)
			-- Initialize conditional with condition `a_condition',
			-- then block `a_then', and else block `a_else'.
			-- (if `a_condition' is Void use *).			
		require
			a_condition_valid: attached a_condition implies a_condition.type.is_boolean
			a_then_attached: attached a_then
			a_else_attached: attached a_else
		do
			condition := a_condition
			then_block := a_then
			else_block := a_else
		ensure
			condition_set: condition = a_condition
			then_block_set: then_block = a_then
			else_block_set: else_block = a_else
		end

feature -- Access

	condition: IV_EXPRESSION
			-- Condition expression.

	then_block: IV_BLOCK
			-- Block for then branch.

	else_block: IV_BLOCK
			-- Block for else branch.

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_conditional (Current)
		end

invariant
	condition_valid: attached condition implies condition.type.is_boolean
	then_block_attached: attached then_block
	else_block_attached: attached else_block

end
