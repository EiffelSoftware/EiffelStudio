class PARAN_B 

inherit

	EXPR_B
		redefine
			analyze, unanalyze, generate,
			print_register, propagate,
			free_register, enlarged, allocates_memory,
			has_gcable_variable, has_call, make_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			generate_il, is_constant_expression, generate_il_value
		end

create
	make

feature {NONE} -- Initialize

	make (e: EXPR_B) is
			-- Set `expr' to `e'
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_paran_b (Current)
		end
	
feature -- Properties

	is_constant_expression: BOOLEAN is
			-- Is current a constant expression?
		do
			Result := expr.is_constant_expression
		end
		
feature

	expr: EXPR_B;
			-- The expression in parenthesis

	type: TYPE_I is
			-- Expression type
		do
			Result := expr.type;
		end;

	enlarged: like Current is
			-- Enlarge the expression
		do
			expr := expr.enlarged;
			Result := Current;
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
		local
			buf: GENERATION_BUFFER
		do
			if
				(expr.register = Void or expr.register = No_register)
				and not expr.is_simple_expr
			then
				buf := buffer
				buf.put_character ('(');
				expr.print_register;
				buf.put_character (')');
			else
					-- No need for parenthesis if expression is held in a
					-- register (e.g. a semi-strict boolean op).
				expr.print_register;
			end;
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for parenthesized expression
		do
			expr.generate_il
		end

	generate_il_value is
			-- Generate code that evaluates expression and puts its value
			-- (rather than a pointer to it) to the evaluation stack.
		do
			expr.generate_il_value
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for parenthesized expression.
		do
			expr.make_byte_code (ba);
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expr.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			expr := expr.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

invariant
	expr_not_void: expr /= Void

end
