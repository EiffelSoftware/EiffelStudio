-- A binary operation.

deferred class BINARY_B 

inherit

	EXPR_B
		redefine
			propagate, print_register,
			analyze, unanalyze, generate, enlarged,
			free_register, has_gcable_variable,
			has_call, allocates_memory, make_byte_code,
			is_unsafe, optimized_byte_node, calls_special_features,
			size, pre_inlined_code, inlined_byte_code,
			has_separate_call
		end;
	
feature 

	left: EXPR_B;
			-- Left expression operand

	right: EXPR_B;
			-- Right expression operand

	access: FEATURE_B;
			-- Access when left is not a simple type

	type: TYPE_I is
			-- Type of the infixed feature
		do
			Result := access.type;
		end;

	set_left (l: EXPR_B) is
			-- Assign `l' to `left'.
		do
			left := l;
		end;

	set_right (r: EXPR_B) is
			-- Assign `r' to `right'.
		do
			right := r;
		end;

	set_access (a: FEATURE_B) is
			-- Set `access' to `a'
		do
			access := a;
		end;
			
	init (a: FEATURE_B) is
			-- Initializes node
		do
			access := a;
		end;

	is_commutative: BOOLEAN is
			-- Is the operation commutative ?
		do
		end;

	is_simple: BOOLEAN is
			-- Is the operation a simple one (C's point of view).
			-- Definition: An operation X is simple for C if it can be
			-- combined in affectation under the shortcut X=.
		do
		end;

	is_additive: BOOLEAN is
			-- Is the operation additive (i.e. + or -) ?
		do
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		deferred
		end;

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable ?
		do
			Result := left.has_gcable_variable or right.has_gcable_variable;
		end;

	has_call: BOOLEAN is
			-- Is the expression using a call ?
		do
			Result := left.has_call or right.has_call;
		end;

	allocates_memory: BOOLEAN is
		do
			Result := left.allocates_memory or right.allocates_memory
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' used in the expression ?
		do
			Result := left.used (r) or right.used (r);
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					left.propagate (r);
				end;
				if not context.propagated or r = No_register then
					right.propagate (r);
				end;
			elseif not left.used (r) then
				if not context.propagated then
					right.propagate (r);
				end;
			elseif not right.used (r) then
				if not context.propagated then
					left.propagate (r);
				end;
			end;
		end;

	free_register is
			-- Free registers used by the expression
		do
			left.free_register;
			right.free_register;
		end;

	analyze is
			-- Analyze expression
		do
			left.analyze;
			right.analyze;
		end;
	
	unanalyze is
			-- Undo the previous analysis
		local
			void_register: REGISTER;
		do
			left.unanalyze;
			right.unanalyze;
			set_register (void_register);
		end;

	generate is
			-- Generate expression
		do
			left.generate;
			right.generate;
		end;

	generate_plus_plus is
			-- Generate things like ++ or --
		do
		end; -- generate_plus_plus

	generate_simple is
			-- Generate operator followed by assignment
		do
		end; -- generate_simple

	print_register is
			-- Print expression value
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putchar ('(')
			left.print_register;
			generate_operator;
			right.print_register;
			buf.putchar (')')
		end;

	generate_operator is
			-- Generate operator in C
		do
		end;

	nested_b: NESTED_B is
		local
			a_access_expr: ACCESS_EXPR_B;
			param: BYTE_LIST [EXPR_B];
			--p: PARAMETER_B;
			--param: BYTE_LIST [PARAMETER_B];
		do
				-- Change this node into a nested call
			!!Result;
			!!a_access_expr;
			a_access_expr.set_expr (left);
			a_access_expr.set_parent (Result);
			Result.set_target (a_access_expr);
			!! param.make (1);
			param.extend (right);

-- FIXME PARAMETER_B takes care of the cast if needed
--			!!p;
--			p.set_expression (right);
--debug
--io.error.putstring (generator);
--io.error.putstring (" BINARY ENLARGED:%NRight:");
--io.error.putstring (right.out);
--io.error.new_line;
--io.error.putstring ("Expected type: ");
--a_access_expr.context_type.trace;
--io.error.putstring ("end display%N");
--end;
--			p.set_attachment_type (a_access_expr.context_type);
--			param.put_i_th (p, 1);

			access.set_parameters (param);
			access.set_parent (Result);
			Result.set_message (access);
		end;

	enlarged: EXPR_B is
			-- Enlarge the left and right handsides
		do
			if not is_built_in then
					-- Change this node into a nested call
				Result := nested_b.enlarged;
			else
				Result := built_in_enlarged;
			end;
		end;

	built_in_enlarged: like Current is
			-- Binary op enlarged node
		do
			left := left.enlarged;
			right := right.enlarged;
			access := access.enlarged;
			Result := Current;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for binary expression
		local
			param: BYTE_LIST [BYTE_NODE];
		do
			if is_built_in then
				make_standard_byte_code (ba);
			else
				make_call_byte_code (ba);
			end;
		end;
	
	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			right.make_byte_code (ba);
				-- Write binary operator
			ba.append (operator_constant);
		end;

	make_call_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an inxed call
		local
			param: BYTE_LIST [EXPR_B];
			Nested: NESTED_B;
			Access_expr: ACCESS_EXPR_B
			--p: PARAMETER_B;
			--param: BYTE_LIST [PARAMETER_B];
		do
				-- Access on expression
			!! Access_expr;
				-- Nested buffer for byte code generation of a binary
				-- operation on non-simple types
			!! Nested;
			Nested.set_target (Access_expr);
			Access_expr.set_parent (Nested);
				-- Production of a nested structure: target is
				-- an access expression (`left') and parameter
				-- of `access' is expression `right'.
			Nested.set_message (access);
			access.set_parent (Nested);
			Access_expr.set_expr (left);
			!! param.make (1);
			param.extend (right);
--!!p;
--p.set_expression (right);
--p.set_attachment_type (Access_expr.context_type);
--param.put_i_th (p, 1);
			access.set_parameters (param);
				-- Byte code generation on a nested call
			Nested.make_byte_code (ba);
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := left.calls_special_features (array_desc) or else
				right.calls_special_features (array_desc) or else
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
			Result := Current
			left := left.optimized_byte_node
			right := right.optimized_byte_node
			access := access.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + right.size + left.size
		end

	pre_inlined_code: EXPR_B is
		do
			if not is_built_in then
				Result := nested_b.pre_inlined_code
			else
				Result := Current
				left := left.pre_inlined_code
				right := right.pre_inlined_code
			end
		end

	inlined_byte_code: EXPR_B is
		do
			if not is_built_in then
				Result := nested_b.inlined_byte_code
			else
				Result := Current
				left := left.inlined_byte_code
				right := right.inlined_byte_code
			end
		end

feature -- concurrent Eiffel

	has_separate_call: BOOLEAN is
		-- is there separate feature call in the assertion?
		do
			if left /= Void then
				Result := left.has_separate_call;
			end;
			if not Result and access /= Void then
				Result := access.has_separate_call;
			end;
			if not Result and right /= Void then
				Result := right.has_separate_call;
			end;
		end
	
end
