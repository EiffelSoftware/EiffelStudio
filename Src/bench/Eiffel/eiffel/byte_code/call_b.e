deferred class CALL_B 

inherit

	EXPR_B
		redefine
			enlarged, is_simple_expr, optimized_byte_node,
			inlined_byte_code, pre_inlined_code
		end;
	
feature 

	parent: NESTED_B;
			-- Parent node

	target: ACCESS_B is
			-- The target of the call
		deferred
		end;

	canonical: CALL_B is
			-- Canonical call entity
			--| To be redefined in CONSTANT_B
		do
			Result := Current
		end;

	set_parent (p: NESTED_B) is
			-- Set parent to `p'
		do
			parent := p;
		end;

	is_simple_expr: BOOLEAN is
			-- A call/access is a simple expression
		do
			Result := true;
		end;

	is_single: BOOLEAN is
			-- Is call/access a single one ?
			-- Definition: A call/access is single if it is a single access
			-- or a call on a predefined target and with predefined arguments.
		deferred
		end;
		
	is_constant: BOOLEAN is
			-- Is Current a call to a constant?
		do
		end

	is_external: BOOLEAN is
			-- 	Is Current a call to an external?
		do
		end

	need_target: BOOLEAN is
			-- Does current call really need a target to be performed?
			-- E.g. not (a constant or a static external)
		do
			Result := True	
		end

	enlarged: like Current is
			-- Redefined only for type check
		do
			Result := Current;
		end;

	sub_enlarged (p: NESTED_BL): like enlarged is
			-- Enlarge node and set parent to `p'
		deferred
		end;

	need_invariant: BOOLEAN is
			-- Does the call need an invariant check ?
		do
			Result := True
		end;

	set_need_invariant (b: BOOLEAN) is
		do
			-- Do nothing
		end;

feature -- Byte code generation

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate call as a creation procedure
		require
			ba_not_void: ba /= Void
		do
			make_byte_code (ba);
		end;

feature -- Array optimization

	is_special_feature: BOOLEAN is
			-- Is it a call to a `special' feature?
		do
		end

	optimized_byte_node: CALL_B is
			-- Redefined only for type check
		do
			Result := Current
		end

feature -- Inlining

	pre_inlined_code: CALL_B is
			-- Redefined only for type check
		do
			Result := Current
		end

	inlined_byte_code: CALL_B is
			-- Redefined only for type check
		do
			Result := Current
		end

end
