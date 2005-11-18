indexing
	description: "Byte node for Void value."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_B

inherit
	EXPR_B
		redefine
			is_simple_expr, is_predefined, generate_il,
			print_register, is_fast_as_local,
			is_constant_expression
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_void_b (Current)
		end

feature -- Access

	type: TYPE_I is
			-- Expression type.
		once
			create {NONE_I} Result
		ensure then
			type_not_void: Result /= Void
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- Void is a simple expression

	is_predefined: BOOLEAN is False
			-- Void is not predefined

	is_constant_expression: BOOLEAN is True
			-- Void is a constant.

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			-- False
		ensure then
			not_used: not Result
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

	generate_il is
			-- Generate IL code for Void value.
		do
			il_generator.put_void
		end

feature -- C code generation

	print_register is
			-- Print Void value.
		do
			buffer.put_string ("NULL")
		end

end -- class VOID_B
