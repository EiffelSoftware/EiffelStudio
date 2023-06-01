note
	description: "Summary description for {CIL_INSTRUCTION_NAME}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_INSTRUCTION_NAME

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_op1, a_op2, a_bytes, a_operand_type: NATURAL_8; a_stack_usage: INTEGER_8)
		do
			name := a_name
			op1 := a_op1
			op2 := a_op2
			bytes := a_bytes
			operand_type := a_operand_type
			stack_usage := a_stack_usage
		end

feature -- Access

	name: STRING_32 assign set_name
			-- `name'

	op1: NATURAL_8 assign set_op1
			-- `op1'

	op2: NATURAL_8 assign set_op2
			-- `op2'

	bytes: NATURAL_8 assign set_bytes
			-- `bytes'

	operand_type: NATURAL_8 assign set_operand_type
			-- `operand_type'

	stack_usage: INTEGER_8 assign set_stack_usage
			-- positive it adds to stack, negative it consumes stack


feature -- Element change

	set_bytes (a_bytes: like bytes)
			-- Assign `bytes' with `a_bytes'.
		do
			bytes := a_bytes
		ensure
			bytes_assigned: bytes = a_bytes
		end

	set_op1 (an_op1: like op1)
			-- Assign `op1' with `an_op1'.
		do
			op1 := an_op1
		ensure
			op1_assigned: op1 = an_op1
		end

	set_op2 (an_op2: like op2)
			-- Assign `op2' with `an_op2'.
		do
			op2 := an_op2
		ensure
			op2_assigned: op2 = an_op2
		end

	set_operand_type (an_operand_type: like operand_type)
			-- Assign `operand_type' with `an_operand_type'.
		do
			operand_type := an_operand_type
		ensure
			operand_type_assigned: operand_type = an_operand_type
		end

	set_stack_usage (a_stack_usage: like stack_usage)
			-- Assign `stack_usage' with `a_stack_usage'.
		do
			stack_usage := a_stack_usage
		ensure
			stack_usage_assigned: stack_usage = a_stack_usage
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

end
