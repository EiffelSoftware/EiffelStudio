indexing
	description: "Boolean constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class BOOL_CONST_B

inherit
	EXPR_B
		redefine
			print_register,
			is_simple_expr, is_predefined, evaluate,
			is_fast_as_local, is_constant_expression
		end

create
	make

feature -- Initialization

	make (v: BOOLEAN) is
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
			v.process_bool_const_b (Current)
		end

feature -- Access

	value: BOOLEAN
			-- Boolean value

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			create {BOOL_VALUE_I} Result.make (value)
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expression.

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	is_constant_expression: BOOLEAN is True
			-- A boolean constant is constant.

	type: TYPE_I is
			-- Boolean type
		once
			Result := Boolean_c_type
		end

feature -- C code generation

	print_register is
			-- Print boolean constant
		do
			if value then
				buffer.put_string ("(EIF_BOOLEAN) 1")
			else
				buffer.put_string ("(EIF_BOOLEAN) 0")
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

end -- class BOOL_CONST_B
