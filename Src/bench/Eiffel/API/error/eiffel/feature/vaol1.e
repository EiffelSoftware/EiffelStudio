-- Error when an old expression is found somewhere else that in a 
-- postcondition

class VAOL1 

inherit

	FEATURE_ERROR
		redefine
			subcode
		end;

feature 

	old_expr: UN_OLD_AS;
			-- Old expression involved in the error

	set_old_expr (o: like old_expr) is
			-- Assign `o' to `old_expr'.
		do
			old_expr := o;
		end;

	code: STRING is "VAOL";
			-- Error code

	subcode: INTEGER is
		do
			Result := 1
		end;

end
