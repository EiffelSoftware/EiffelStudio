-- Byte code for an hector operator

class HECTOR_B 

inherit

	UNARY_B
		redefine
			expr, enlarged, is_hector, type, make_byte_code,
			is_unsafe, optimized_byte_node,
			pre_inlined_code, inlined_byte_code
		end

creation

	make

feature 

	expr: ACCESS_B;

	type: TYPE_I is
			-- Expression's type
		once
			!POINTER_I!Result
		end;

	make (a: ACCESS_B) is
			-- Initialization
		require
			good_argument: a /= Void
		do
			expr := a;
		end;

	enlarged: like Current is
			-- Enlarge the expression
		do
			expr := expr.enlarged;
			Result := Current;
		end;

	is_hector: BOOLEAN is true;
			-- The expression is an hector one.

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
            -- operation
		do
		ensure then
			False
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an unprotected external call argument
		do
			expr.make_byte_code (ba);
		end;

feature -- Array optimization

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

	pre_inlined_code: like Current is
		do  
			Result := Current
			expr ?= expr.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

end
