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
			has_separate_call, generate_il
		end

	IL_CONST
	
feature 

	left: EXPR_B;
			-- Left expression operand

	right: EXPR_B;
			-- Right expression operand

	access: FEATURE_B;
			-- Access when left is not a simple type

	attachment: TYPE_I
			-- Type of `right' expression as described in
			-- class text, used for metamorphosis of basic type.

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
			
	set_attachment (a: TYPE_I) is
			-- Set `attachment' to `a'.
		do
			attachment := a
		ensure
			attachment_set: attachment = a
		end

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
			access_expr: ACCESS_EXPR_B;
			p: PARAMETER_B;
			param: BYTE_LIST [PARAMETER_B];
		do
				-- Access on expression
			create access_expr

				-- Nested buffer for byte code generation of a binary
				-- operation on non-simple types					
			create Result
			Result.set_target (access_expr)
			access_expr.set_parent (Result)

				-- Production of a nested structure: target is
				-- an access expression (`left') and parameter
				-- of `access' is expression `right'.
			Result.set_message (access)
			access.set_parent (Result)
			access_expr.set_expr (left)

			create param.make (1)
			create p
			p.set_expression (right)
			p.set_attachment_type (attachment)
			param.extend (p)
			access.set_parameters (param)
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

feature -- IL code generation

	generate_il is
			-- Generate IL code for binary expression.
		do
			if is_built_in then
				generate_standard_il
			else
				nested_b.generate_il
			end
		end

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		do
			left.generate_il
			right.generate_il
			il_generator.generate_binary_operator (il_operator_constant)
		end

	il_operator_constant: INTEGER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for binary expression
		do
			if is_built_in then
				make_standard_byte_code (ba)
			else
					-- Make byte code with call to infix feature
				nested_b.make_byte_code (ba)
			end
		end
	
	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			right.make_byte_code (ba);
				-- Write binary operator
			ba.append (operator_constant);
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
