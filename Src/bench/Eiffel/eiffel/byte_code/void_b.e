indexing
	description: "Byte node for Void value."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_B

inherit
	EXPR_B
		redefine
			is_simple_expr, is_predefined, generate_il, make_byte_code, print_register
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

	is_simple_expr, is_predefined: BOOLEAN is True
			-- Void value is a simple expression and is predefined

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			-- False
		ensure then
			not_used: not Result
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for Void value.
		do
			il_generator.put_void
		end
		
feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for Void value.
		do
			ba.append (bc_void)
		end
		
feature -- C code generation

	print_register is
			-- Print Void value.
		do
			buffer.put_string ("NULL")
		end
		
end -- class VOID_B
