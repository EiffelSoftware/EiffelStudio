-- Byte code for manifest arrays

class ARRAY_CONST_B 

inherit

	EXPR_B
		redefine
			make_byte_code, analyze, generate, print_register
		end
	
feature 

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the array

	type: GEN_TYPE_I;
			-- Generic array type

	set_expressions (e: like expressions) is
			-- Assign `e' to `expressions'.
		do
			expressions := e;
		end;

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			--## FIXME
		do
		end;

	analyze is
			-- Analyze expression
		do
			--## FIXME
		end;
	
	generate is
			-- Generate expression
		do
			--## FIXME
		end;

	print_register is
			-- Print the register holding the manifest array
		do
			--## FIXME
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest array
		do
			-- FIXME
		end;

end
