-- Unary operation.

deferred class UNARY_B 

inherit

	EXPR_B
		redefine
			analyze, unanalyze, generate,
			print_register, free_register,
			propagate, enlarged,
			has_gcable_variable, has_call, make_byte_code,
			allocates_memory,
			is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			has_separate_call, generate_il
		end

	IL_CONST
	
feature 

	expr: EXPR_B;
			-- Expression

	access: ACCESS_B;
			-- Access when expression is not a simple type

	is_built_in: BOOLEAN is
			-- Is the unary operation a built-in one ?
		do
			-- Do nothing
		end

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

	set_access (a: like access) is
			-- Set `access' to `a'
		do
			access := a;
		end;

	init (a: like access) is
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

	allocates_memory: BOOLEAN is
		do
			Result := expr.allocates_memory
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
				-- Should never be called directly. Descendant of UNARY_B
				-- not redefining `generate_operator' usually redefine
				-- `print_register' and thus they might choose not to
				-- use `generate_operator'.
			check
				False
			end
		end;

	nested_b: NESTED_B is
			-- Change this node into a nested call
		local
			a_access_expr: ACCESS_EXPR_B;
		do
			create Result
			create a_access_expr
			a_access_expr.set_expr (expr)
			a_access_expr.set_parent (Result)
			Result.set_target (a_access_expr)
			access.set_parent (Result)
			Result.set_message (access)
		end

	enlarged: EXPR_B is
			-- Enlarge the expression
		do
			if not is_built_in then
					-- Change this node into a nested call
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

feature -- IL code generation

	generate_il is
			-- Generate IL code for an unary expression
		do
			if is_built_in then
					-- Polish notation
				expr.generate_il

					-- Write unary operator
				il_generator.generate_unary_operator (il_operator_constant)
			else
				nested_b.generate_il
			end
		end

	il_operator_constant: INTEGER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an unary expression
		do
			if is_built_in then
					-- Polish notation
				expr.make_byte_code (ba);

					-- Write unary operator
				ba.append (operator_constant);
			else
				nested_b.make_byte_code (ba);
			end;
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expr.calls_special_features (array_desc) or else
				access.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
				-- Use the nested form of the byte code (the type resolution
				-- does not work otherwise)
			Result := nested_b.is_unsafe
		end

	optimized_byte_node: EXPR_B is
		do
			if is_built_in then
				Result := Current
				expr := expr.optimized_byte_node
				access := access.optimized_byte_node
			else
				Result := nested_b.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expr.size + 1
		end

	pre_inlined_code: EXPR_B is
		do
			if not is_built_in then
				Result := nested_b.pre_inlined_code
			else
				Result := Current
				expr := expr.pre_inlined_code
			end
		end

	inlined_byte_code: EXPR_B is
		do
			if not is_built_in then
				Result := nested_b.inlined_byte_code
			else
				Result := Current
				expr := expr.inlined_byte_code
			end
		end

feature -- concurrent Eiffel

	has_separate_call: BOOLEAN is
		-- Is there separate feature call in the assertion?
		do
			if expr /= Void then
				Result := expr.has_separate_call;
			end;
			if not Result and access /= Void then
				Result := access.has_separate_call;
			end;
		end

end
