-- Byte code for an hector operator

class HECTOR_B 

inherit
	
	UNARY_B
		redefine
			expr, enlarged, is_hector, type, make_byte_code
		end

creation

	make
	
feature 

	expr: ACCESS_B;

	type: TYPE_I is
			-- Expression's type
		do
			Result := expr.type;
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

end
