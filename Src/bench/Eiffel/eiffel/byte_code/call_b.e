deferred class CALL_B 

inherit

	EXPR_B
		redefine
			enlarged, is_simple_expr
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

	forth_used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in the forthcomming dot calls ?
		deferred
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
		do
			make_byte_code (ba);
		end;

end
