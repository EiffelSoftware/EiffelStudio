class EXPR_ADDRESS_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged,
			allocates_memory, has_call, has_gcable_variable,
			is_hector, inlined_byte_code, pre_inlined_code, size,
			optimized_byte_node, is_unsafe, calls_special_features
		end;

create
	make

feature {NONE} -- Initialization

	make (e: EXPR_B) is
			-- Set `expr' to `e'
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Attributes

	expr: EXPR_B;
		-- Expression to address

feature

	type: POINTER_I is
			-- Address type
		once
			create Result;
		end;

	enlarged: EXPR_ADDRESS_BL is
			-- Enlarge the expression
		do
			create Result.make (expr.enlarged)
		end;

	is_hector: BOOLEAN is True;
			-- The expression is an hector one.
 
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
 
feature -- Byte code generation

	generate_expression_byte_code (ba: BYTE_ARRAY) is
			-- Generate the byte code for the expression before the
			-- actual arguments to be able to generate the address
			-- operator.
		require
			is_protected: is_protected
		do
			expr.make_byte_code (ba);
		end
 
	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for parenthesized expression.
		do
			if expr.type.is_basic then
					-- computation of the offset will be done once
					-- all the arguements are pushed on the stack.
				ba.append (Bc_reserve);
			else
				expr.make_byte_code (ba);
			end
		end;

	make_protected_byte_code (ba: BYTE_ARRAY; pointer_pos, value_pos: INTEGER) is
			-- Generate byte code for parenthesized expression.
		require
			is_protected: is_protected
		do
			ba.append (Bc_object_expr_addr);
			ba.append_uint32_integer (pointer_pos);
			ba.append_uint32_integer (value_pos);
		end

	is_protected: BOOLEAN is
			-- Is the expression protected with some special byte code?
		do
			Result := expr.type.is_basic
		end

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
