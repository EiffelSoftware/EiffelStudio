-- Unary operation.

deferred class UNARY_B 

inherit

	EXPR_B
		redefine
			analyze, unanalyze, generate,
			print_register, free_register,
			propagate, enlarged,
			has_gcable_variable, has_call, make_byte_code
		end;
	
feature 

	expr: EXPR_B;
			-- Expression

	access: FEATURE_B;
			-- Access when expression is not a simple type

	type: TYPE_I is
			-- Type of the prefixed feature
		do
			Result := access.type;
		end;

	set_expr (e: EXPR_B) is
			-- Assign `e' to `expr'.
		do
			expr := e;
		end;

	set_access (a: FEATURE_B) is
			-- Set `access' to `a'
		do
			access := a;
		end;

	init (a: FEATURE_B) is
			-- Initializes access
		do
			set_access (a);
		end;

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable ?
		do
			Result := expr.has_gcable_variable;
		end;

	has_call: BOOLEAN is
			-- Is the expression using a call ?
		do
			Result := expr.has_call;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' used in the expression ?
		do
			Result := expr.used (r);
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					expr.propagate (r);
				end;
			end;
		end;

	free_register is
			-- Free register used by expression
		do
			expr.free_register;
		end;

	analyze is
			-- Analyze expression
		do
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
		end;
	
	unanalyze is
			-- Undo the analysis of the expression
		do
			expr.unanalyze;
		end;
	
	generate is
			-- Generate expression
		do
			expr.generate;
		end;

	print_register is
			-- Print expression value
		do
			generate_operator;
			expr.print_register;
		end;

	
	generate_operator is
			-- Generate operator in C
		do
		end;

	enlarged: EXPR_B is
			-- Enlarge the expression
		local
			nested_b: NESTED_B;
			a_access_expr: ACCESS_EXPR_B;
		do
			if not is_built_in then
					-- Change this node into a nested call
				!!nested_b;
				!!a_access_expr;
				a_access_expr.set_expr (expr);
				a_access_expr.set_parent (nested_b);
				nested_b.set_target (a_access_expr);
				access.set_parent (nested_b);
				nested_b.set_message (access);
				Result := nested_b.enlarged;
			else
					-- Enlarge current node
				expr := expr.enlarged;
					-- Access is void in UN_OLD_B
				if access /= Void then
					access := access.enlarged;
				end;
				Result := Current;
			end;
		end;

	Nested: NESTED_B is
			-- Nested buffer for byte code generation of a binary
			-- operation on non-simple types
		once
			!!Result;
			Result.set_target (Access_expr);
			Access_expr.set_parent (Result);
		end;

	Access_expr: ACCESS_EXPR_B is
			-- Access on expression
		once
			!!Result;
		end;

feature -- Byte code generation

	is_built_in: BOOLEAN is
			-- is the unary operation a built-in one ?
		do
			-- Do nothing
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an unary expression
		do
			if is_built_in then
					-- Polish notation
				expr.make_byte_code (ba);

					-- Write unary operator
				ba.append (operator_constant);
			else
				make_call_byte_code (ba);
			end;
		end;

	make_call_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for an infixed call
		do
				-- Production of a nested call wich target is `expr
				-- and message `access'.
			Nested.set_message (access);
			access.set_parent (Nested);
			Access_expr.set_expr (expr);
			Nested.make_byte_code (ba);
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

end
