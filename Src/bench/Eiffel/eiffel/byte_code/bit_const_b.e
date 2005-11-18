indexing
	description: "BIT constant byte node."
	date: "$Date$"
	revision: "$Revision$"

class
	BIT_CONST_B

inherit
	EXPR_B
		redefine
			enlarged, generate_il, is_simple_expr, allocates_memory,
			is_constant_expression
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING) is
			-- Assign `v' to `value'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bit_const_b (Current)
		end

feature -- Access

	value: STRING;
			-- Bit value (sequence of 0 and 1)

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is True

	is_constant_expression: BOOLEAN is True
			-- A bit constant is constant

	type: BIT_I is
			-- Integer type
		do
			create Result;
			Result.set_size (value.count);
		end;

	enlarged: BIT_CONST_BL is
			-- Enlarged node
		do
			create Result.make (value)
		end;

	used (r: REGISTRABLE): BOOLEAN is
            -- Is register `r' used in local or forthcomming dot calls ?
        do
        end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for bit constant.
			--| Not applicable
		do
			check False end
		end

end
